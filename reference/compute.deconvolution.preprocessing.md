# Compute deconvolution preprocessing

Give consistent names and patterns following the method_signature_cell
structure to the deconvolution features

## Usage

``` r
compute.deconvolution.preprocessing(deconv, cells_extra = NULL)
```

## Arguments

- deconv:

  A dataframe with the unprocessed deconvolution features

## Value

A matrix of the preprocessed deconvolution features with fixed and
consistent names across the different methods and signatures following
the nomenclature specified in multideconv (see Readme)

## Examples

``` r
data("deconvolution")

deconvolution = multideconv:::compute.deconvolution.preprocessing(deconvolution)
#> Preprocessing deconvolution features...............................................................
#> 
#> Error in if (prefix == "") {    "CD4.regulatory"} else {    "\\1_CD4.regulatory"}: the condition has length > 1
```
