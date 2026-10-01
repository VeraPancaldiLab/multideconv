# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working
with code in this repository.

## What This Package Does

**multideconv** is an R package providing an integrative pipeline for
combining multiple cell type deconvolution methods (both first- and
second-generation) from bulk RNA-seq data. It harmonizes outputs across
methods, removes redundant cell types via correlation analysis, and
identifies robust cell subgroups.

## Working Rules

- **Describe a fix and get approval before editing code.** Report the
  bug, the proposed change and how it was verified; apply only after the
  user agrees.
- **Test with small data only.** The dev machine has ~15 GB RAM.
  Subsample (e.g. ~200 cells x 2,000 genes, 4 bulk samples), use 1
  worker/core, cap runs with `timeout`, and run heavy methods one at a
  time. Never compile large packages (e.g. Seurat) from source with many
  cores; use Posit Package Manager binaries into a temporary library
  instead.
- Never write test output into the package tree or the user’s home; run
  in a temp directory
  ([`withr::local_tempdir()`](https://withr.r-lib.org/reference/with_tempfile.html))
  and clean up.

## Development Commands

``` r

devtools::load_all()     # interactive development
devtools::document()     # regenerate man/ + NAMESPACE (required after any roxygen change)
devtools::test()         # testthat suite in tests/testthat/
devtools::check()        # R CMD check
pkgdown::check_pkgdown() # verify _pkgdown.yml before pushing
shiny::runApp('inst/shiny', host='127.0.0.1', port=3838)
```

### CI (GitHub Actions)

- `R-CMD-check.yaml` fails on any **WARNING**. A roxygen block without a
  regenerated `.Rd` (forgetting
  [`devtools::document()`](https://devtools.r-lib.org/reference/document.html))
  produces “Undocumented code objects” and fails CI.
- `pkgdown.yaml` fails if any documented topic is missing from the
  `reference:` index in `_pkgdown.yml`. Every new exported/documented
  function must be added there (sections: Main, Benchmarking, Single
  cell functions, Helpers = exported helpers, Internal = not exported,
  Package Data) or marked `@keywords internal`.
- Exported functions (12): `compute.deconvolution`,
  `compute.deconvolution.analysis`, `aggregate_cell_groups`,
  `replicate_deconvolution_subgroups`, `compute.benchmark`,
  `compute.subgroup.pathways`, `prepare_multideconv_folds`,
  `create_metacells`, `create_sc_pseudobulk`, `create_sc_signatures`,
  `get_cell_type_nomenclature`, `standardize_celltype_colnames`. Every
  other function is tagged `@keywords internal` (`.onLoad` uses
  `@noRd`); new internal functions must be too. Every `@param` must be
  documented, otherwise R CMD check warns
  ([`devtools::check_man()`](https://devtools.r-lib.org/reference/check_man.html)
  catches it quickly).
- Non-package files at top level must be listed in `.Rbuildignore`
  (CLAUDE.md, Results, Rplots.pdf, launch_app.R, .vscode, .claude,
  pypath_log, omnipathr-log, …). Do not ignore `vignettes/Results/`: the
  a4 vignette embeds `vignettes/Results/Benchmark.png`.

## Installation

``` r

pak::pkg_install("VeraPancaldiLab/multideconv")
```

Several dependencies come from GitHub remotes (omnideconv, immunedeconv,
DWLS, BayesPrism, MOMF, bisque) — see `DESCRIPTION`. `hdWGCNA` is an
optional runtime dependency (`pak::pkg_install("smorabit/hdWGCNA")`)
needed only by
[`create_metacells()`](https://verapancaldilab.github.io/multideconv/reference/create_metacells.md);
it is not a `Remote` and is checked via
[`requireNamespace()`](https://rdrr.io/r/base/ns-load.html). `Seurat` is
in Suggests: functions using it
([`create_metacells()`](https://verapancaldilab.github.io/multideconv/reference/create_metacells.md),
[`create_sc_pseudobulk()`](https://verapancaldilab.github.io/multideconv/reference/create_sc_pseudobulk.md))
must check [`requireNamespace("Seurat")`](https://satijalab.org/seurat)
first.

CIBERSORTx requires credentials and Docker (image
`cibersortx/fractions`). AutogeneS runs in omnideconv’s Python conda env
`r-omnideconv` (module `autogenes`).

## Architecture

All functions live in a single file: `R/cell_deconvolution.R` (~3,000
lines). This is intentional.

### Core Pipeline Flow

1.  **[`compute.deconvolution()`](https://verapancaldilab.github.io/multideconv/reference/compute.deconvolution.md)**
    — TPM-normalizes (`normalized = TRUE` means “normalize the input”),
    runs Quantiseq plus the signature-based methods over every signature
    (bundled + `Results/custom_signatures/`), then standardizes names
    via
    [`compute.deconvolution.preprocessing()`](https://verapancaldilab.github.io/multideconv/reference/compute.deconvolution.preprocessing.md).
    Per-method/signature results are cached as
    `Results/deconv_<method>_<sig>_<data id>.rds` while running (crash
    recovery; the data id is a short md5 of the TPM matrix, so a cache
    is only reused for the same input) and deleted at the end. Signature
    names are the file name without `.txt`
    ([`tools::file_path_sans_ext()`](https://rdrr.io/r/tools/fileutils.html))
    everywhere; `Results/` is removed again if it was created only for
    the cache. It stops with a clear error if no method produced output.
    - **CBSX without credentials is skipped with a warning** (it is in
      the default `methods`), not a hard error.
    - `doParallel = TRUE` with `workers = NULL` uses
      `detectCores() - 1`.
2.  **[`compute.deconvolution.analysis()`](https://verapancaldilab.github.io/multideconv/reference/compute.deconvolution.analysis.md)**
    — removes zero-heavy features (`zero_thr`) and features that barely
    vary (`cv_thr`: coefficient of variation sd/mean below 0.1, each
    feature judged on its own so rare cell types are not penalised),
    splits by cell type
    ([`compute.cell.types()`](https://verapancaldilab.github.io/multideconv/reference/compute.cell.types.md)),
    then groups the features of each cell type by complete-linkage
    hierarchical clustering of their correlations
    ([`compute_subgroups()`](https://verapancaldilab.github.io/multideconv/reference/compute_subgroups.md),
    correlations from
    [`corr_subgroups()`](https://verapancaldilab.github.io/multideconv/reference/corr_subgroups.md)):
    features form a subgroup only if every pair correlates \>= `corr`
    (non-significant correlations, p \>= 0.05, count as 0), and each
    subgroup is summarised by the row median of its members. Features
    are sorted by name before clustering, so ties are broken the same
    way and the result does not depend on column order. There is no
    pruning step and no `seed` (`removeCorrelatedFeatures()`,
    `prune_thr` and `seed` were removed). With `batch`, correlations are
    partial correlations (`ppcor`) controlling for batch.
    - Optional `cell_groups` (named list, see “Cell group aggregation”):
      groups are aggregated first, on the raw proportions (before the
      zero and CV filters), their names are appended to `cells_extra`,
      and the list is stored as the 7th output element, “Cell groups”
      (`NULL` when not given).
3.  **[`replicate_deconvolution_subgroups()`](https://verapancaldilab.github.io/multideconv/reference/replicate_deconvolution_subgroups.md)**
    — applies the learned subgroups (median of the member features) to a
    new cohort, one subgroup at a time in composition order, so
    compositions whose members are earlier subgroups (results saved with
    older versions) still work. On the training data it reproduces the
    “Deconvolution matrix” exactly. If the analysis output has “Cell
    groups”, the same groups are aggregated in the new cohort first, so
    it takes the raw deconvolution.
4.  **[`prepare_multideconv_folds()`](https://verapancaldilab.github.io/multideconv/reference/prepare_multideconv_folds.md)**
    — fold-aware feature construction for pipeML (see below).
5.  **Single-cell workflow** —
    [`create_metacells()`](https://verapancaldilab.github.io/multideconv/reference/create_metacells.md)
    →
    [`create_sc_pseudobulk()`](https://verapancaldilab.github.io/multideconv/reference/create_sc_pseudobulk.md)
    /
    [`create_sc_signatures()`](https://verapancaldilab.github.io/multideconv/reference/create_sc_signatures.md)
    → `compute.deconvolution(sc_deconv = TRUE, ...)`, which calls the
    internal
    [`compute_sc_deconvolution_methods()`](https://verapancaldilab.github.io/multideconv/reference/compute_sc_deconvolution_methods.md).

### Method Categories

- **First-generation / signature-based**: Quantiseq (`immunedeconv`,
  TIL10), EpiDISH, DeconRNASeq, DWLS, CIBERSORTx (CBSX, via
  `omnideconv`), MOMF (needs `sc_matrix`). MCP-counter and xCell were
  removed (helpers kept commented out).
- **Second-generation** (internal
  [`compute_sc_deconvolution_methods()`](https://verapancaldilab.github.io/multideconv/reference/compute_sc_deconvolution_methods.md),
  run via `compute.deconvolution(sc_deconv = TRUE)`, through
  `omnideconv`, need a single-cell reference): AutogeneS, BayesPrism,
  Bisque, CPM, MuSiC, SCDC. AutogeneS and CPM are slow even on tiny
  inputs (tens of minutes / \>5 min).

### Method-specific pitfalls

- **Result element names differ per method** and are extracted by name
  (`$proportions`, `$theta`, `$bulk.props`, `$cellTypePredictions`,
  `$Est.prop.weighted`, `$prop.est.mvw`, `$cell.prop`). A wrong name
  silently yields `NULL` and the method disappears from the output.
  BisqueRNA returns `bulk.props` as **cell types x samples**, so it is
  transposed; every method must end up samples x cell types.
- **CIBERSORTx fallback**
  ([`computeCBSX()`](https://verapancaldilab.github.io/multideconv/reference/computeCBSX.md),
  also used by the parallel version): omnideconv defaults
  `input_dir`/`output_dir` to
  [`tempdir()`](https://rdrr.io/r/base/tempfile.html). On some machines
  the container crashes (error code 139,
  `..._Results.txt does not exist`). Only on that error it retries once
  with `~/user_projects/cibersort/{input,output}` (created on demand);
  any other error is re-raised.
- `name_object` / `name_signature` default to `"scRNAseq"` / `"custom"`
  when `NULL`, to avoid `Method__cell` names and `DWLS--scRNAseq.txt`
  files.

### Metacells (Seurat 4 and 5)

[`create_metacells()`](https://verapancaldilab.github.io/multideconv/reference/create_metacells.md)
/
[`process_group()`](https://verapancaldilab.github.io/multideconv/reference/process_group.md)
must work with both Seurat 4 (SeuratObject 4.x, `Assay`) and Seurat 5
(SeuratObject 5.x, `Assay5`, possibly split layers). Verified on Seurat
4.4.0 and 5.5.1. - Read counts from the metacell object’s own assay
(`DefaultAssay(meta)`; hdWGCNA keeps the input’s default assay,
e.g. `SCT`), with `LayerData(layer = "counts")` on SeuratObject \>= 5
and `GetAssayData(slot = "counts")` on 4. The `slot` argument is defunct
in recent SeuratObject 5 and `layer` does not exist in 4. - Group
subsets are built by selecting cell names from the metadata with
[`which()`](https://rdrr.io/r/base/which.html) and calling
`subset(data, cells = cells_use)`. Do **not** use
`subset(subset = samples_ids == patient, ...)`: a metadata column named
e.g. `patient` shadows the loop variable and silently returns empty
groups. [`which()`](https://rdrr.io/r/base/which.html) handles `NA`
labels. - [`subset()`](https://rdrr.io/r/base/subset.html) is base R’s
S3 generic; it dispatches to `SeuratObject`’s `subset.Seurat`.
`Seurat::subset` does not exist — do not write it. - The user’s `future`
plan is saved and restored (`on.exit`), also on error. hdWGCNA’s
`MetacellsByGroups()` needs a `pca` reduction already present in the
input object. - Metacells are built with
`MetacellsByGroups(mode = "sum")` (integer summed counts) and default
`k = 15`, `max_shared = 10`. `max_shared` must stay below `k`: with
`max_shared = k` metacells can overlap completely and you get about one
metacell per cell.

### Cross-validation folds (`prepare_multideconv_folds()` ↔︎ pipeML)

- `folds` is a list of **training** row indices
  (e.g. `caret::createMultiFolds`); the test set is the complement.
- Fold mode writes `Results/fold_<fold name>.rds` (each with
  `train_data`, `test_data`, `obs_test`, `rowIndex`, `fold_name`) and
  returns the folds invisibly. pipeML reads back **every**
  `Results/fold_*.rds` in alphabetical order and relies on each file’s
  own `rowIndex`, so stale `fold_*.rds` files are deleted before writing
  (pipeML’s survival path never deletes them). Unnamed folds are named
  `Fold1`, `Fold2`, …
- `bestune` mode returns
  `list(features_with_target, full_analysis_output, bestune)`.
- Workers (`doParallel`) load the **installed** multideconv, not
  `load_all()` code: reinstall (e.g. into a temp library via
  `R CMD INSTALL -l`) before testing parallel code paths.
- Workers attach the package with
  [`library()`](https://rdrr.io/r/base/library.html), which only exposes
  **exported** functions. An internal function called inside a `%dopar%`
  body must be passed with `.export = "<name>"` (as in
  [`computeCBSX_parallel()`](https://verapancaldilab.github.io/multideconv/reference/computeCBSX_parallel.md),
  [`computeDWLS_parallel()`](https://verapancaldilab.github.io/multideconv/reference/computeDWLS_parallel.md),
  [`computeMOMF_parallel()`](https://verapancaldilab.github.io/multideconv/reference/computeMOMF_parallel.md)),
  otherwise workers fail with “could not find function”.

### File Layout

- `R/cell_deconvolution.R` — all function implementations
- `R/data.R` — documentation for built-in datasets
- `R/zzz.R` —
  [`ensure_results_dir()`](https://verapancaldilab.github.io/multideconv/reference/ensure_results_dir.md)
  helper; `.onLoad()` creates `Results/custom_signatures/` **only in
  interactive sessions** (CRAN/R CMD check forbid writing to the working
  directory at load time)
- `inst/shiny/app.R` — Shiny app (creates its own `Results/`)
- `inst/signatures/` — bundled signature matrices (LM22, TIL10,
  CBSX-\*-scRNAseq)
- `data/` — sample datasets
- `tests/testthat/` — test suite (small built-in data, runs in a temp
  dir)
- `vignettes/` — `multideconv.Rmd` plus articles `a1_deconvolution` →
  `a5_machine_learning`

### Output files

Every function that writes into `Results/` must call
[`ensure_results_dir()`](https://verapancaldilab.github.io/multideconv/reference/ensure_results_dir.md)
first; do not assume `.onLoad()` created it.

### Cell Type Nomenclature

Column names follow `method_signature_celltype`, with `_` as the
separator.
[`standardize_celltype_colnames()`](https://verapancaldilab.github.io/multideconv/reference/standardize_celltype_colnames.md)
harmonizes cell names (it only renames the part after the last `_`, so
cell labels in custom signatures must not contain `_`).
[`get_cell_type_nomenclature()`](https://verapancaldilab.github.io/multideconv/reference/get_cell_type_nomenclature.md)
is the single source of truth for the vocabulary; other code, including
sister packages like CellTFusion, should call it rather than hardcode a
copy. All cell names in the bundled signatures map to the correct cell
type.

[`get_cell_type_nomenclature()`](https://verapancaldilab.github.io/multideconv/reference/get_cell_type_nomenclature.md)
is the only hardcoded list:
[`standardize_celltype_colnames()`](https://verapancaldilab.github.io/multideconv/reference/standardize_celltype_colnames.md)
(block names/order, plus a trailing `"extra"` block) and
[`compute.cell.types()`](https://verapancaldilab.github.io/multideconv/reference/compute.cell.types.md)
(one element per cell type) are both built from it, excluding
`uncharacterized_cell`, which is in the vocabulary only so Quantiseq’s
proportions sum to 1. To add a cell type: add its name to the vocabulary
and a block (search pattern + rename pattern) in
[`standardize_celltype_colnames()`](https://verapancaldilab.github.io/multideconv/reference/standardize_celltype_colnames.md)
— simple ones go in the `other` list there, placed before the final
B-cell step, which renames everything left over. Block order matters:
earlier blocks claim columns first (e.g. pDCs must be split out of the
Dendritic block before the Plasma block runs). `cells_extra` entries
that are already in the vocabulary are ignored.

[`compute.cell.types()`](https://verapancaldilab.github.io/multideconv/reference/compute.cell.types.md)
intentionally matches cell types by **unanchored substring**
(`grep("Plasma", ...)`), so older/non-standard names
(e.g. `T.cells.CD4.memory.activated`, `Plasma.cells` in `deconv_bulk`)
are still recognized. Anchoring the patterns breaks this.

Feature names must survive the analysis unchanged (users may pass names
with `-`, spaces, …): every
[`data.frame()`](https://rdrr.io/r/base/data.frame.html) in the analysis
path
([`compute_subgroups()`](https://verapancaldilab.github.io/multideconv/reference/compute_subgroups.md),
[`corr_subgroups()`](https://verapancaldilab.github.io/multideconv/reference/corr_subgroups.md),
[`compute.deconvolution.analysis()`](https://verapancaldilab.github.io/multideconv/reference/compute.deconvolution.analysis.md),
[`replicate_deconvolution_subgroups()`](https://verapancaldilab.github.io/multideconv/reference/replicate_deconvolution_subgroups.md))
uses `check.names = FALSE`. A
[`data.frame()`](https://rdrr.io/r/base/data.frame.html) without it
rewrites names, lookups by name then fail and features are silently
dropped or replicated as zeros.

With `batch`,
[`corr_subgroups()`](https://verapancaldilab.github.io/multideconv/reference/corr_subgroups.md)
uses partial correlations (`ppcor`) and applies the same filter as
without batch (p \< 0.05, no `NA`). A factor/character batch is coded as
one indicator column per batch (`model.matrix(~ factor(batch))[, -1]`),
so every batch’s own shift is removed; a numeric batch is used as one
linear covariate. With a single batch,
[`compute.deconvolution.analysis()`](https://verapancaldilab.github.io/multideconv/reference/compute.deconvolution.analysis.md)
falls back to ordinary correlations.

Subgroup names are `<CellType>_Subgroup.<i>`; there are no iterations
(the old `.Iteration.<k>` suffix was removed). Numbering is
deterministic because features are sorted by name before clustering.

### Cell group aggregation

`aggregate_cell_groups(deconvolution, cell_groups, min_types = 2, verbose = TRUE)`
adds `<method>_<signature>_<group>` = sum of the group’s cell types,
**only within one method-signature combination** (proportions of the
same sample; never across methods). Rules agreed with the user: - Member
features are **kept** (nothing is replaced). - A combination that
already has the group column is skipped, so a group may reuse a
vocabulary name (`Myeloid.cells`) and the function is idempotent. - A
combination needs at least `min_types` (2) members present, otherwise it
is skipped. - It prints one line per combination (summed members /
already has it / skipped) and warns about members that are neither in
the vocabulary nor in the data. - New group names (not in the
vocabulary) must not contain `_` nor a vocabulary cell type name
(e.g. `Cancer.cells`, `All.B.cells`):
[`compute.cell.types()`](https://verapancaldilab.github.io/multideconv/reference/compute.cell.types.md)
matches by unanchored substring, so such a feature would be counted in
two cell types. This is a
[`stop()`](https://rdrr.io/r/base/stop.html). - Method-signature
combinations are found by stripping a vocabulary cell type from the end
of the column names; `cells_extra` cell types can be group members but
do not define combinations.

`compute.deconvolution.analysis(cell_groups = )` and
`prepare_multideconv_folds(cell_groups = )` use it with the default
`min_types`; for another value, call
[`aggregate_cell_groups()`](https://verapancaldilab.github.io/multideconv/reference/aggregate_cell_groups.md)
first and pass new group names in `cells_extra` (then the new cohort
must be aggregated by hand before
[`replicate_deconvolution_subgroups()`](https://verapancaldilab.github.io/multideconv/reference/replicate_deconvolution_subgroups.md)).

### Custom Signatures

Users can add `.txt` signature files to `Results/custom_signatures/`;
[`compute.deconvolution()`](https://verapancaldilab.github.io/multideconv/reference/compute.deconvolution.md)
picks them up automatically (use `signatures_select` to restrict).

### Parallel Execution

`doParallel`/`foreach` for method-level parallelism and
`future`/`future.apply` for metacells. When debugging, set
`future::plan(future::sequential)`.

## Testing

`tests/testthat/` (testthat edition 3, `withr` in Suggests) covers
nomenclature, preprocessing, analysis + replication, cell group
aggregation (also through the analysis, replication and folds), subgroup
grouping (every pair in a subgroup \>= `corr`, same result for any
column order; same-method features are grouped like any others),
replication (including subgroups built from earlier subgroups),
benchmark, fold construction and CBSX skipping. Tests use the built-in
datasets (`deconvolution`, `cells_groundtruth`, `raw_counts`) and run in
a temporary directory;
[`compute.deconvolution()`](https://verapancaldilab.github.io/multideconv/reference/compute.deconvolution.md)
tests are `skip_on_cran()`.
