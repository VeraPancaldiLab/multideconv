# Deconvolution with default methods

``` r

library(multideconv)
```

## **Deconvolution with default methods**

The basic function is to perform cell type deconvolution using six
default methods (`quanTIseq`, `DeconRNASeq`, `CIBERSORTx`, `EpiDISH`,
`DWLS`, `MOMF`) and nine default signatures (see paper [Hurtado et al.,
2025](https://www.biorxiv.org/content/10.1101/2025.04.29.651220v2.article-info)).
The function accepts either raw counts or TPM-normalized counts as input
(with genes as SYMBOL).

**NOTE:** If you plan to use `CIBERSORTx`, you must provide your
credentials (see README for details). The resulting deconvolution matrix
is automatically saved in the `Results/` directory.

The output includes all combinations of deconvolution features,
method-signature-cell type.

``` r

bulk = multideconv::raw_counts
deconv = compute.deconvolution(raw.counts = bulk, 
                               methods = c("Quantiseq", "Epidish", 
                                           "DeconRNASeq", "DWLS","MOMF"), 
                               normalized = TRUE, 
                               return = TRUE, 
                               file_name = "Tutorial")
```

To exclude specific methods or signatures, use the methods or
signatures_exclude arguments:

``` r

deconv = compute.deconvolution(raw.counts = bulk, 
                               methods = c("Quantiseq", "DeconRNASeq"), 
                               normalized = TRUE,
                               signatures_exclude = "BPRNACan", 
                               return = TRUE, 
                               file_name = "Tutorial")
```

To speed up computation, `multideconv` supports parallelization. Set
`doParallel = TRUE` and specify the number of workers based on your
system’s resources:

``` r

deconv = compute.deconvolution(raw.counts = bulk, 
                               methods = "DWLS", 
                               normalized = TRUE, 
                               return = TRUE, 
                               file_name = "Tutorial", 
                               doParallel = TRUE, 
                               workers = 3)
```

## **Cell type signatures**

In order to access the default signatures `multideconv` provides, you
can do the following:

To list all signatures

``` r

path <- system.file("signatures/", package = "multideconv")
list.files(path)
#> [1] "CBSX-HNSCC-scRNAseq.txt"       "CBSX-Melanoma-scRNAseq.txt"   
#> [3] "CBSX-NSCLC-PBMCs-scRNAseq.txt" "CBSX-NSCLC-scRNAseq.txt"      
#> [5] "CBSX-Vanderbilt-scRNAseq.txt"  "LM22.txt"                     
#> [7] "MCPcounter"                    "TIL10.txt"
```

To access a specific signature

``` r

signature = read.delim(paste0(path, "CBSX-Melanoma-scRNAseq.txt"))
head(signature)
#>     NAME Malignant Endothelial.cells      CAF T.cells.CD8 NK.cells Macrophages
#> 1    A2M 272.91408         212.14093  1.00000     1.00000   1.0000    700.2033
#> 2 A4GALT   1.00000          67.08075  1.00000     1.00000   1.0000      1.0000
#> 3  ABCA1   1.00000          84.22255  1.00000     1.00000   1.0000    128.7594
#> 4  ABCB1   1.00000           1.00000  1.00000     1.00000 133.5748      1.0000
#> 5  ABCB5 117.86677           1.00000  1.00000    19.94351   1.0000      1.0000
#> 6  ABCB6  49.62804           1.00000 41.38285     1.00000   1.0000      1.0000
#>   T.cells.CD4 B.cells
#> 1           1       1
#> 2           1       1
#> 3           1       1
#> 4           1       1
#> 5           1       1
#> 6           1       1
```
