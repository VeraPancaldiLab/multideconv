# Compute cell type processing

Compute cell type processing

## Usage

``` r
compute.deconvolution.analysis(
  deconvolution,
  corr = 0.7,
  corr_type = "spearman",
  zero_thr = 0.9,
  cv_thr = 0.1,
  batch = NULL,
  cells_extra = NULL,
  file_name = NULL,
  return = FALSE,
  verbose = FALSE
)
```

## Arguments

- deconvolution:

  Deconvolution output of compute.deconvolution() with features as
  columns and samples as rows

- corr:

  Minimum correlation threshold for subgroupping the deconvolution
  features

- corr_type:

  Correlation type for computing the cell subgroups, whether "spearman"
  or "pearson".

- zero_thr:

  Maximum fraction of zeros allowed per feature before it is discarded.

- cv_thr:

  Minimum coefficient of variation (standard deviation / mean) across
  samples; features below it are removed.

- batch:

  Optional batch labels, one per sample in the same order as the rows. A
  factor or character is treated as categorical: correlations become
  partial correlations controlling for one indicator column per batch. A
  numeric vector is used as a single linear covariate. With only one
  batch, ordinary correlations are used.

- cells_extra:

  A string specifying the cells names to consider and that are not
  including in the nomenclature of multideconv (see Readme). This
  includes groups created with
  [`aggregate_cell_groups()`](https://verapancaldilab.github.io/multideconv/reference/aggregate_cell_groups.md)
  under a new name (e.g. `Lymphocytes`): if they are not listed here
  they are discarded.

- file_name:

  A string specifying the file name of the .csv file with the
  deconvolution subgroups

- return:

  Boolean value to whether return and saved the plot and csv files of
  deconvolution generated during the run inside the Results/ directory.

- verbose:

  Boolen value to whether print or no the function messages

## Value

A list containing

- A matrix with the deconvolution after processing

- The deconvolution subgroups per cell type

- The deconvolution subgroups composition

- The discarded features because they contain a high number of zeros
  across samples (\> 90%)

- Discarded features due to low variance across samples

- Discarded cell types because they are not supported in the pipeline

## Examples

``` r

data("deconvolution")

processed_deconvolution = compute.deconvolution.analysis(deconvolution, corr = 0.7)

processed_deconvolution = compute.deconvolution.analysis(deconvolution, cells_extra = "mesenchymal")
```
