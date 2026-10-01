# Replicate deconvolution subgroups in a new dataset

Reconstructs and applies deconvolution subgroup signatures based on a
previous decomposition.

## Usage

``` r
replicate_deconvolution_subgroups(deconv_res, deconvolution_test)
```

## Arguments

- deconv_res:

  A list containing results from the deconvolution process, including:

  - `Deconvolution subgroups composition`: the member features of each
    subgroup, per cell type

  - `Deconvolution matrix`: the original deconvolution result used to
    determine relevant features

- deconvolution_test:

  A data.frame or matrix of deconvolution results (e.g., from another
  cohort). If `deconv_res` was computed with `cell_groups`, the same
  cell groups are aggregated here first (see
  [`aggregate_cell_groups()`](https://verapancaldilab.github.io/multideconv/reference/aggregate_cell_groups.md)),
  so give the deconvolution as returned by
  [`compute.deconvolution()`](https://verapancaldilab.github.io/multideconv/reference/compute.deconvolution.md).

## Value

A data.frame with the projected subgroup features proportions: the same
features, in the same order, as the "Deconvolution matrix" of
`deconv_res`. Each subgroup is the median of its member features.
Subgroups with no member in `deconvolution_test`, and training features
missing from it, are set to `NA` with a warning; a warning also lists
subgroups computed from only part of their members.
