# Changelog

## multideconv (development version)

### New features

- New
  [`aggregate_cell_groups()`](https://verapancaldilab.github.io/multideconv/reference/aggregate_cell_groups.md):
  sums cell types into user-defined groups (e.g. Myeloid cells =
  macrophages + monocytes + dendritic cells) within each
  method-signature combination, adding a feature
  `<method>_<signature>_<group>`. The original features are kept,
  combinations that already estimate the group are left as they are and
  combinations with fewer than `min_types` (default 2) cell types of the
  group are skipped. It prints which cell types were summed in each
  combination.
- [`compute.deconvolution.analysis()`](https://verapancaldilab.github.io/multideconv/reference/compute.deconvolution.analysis.md)
  and
  [`prepare_multideconv_folds()`](https://verapancaldilab.github.io/multideconv/reference/prepare_multideconv_folds.md)
  have a `cell_groups` argument that aggregates the groups before the
  analysis and analyses them as any other cell type. The output of
  [`compute.deconvolution.analysis()`](https://verapancaldilab.github.io/multideconv/reference/compute.deconvolution.analysis.md)
  has a new last element, “Cell groups”, and
  [`replicate_deconvolution_subgroups()`](https://verapancaldilab.github.io/multideconv/reference/replicate_deconvolution_subgroups.md)
  uses it to aggregate the same groups in a new cohort.

## multideconv 0.2.0

### Breaking changes

- [`compute.deconvolution.analysis()`](https://verapancaldilab.github.io/multideconv/reference/compute.deconvolution.analysis.md)
  now builds cell subgroups with complete-linkage hierarchical
  clustering of the feature correlations: features form a subgroup only
  if every pair of them correlates at least `corr`. Results no longer
  depend on the order of the columns.
- Subgroups are named `<CellType>_Subgroup.<i>`: the `.Iteration.<k>`
  suffix was removed.
- The pruning step was removed together with
  `removeCorrelatedFeatures()`:
  [`compute.deconvolution.analysis()`](https://verapancaldilab.github.io/multideconv/reference/compute.deconvolution.analysis.md)
  and
  [`prepare_multideconv_folds()`](https://verapancaldilab.github.io/multideconv/reference/prepare_multideconv_folds.md)
  no longer have the `prune_thr` and `seed` arguments.
- The output of
  [`compute.deconvolution.analysis()`](https://verapancaldilab.github.io/multideconv/reference/compute.deconvolution.analysis.md)
  no longer contains “Discarded groups with equal method” (same-method
  subgroups are kept) nor “High correlated deconvolution groups (\>0.9)
  per cell type”.
- The low-variance filter now removes features whose coefficient of
  variation (sd / mean) is below `cv_thr` (default 0.1) instead of the
  25% least variable features: `var_quantile` was replaced by `cv_thr`
  in
  [`compute.deconvolution.analysis()`](https://verapancaldilab.github.io/multideconv/reference/compute.deconvolution.analysis.md)
  and
  [`prepare_multideconv_folds()`](https://verapancaldilab.github.io/multideconv/reference/prepare_multideconv_folds.md).
  Rare cell types are no longer removed only because their values are
  small.
- [`computeCBSX()`](https://verapancaldilab.github.io/multideconv/reference/computeCBSX.md),
  [`computeDWLS()`](https://verapancaldilab.github.io/multideconv/reference/computeDWLS.md)
  and
  [`computeMOMF()`](https://verapancaldilab.github.io/multideconv/reference/computeMOMF.md)
  are no longer exported. Second-generation methods are run with
  `compute.deconvolution(sc_deconv = TRUE)`.

### New features and improvements

- New cell types: `Dendritic.plasmacytoid.cells`, `Myeloid.cells`,
  `Basophils`, `Epithelial`, `Pericytes`, `Mural.cells` and
  `T.cells.proliferative`.
  [`get_cell_type_nomenclature()`](https://verapancaldilab.github.io/multideconv/reference/get_cell_type_nomenclature.md)
  is the single source of the cell type vocabulary.
- A factor/character `batch` is adjusted with one indicator per batch,
  which is correct for 3 or more batches.
- [`create_metacells()`](https://verapancaldilab.github.io/multideconv/reference/create_metacells.md)
  works with Seurat 4 and Seurat 5 objects and with a default assay
  other than “RNA”.
- [`create_sc_pseudobulk()`](https://verapancaldilab.github.io/multideconv/reference/create_sc_pseudobulk.md)
  now sums the counts of each sample’s cells (previously the mean;
  identical after TPM normalisation), keeps sample names unchanged,
  saves a comma-separated CSV (previously tab-separated) and has a
  `return` argument to skip saving. `cells_labels` is no longer needed.
- [`create_metacells()`](https://verapancaldilab.github.io/multideconv/reference/create_metacells.md)
  metacells are now the **sum** of the counts of their cells (integer
  counts; previously the average), and `max_shared` defaults to 10
  (previously 15, which with `k = 15` allowed metacells to overlap
  completely).
- CIBERSORTx is retried with fixed input/output folders when the
  container fails with error code 139.
- [`compute.deconvolution()`](https://verapancaldilab.github.io/multideconv/reference/compute.deconvolution.md)
  skips CIBERSORTx with a warning when no credentials are given.
- [`compute.subgroup.pathways()`](https://verapancaldilab.github.io/multideconv/reference/compute.subgroup.pathways.md)
  returns the correlations and p-values per cell type (in addition to
  the PDFs), has a `corr_type` argument (“pearson” or “spearman”), uses
  `width`/`height` when given, keeps pathway and feature names unchanged
  and stops with a clear error when sample names do not match.
- [`create_sc_signatures()`](https://verapancaldilab.github.io/multideconv/reference/create_sc_signatures.md)
  accepts method names in any case (and “CBSX” for “CIBERSORTx”), warns
  about unknown ones, replaces `_` in `name_signature` and reports
  overwritten signature files.
- [`compute.benchmark()`](https://verapancaldilab.github.io/multideconv/reference/compute.benchmark.md):
  the scatter plots report one correlation per cell type instead of a
  single pooled correlation, and the heatmap labels show how many cell
  types each average is based on. For subgrouped input no “average” row
  is computed (a column such as `Subgroup.1` holds unrelated features).

### Bug fixes

- Bisque results were silently dropped from the second-generation
  deconvolution.
- Feature names with characters such as `-` are kept unchanged
  throughout the analysis and replication.
- [`replicate_deconvolution_subgroups()`](https://verapancaldilab.github.io/multideconv/reference/replicate_deconvolution_subgroups.md),
  [`compute.benchmark()`](https://verapancaldilab.github.io/multideconv/reference/compute.benchmark.md)
  and
  [`prepare_multideconv_folds()`](https://verapancaldilab.github.io/multideconv/reference/prepare_multideconv_folds.md)
  now handle edge cases (single ground-truth cell type, unnamed folds,
  stale fold files).

## multideconv 0.0.1

This is the first release version of multideconv! 🎉

- Added a `NEWS.md` file to track changes to the package.
- Main functions for cell type deconvolution:
  - [`compute.deconvolution()`](https://verapancaldilab.github.io/multideconv/reference/compute.deconvolution.md)
  - [`compute.deconvolution.analysis()`](https://verapancaldilab.github.io/multideconv/reference/compute.deconvolution.analysis.md)
  - [`compute.deconvolution.preprocessing()`](https://verapancaldilab.github.io/multideconv/reference/compute.deconvolution.preprocessing.md)
  - [`compute_methods_variable_signature()`](https://verapancaldilab.github.io/multideconv/reference/compute_methods_variable_signature.md)
- Support for single-cell data for cell type deconvolution:
  - [`create_metacells()`](https://verapancaldilab.github.io/multideconv/reference/create_metacells.md)
  - [`create_sc_pseudobulk()`](https://verapancaldilab.github.io/multideconv/reference/create_sc_pseudobulk.md)
  - [`create_sc_signatures()`](https://verapancaldilab.github.io/multideconv/reference/create_sc_signatures.md)
  - [`compute_sc_deconvolution_methods()`](https://verapancaldilab.github.io/multideconv/reference/compute_sc_deconvolution_methods.md)
  - [`compute.benchmark()`](https://verapancaldilab.github.io/multideconv/reference/compute.benchmark.md)
- New vignettes:
  - [Getting
    started](https://verapancaldilab.github.io/multideconv/articles/multideconv.html)
