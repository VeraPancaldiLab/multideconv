# Compute deconvolution subgroups

Compute deconvolution subgroups

## Usage

``` r
compute_subgroups(deconvolution, thres_corr, corr_type, file_name)
```

## Arguments

- deconvolution:

  A matrix with unprocessed cell deconvolution results

- thres_corr:

  A numeric value with the minimum correlation allowed to group cell
  deconvolution features

- corr_type:

  Correlation type whether "spearman" or "pearson".

- file_name:

  Base name for subgroup

## Value

A list containing

- A matrix with the processed deconvolution features

- Cell subgroups obtained by linear correlation

- Cell subgroups obtained by proportionality correlation

- Discard cell features either because of low variance or high zero
  number
