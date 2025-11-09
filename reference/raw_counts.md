# Raw counts

Raw gene expression matrix from bulk RNAseq.

## Usage

``` r
raw_counts
```

## Format

Matrix with genes as rows and samples as columns

## Source

Mariathasan et al. (2018), doi: https://doi.org/10.1038/nature25501

## Examples

``` r
data(raw_counts)
head(raw_counts)
#>         SAM7f0d9cc7f001 SAM4305ab968b90 SAMcf018fee2acd SAMcc4675f394a1
#> A1BG                 22               9              43            9821
#> NAT2                  0               0              13             173
#> ADA                 294             735             345             944
#> CDH2                115              24              57            4288
#> AKT3               2694             239            2194            1450
#> GAGE12F               0               0               0               0
#>         SAM49f9b2e57aa5 SAM2e7aa8fa0ab3 SAMdf3e42c8672a SAMd027124354ce
#> A1BG                 23              32              24              96
#> NAT2                  0               2               3               2
#> ADA                1123             492            1275            1562
#> CDH2                481             331             121            4106
#> AKT3                457             669            1376            3701
#> GAGE12F               0               0               0               0
#>         SAMe7bf6c015192 SAM6dd7ad1d797d SAM18039827e1b9 SAMc692536a795a
#> A1BG                 30             147              19              42
#> NAT2                  2               4               6               3
#> ADA                 994            2472             369             412
#> CDH2                443             966              59             285
#> AKT3               1342            2129            1765            2045
#> GAGE12F               0               0               0               0
#>         SAM9a2cf3c06fb3 SAM557dde1b9f3e SAM23aa15d4a0b0 SAM468a9e1dc821
#> A1BG                 22              31               9               9
#> NAT2                  7               0               1               0
#> ADA                1057             207             813            1331
#> CDH2                203             647             322             227
#> AKT3               4500            1931            1795             934
#> GAGE12F               0               0               0               0
#>         SAM81b71522417a SAMb963dda93cfd SAMbcbc7957c264 SAM7fb6987514a4
#> A1BG                 57              51              10              27
#> NAT2                  0               1               1               0
#> ADA                 913            2389             326            1299
#> CDH2               5402             565             496            2113
#> AKT3                876            1628            1398            2736
#> GAGE12F               0               0               0               0
#>         SAM63405b04ab2d SAM18bc1078bc15 SAMd1bd63734394 SAMe9ae8beb82fa
#> A1BG                 34              56              49              25
#> NAT2                  0               1               1              16
#> ADA                1795             281            2130             846
#> CDH2                879              65              85             758
#> AKT3               1308            1745             934            2286
#> GAGE12F               0               0               0               0
#>         SAMba7176afe070 SAMbe83eae4026e SAMe5bc41772bc9 SAM23095936e611
#> A1BG                 13              14            1923              18
#> NAT2                  0               0              65               0
#> ADA                 366             534            1361             721
#> CDH2                666             411            4627             282
#> AKT3                602             760            1147             709
#> GAGE12F               0               0               0               0
#>         SAM7114d99032ec SAMdb3f50c9129c
#> A1BG                 20              16
#> NAT2                  2               0
#> ADA                 512             232
#> CDH2                240             297
#> AKT3                958            3776
#> GAGE12F               0               0
```
