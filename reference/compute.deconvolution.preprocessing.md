# Compute deconvolution preprocessing

Give consistent names and patterns following the method_signature_cell
structure to the deconvolution features

## Usage

``` r
compute.deconvolution.preprocessing(deconv)
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
#> Checking consistency in deconvolution cell fractions across patients...............................................................
#> 
#> 
#> Total sum across samples of combination Quantiseq is 1
#> Total sum across samples of combination Epidish_BPRNACan_ is 1
#> Total sum across samples of combination Epidish_BPRNACanProMet is 1
#> Total sum across samples of combination Epidish_BPRNACan3DProMet is 1
#> Total sum across samples of combination Epidish_CBSX.HNSCC.scRNAseq is 1
#> Total sum across samples of combination Epidish_CBSX.Melanoma.scRNAseq is 1
#> Total sum across samples of combination Epidish_CBSX.NSCLC.PBMCs.scRNAseq is 1
#> Total sum across samples of combination Epidish_CCLE.TIL10 is 1
#> Total sum across samples of combination Epidish_TIL10 is 1
#> Total sum across samples of combination Epidish_LM22 is 1
#> Total sum across samples of combination DeconRNASeq_BPRNACan_ is 1
#> Total sum across samples of combination DeconRNASeq_BPRNACanProMet is 1
#> Total sum across samples of combination DeconRNASeq_BPRNACan3DProMet is 1
#> Total sum across samples of combination DeconRNASeq_CBSX.HNSCC.scRNAseq is 1
#> Total sum across samples of combination DeconRNASeq_CBSX.Melanoma.scRNAseq is 1
#> Total sum across samples of combination DeconRNASeq_CBSX.NSCLC.PBMCs.scRNAseq is 1
#> Total sum across samples of combination DeconRNASeq_CCLE.TIL10 is 1
#> Total sum across samples of combination DeconRNASeq_TIL10 is 1
#> Total sum across samples of combination DeconRNASeq_LM22 is 1
#> Total sum across samples of combination CBSX_BPRNACan_ is 1
#> Total sum across samples of combination CBSX_BPRNACanProMet is 1
#> Total sum across samples of combination CBSX_BPRNACan3DProMet is 1
#> Total sum across samples of combination CBSX_CBSX.HNSCC.scRNAseq is 1
#> Total sum across samples of combination CBSX_CBSX.Melanoma.scRNAseq is 1
#> Total sum across samples of combination CBSX_CBSX.NSCLC.PBMCs.scRNAseq is 1
#> Total sum across samples of combination CBSX_CCLE.TIL10 is 1
#> Total sum across samples of combination CBSX_TIL10 is 1
#> Total sum across samples of combination CBSX_LM22 is 1
#> Total sum across samples of combination DWLS_BPRNACan_ is 1
#> Total sum across samples of combination DWLS_BPRNACanProMet is 1
#> Total sum across samples of combination DWLS_BPRNACan3DProMet is 1
#> Total sum across samples of combination DWLS_CBSX.HNSCC.scRNAseq is 1
#> Total sum across samples of combination Epidish_CBSX.Melanoma.scRNAseq is 1
#> Total sum across samples of combination DWLS_CBSX.NSCLC.PBMCs.scRNAseq is 1
#> Total sum across samples of combination DWLS_CCLE.TIL10 is 1
#> Total sum across samples of combination DWLS_TIL10 is 1
#> Total sum across samples of combination DWLS_LM22 is 1
```
