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

- cells_extra:

  A character vector of non-standard cell type names to retain.

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
#> No extra cell types provided. Only the following cell types will be considered:
#>  B.cells
#> B.naive.cells
#> B.memory.cells
#> Macrophages.cells
#> Macrophages.M0
#> Macrophages.M1
#> Macrophages.M2
#> Monocytes
#> Neutrophils
#> NK.cells
#> NK.activated
#> NK.resting
#> NKT.cells
#> CD4.cells
#> CD4.memory.activated
#> CD4.memory.resting
#> CD4.naive
#> CD8.cells
#> CD4.regulatory
#> CD4.non.regulatory
#> T.cells.helper
#> T.cells.gamma.delta
#> Dendritic.cells
#> Dendritic.activated.cells
#> Dendritic.resting.cells
#> Cancer
#> Endothelial
#> Eosinophils
#> Plasma
#> Myocytes
#> Fibroblast
#> Mast.cells
#> Mast.activated.cells
#> Mast.resting.cells
#> CAF
#> uncharacterized_cell 
#> 
#> If you want to consider other cell types (e.g. from a custom signature) which are not included in the package by default (see README), please provide them in the cells_extra argument.
#> 
#> Total sum across samples of combination Quantiseq is 1
#> Total sum across samples of combination DeconRNASeq_BPRNACan is 1
#> Total sum across samples of combination Epidish_BPRNACan is 1
#> Total sum across samples of combination CBSX_BPRNACan is 1
#> Total sum across samples of combination DWLS_BPRNACan is 1
#> Total sum across samples of combination DeconRNASeq_BPRNACan3DProMet is 1
#> Total sum across samples of combination Epidish_BPRNACan3DProMet is 1
#> Total sum across samples of combination CBSX_BPRNACan3DProMet is 1
#> Total sum across samples of combination DWLS_BPRNACan3DProMet is 1
#> Total sum across samples of combination DeconRNASeq_BPRNACanProMet is 1
#> Total sum across samples of combination Epidish_BPRNACanProMet is 1
#> Total sum across samples of combination CBSX_BPRNACanProMet is 1
#> Total sum across samples of combination DWLS_BPRNACanProMet is 1
#> 
#> Total sum across samples of combination DeconRNASeq_BSeqSC.Vanderbilt.scRNAseq is not 1! Remember these are proportions and the total should be 1
#> Samples which sum with combination DeconRNASeq_BSeqSC.Vanderbilt.scRNAseq is not 1:
#> 
#>  Sample_14428
#> Sample_11817
#> Sample_12935
#> Sample_13636
#> Sample_13774
#> Sample_12889
#> Sample_8356 
#> 
#> 
#> Total sum across samples of combination Epidish_BSeqSC.Vanderbilt.scRNAseq is not 1! Remember these are proportions and the total should be 1
#> Samples which sum with combination Epidish_BSeqSC.Vanderbilt.scRNAseq is not 1:
#> 
#>  Sample_14428
#> Sample_11817
#> Sample_12935
#> Sample_11918 
#> 
#> Total sum across samples of combination CBSX_BSeqSC.Vanderbilt.scRNAseq is 1
#> 
#> Total sum across samples of combination DWLS_BSeqSC.Vanderbilt.scRNAseq is not 1! Remember these are proportions and the total should be 1
#> Samples which sum with combination DWLS_BSeqSC.Vanderbilt.scRNAseq is not 1:
#> 
#>  Sample_12929
#> Sample_14428
#> Sample_11817
#> Sample_12935
#> Sample_11918 
#> 
#> Total sum across samples of combination DeconRNASeq_CBSX.HNSCC.scRNAseq is 1
#> Total sum across samples of combination Epidish_CBSX.HNSCC.scRNAseq is 1
#> Total sum across samples of combination CBSX_CBSX.HNSCC.scRNAseq is 1
#> Total sum across samples of combination DWLS_CBSX.HNSCC.scRNAseq is 1
#> Total sum across samples of combination DeconRNASeq_CBSX.Melanoma.scRNAseq is 1
#> Total sum across samples of combination Epidish_CBSX.Melanoma.scRNAseq is 1
#> Total sum across samples of combination CBSX_CBSX.Melanoma.scRNAseq is 1
#> Total sum across samples of combination DWLS_CBSX.Melanoma.scRNAseq is 1
#> Total sum across samples of combination DeconRNASeq_CBSX.NSCLC.PBMCs.scRNAseq is 1
#> Total sum across samples of combination Epidish_CBSX.NSCLC.PBMCs.scRNAseq is 1
#> Total sum across samples of combination CBSX_CBSX.NSCLC.PBMCs.scRNAseq is 1
#> Total sum across samples of combination DWLS_CBSX.NSCLC.PBMCs.scRNAseq is 1
#> Total sum across samples of combination DeconRNASeq_CBSX.Vanderbilt.scRNAseq is 1
#> 
#> Total sum across samples of combination Epidish_CBSX.Vanderbilt.scRNAseq is not 1! Remember these are proportions and the total should be 1
#> Samples which sum with combination Epidish_CBSX.Vanderbilt.scRNAseq is not 1:
#> 
#>  Sample_14428 
#> 
#> 
#> Total sum across samples of combination CBSX_CBSX.Vanderbilt.scRNAseq is not 1! Remember these are proportions and the total should be 1
#> Samples which sum with combination CBSX_CBSX.Vanderbilt.scRNAseq is not 1:
#> 
#>  Sample_14428 
#> 
#> 
#> Total sum across samples of combination DWLS_CBSX.Vanderbilt.scRNAseq is not 1! Remember these are proportions and the total should be 1
#> Samples which sum with combination DWLS_CBSX.Vanderbilt.scRNAseq is not 1:
#> 
#>  Sample_14428 
#> 
#> Total sum across samples of combination DeconRNASeq_CCLE.TIL10 is 1
#> Total sum across samples of combination Epidish_CCLE.TIL10 is 1
#> Total sum across samples of combination CBSX_CCLE.TIL10 is 1
#> Total sum across samples of combination DWLS_CCLE.TIL10 is 1
#> Total sum across samples of combination DeconRNASeq_DWLS.Vanderbilt.scRNAseq is 1
#> 
#> Total sum across samples of combination Epidish_DWLS.Vanderbilt.scRNAseq is not 1! Remember these are proportions and the total should be 1
#> Samples which sum with combination Epidish_DWLS.Vanderbilt.scRNAseq is not 1:
#> 
#>  Sample_15467
#> Sample_14428
#> Sample_14958 
#> 
#> 
#> Total sum across samples of combination CBSX_DWLS.Vanderbilt.scRNAseq is not 1! Remember these are proportions and the total should be 1
#> Samples which sum with combination CBSX_DWLS.Vanderbilt.scRNAseq is not 1:
#> 
#>  Sample_14428
#> Sample_14965 
#> 
#> 
#> Total sum across samples of combination DWLS_DWLS.Vanderbilt.scRNAseq is not 1! Remember these are proportions and the total should be 1
#> Samples which sum with combination DWLS_DWLS.Vanderbilt.scRNAseq is not 1:
#> 
#>  Sample_15467
#> Sample_14428
#> Sample_11817
#> Sample_14958
#> Sample_13636
#> Sample_14965
#> Sample_12889
#> Sample_11918 
#> 
#> 
#> Total sum across samples of combination DeconRNASeq_MOMF.Vanderbilt.scRNAseq is not 1! Remember these are proportions and the total should be 1
#> Samples which sum with combination DeconRNASeq_MOMF.Vanderbilt.scRNAseq is not 1:
#> 
#>  Sample_12929
#> Sample_15467
#> Sample_13634
#> Sample_14428
#> Sample_11817
#> Sample_14958
#> Sample_12935
#> Sample_13636
#> Sample_13774
#> Sample_14965
#> Sample_12889
#> Sample_8356
#> Sample_11918
#> Sample_11522
#> Sample_15002 
#> 
#> 
#> Total sum across samples of combination Epidish_MOMF.Vanderbilt.scRNAseq is not 1! Remember these are proportions and the total should be 1
#> Samples which sum with combination Epidish_MOMF.Vanderbilt.scRNAseq is not 1:
#> 
#>  Sample_12929
#> Sample_15467
#> Sample_13634
#> Sample_14428
#> Sample_11817
#> Sample_14958
#> Sample_12935
#> Sample_13636
#> Sample_13774
#> Sample_14965
#> Sample_12889
#> Sample_8356
#> Sample_11918
#> Sample_11522
#> Sample_15002 
#> 
#> 
#> Total sum across samples of combination CBSX_MOMF.Vanderbilt.scRNAseq is not 1! Remember these are proportions and the total should be 1
#> Samples which sum with combination CBSX_MOMF.Vanderbilt.scRNAseq is not 1:
#> 
#>  Sample_12929
#> Sample_15467
#> Sample_13634
#> Sample_14428
#> Sample_11817
#> Sample_14958
#> Sample_12935
#> Sample_13636
#> Sample_13774
#> Sample_14965
#> Sample_12889
#> Sample_8356
#> Sample_11918
#> Sample_11522
#> Sample_15002 
#> 
#> 
#> Total sum across samples of combination DWLS_MOMF.Vanderbilt.scRNAseq is not 1! Remember these are proportions and the total should be 1
#> Samples which sum with combination DWLS_MOMF.Vanderbilt.scRNAseq is not 1:
#> 
#>  Sample_12929
#> Sample_15467
#> Sample_14428
#> Sample_11817
#> Sample_14958
#> Sample_12935
#> Sample_13636
#> Sample_13774
#> Sample_14965
#> Sample_12889
#> Sample_11918 
#> 
#> Total sum across samples of combination DeconRNASeq_TIL10 is 1
#> Total sum across samples of combination Epidish_TIL10 is 1
#> Total sum across samples of combination CBSX_TIL10 is 1
#> Total sum across samples of combination DWLS_TIL10 is 1
#> Total sum across samples of combination AutogeneS_Vanderbilt is 1
#> Total sum across samples of combination BayesPrism_Vanderbilt is 1
#> Total sum across samples of combination Bisque_Vanderbilt is 1
#> Total sum across samples of combination CPM_Vanderbilt is 1
#> Total sum across samples of combination MuSic_Vanderbilt is 1
#> Total sum across samples of combination SCDC_Vanderbilt is 1
#> Total sum across samples of combination DeconRNASeq_LM22 is 1
#> Total sum across samples of combination Epidish_LM22 is 1
#> Total sum across samples of combination CBSX_LM22 is 1
#> Total sum across samples of combination DWLS_LM22 is 1
#> Warning: 
#> Please verify your matrix
```
