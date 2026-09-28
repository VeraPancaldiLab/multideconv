# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What This Package Does

**multideconv** is an R package providing an integrative pipeline for combining multiple cell type deconvolution methods (both first- and second-generation) from bulk RNA-seq data. It harmonizes outputs across methods, removes redundant cell types via correlation analysis, and identifies robust cell subgroups.

## Working Rules

- **Describe a fix and get approval before editing code.** Report the bug, the proposed change and how it was verified; apply only after the user agrees.
- **Test with small data only.** The dev machine has ~15 GB RAM. Subsample (e.g. ~200 cells x 2,000 genes, 4 bulk samples), use 1 worker/core, cap runs with `timeout`, and run heavy methods one at a time. Never compile large packages (e.g. Seurat) from source with many cores; use Posit Package Manager binaries into a temporary library instead.
- Never write test output into the package tree or the user's home; run in a temp directory (`withr::local_tempdir()`) and clean up.

## Development Commands

```r
devtools::load_all()     # interactive development
devtools::document()     # regenerate man/ + NAMESPACE (required after any roxygen change)
devtools::test()         # testthat suite in tests/testthat/
devtools::check()        # R CMD check
pkgdown::check_pkgdown() # verify _pkgdown.yml before pushing
shiny::runApp('inst/shiny', host='127.0.0.1', port=3838)
```

### CI (GitHub Actions)

- `R-CMD-check.yaml` fails on any **WARNING**. A roxygen block without a regenerated `.Rd` (forgetting `devtools::document()`) produces "Undocumented code objects" and fails CI.
- `pkgdown.yaml` fails if any documented topic is missing from the `reference:` index in `_pkgdown.yml`. Every new exported/documented function must be added there (sections: Main, Benchmarking, Single cell functions, Helpers = exported helpers, Internal = not exported, Package Data) or marked `@keywords internal`.
- Non-package files at top level must be listed in `.Rbuildignore` (CLAUDE.md, Results, Rplots.pdf, launch_app.R, .vscode, .claude, pypath_log, omnipathr-log, ...). Do not ignore `vignettes/Results/`: the a4 vignette embeds `vignettes/Results/Benchmark.png`.

## Installation

```r
pak::pkg_install("VeraPancaldiLab/multideconv")
```

Several dependencies come from GitHub remotes (omnideconv, immunedeconv, DWLS, BayesPrism, MOMF, bisque) — see `DESCRIPTION`. `hdWGCNA` is an optional runtime dependency (`pak::pkg_install("smorabit/hdWGCNA")`) needed only by `create_metacells()`; it is not a `Remote` and is checked via `requireNamespace()`. `Seurat` is in Suggests: functions using it (`create_metacells()`, `create_sc_pseudobulk()`) must check `requireNamespace("Seurat")` first.

CIBERSORTx requires credentials and Docker (image `cibersortx/fractions`). AutogeneS runs in omnideconv's Python conda env `r-omnideconv` (module `autogenes`).

## Architecture

All functions live in a single file: `R/cell_deconvolution.R` (~3,000 lines). This is intentional.

### Core Pipeline Flow

1. **`compute.deconvolution()`** — TPM-normalizes (`normalized = TRUE` means "normalize the input"), runs Quantiseq plus the signature-based methods over every signature (bundled + `Results/custom_signatures/`), then standardizes names via `compute.deconvolution.preprocessing()`. Per-method/signature results are cached as `Results/deconv_<method>_<sig>.rds` while running (crash recovery) and deleted at the end; `Results/` is removed again if it was created only for the cache. It stops with a clear error if no method produced output.
   - **CBSX without credentials is skipped with a warning** (it is in the default `methods`), not a hard error.
   - `doParallel = TRUE` with `workers = NULL` uses `detectCores() - 1`.
2. **`compute.deconvolution.analysis()`** — removes zero-heavy features (`zero_thr`) and low-variance features (`var_quantile`, global quantile), splits by cell type (`compute.cell.types()`), prunes highly correlated features within a cell type (`prune_thr`, using `corr_type` — not always Pearson), then builds subgroups iteratively (`compute_subgroups()`/`corr_subgroups()`, homegrown, not WGCNA). With `batch`, correlations are partial correlations (`ppcor`) controlling for batch.
3. **`replicate_deconvolution_subgroups()`** — applies the learned subgroups (medians of member features, iteration by iteration) to a new cohort. On the training data it reproduces the "Deconvolution matrix" exactly.
4. **`prepare_multideconv_folds()`** — fold-aware feature construction for pipeML (see below).
5. **Single-cell workflow** — `create_metacells()` → `create_sc_pseudobulk()` / `create_sc_signatures()` → `compute_sc_deconvolution_methods()`.

### Method Categories

- **First-generation / signature-based**: Quantiseq (`immunedeconv`, TIL10), EpiDISH, DeconRNASeq, DWLS, CIBERSORTx (CBSX, via `omnideconv`), MOMF (needs `sc_matrix`). MCP-counter and xCell were removed (helpers kept commented out).
- **Second-generation** (`compute_sc_deconvolution_methods()`, via `omnideconv`, need a single-cell reference): AutogeneS, BayesPrism, Bisque, CPM, MuSiC, SCDC. AutogeneS and CPM are slow even on tiny inputs (tens of minutes / >5 min).

### Method-specific pitfalls

- **Result element names differ per method** and are extracted by name (`$proportions`, `$theta`, `$bulk.props`, `$cellTypePredictions`, `$Est.prop.weighted`, `$prop.est.mvw`, `$cell.prop`). A wrong name silently yields `NULL` and the method disappears from the output. BisqueRNA returns `bulk.props` as **cell types x samples**, so it is transposed; every method must end up samples x cell types.
- **CIBERSORTx fallback** (`computeCBSX()`, also used by the parallel version): omnideconv defaults `input_dir`/`output_dir` to `tempdir()`. On some machines the container crashes (error code 139, `..._Results.txt does not exist`). Only on that error it retries once with `~/user_projects/cibersort/{input,output}` (created on demand); any other error is re-raised.
- `name_object` / `name_signature` default to `"scRNAseq"` / `"custom"` when `NULL`, to avoid `Method__cell` names and `DWLS--scRNAseq.txt` files.

### Metacells (Seurat 4 and 5)

`create_metacells()` / `process_group()` must work with both Seurat 4 (SeuratObject 4.x, `Assay`) and Seurat 5 (SeuratObject 5.x, `Assay5`, possibly split layers). Verified on Seurat 4.4.0 and 5.5.1.
- Read counts from the metacell object's own assay (`DefaultAssay(meta)`; hdWGCNA keeps the input's default assay, e.g. `SCT`), with `LayerData(layer = "counts")` on SeuratObject >= 5 and `GetAssayData(slot = "counts")` on 4. The `slot` argument is defunct in recent SeuratObject 5 and `layer` does not exist in 4.
- Group subsets are built by selecting cell names from the metadata with `which()` and calling `subset(data, cells = cells_use)`. Do **not** use `subset(subset = samples_ids == patient, ...)`: a metadata column named e.g. `patient` shadows the loop variable and silently returns empty groups. `which()` handles `NA` labels.
- `subset()` is base R's S3 generic; it dispatches to `SeuratObject`'s `subset.Seurat`. `Seurat::subset` does not exist — do not write it.
- The user's `future` plan is saved and restored (`on.exit`), also on error. hdWGCNA's `MetacellsByGroups()` needs a `pca` reduction already present in the input object.

### Cross-validation folds (`prepare_multideconv_folds()` ↔ pipeML)

- `folds` is a list of **training** row indices (e.g. `caret::createMultiFolds`); the test set is the complement.
- Fold mode writes `Results/fold_<fold name>.rds` (each with `train_data`, `test_data`, `obs_test`, `rowIndex`, `fold_name`) and returns the folds invisibly. pipeML reads back **every** `Results/fold_*.rds` in alphabetical order and relies on each file's own `rowIndex`, so stale `fold_*.rds` files are deleted before writing (pipeML's survival path never deletes them). Unnamed folds are named `Fold1`, `Fold2`, ...
- `bestune` mode returns `list(features_with_target, full_analysis_output, bestune)`.
- Workers (`doParallel`) load the **installed** multideconv, not `load_all()` code: reinstall (e.g. into a temp library via `R CMD INSTALL -l`) before testing parallel code paths.

### File Layout

- `R/cell_deconvolution.R` — all function implementations
- `R/data.R` — documentation for built-in datasets
- `R/zzz.R` — `ensure_results_dir()` helper; `.onLoad()` creates `Results/custom_signatures/` **only in interactive sessions** (CRAN/R CMD check forbid writing to the working directory at load time)
- `inst/shiny/app.R` — Shiny app (creates its own `Results/`)
- `inst/signatures/` — bundled signature matrices (LM22, TIL10, CBSX-*-scRNAseq)
- `data/` — sample datasets
- `tests/testthat/` — test suite (small built-in data, runs in a temp dir)
- `vignettes/` — `multideconv.Rmd` plus articles `a1_deconvolution` → `a5_machine_learning`

### Output files

Every function that writes into `Results/` must call `ensure_results_dir()` first; do not assume `.onLoad()` created it.

### Cell Type Nomenclature

Column names follow `method_signature_celltype`, with `_` as the separator. `standardize_celltype_colnames()` harmonizes cell names (it only renames the part after the last `_`, so cell labels in custom signatures must not contain `_`). `get_cell_type_nomenclature()` is the single source of truth for the vocabulary; other code, including sister packages like CellTFusion, should call it rather than hardcode a copy. All cell names in the bundled signatures map to the correct cell type.

`compute.cell.types()` intentionally matches cell types by **unanchored substring** (`grep("Plasma", ...)`), so older/non-standard names (e.g. `T.cells.CD4.memory.activated`, `Plasma.cells` in `deconv_bulk`) are still recognized. Anchoring the patterns breaks this.

Subgroup names are `<CellType>_Subgroup.<i>.Iteration.<m>`. Match iterations exactly (`"\\.Iteration\\.<m>$"`), otherwise `Iteration.1` also matches `Iteration.10`.

### Custom Signatures

Users can add `.txt` signature files to `Results/custom_signatures/`; `compute.deconvolution()` picks them up automatically (use `signatures_select` to restrict).

### Parallel Execution

`doParallel`/`foreach` for method-level parallelism and `future`/`future.apply` for metacells. When debugging, set `future::plan(future::sequential)`.

## Testing

`tests/testthat/` (testthat edition 3, `withr` in Suggests) covers nomenclature, preprocessing, analysis + replication, correlation pruning (with/without batch), subgroup deduplication, iteration matching, benchmark, fold construction and CBSX skipping. Tests use the built-in datasets (`deconvolution`, `cells_groundtruth`, `raw_counts`) and run in a temporary directory; `compute.deconvolution()` tests are `skip_on_cran()`.
