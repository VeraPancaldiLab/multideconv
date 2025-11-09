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

  - `Deconvolution subgroups composition`: a list of subgroup feature
    names per iteration

  - `Deconvolution matrix`: the original deconvolution result used to
    determine relevant features

- deconvolution_test:

  A data.frame or matrix of deconvolution results (e.g., from another
  cohort)

## Value

A data.frame with the projected subgroup features proportions
