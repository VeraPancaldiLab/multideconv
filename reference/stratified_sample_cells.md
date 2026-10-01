# Subsample cells per cell type

Randomly keeps at most `n_cells_per_type` cells of each cell type. Used
to limit the size of the single-cell reference for CPM in
[`compute_sc_deconvolution_methods()`](https://verapancaldilab.github.io/multideconv/reference/compute_sc_deconvolution_methods.md).

## Usage

``` r
stratified_sample_cells(
  SCData,
  SCData_metadata,
  cell_label,
  n_cells_per_type = 500,
  seed = 123
)
```

## Arguments

- SCData:

  A count matrix (genes x cells); its column names must match the row
  names of `SCData_metadata`.

- SCData_metadata:

  A data frame with one row per cell (row names = cell names).

- cell_label:

  Name of the metadata column with the cell type labels.

- n_cells_per_type:

  Maximum number of cells kept per cell type.

- seed:

  Random seed for the sampling.

## Value

A list with `Counts` (subsampled count matrix) and `Metadata` (matching
metadata).
