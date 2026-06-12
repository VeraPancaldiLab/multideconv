# Compute cell type processing

Compute cell type processing

## Usage

``` r
compute.deconvolution.analysis(
  deconvolution,
  corr = 0.7,
  corr_type = "spearman",
  zero_thr = 0.9,
  var_quantile = 0.25,
  prune_thr = 0.9,
  seed = NULL,
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

- var_quantile:

  Quantile threshold below which low-variance features are removed.

- prune_thr:

  Pearson correlation threshold above which highly correlated features
  are pruned.

- seed:

  A numeric value to specificy the seed. This ensures reproducibility
  during the choice step of high correlated features.

- batch:

  Optional batch covariate used to compute partial correlations.

- cells_extra:

  A string specifying the cells names to consider and that are not
  including in the nomenclature of multideconv (see Readme)

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

- The deconvolution groups discarded caused they are all belonging to
  the same method

- The discarded features because they contain a high number of zeros
  across samples (\> 90%)

- Discarded features due to low variance across samples

- Discarded cell types because they are not supported in the pipeline

- High correlated deconvolution pairs (\>high_corr)

## Examples

``` r

data("deconvolution")

processed_deconvolution = compute.deconvolution.analysis(deconvolution, corr = 0.7, seed = 123)

processed_deconvolution = compute.deconvolution.analysis(deconvolution, cells_extra = "mesenchymal")
```
