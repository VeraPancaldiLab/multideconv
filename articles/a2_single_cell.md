# Single-cell deconvolution

``` r
library(multideconv)
```

## **Single-cell metacell construction**

If single-cell data is available, we recommend generating metacells to
reduce computation time and prevent session crashes. Deconvolution
methods that rely on single-cell data can be computationally intensive,
especially with large matrices. We suggest using a maximum of 20k cells;
if your object exceeds this size, creating metacells is strongly
advised. However, if your computational resources are sufficient to
handle the full single-cell dataset, you may skip this step.

We adapted functions from the R package hdWGCNA (Morabito et al.
([2023](#ref-morabito2023hdwgcna)); Langfelder and Horvath
([2008](#ref-langfelder2008wgcna))) for the construction of metacells
using the KNN algorithm.

- **sc_object**: Normalized gene expression matrix with genes as rows
  and cells as columns

- **labels_column**: Vector of cell annotations

- **samples_column**: Vector of sample IDs for each cell

- **exclude_cells**: Vector specifying which cell types to ignore during
  metacell construction (default is NULL)

- **min_cells**: Minimum number of cells required to construct metacells
  in a group

- **k**: Number of nearest neighbors used for the KNN algorithm

- **max_shared**: Maximum number of cells shared between two metacells

- **n_workers**: Number of cores to use for parallelizing metacell
  construction

- **min_meta**: Minimum number of metacells required for a cell type to
  be retained

Because of space limitations, we have not included a complete
single-cell object in this tutorial. However, users are expected to
provide their own single-cell data and supply it to the `sc_object`
parameter in the function call.

``` r
metacells = create_metacells(sc_object, 
                             labels_column = cell_labels, 
                             samples_column = sample_labels, 
                             exclude_cells = NULL,
                             min_cells = 50, 
                             k = 15, 
                             max_shared = 15, 
                             n_workers = 4, 
                             min_meta = 10)
```

## **Second-generation deconvolution methods**

Once the single-cell data is prepared, users can supplement the default
deconvolution methods with second-generation approaches such as
`AutogeneS`, `BayesPrism`, `Bisque`, `CPM`, `MuSic`, and `SCDC`. These
methods learn cell-type signatures directly from annotated single-cell
RNA-seq data, rather than relying on predefined static signatures
(Dietrich et al. ([2024](#ref-Dietrich2024.06.10.598226))), to
deconvolve bulk RNA-seq profiles.

- **sc_deconv**: Boolean indicating whether to run second-generation
  methods

- **sc_matrix**: Normalized single-cell gene expression matrix

- **sc_metadata**: Dataframe containing single-cell metadata

- **cell_annotations**: Vector of cell type labels

- **cell_samples**: Vector of sample IDs

- **name_sc_signature**: Name to assign to the resulting signature

``` r
metacell_obj = multideconv::metacells_data
metacell_metadata = multideconv::metacells_metadata
head(metacell_obj[1:5,1:5])
#>            B cells#Sample_15002_393 CD4+ T cells#Sample_14958_193
#> AL627309.1                        0                             0
#> AL732372.1                        0                             0
#> AC114498.1                        0                             0
#> FAM87B                            0                             0
#> LINC00115                         0                             0
#>            Plasma B cells#Sample_15467_117 CD4+ T cells#Sample_12889_54
#> AL627309.1                      0.00000000                   0.00000000
#> AL732372.1                      0.00000000                   0.00000000
#> AC114498.1                      0.00000000                   0.00000000
#> FAM87B                          0.00000000                   0.00000000
#> LINC00115                       0.01454298                   0.05538857
#>            B cells#Sample_11817_97
#> AL627309.1                       0
#> AL732372.1                       0
#> AC114498.1                       0
#> FAM87B                           0
#> LINC00115                        0
head(metacell_metadata)
#>                                            orig.ident nCount_RNA nFeature_RNA
#> B cells#Sample_15002_393               B cells#Sample   2085.014         7927
#> CD4+ T cells#Sample_14958_193     CD4+ T cells#Sample   1699.248         6390
#> Plasma B cells#Sample_15467_117 Plasma B cells#Sample   1397.391         9314
#> CD4+ T cells#Sample_12889_54      CD4+ T cells#Sample   1798.458         7164
#> B cells#Sample_11817_97                B cells#Sample   1944.183         7765
#> CD8+ T cells#Sample_11522_665     CD8+ T cells#Sample   2317.216         7862
#>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  cells_merged
#> B cells#Sample_15002_393            CTGTTTATCGCCATAA-1,TGCTGCTTCGGAGCAA-1,ACTTTCATCGACAGCC-1,GCTGCAGTCATTGCGA-1,CGTAGGCGTGGCTCCA-1,TCAGCTCAGACTAAGT-1,CACCAGGCACCAGCAC-1,CATCAAGTCAGCGATT-1,CGATGGCTCGTTACGA-1,CAGTCCTGTGTGAATA-1,CTTGGCTCAAGTCATC-1,CCAATCCAGCCACGTC-1,TTTGGTTCAGATGGCA-1,TGGTTAGAGAGTAATC-1,TAGTTGGGTTATGTGC-1,GACACGCGTCGAGTTT-1,AGGGATGGTACACCGC-1,ACTTACTTCGAGAACG-1,GGCAATTCATTAGGCT-1,GAAACTCAGACTGGGT-1,ATTGGTGGTAGCTTGT-1,TTGAACGAGACGCAAC-1,TGTTCCGGTACTTAGC-1,CAGCTGGCAGGTGGAT-1,GGACATTAGCCCAATT-1,TAAGCGTCAGCCTGTG-1,CTCTAATAGATCTGAA-1,CACACCTAGCCTTGAT-1,CTTACCGAGCGCTCCA-1,CACTCCAGTCGACTGC-1
#> CD4+ T cells#Sample_14958_193     AAGGAGCTCCAAATGC-1,ACACCCTTCTGCGTAA-1,CGGACGTGTAGGCTGA-1,CGACCTTCAAGTCATC-1,TTAGGCACAGGAACGT-1,GTATTCTAGTGTGAAT-1,TCAATCTCAAGAAAGG-1,GGCAATTTCTTGTTTG-1,GCGCAACGTCTAGCCG-1,CCTTACGCATCGACGC-1,TCCCGATAGACAATAC-1,ACAGCTAGTTCCACTC-1,TGAGAGGAGATCTGAA-1,GCGCCAAAGCCACCTG-1,TAAGTGCGTCTCACCT-1,ATGCGATTCGTTACGA-1,CAAGTTGAGCTACCGC-1,TACCTTACATTCTTAC-1,GCATGTATCAGTCAGT-1,GATGCTACATATGGTC-1,CCATGTCTCTGGGCCA-1,TACACGAGTCATTAGC-1,GATTCAGAGCACACAG-1,TTGCCGTAGCAATATG-1,TCGTACCAGCCAACAG-1,CAGTCCTTCGCCAGCA-1,CTACATTCAGTCGATT-1,AGGGTGATCTTGACGA-1,GTCTCGTGTCTCTTAT-1,TCGGGACAGCACACAG-1-1
#> Plasma B cells#Sample_15467_117     GCGCAACAGTACATGA-1,GTCATTTCACGCGAAA-1,ACGATACTCATAAAGG-1,CCCATACCACCAACCG-1,AGCCTAAAGTGTTAGA-1,TGTATTCCAGGGTACA-1,CATATTCTCAACGGCC-1,CACACCTGTCCAACTA-1,CCGTACTTCCGAGCCA-1,GGGACCTTCCAGAAGG-1,ACACCCTGTGTAACGG-1,AGCCTAACAGAAGCAC-1,GCTTCCATCCATGCTC-1,AGTGTCAGTCCTGCTT-1,CGAGCACAGAAACGCC-1,GAACGGATCGGGAGTA-1,TGCCAAACACTCAGGC-1,TACAGTGCAGTGGGAT-1,TATGCCCCAGTATCTG-1,GTCGGGTGTAAGAGGA-1,AAGGCAGCATCTATGG-1,TCGAGGCGTAGCTCCG-1,CTGCTGTTCGCGCCAA-1,CGGACACAGACTACAA-1,CGTGTAAAGCCCAATT-1,CTTTGCGAGGAGTCTG-1,TGCCCTAAGCCAACAG-1,CTCAGAACACCTCGGA-1,CTGCCTAGTGTCTGAT-1,ACACCAATCGACGGAA-1
#> CD4+ T cells#Sample_12889_54        GCGAGAATCGCACTCT-1,GTTACAGTCTTCGAGA-1,CAGTAACGTAACGACG-1,TCGCGTTCAATCCGAT-1,CACCTTGGTGTCGCTG-1,ATTACTCCAAACAACA-1,TACAGTGTCAGTGCAT-1,ACGCAGCGTCTGCCAG-1,TTGTAGGAGCCACGTC-1,CTTGGCTGTTCGTGAT-1,CCACTACAGACACTAA-1,CCCAGTTTCAGGCCCA-1,GAACGGAAGGCACATG-1,CGTAGCGAGAGGGCTT-1,ATTCTACTCGGTTAAC-1,CATGACAGTGGTCCGT-1,TCAGCAAGTGCTTCTC-1,AGCTTGAGTCCTCCAT-1,CATTCGCCATCGATTG-1,TCAGGATAGCACAGGT-1,CCCTCCTTCTGCGTAA-1,AAATGCCTCCTTGACC-1,TACTCGCTCCTATTCA-1,GAAATGATCGCATGGC-1,ACTGCTCTCGGTCTAA-1,AACGTTGTCATAGCAC-1,GTGTGCGGTCTAGGTT-1,GCACTCTCAAGCCGTC-1,CCGTTCACATCCTTGC-1,CCACTACGTCGAGTTT-1
#> B cells#Sample_11817_97         AAACCTGGTACCGGCT-1,ACAGCTAGTAAGTAGT-1,ACGATACAGTACGACG-1,TAAACCGAGGAGTACC-1,GGACGTCGTCTGCAAT-1,TAGCCGGAGGGCATGT-1,CGGACACCACATCCAA-1,GGTATTGTCACTTCAT-1,GGAAAGCAGTACGATA-1,AAACGGGTCGTGGGAA-1,TTTCCTCCAGGCGATA-1,GTCATTTAGGAACTGC-1,CAACCAAGTCCGTTAA-1-1,GTCGTAAGTACAGTGG-1,GTTTCTAAGCCCAATT-1,GACCAATCATTCCTCG-1,CAACCAAGTTCTGAAC-1,AGATCTGAGCAGGTCA-1,GTTCGGGCAGTTCCCT-1,GCAAACTCATGAACCT-1,CTCTGGTGTGATGATA-1,TTATGCTCAAACTGTC-1,GACGTTAGTACCGTTA-1,GGGACCTGTTTGACAC-1,ACAGCCGTCTGCGGCA-1,GGCGTGTTCTAAGCCA-1,CGGACACGTGCTTCTC-1-1,GGTGAAGAGCTCAACT-1,GCTTGAACATCCGTGG-1,GGGAGATAGGGCACTA-1
#> CD8+ T cells#Sample_11522_665     ACACCGGAGCCAGTAG-1-1,GAAATGATCCCACTTG-1,GAGTCCGAGTACGCGA-1,CTGAAACAGTCGCCGT-1,GTCGGGTGTGGTGTAG-1,ACGATGTCAGACGCTC-1,ATCATCTGTCTGCAAT-1,TGCTGCTAGACACTAA-1,TACTTGTTCGCAAGCC-1,CGAGCACAGTTAGGTA-1,GCTTGAATCTACTCAT-1,ATCATCTCAAGACGTG-1,GTGTTAGGTCAACATC-1,CGGGTCAGTAAGCACG-1,GAACCTAAGAGTGAGA-1,TCATTACGTGCAACGA-1,GACGTGCGTATGCTTG-1,TCGTACCTCATGCTCC-1,TGCGCAGTCGCCAGCA-1,CACACTCGTAGCAAAT-1,GATGAAAGTATCAGTC-1,TCATTTGAGGCTATCT-1,CTAACTTTCAACTCTT-1,CTTGGCTCAAAGAATC-1,GACTACATCTGACCTC-1,TTTCCTCTCAACGAAA-1,AAAGCAAGTCAGAAGC-1,CATCAAGTCCGAATGT-1,CGATGGCTCGCAAACT-1,CGAGAAGTCAGTGTTG-1
#>                                   annotated_ct       sample
#> B cells#Sample_15002_393               B cells Sample_15002
#> CD4+ T cells#Sample_14958_193     CD4+ T cells Sample_14958
#> Plasma B cells#Sample_15467_117 Plasma B cells Sample_15467
#> CD4+ T cells#Sample_12889_54      CD4+ T cells Sample_12889
#> B cells#Sample_11817_97                B cells Sample_11817
#> CD8+ T cells#Sample_11522_665     CD8+ T cells Sample_11522
```

This function computes cell type deconvolution using the six default
methods (`quanTIseq`, `DeconRNASeq`, `EpiDISH`, `DWLS`, `MOMF`) and
`CIBERSORTx` (if credentials are provided), along with second-generation
deconvolution approaches. The output includes all combinations of
methods and signatures.

``` r
deconv = compute.deconvolution(raw.counts = bulk, 
                               normalized = TRUE, 
                               return = TRUE, 
                               methods = c("Quantiseq", "Epidish", "DeconRNASeq"),
                               file_name = "Tutorial", 
                               sc_deconv = TRUE, 
                               sc_matrix = metacell_obj, 
                               sc_metadata = metacell_metadata, 
                               methods_sc = c("Autogenes", "BayesPrism", 
                                              "Bisque", "CPM", "MuSic", "SCDC"),
                               cell_label = "annotated_ct", 
                               sample_label = "sample", 
                               name_sc_signature = "Test")
```

To run only the second-generation deconvolution methods based on
single-cell data, without using any static cell-type signatures, use the
following:

``` r
deconv_sc = compute_sc_deconvolution_methods(raw_counts = bulk, 
                                             normalized = TRUE, 
                                             methods_sc = c("Autogenes", "BayesPrism", 
                                                            "Bisque", "CPM", "MuSic", "SCDC"),
                                             sc_object = metacell_obj, 
                                             sc_metadata = metacell_metadata, 
                                             cell_annotations = "annotated_ct", 
                                             samples_ids = "sample", 
                                             name_object = "Test", 
                                             n_cores = 2, 
                                             return = TRUE, 
                                             file_name = "Tutorial")
```

Dietrich, Alexander, Lorenzo Merotto, Konstantin Pelz, Bernhard Eder,
Constantin Zackl, Katharina Reinisch, Frank Edenhofer, et al. 2024.
“Benchmarking Second-Generation Methods for Cell-Type Deconvolution of
Transcriptomic Data.” *bioRxiv*.
<https://doi.org/10.1101/2024.06.10.598226>.

Langfelder, Peter, and Steve Horvath. 2008. “WGCNA: An r Package for
Weighted Correlation Network Analysis.” *BMC Bioinformatics* 9 (1): 559.
<https://doi.org/10.1186/1471-2105-9-559>.

Morabito, Samuel, Fairlie Reese, Negin Rahimzadeh, Emily Miyoshi, and
Vivek Swarup. 2023. “hdWGCNA Identifies Co-Expression Networks in
High-Dimensional Transcriptomics Data.” *Cell Reports Methods* 3 (6):
100498. <https://doi.org/10.1016/j.crmeth.2023.100498>.
