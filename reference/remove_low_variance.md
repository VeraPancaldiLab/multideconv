# Remove low variance deconvolution features

Removes features that barely vary across samples: features whose
coefficient of variation (CV = standard deviation / mean) is below
`cv_thr`. Each feature is judged on its own, so features of rare cell
types (small values) are kept as long as they vary relative to their
size.

## Usage

``` r
remove_low_variance(data, cv_thr = 0.1)
```

## Arguments

- data:

  Deconvolution features

- cv_thr:

  Minimum coefficient of variation; features below it are discarded.

## Value

A list containing

- Deconvolution matrix after removal of low variance.

- Discarded low variance features.
