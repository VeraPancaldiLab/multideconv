# Compute deconvolution benchmark

Compute deconvolution benchmark

## Usage

``` r
compute.benchmark(
  deconvolution,
  groundtruth,
  cells_extra = NULL,
  corr_type = "spearman",
  scatter = TRUE,
  plot = FALSE,
  pval = 0.05,
  file_name = NULL,
  width = 16,
  height = 8
)
```

## Arguments

- deconvolution:

  The deconvolution matrix output from compute.deconvolution()

- groundtruth:

  A matrix with the cell type proportions (samples as rows and cell
  types as columns). Cell types names should correspond to the ones on
  the deconvolution matrix.

- cells_extra:

  A string specifying the cells names to consider and that are not
  including in the nomenclature of multideconv (see Readme)

- corr_type:

  Secifies the type of correlations to compute ('spearman' or
  'pearson').

- scatter:

  Boolean value to specify if scatter plots should be returned.

- plot:

  Boolean value to whether save or not the plot of the benchmark in the
  Results/ directory.

- pval:

  A numeric value with the pvalue to use for selecting significant
  features.

- file_name:

  A string specifying the name of the plot saved in Results/

- width:

  A numeric value with the width for the returned plot.

- height:

  A numeric value with the height for the returned plot.

## Value

A correlation matrix between the cell type deconvolution combinations
and the real cell proportions.

## Examples

``` r
data("deconvolution")
data("cells_groundtruth")

corr_matrix = compute.benchmark(deconvolution, cells_groundtruth, cells_extra = "Myeloid.cells",
                                corr_type = "spearman", scatter = FALSE)
#> No id variables; using all as measure variables
#> No id variables; using all as measure variables
```
