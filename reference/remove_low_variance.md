# Remove low variance deconvolution features

Remove low variance deconvolution features

## Usage

``` r
remove_low_variance(data, var_quantile = 0.25)
```

## Arguments

- data:

  Deconvolution features

- var_quantile:

  Quantile threshold below which features are discarded.

## Value

A list containing

- Deconvolution matrix after removal of low variance.

- Discarded low variance features.
