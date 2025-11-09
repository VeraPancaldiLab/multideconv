# Deconvolution matrix

A matrix with the cell type deconvolution features obtained from
compute.deconvolution() from the pseudobulk matrix

## Usage

``` r
deconvolution
```

## Format

Matrix with samples as rows and deconvolution features as columns

## Examples

``` r
data(deconvolution)
head(deconvolution)
#>              Quantiseq_B.cells DeconRNASeq_BPRNACan_B.cells
#> Sample_12929       0.001777905                    0.1571790
#> Sample_15467       0.113360357                    0.2393388
#> Sample_13634       0.047470005                    0.2070539
#> Sample_14428       0.084473137                    0.1931020
#> Sample_11817       0.051403620                    0.1895494
#> Sample_14958       0.004990907                    0.1049224
#>              Epidish_BPRNACan_B.cells CBSX_BPRNACan_B.cells
#> Sample_12929               0.07851520            0.06959084
#> Sample_15467               0.19024213            0.17386305
#> Sample_13634               0.18921194            0.15923601
#> Sample_14428               0.15049899            0.12590952
#> Sample_11817               0.15452210            0.12770655
#> Sample_14958               0.03236415            0.02063074
#>              DWLS_BPRNACan_B.cells DeconRNASeq_BPRNACan3DProMet_B.cells
#> Sample_12929            0.07229290                           0.08236239
#> Sample_15467            0.14936147                           0.17768102
#> Sample_13634            0.12939978                           0.11307984
#> Sample_14428            0.12289162                           0.12609350
#> Sample_11817            0.09297215                           0.08207529
#> Sample_14958            0.01858275                           0.01787481
#>              Epidish_BPRNACan3DProMet_B.cells CBSX_BPRNACan3DProMet_B.cells
#> Sample_12929                       0.07121289                    0.04979896
#> Sample_15467                       0.16776636                    0.13340666
#> Sample_13634                       0.15206140                    0.12367969
#> Sample_14428                       0.13723839                    0.11653899
#> Sample_11817                       0.13424170                    0.07046234
#> Sample_14958                       0.02037617                    0.02506361
#>              DWLS_BPRNACan3DProMet_B.cells DeconRNASeq_BPRNACanProMet_B.cells
#> Sample_12929                    0.07230288                         0.11038530
#> Sample_15467                    0.16495777                         0.19360957
#> Sample_13634                    0.11234718                         0.13660336
#> Sample_14428                    0.12558950                         0.14869556
#> Sample_11817                    0.09403535                         0.09118902
#> Sample_14958                    0.01547149                         0.04853287
#>              Epidish_BPRNACanProMet_B.cells CBSX_BPRNACanProMet_B.cells
#> Sample_12929                     0.07180674                  0.05935233
#> Sample_15467                     0.17110258                  0.13084034
#> Sample_13634                     0.14903487                  0.12318689
#> Sample_14428                     0.13166227                  0.12001258
#> Sample_11817                     0.12414652                  0.10727717
#> Sample_14958                     0.02689582                  0.01856718
#>              DWLS_BPRNACanProMet_B.cells
#> Sample_12929                  0.07788098
#> Sample_15467                  0.16770304
#> Sample_13634                  0.12253639
#> Sample_14428                  0.13982397
#> Sample_11817                  0.09819142
#> Sample_14958                  0.02284383
#>              DeconRNASeq_BSeqSC.Vanderbilt.scRNAseq_B.cells
#> Sample_12929                                      0.1327184
#> Sample_15467                                      0.1714428
#> Sample_13634                                      0.1671482
#> Sample_14428                                      0.1418695
#> Sample_11817                                      0.1443771
#> Sample_14958                                      0.0000000
#>              Epidish_BSeqSC.Vanderbilt.scRNAseq_B.cells
#> Sample_12929                                 0.00545693
#> Sample_15467                                 0.08208929
#> Sample_13634                                 0.10750666
#> Sample_14428                                 0.05881834
#> Sample_11817                                 0.07774274
#> Sample_14958                                 0.00000000
#>              CBSX_BSeqSC.Vanderbilt.scRNAseq_B.cells
#> Sample_12929                              0.02075191
#> Sample_15467                              0.07861258
#> Sample_13634                              0.09503777
#> Sample_14428                              0.08218364
#> Sample_11817                              0.06812374
#> Sample_14958                              0.00000000
#>              DWLS_BSeqSC.Vanderbilt.scRNAseq_B.cells
#> Sample_12929                              0.01585004
#> Sample_15467                              0.08949398
#> Sample_13634                              0.10525419
#> Sample_14428                              0.06949794
#> Sample_11817                              0.07977151
#> Sample_14958                              0.00000000
#>              DeconRNASeq_CBSX.HNSCC.scRNAseq_B.cells
#> Sample_12929                              0.11778024
#> Sample_15467                              0.18677341
#> Sample_13634                              0.11679378
#> Sample_14428                              0.09731088
#> Sample_11817                              0.09776913
#> Sample_14958                              0.07534749
#>              Epidish_CBSX.HNSCC.scRNAseq_B.cells
#> Sample_12929                          0.10934684
#> Sample_15467                          0.18349195
#> Sample_13634                          0.11682714
#> Sample_14428                          0.10329726
#> Sample_11817                          0.10885399
#> Sample_14958                          0.07681221
#>              CBSX_CBSX.HNSCC.scRNAseq_B.cells DWLS_CBSX.HNSCC.scRNAseq_B.cells
#> Sample_12929                       0.11507449                       0.11198996
#> Sample_15467                       0.19103361                       0.19132116
#> Sample_13634                       0.11192278                       0.12032508
#> Sample_14428                       0.10727356                       0.10816833
#> Sample_11817                       0.10250751                       0.11873500
#> Sample_14958                       0.07215938                       0.07303483
#>              DeconRNASeq_CBSX.Melanoma.scRNAseq_B.cells
#> Sample_12929                                 0.00000000
#> Sample_15467                                 0.15585598
#> Sample_13634                                 0.10492529
#> Sample_14428                                 0.05318922
#> Sample_11817                                 0.03697820
#> Sample_14958                                 0.00000000
#>              Epidish_CBSX.Melanoma.scRNAseq_B.cells
#> Sample_12929                             0.00000000
#> Sample_15467                             0.11619009
#> Sample_13634                             0.07037594
#> Sample_14428                             0.04717043
#> Sample_11817                             0.04392275
#> Sample_14958                             0.00000000
#>              CBSX_CBSX.Melanoma.scRNAseq_B.cells
#> Sample_12929                         0.007865249
#> Sample_15467                         0.134174446
#> Sample_13634                         0.080284425
#> Sample_14428                         0.073162500
#> Sample_11817                         0.042551715
#> Sample_14958                         0.000000000
#>              DWLS_CBSX.Melanoma.scRNAseq_B.cells
#> Sample_12929                          0.00000000
#> Sample_15467                          0.21353984
#> Sample_13634                          0.13295657
#> Sample_14428                          0.07688043
#> Sample_11817                          0.08053462
#> Sample_14958                          0.00000000
#>              DeconRNASeq_CBSX.NSCLC.PBMCs.scRNAseq_B.cells
#> Sample_12929                                     0.3977192
#> Sample_15467                                     0.4464778
#> Sample_13634                                     0.3495878
#> Sample_14428                                     0.3954715
#> Sample_11817                                     0.3390677
#> Sample_14958                                     0.3194868
#>              Epidish_CBSX.NSCLC.PBMCs.scRNAseq_B.cells
#> Sample_12929                                 0.1801630
#> Sample_15467                                 0.1970183
#> Sample_13634                                 0.1601694
#> Sample_14428                                 0.1740413
#> Sample_11817                                 0.1507841
#> Sample_14958                                 0.1505887
#>              CBSX_CBSX.NSCLC.PBMCs.scRNAseq_B.cells
#> Sample_12929                              0.2268423
#> Sample_15467                              0.2380677
#> Sample_13634                              0.1697830
#> Sample_14428                              0.1910359
#> Sample_11817                              0.1549300
#> Sample_14958                              0.1934163
#>              DWLS_CBSX.NSCLC.PBMCs.scRNAseq_B.cells
#> Sample_12929                              0.2979456
#> Sample_15467                              0.3282672
#> Sample_13634                              0.2439549
#> Sample_14428                              0.2835789
#> Sample_11817                              0.2279067
#> Sample_14958                              0.2616233
#>              DeconRNASeq_CBSX.Vanderbilt.scRNAseq_B.cells
#> Sample_12929                                   0.00000000
#> Sample_15467                                   0.11062359
#> Sample_13634                                   0.06352173
#> Sample_14428                                   0.00000000
#> Sample_11817                                   0.00000000
#> Sample_14958                                   0.00000000
#>              Epidish_CBSX.Vanderbilt.scRNAseq_B.cells
#> Sample_12929                               0.00000000
#> Sample_15467                               0.08553118
#> Sample_13634                               0.04944208
#> Sample_14428                               0.03909048
#> Sample_11817                               0.01625429
#> Sample_14958                               0.00000000
#>              CBSX_CBSX.Vanderbilt.scRNAseq_B.cells
#> Sample_12929                            0.00000000
#> Sample_15467                            0.09629067
#> Sample_13634                            0.03604282
#> Sample_14428                            0.04058988
#> Sample_11817                            0.02495333
#> Sample_14958                            0.00000000
#>              DWLS_CBSX.Vanderbilt.scRNAseq_B.cells
#> Sample_12929                            0.00000000
#> Sample_15467                            0.13105623
#> Sample_13634                            0.08290183
#> Sample_14428                            0.05948316
#> Sample_11817                            0.03237919
#> Sample_14958                            0.00000000
#>              DeconRNASeq_CCLE.TIL10_B.cells Epidish_CCLE.TIL10_B.cells
#> Sample_12929                     0.00000000                0.030785903
#> Sample_15467                     0.11034596                0.105367267
#> Sample_13634                     0.03851107                0.069951546
#> Sample_14428                     0.04861288                0.067084225
#> Sample_11817                     0.02720285                0.057407033
#> Sample_14958                     0.00000000                0.005569617
#>              CBSX_CCLE.TIL10_B.cells DWLS_CCLE.TIL10_B.cells
#> Sample_12929              0.01725966             0.041595777
#> Sample_15467              0.11088823             0.151831340
#> Sample_13634              0.06633094             0.092681931
#> Sample_14428              0.06089195             0.075105895
#> Sample_11817              0.06038178             0.067347468
#> Sample_14958              0.01690060             0.008948086
#>              DeconRNASeq_DWLS.Vanderbilt.scRNAseq_B.cells
#> Sample_12929                                   0.00000000
#> Sample_15467                                   0.06345484
#> Sample_13634                                   0.04018900
#> Sample_14428                                   0.00000000
#> Sample_11817                                   0.00000000
#> Sample_14958                                   0.00000000
#>              Epidish_DWLS.Vanderbilt.scRNAseq_B.cells
#> Sample_12929                              0.006103814
#> Sample_15467                              0.085869599
#> Sample_13634                              0.086313642
#> Sample_14428                              0.061494425
#> Sample_11817                              0.054099600
#> Sample_14958                              0.000000000
#>              CBSX_DWLS.Vanderbilt.scRNAseq_B.cells
#> Sample_12929                            0.00000000
#> Sample_15467                            0.08366567
#> Sample_13634                            0.08695856
#> Sample_14428                            0.06793426
#> Sample_11817                            0.06064571
#> Sample_14958                            0.00000000
#>              DWLS_DWLS.Vanderbilt.scRNAseq_B.cells
#> Sample_12929                           0.009512514
#> Sample_15467                           0.083978744
#> Sample_13634                           0.082699049
#> Sample_14428                           0.055092329
#> Sample_11817                           0.055498142
#> Sample_14958                           0.000000000
#>              DeconRNASeq_MOMF.Vanderbilt.scRNAseq_B.cells
#> Sample_12929                                   0.07581771
#> Sample_15467                                   0.18810085
#> Sample_13634                                   0.18085622
#> Sample_14428                                   0.18800347
#> Sample_11817                                   0.13092467
#> Sample_14958                                   0.00000000
#>              Epidish_MOMF.Vanderbilt.scRNAseq_B.cells
#> Sample_12929                              0.002701012
#> Sample_15467                              0.012596549
#> Sample_13634                              0.029404651
#> Sample_14428                              0.005490899
#> Sample_11817                              0.003337928
#> Sample_14958                              0.000000000
#>              CBSX_MOMF.Vanderbilt.scRNAseq_B.cells
#> Sample_12929                           0.004660960
#> Sample_15467                           0.023216629
#> Sample_13634                           0.032254658
#> Sample_14428                           0.015599774
#> Sample_11817                           0.006702482
#> Sample_14958                           0.000000000
#>              DWLS_MOMF.Vanderbilt.scRNAseq_B.cells DeconRNASeq_TIL10_B.cells
#> Sample_12929                             0.0355144              0.0004927868
#> Sample_15467                             0.1400615              0.1210637379
#> Sample_13634                             0.1122445              0.0494797983
#> Sample_14428                             0.1299016              0.0442937888
#> Sample_11817                             0.0811371              0.0404906127
#> Sample_14958                             0.0000000              0.0000000000
#>              Epidish_TIL10_B.cells CBSX_TIL10_B.cells DWLS_TIL10_B.cells
#> Sample_12929            0.01705660         0.01599580         0.02588584
#> Sample_15467            0.09940992         0.09004010         0.14461081
#> Sample_13634            0.07110081         0.05177014         0.10649046
#> Sample_14428            0.05514232         0.04381122         0.05590985
#> Sample_11817            0.06294322         0.06812036         0.08347724
#> Sample_14958            0.00000000         0.01015635         0.00000000
#>              AutogeneS_Vanderbilt_B.cells BayesPrism_Vanderbilt_B.cells
#> Sample_12929                   0.05871836                  2.204125e-02
#> Sample_15467                   0.06798937                  1.245615e-01
#> Sample_13634                   0.07193086                  1.156560e-01
#> Sample_14428                   0.05411343                  1.372101e-01
#> Sample_11817                   0.06756586                  6.096520e-02
#> Sample_14958                   0.04895074                  7.007226e-05
#>              Bisque_Vanderbilt_B.cells CPM_Vanderbilt_B.cells
#> Sample_12929                0.08472911             0.08885840
#> Sample_15467                0.15097312             0.09301681
#> Sample_13634                0.12175653             0.09190953
#> Sample_14428                0.15607676             0.09090922
#> Sample_11817                0.13267538             0.08910481
#> Sample_14958                0.03600030             0.08659451
#>              MuSic_Vanderbilt_B.cells SCDC_Vanderbilt_B.cells
#> Sample_12929               0.03874161              0.02774254
#> Sample_15467               0.14494464              0.15092744
#> Sample_13634               0.13596094              0.14796487
#> Sample_14428               0.14430885              0.12010269
#> Sample_11817               0.11453668              0.07639401
#> Sample_14958               0.00000000              0.00000000
#>              DeconRNASeq_LM22_B.naive.cells Epidish_LM22_B.naive.cells
#> Sample_12929                     0.02523129               0.0000000000
#> Sample_15467                     0.00000000               0.0000000000
#> Sample_13634                     0.03279766               0.0000000000
#> Sample_14428                     0.03485217               0.0000000000
#> Sample_11817                     0.01683353               0.0008224731
#> Sample_14958                     0.00000000               0.0023097333
#>              CBSX_LM22_B.naive.cells DWLS_LM22_B.naive.cells
#> Sample_12929                       0             0.000000000
#> Sample_15467                       0             0.000000000
#> Sample_13634                       0             0.000000000
#> Sample_14428                       0             0.000000000
#> Sample_11817                       0             0.005440949
#> Sample_14958                       0             0.001558354
#>              DeconRNASeq_LM22_B.memory.cells Epidish_LM22_B.memory.cells
#> Sample_12929                      0.04173181                  0.03571205
#> Sample_15467                      0.22566433                  0.09475120
#> Sample_13634                      0.05995308                  0.05232816
#> Sample_14428                      0.06610779                  0.05628631
#> Sample_11817                      0.04745640                  0.03633752
#> Sample_14958                      0.00000000                  0.00000000
#>              CBSX_LM22_B.memory.cells DWLS_LM22_B.memory.cells
#> Sample_12929               0.03966522               0.03444624
#> Sample_15467               0.10883645               0.11132081
#> Sample_13634               0.04886780               0.05194382
#> Sample_14428               0.05697963               0.06069588
#> Sample_11817               0.04164067               0.03635529
#> Sample_14958               0.00000000               0.00000000
#>              DeconRNASeq_CBSX.HNSCC.scRNAseq_Macrophages.cells
#> Sample_12929                                        0.08576198
#> Sample_15467                                        0.00000000
#> Sample_13634                                        0.00000000
#> Sample_14428                                        0.03078755
#> Sample_11817                                        0.01129495
#> Sample_14958                                        0.09112754
#>              Epidish_CBSX.HNSCC.scRNAseq_Macrophages.cells
#> Sample_12929                                   0.075292165
#> Sample_15467                                   0.008499376
#> Sample_13634                                   0.007623895
#> Sample_14428                                   0.024191386
#> Sample_11817                                   0.017359857
#> Sample_14958                                   0.069939458
#>              CBSX_CBSX.HNSCC.scRNAseq_Macrophages.cells
#> Sample_12929                                 0.07749385
#> Sample_15467                                 0.01097979
#> Sample_13634                                 0.00542370
#> Sample_14428                                 0.02329723
#> Sample_11817                                 0.01942981
#> Sample_14958                                 0.07263549
#>              DWLS_CBSX.HNSCC.scRNAseq_Macrophages.cells
#> Sample_12929                                 0.11774133
#> Sample_15467                                 0.01658478
#> Sample_13634                                 0.01639775
#> Sample_14428                                 0.03657473
#> Sample_11817                                 0.03356979
#> Sample_14958                                 0.11003733
#>              DeconRNASeq_CBSX.Melanoma.scRNAseq_Macrophages.cells
#> Sample_12929                                           0.18910427
#> Sample_15467                                           0.06359302
#> Sample_13634                                           0.05450311
#> Sample_14428                                           0.12308670
#> Sample_11817                                           0.11083040
#> Sample_14958                                           0.15557081
#>              Epidish_CBSX.Melanoma.scRNAseq_Macrophages.cells
#> Sample_12929                                      0.061770969
#> Sample_15467                                      0.009135950
#> Sample_13634                                      0.003332959
#> Sample_14428                                      0.029195302
#> Sample_11817                                      0.008494767
#> Sample_14958                                      0.069093902
#>              CBSX_CBSX.Melanoma.scRNAseq_Macrophages.cells
#> Sample_12929                                   0.061709506
#> Sample_15467                                   0.009907880
#> Sample_13634                                   0.003732750
#> Sample_14428                                   0.024113263
#> Sample_11817                                   0.008953068
#> Sample_14958                                   0.069556715
#>              DWLS_CBSX.Melanoma.scRNAseq_Macrophages.cells
#> Sample_12929                                    0.21361820
#> Sample_15467                                    0.02881323
#> Sample_13634                                    0.01460246
#> Sample_14428                                    0.09716795
#> Sample_11817                                    0.03297417
#> Sample_14958                                    0.21544562
#>              DeconRNASeq_BPRNACan_Macrophages.M0
#> Sample_12929                                   0
#> Sample_15467                                   0
#> Sample_13634                                   0
#> Sample_14428                                   0
#> Sample_11817                                   0
#> Sample_14958                                   0
#>              Epidish_BPRNACan_Macrophages.M0 CBSX_BPRNACan_Macrophages.M0
#> Sample_12929                    0.000000e+00                 5.486507e-05
#> Sample_15467                    8.846067e-05                 0.000000e+00
#> Sample_13634                    0.000000e+00                 0.000000e+00
#> Sample_14428                    0.000000e+00                 0.000000e+00
#> Sample_11817                    0.000000e+00                 0.000000e+00
#> Sample_14958                    5.923447e-05                 4.118006e-04
#>              DWLS_BPRNACan_Macrophages.M0
#> Sample_12929                  0.000000000
#> Sample_15467                  0.000000000
#> Sample_13634                  0.000000000
#> Sample_14428                  0.001273488
#> Sample_11817                  0.000000000
#> Sample_14958                  0.002988045
#>              DeconRNASeq_BPRNACan3DProMet_Macrophages.M0
#> Sample_12929                                           0
#> Sample_15467                                           0
#> Sample_13634                                           0
#> Sample_14428                                           0
#> Sample_11817                                           0
#> Sample_14958                                           0
#>              Epidish_BPRNACan3DProMet_Macrophages.M0
#> Sample_12929                                       0
#> Sample_15467                                       0
#> Sample_13634                                       0
#> Sample_14428                                       0
#> Sample_11817                                       0
#> Sample_14958                                       0
#>              CBSX_BPRNACan3DProMet_Macrophages.M0
#> Sample_12929                          3.21219e-05
#> Sample_15467                          0.00000e+00
#> Sample_13634                          0.00000e+00
#> Sample_14428                          0.00000e+00
#> Sample_11817                          0.00000e+00
#> Sample_14958                          0.00000e+00
#>              DWLS_BPRNACan3DProMet_Macrophages.M0
#> Sample_12929                          0.000000000
#> Sample_15467                          0.000000000
#> Sample_13634                          0.000000000
#> Sample_14428                          0.000000000
#> Sample_11817                          0.000000000
#> Sample_14958                          0.002329731
#>              DeconRNASeq_BPRNACanProMet_Macrophages.M0
#> Sample_12929                                         0
#> Sample_15467                                         0
#> Sample_13634                                         0
#> Sample_14428                                         0
#> Sample_11817                                         0
#> Sample_14958                                         0
#>              Epidish_BPRNACanProMet_Macrophages.M0
#> Sample_12929                           0.000000000
#> Sample_15467                           0.000000000
#> Sample_13634                           0.000000000
#> Sample_14428                           0.000000000
#> Sample_11817                           0.000000000
#> Sample_14958                           0.000221913
#>              CBSX_BPRNACanProMet_Macrophages.M0
#> Sample_12929                       0.0000000000
#> Sample_15467                       0.0000000000
#> Sample_13634                       0.0000000000
#> Sample_14428                       0.0000000000
#> Sample_11817                       0.0000000000
#> Sample_14958                       0.0007140987
#>              DWLS_BPRNACanProMet_Macrophages.M0 DeconRNASeq_LM22_Macrophages.M0
#> Sample_12929                        0.000000000                               0
#> Sample_15467                        0.000000000                               0
#> Sample_13634                        0.000000000                               0
#> Sample_14428                        0.000000000                               0
#> Sample_11817                        0.000000000                               0
#> Sample_14958                        0.002396036                               0
#>              Epidish_LM22_Macrophages.M0 CBSX_LM22_Macrophages.M0
#> Sample_12929                           0                        0
#> Sample_15467                           0                        0
#> Sample_13634                           0                        0
#> Sample_14428                           0                        0
#> Sample_11817                           0                        0
#> Sample_14958                           0                        0
#>              DWLS_LM22_Macrophages.M0 Quantiseq_Macrophages.M1
#> Sample_12929                        0              0.126578546
#> Sample_15467                        0              0.031170929
#> Sample_13634                        0              0.006860362
#> Sample_14428                        0              0.085889305
#> Sample_11817                        0              0.005459985
#> Sample_14958                        0              0.129016128
#>              DeconRNASeq_BPRNACan_Macrophages.M1
#> Sample_12929                         0.000000000
#> Sample_15467                         0.002342920
#> Sample_13634                         0.013736234
#> Sample_14428                         0.001084007
#> Sample_11817                         0.015592241
#> Sample_14958                         0.010964399
#>              Epidish_BPRNACan_Macrophages.M1 CBSX_BPRNACan_Macrophages.M1
#> Sample_12929                    8.183520e-04                 0.0012636292
#> Sample_15467                    0.000000e+00                 0.0004690044
#> Sample_13634                    3.775840e-04                 0.0008473647
#> Sample_14428                    3.060162e-04                 0.0020256629
#> Sample_11817                    6.379536e-05                 0.0009771027
#> Sample_14958                    5.853758e-04                 0.0002678580
#>              DWLS_BPRNACan_Macrophages.M1
#> Sample_12929                 0.0072040608
#> Sample_15467                 0.0025268137
#> Sample_13634                 0.0054250098
#> Sample_14428                 0.0003486777
#> Sample_11817                 0.0030806297
#> Sample_14958                 0.0012358510
#>              DeconRNASeq_BPRNACan3DProMet_Macrophages.M1
#> Sample_12929                                  0.02176880
#> Sample_15467                                  0.01970052
#> Sample_13634                                  0.03603731
#> Sample_14428                                  0.01798562
#> Sample_11817                                  0.04441717
#> Sample_14958                                  0.03804909
#>              Epidish_BPRNACan3DProMet_Macrophages.M1
#> Sample_12929                            9.555210e-04
#> Sample_15467                            0.000000e+00
#> Sample_13634                            4.863925e-04
#> Sample_14428                            4.597157e-04
#> Sample_11817                            7.400187e-05
#> Sample_14958                            6.927458e-04
#>              CBSX_BPRNACan3DProMet_Macrophages.M1
#> Sample_12929                         0.0012057828
#> Sample_15467                         0.0005150699
#> Sample_13634                         0.0004147509
#> Sample_14428                         0.0033922906
#> Sample_11817                         0.0008753264
#> Sample_14958                         0.0038681585
#>              DWLS_BPRNACan3DProMet_Macrophages.M1
#> Sample_12929                         0.0065797047
#> Sample_15467                         0.0002716039
#> Sample_13634                         0.0043311819
#> Sample_14428                         0.0021252582
#> Sample_11817                         0.0043554998
#> Sample_14958                         0.0010270748
#>              DeconRNASeq_BPRNACanProMet_Macrophages.M1
#> Sample_12929                                0.01761818
#> Sample_15467                                0.01353357
#> Sample_13634                                0.02687088
#> Sample_14428                                0.01489863
#> Sample_11817                                0.03700875
#> Sample_14958                                0.02971435
#>              Epidish_BPRNACanProMet_Macrophages.M1
#> Sample_12929                          0.0008466741
#> Sample_15467                          0.0000000000
#> Sample_13634                          0.0002467042
#> Sample_14428                          0.0002858963
#> Sample_11817                          0.0000000000
#> Sample_14958                          0.0002908523
#>              CBSX_BPRNACanProMet_Macrophages.M1
#> Sample_12929                       0.0015931755
#> Sample_15467                       0.0004859293
#> Sample_13634                       0.0000000000
#> Sample_14428                       0.0016781777
#> Sample_11817                       0.0005613984
#> Sample_14958                       0.0003880235
#>              DWLS_BPRNACanProMet_Macrophages.M1
#> Sample_12929                       0.0053827132
#> Sample_15467                       0.0002679217
#> Sample_13634                       0.0000000000
#> Sample_14428                       0.0038849649
#> Sample_11817                       0.0000000000
#> Sample_14958                       0.0009765272
#>              DeconRNASeq_CCLE.TIL10_Macrophages.M1
#> Sample_12929                            0.23982807
#> Sample_15467                            0.09627939
#> Sample_13634                            0.04217790
#> Sample_14428                            0.19936406
#> Sample_11817                            0.01306426
#> Sample_14958                            0.32985667
#>              Epidish_CCLE.TIL10_Macrophages.M1 CBSX_CCLE.TIL10_Macrophages.M1
#> Sample_12929                        0.24565757                     0.14019174
#> Sample_15467                        0.09266398                     0.10788270
#> Sample_13634                        0.05197184                     0.05012929
#> Sample_14428                        0.19076269                     0.17577775
#> Sample_11817                        0.03862152                     0.03489012
#> Sample_14958                        0.27483855                     0.19287098
#>              DWLS_CCLE.TIL10_Macrophages.M1 DeconRNASeq_LM22_Macrophages.M1
#> Sample_12929                     0.37776621                               0
#> Sample_15467                     0.13832471                               0
#> Sample_13634                     0.07572812                               0
#> Sample_14428                     0.23421316                               0
#> Sample_11817                     0.05346762                               0
#> Sample_14958                     0.33561501                               0
#>              Epidish_LM22_Macrophages.M1 CBSX_LM22_Macrophages.M1
#> Sample_12929                           0                        0
#> Sample_15467                           0                        0
#> Sample_13634                           0                        0
#> Sample_14428                           0                        0
#> Sample_11817                           0                        0
#> Sample_14958                           0                        0
#>              DWLS_LM22_Macrophages.M1 DeconRNASeq_TIL10_Macrophages.M1
#> Sample_12929                        0                       0.23820537
#> Sample_15467                        0                       0.07684289
#> Sample_13634                        0                       0.01717793
#> Sample_14428                        0                       0.18487025
#> Sample_11817                        0                       0.00000000
#> Sample_14958                        0                       0.34112672
#>              Epidish_TIL10_Macrophages.M1 CBSX_TIL10_Macrophages.M1
#> Sample_12929                   0.16390705                0.15524281
#> Sample_15467                   0.05727822                0.04960230
#> Sample_13634                   0.04524524                0.02751504
#> Sample_14428                   0.09380657                0.08338320
#> Sample_11817                   0.03767540                0.03476980
#> Sample_14958                   0.20490953                0.25143729
#>              DWLS_TIL10_Macrophages.M1 Quantiseq_Macrophages.M2
#> Sample_12929                0.24709473               0.00000000
#> Sample_15467                0.07648197               0.00000000
#> Sample_13634                0.04474821               0.00000000
#> Sample_14428                0.08159421               0.00000000
#> Sample_11817                0.04675715               0.00000000
#> Sample_14958                0.30330462               0.01533913
#>              DeconRNASeq_BPRNACan_Macrophages.M2
#> Sample_12929                         0.000000000
#> Sample_15467                         0.010128690
#> Sample_13634                         0.023449452
#> Sample_14428                         0.006667155
#> Sample_11817                         0.028519639
#> Sample_14958                         0.003222397
#>              Epidish_BPRNACan_Macrophages.M2 CBSX_BPRNACan_Macrophages.M2
#> Sample_12929                    0.000000e+00                 1.008834e-04
#> Sample_15467                    7.414674e-05                 2.326452e-04
#> Sample_13634                    1.525939e-05                 2.748986e-04
#> Sample_14428                    8.454774e-05                 0.000000e+00
#> Sample_11817                    1.061562e-04                 2.810944e-04
#> Sample_14958                    2.362162e-05                 9.812054e-05
#>              DWLS_BPRNACan_Macrophages.M2
#> Sample_12929                  0.001148360
#> Sample_15467                  0.004018720
#> Sample_13634                  0.001811246
#> Sample_14428                  0.003821937
#> Sample_11817                  0.003997786
#> Sample_14958                  0.002483014
#>              DeconRNASeq_BPRNACan3DProMet_Macrophages.M2
#> Sample_12929                                  0.03437822
#> Sample_15467                                  0.04061631
#> Sample_13634                                  0.06199413
#> Sample_14428                                  0.03639906
#> Sample_11817                                  0.07451596
#> Sample_14958                                  0.04217949
#>              Epidish_BPRNACan3DProMet_Macrophages.M2
#> Sample_12929                            0.000000e+00
#> Sample_15467                            7.172884e-05
#> Sample_13634                            1.031994e-05
#> Sample_14428                            8.536000e-05
#> Sample_11817                            1.022006e-04
#> Sample_14958                            1.778005e-05
#>              CBSX_BPRNACan3DProMet_Macrophages.M2
#> Sample_12929                         8.960686e-05
#> Sample_15467                         3.819967e-04
#> Sample_13634                         0.000000e+00
#> Sample_14428                         3.669778e-04
#> Sample_11817                         4.906472e-04
#> Sample_14958                         5.806934e-05
#>              DWLS_BPRNACan3DProMet_Macrophages.M2
#> Sample_12929                          0.000816814
#> Sample_15467                          0.003282557
#> Sample_13634                          0.001293608
#> Sample_14428                          0.003220463
#> Sample_11817                          0.003242016
#> Sample_14958                          0.001923586
#>              DeconRNASeq_BPRNACanProMet_Macrophages.M2
#> Sample_12929                                0.02814900
#> Sample_15467                                0.03481959
#> Sample_13634                                0.05410804
#> Sample_14428                                0.03145612
#> Sample_11817                                0.06726301
#> Sample_14958                                0.03416021
#>              Epidish_BPRNACanProMet_Macrophages.M2
#> Sample_12929                          1.285974e-05
#> Sample_15467                          6.994768e-05
#> Sample_13634                          1.110763e-07
#> Sample_14428                          8.019213e-05
#> Sample_11817                          7.631924e-05
#> Sample_14958                          1.513286e-05
#>              CBSX_BPRNACanProMet_Macrophages.M2
#> Sample_12929                       0.0001089635
#> Sample_15467                       0.0003716081
#> Sample_13634                       0.0000000000
#> Sample_14428                       0.0003963378
#> Sample_11817                       0.0003868981
#> Sample_14958                       0.0001473475
#>              DWLS_BPRNACanProMet_Macrophages.M2
#> Sample_12929                       0.0008428604
#> Sample_15467                       0.0031317816
#> Sample_13634                       0.0000000000
#> Sample_14428                       0.0032831110
#> Sample_11817                       0.0000000000
#> Sample_14958                       0.0018830237
#>              DeconRNASeq_CCLE.TIL10_Macrophages.M2
#> Sample_12929                            0.00000000
#> Sample_15467                            0.00000000
#> Sample_13634                            0.00000000
#> Sample_14428                            0.00000000
#> Sample_11817                            0.00000000
#> Sample_14958                            0.01085866
#>              Epidish_CCLE.TIL10_Macrophages.M2 CBSX_CCLE.TIL10_Macrophages.M2
#> Sample_12929                       0.028439106                    0.057562884
#> Sample_15467                       0.026751620                    0.014886217
#> Sample_13634                       0.001912398                    0.005789941
#> Sample_14428                       0.039934361                    0.042406669
#> Sample_11817                       0.020761658                    0.024427009
#> Sample_14958                       0.099186324                    0.047784084
#>              DWLS_CCLE.TIL10_Macrophages.M2 DeconRNASeq_TIL10_Macrophages.M2
#> Sample_12929                    0.045362848                       0.00000000
#> Sample_15467                    0.024863887                       0.00000000
#> Sample_13634                    0.001273892                       0.00000000
#> Sample_14428                    0.041821449                       0.00000000
#> Sample_11817                    0.023395847                       0.00000000
#> Sample_14958                    0.121376417                       0.01505073
#>              Epidish_TIL10_Macrophages.M2 CBSX_TIL10_Macrophages.M2
#> Sample_12929                   0.04150415                0.01717952
#> Sample_15467                   0.01823499                0.01219592
#> Sample_13634                   0.00000000                0.03160572
#> Sample_14428                   0.02964844                0.02478074
#> Sample_11817                   0.02271730                0.03080761
#> Sample_14958                   0.09657577                0.01809545
#>              DWLS_TIL10_Macrophages.M2 DeconRNASeq_LM22_Macrophages.M2
#> Sample_12929               0.021141022                     0.040763362
#> Sample_15467               0.014257078                     0.000000000
#> Sample_13634               0.011115972                     0.000000000
#> Sample_14428               0.027120305                     0.007936016
#> Sample_11817               0.009538183                     0.008396166
#> Sample_14958               0.053210355                     0.055978054
#>              Epidish_LM22_Macrophages.M2 CBSX_LM22_Macrophages.M2
#> Sample_12929                 0.040290539              0.037647861
#> Sample_15467                 0.007817649              0.008622675
#> Sample_13634                 0.005084624              0.005629767
#> Sample_14428                 0.024369565              0.019427832
#> Sample_11817                 0.017734895              0.014893101
#> Sample_14958                 0.064543009              0.053412374
#>              DWLS_LM22_Macrophages.M2 Quantiseq_Monocytes
#> Sample_12929              0.043726233                   0
#> Sample_15467              0.005637107                   0
#> Sample_13634              0.004453857                   0
#> Sample_14428              0.016611272                   0
#> Sample_11817              0.013106633                   0
#> Sample_14958              0.050178876                   0
#>              DeconRNASeq_BPRNACan_Monocytes Epidish_BPRNACan_Monocytes
#> Sample_12929                     0.03989451                0.008319263
#> Sample_15467                     0.02753689                0.000000000
#> Sample_13634                     0.02534086                0.000000000
#> Sample_14428                     0.01985890                0.002813648
#> Sample_11817                     0.03180483                0.005254593
#> Sample_14958                     0.04474596                0.011229320
#>              CBSX_BPRNACan_Monocytes DWLS_BPRNACan_Monocytes
#> Sample_12929             0.010574360             0.010265389
#> Sample_15467             0.000000000             0.000000000
#> Sample_13634             0.000000000             0.000000000
#> Sample_14428             0.001169072             0.004299787
#> Sample_11817             0.001874512             0.005766841
#> Sample_14958             0.011966425             0.018538398
#>              DeconRNASeq_BPRNACan3DProMet_Monocytes
#> Sample_12929                            0.005180254
#> Sample_15467                            0.000000000
#> Sample_13634                            0.000000000
#> Sample_14428                            0.000000000
#> Sample_11817                            0.000000000
#> Sample_14958                            0.011332385
#>              Epidish_BPRNACan3DProMet_Monocytes CBSX_BPRNACan3DProMet_Monocytes
#> Sample_12929                        0.006518028                     0.007210337
#> Sample_15467                        0.000000000                     0.000000000
#> Sample_13634                        0.000000000                     0.000000000
#> Sample_14428                        0.000000000                     0.000000000
#> Sample_11817                        0.003665046                     0.001980099
#> Sample_14958                        0.009793648                     0.012680502
#>              DWLS_BPRNACan3DProMet_Monocytes
#> Sample_12929                     0.008625730
#> Sample_15467                     0.000000000
#> Sample_13634                     0.000000000
#> Sample_14428                     0.000000000
#> Sample_11817                     0.002341361
#> Sample_14958                     0.019092126
#>              DeconRNASeq_BPRNACanProMet_Monocytes
#> Sample_12929                          0.024999526
#> Sample_15467                          0.006488495
#> Sample_13634                          0.000000000
#> Sample_14428                          0.000000000
#> Sample_11817                          0.003143438
#> Sample_14958                          0.031424807
#>              Epidish_BPRNACanProMet_Monocytes CBSX_BPRNACanProMet_Monocytes
#> Sample_12929                      0.014758712                   0.010316765
#> Sample_15467                      0.000000000                   0.000000000
#> Sample_13634                      0.000000000                   0.000000000
#> Sample_14428                      0.002847892                   0.004247411
#> Sample_11817                      0.003721947                   0.005791508
#> Sample_14958                      0.013226247                   0.011418861
#>              DWLS_BPRNACanProMet_Monocytes
#> Sample_12929                   0.025023748
#> Sample_15467                   0.000000000
#> Sample_13634                   0.000000000
#> Sample_14428                   0.004282118
#> Sample_11817                   0.003686134
#> Sample_14958                   0.029130839
#>              DeconRNASeq_CBSX.NSCLC.PBMCs.scRNAseq_Monocytes
#> Sample_12929                                               0
#> Sample_15467                                               0
#> Sample_13634                                               0
#> Sample_14428                                               0
#> Sample_11817                                               0
#> Sample_14958                                               0
#>              Epidish_CBSX.NSCLC.PBMCs.scRNAseq_Monocytes
#> Sample_12929                                           0
#> Sample_15467                                           0
#> Sample_13634                                           0
#> Sample_14428                                           0
#> Sample_11817                                           0
#> Sample_14958                                           0
#>              CBSX_CBSX.NSCLC.PBMCs.scRNAseq_Monocytes
#> Sample_12929                                        0
#> Sample_15467                                        0
#> Sample_13634                                        0
#> Sample_14428                                        0
#> Sample_11817                                        0
#> Sample_14958                                        0
#>              DWLS_CBSX.NSCLC.PBMCs.scRNAseq_Monocytes
#> Sample_12929                                        0
#> Sample_15467                                        0
#> Sample_13634                                        0
#> Sample_14428                                        0
#> Sample_11817                                        0
#> Sample_14958                                        0
#>              DeconRNASeq_CCLE.TIL10_Monocytes Epidish_CCLE.TIL10_Monocytes
#> Sample_12929                                0                  0.013643812
#> Sample_15467                                0                  0.023483016
#> Sample_13634                                0                  0.008669774
#> Sample_14428                                0                  0.055233645
#> Sample_11817                                0                  0.011744866
#> Sample_14958                                0                  0.018618031
#>              CBSX_CCLE.TIL10_Monocytes DWLS_CCLE.TIL10_Monocytes
#> Sample_12929               0.000000000               0.004058127
#> Sample_15467               0.014805898               0.023802607
#> Sample_13634               0.009512379               0.005837029
#> Sample_14428               0.054141351               0.043187372
#> Sample_11817               0.012691345               0.010976547
#> Sample_14958               0.000000000               0.011748776
#>              DeconRNASeq_LM22_Monocytes Epidish_LM22_Monocytes
#> Sample_12929                0.000000000            0.012442874
#> Sample_15467                0.000000000            0.011314409
#> Sample_13634                0.000000000            0.001485282
#> Sample_14428                0.000000000            0.011646098
#> Sample_11817                0.000000000            0.012667374
#> Sample_14958                0.006345126            0.018869018
#>              CBSX_LM22_Monocytes DWLS_LM22_Monocytes
#> Sample_12929         0.011629983         0.008598365
#> Sample_15467         0.009438697         0.013018549
#> Sample_13634         0.002530372         0.002919099
#> Sample_14428         0.012597945         0.011984791
#> Sample_11817         0.014499740         0.014513173
#> Sample_14958         0.014384818         0.013719583
#>              DeconRNASeq_TIL10_Monocytes Epidish_TIL10_Monocytes
#> Sample_12929                           0             0.021017010
#> Sample_15467                           0             0.030420105
#> Sample_13634                           0             0.007896362
#> Sample_14428                           0             0.079376839
#> Sample_11817                           0             0.014742992
#> Sample_14958                           0             0.035019967
#>              CBSX_TIL10_Monocytes DWLS_TIL10_Monocytes Quantiseq_Neutrophils
#> Sample_12929           0.03715734          0.038078217            0.00000000
#> Sample_15467           0.02435488          0.024363182            0.00000000
#> Sample_13634           0.00000000          0.005618837            0.00000000
#> Sample_14428           0.09569119          0.060874322            0.00000000
#> Sample_11817           0.01459089          0.013259730            0.00000000
#> Sample_14958           0.03268526          0.048967385            0.02402664
#>              DeconRNASeq_BPRNACan_Neutrophils Epidish_BPRNACan_Neutrophils
#> Sample_12929                                0                  0.004322000
#> Sample_15467                                0                  0.000965925
#> Sample_13634                                0                  0.001871399
#> Sample_14428                                0                  0.000559323
#> Sample_11817                                0                  0.003619774
#> Sample_14958                                0                  0.002903511
#>              CBSX_BPRNACan_Neutrophils DWLS_BPRNACan_Neutrophils
#> Sample_12929               0.006515547               0.011914000
#> Sample_15467               0.002327377               0.004198128
#> Sample_13634               0.004846013               0.004749887
#> Sample_14428               0.002883803               0.004774828
#> Sample_11817               0.004536307               0.005489456
#> Sample_14958               0.001926899               0.005999294
#>              DeconRNASeq_BPRNACan3DProMet_Neutrophils
#> Sample_12929                                        0
#> Sample_15467                                        0
#> Sample_13634                                        0
#> Sample_14428                                        0
#> Sample_11817                                        0
#> Sample_14958                                        0
#>              Epidish_BPRNACan3DProMet_Neutrophils
#> Sample_12929                         0.0016006923
#> Sample_15467                         0.0000000000
#> Sample_13634                         0.0007891512
#> Sample_14428                         0.0000000000
#> Sample_11817                         0.0023158765
#> Sample_14958                         0.0009619417
#>              CBSX_BPRNACan3DProMet_Neutrophils
#> Sample_12929                      0.0008247029
#> Sample_15467                      0.0000000000
#> Sample_13634                      0.0019099536
#> Sample_14428                      0.0000000000
#> Sample_11817                      0.0000000000
#> Sample_14958                      0.0004024234
#>              DWLS_BPRNACan3DProMet_Neutrophils
#> Sample_12929                      0.0030313607
#> Sample_15467                      0.0032003842
#> Sample_13634                      0.0018685741
#> Sample_14428                      0.0008909722
#> Sample_11817                      0.0031549421
#> Sample_14958                      0.0021865652
#>              DeconRNASeq_BPRNACanProMet_Neutrophils
#> Sample_12929                                      0
#> Sample_15467                                      0
#> Sample_13634                                      0
#> Sample_14428                                      0
#> Sample_11817                                      0
#> Sample_14958                                      0
#>              Epidish_BPRNACanProMet_Neutrophils CBSX_BPRNACanProMet_Neutrophils
#> Sample_12929                       0.0011558686                    0.0010545782
#> Sample_15467                       0.0000000000                    0.0000000000
#> Sample_13634                       0.0009196561                    0.0000000000
#> Sample_14428                       0.0000000000                    0.0000000000
#> Sample_11817                       0.0021820875                    0.0005602243
#> Sample_14958                       0.0011660525                    0.0017117288
#>              DWLS_BPRNACanProMet_Neutrophils DeconRNASeq_CCLE.TIL10_Neutrophils
#> Sample_12929                    0.0007976901                                  0
#> Sample_15467                    0.0032853942                                  0
#> Sample_13634                    0.0020572490                                  0
#> Sample_14428                    0.0039213441                                  0
#> Sample_11817                    0.0046206180                                  0
#> Sample_14958                    0.0021973164                                  0
#>              Epidish_CCLE.TIL10_Neutrophils CBSX_CCLE.TIL10_Neutrophils
#> Sample_12929                    0.000000000                 0.011077614
#> Sample_15467                    0.000000000                 0.000000000
#> Sample_13634                    0.002096064                 0.001165247
#> Sample_14428                    0.000000000                 0.000000000
#> Sample_11817                    0.001139232                 0.000000000
#> Sample_14958                    0.000000000                 0.007478875
#>              DWLS_CCLE.TIL10_Neutrophils DeconRNASeq_LM22_Neutrophils
#> Sample_12929                 0.000000000                            0
#> Sample_15467                 0.000000000                            0
#> Sample_13634                 0.001594481                            0
#> Sample_14428                 0.000000000                            0
#> Sample_11817                 0.001077722                            0
#> Sample_14958                 0.000000000                            0
#>              Epidish_LM22_Neutrophils CBSX_LM22_Neutrophils
#> Sample_12929                        0                     0
#> Sample_15467                        0                     0
#> Sample_13634                        0                     0
#> Sample_14428                        0                     0
#> Sample_11817                        0                     0
#> Sample_14958                        0                     0
#>              DWLS_LM22_Neutrophils DeconRNASeq_TIL10_Neutrophils
#> Sample_12929                     0                   0.000000000
#> Sample_15467                     0                   0.000000000
#> Sample_13634                     0                   0.000000000
#> Sample_14428                     0                   0.000000000
#> Sample_11817                     0                   0.000000000
#> Sample_14958                     0                   0.003851523
#>              Epidish_TIL10_Neutrophils CBSX_TIL10_Neutrophils
#> Sample_12929                         0            0.000000000
#> Sample_15467                         0            0.000000000
#> Sample_13634                         0            0.014896298
#> Sample_14428                         0            0.003900519
#> Sample_11817                         0            0.000000000
#> Sample_14958                         0            0.000000000
#>              DWLS_TIL10_Neutrophils Quantiseq_NK.cells
#> Sample_12929           0.0000000000          0.2028034
#> Sample_15467           0.0001068078          0.1520596
#> Sample_13634           0.0032270387          0.2066250
#> Sample_14428           0.0000000000          0.1803146
#> Sample_11817           0.0000000000          0.1387909
#> Sample_14958           0.0000000000          0.1490053
#>              DeconRNASeq_BPRNACan_NK.cells Epidish_BPRNACan_NK.cells
#> Sample_12929                             0                         0
#> Sample_15467                             0                         0
#> Sample_13634                             0                         0
#> Sample_14428                             0                         0
#> Sample_11817                             0                         0
#> Sample_14958                             0                         0
#>              CBSX_BPRNACan_NK.cells DWLS_BPRNACan_NK.cells
#> Sample_12929                      0                      0
#> Sample_15467                      0                      0
#> Sample_13634                      0                      0
#> Sample_14428                      0                      0
#> Sample_11817                      0                      0
#> Sample_14958                      0                      0
#>              DeconRNASeq_BPRNACan3DProMet_NK.cells
#> Sample_12929                            0.00000000
#> Sample_15467                            0.00000000
#> Sample_13634                            0.00000000
#> Sample_14428                            0.00000000
#> Sample_11817                            0.01221711
#> Sample_14958                            0.00000000
#>              Epidish_BPRNACan3DProMet_NK.cells CBSX_BPRNACan3DProMet_NK.cells
#> Sample_12929                                 0                              0
#> Sample_15467                                 0                              0
#> Sample_13634                                 0                              0
#> Sample_14428                                 0                              0
#> Sample_11817                                 0                              0
#> Sample_14958                                 0                              0
#>              DWLS_BPRNACan3DProMet_NK.cells DeconRNASeq_BPRNACanProMet_NK.cells
#> Sample_12929                              0                         0.000000000
#> Sample_15467                              0                         0.000000000
#> Sample_13634                              0                         0.000000000
#> Sample_14428                              0                         0.000000000
#> Sample_11817                              0                         0.008460782
#> Sample_14958                              0                         0.000000000
#>              Epidish_BPRNACanProMet_NK.cells CBSX_BPRNACanProMet_NK.cells
#> Sample_12929                               0                            0
#> Sample_15467                               0                            0
#> Sample_13634                               0                            0
#> Sample_14428                               0                            0
#> Sample_11817                               0                            0
#> Sample_14958                               0                            0
#>              DWLS_BPRNACanProMet_NK.cells
#> Sample_12929                            0
#> Sample_15467                            0
#> Sample_13634                            0
#> Sample_14428                            0
#> Sample_11817                            0
#> Sample_14958                            0
#>              DeconRNASeq_BSeqSC.Vanderbilt.scRNAseq_NK.cells
#> Sample_12929                                      0.10740695
#> Sample_15467                                      0.15684286
#> Sample_13634                                      0.14710941
#> Sample_14428                                      0.07392930
#> Sample_11817                                      0.21837193
#> Sample_14958                                      0.07931141
#>              Epidish_BSeqSC.Vanderbilt.scRNAseq_NK.cells
#> Sample_12929                                  0.02328995
#> Sample_15467                                  0.03897010
#> Sample_13634                                  0.07382546
#> Sample_14428                                  0.00000000
#> Sample_11817                                  0.15150474
#> Sample_14958                                  0.01811292
#>              CBSX_BSeqSC.Vanderbilt.scRNAseq_NK.cells
#> Sample_12929                              0.040043629
#> Sample_15467                              0.052155777
#> Sample_13634                              0.094959284
#> Sample_14428                              0.000183405
#> Sample_11817                              0.124780848
#> Sample_14958                              0.015054396
#>              DWLS_BSeqSC.Vanderbilt.scRNAseq_NK.cells
#> Sample_12929                               0.03116492
#> Sample_15467                               0.03646821
#> Sample_13634                               0.08197493
#> Sample_14428                               0.00000000
#> Sample_11817                               0.15692199
#> Sample_14958                               0.01672762
#>              DeconRNASeq_CBSX.Melanoma.scRNAseq_NK.cells
#> Sample_12929                                  0.02987641
#> Sample_15467                                  0.04561339
#> Sample_13634                                  0.08886263
#> Sample_14428                                  0.07110812
#> Sample_11817                                  0.03126592
#> Sample_14958                                  0.03403444
#>              Epidish_CBSX.Melanoma.scRNAseq_NK.cells
#> Sample_12929                              0.05376527
#> Sample_15467                              0.06894373
#> Sample_13634                              0.07235762
#> Sample_14428                              0.04137880
#> Sample_11817                              0.05307437
#> Sample_14958                              0.05607748
#>              CBSX_CBSX.Melanoma.scRNAseq_NK.cells
#> Sample_12929                           0.03368187
#> Sample_15467                           0.05536748
#> Sample_13634                           0.05036128
#> Sample_14428                           0.03247970
#> Sample_11817                           0.05074308
#> Sample_14958                           0.05589359
#>              DWLS_CBSX.Melanoma.scRNAseq_NK.cells
#> Sample_12929                           0.06769900
#> Sample_15467                           0.08518045
#> Sample_13634                           0.09911940
#> Sample_14428                           0.05055487
#> Sample_11817                           0.07142874
#> Sample_14958                           0.06840510
#>              DeconRNASeq_CBSX.NSCLC.PBMCs.scRNAseq_NK.cells
#> Sample_12929                                     0.03454458
#> Sample_15467                                     0.00000000
#> Sample_13634                                     0.00000000
#> Sample_14428                                     0.00000000
#> Sample_11817                                     0.00000000
#> Sample_14958                                     0.11964524
#>              Epidish_CBSX.NSCLC.PBMCs.scRNAseq_NK.cells
#> Sample_12929                                0.007539654
#> Sample_15467                                0.000000000
#> Sample_13634                                0.033856947
#> Sample_14428                                0.020486384
#> Sample_11817                                0.000000000
#> Sample_14958                                0.021009311
#>              CBSX_CBSX.NSCLC.PBMCs.scRNAseq_NK.cells
#> Sample_12929                             0.000000000
#> Sample_15467                             0.000000000
#> Sample_13634                             0.028161116
#> Sample_14428                             0.003580511
#> Sample_11817                             0.000000000
#> Sample_14958                             0.024077283
#>              DWLS_CBSX.NSCLC.PBMCs.scRNAseq_NK.cells
#> Sample_12929                              0.04039915
#> Sample_15467                              0.00000000
#> Sample_13634                              0.08092822
#> Sample_14428                              0.02562214
#> Sample_11817                              0.00000000
#> Sample_14958                              0.07483615
#>              DeconRNASeq_CBSX.Vanderbilt.scRNAseq_NK.cells
#> Sample_12929                                   0.022859671
#> Sample_15467                                   0.025786423
#> Sample_13634                                   0.084311828
#> Sample_14428                                   0.006258086
#> Sample_11817                                   0.134673654
#> Sample_14958                                   0.000000000
#>              Epidish_CBSX.Vanderbilt.scRNAseq_NK.cells
#> Sample_12929                                0.03216455
#> Sample_15467                                0.03957782
#> Sample_13634                                0.04405105
#> Sample_14428                                0.03377400
#> Sample_11817                                0.08516336
#> Sample_14958                                0.01828499
#>              CBSX_CBSX.Vanderbilt.scRNAseq_NK.cells
#> Sample_12929                             0.02475138
#> Sample_15467                             0.03444567
#> Sample_13634                             0.03211423
#> Sample_14428                             0.02540831
#> Sample_11817                             0.04919896
#> Sample_14958                             0.01865195
#>              DWLS_CBSX.Vanderbilt.scRNAseq_NK.cells
#> Sample_12929                             0.03602911
#> Sample_15467                             0.04470350
#> Sample_13634                             0.05637551
#> Sample_14428                             0.03889482
#> Sample_11817                             0.10054477
#> Sample_14958                             0.02558900
#>              DeconRNASeq_CCLE.TIL10_NK.cells Epidish_CCLE.TIL10_NK.cells
#> Sample_12929                       0.2037996                   0.1154782
#> Sample_15467                       0.2919285                   0.1967204
#> Sample_13634                       0.2700728                   0.1908396
#> Sample_14428                       0.2636557                   0.1590809
#> Sample_11817                       0.2126663                   0.1697983
#> Sample_14958                       0.2383901                   0.0878186
#>              CBSX_CCLE.TIL10_NK.cells DWLS_CCLE.TIL10_NK.cells
#> Sample_12929                0.1017843               0.12420640
#> Sample_15467                0.1914944               0.23128472
#> Sample_13634                0.1992129               0.16838265
#> Sample_14428                0.1654348               0.18748225
#> Sample_11817                0.1669452               0.19550095
#> Sample_14958                0.1498304               0.09515698
#>              DeconRNASeq_DWLS.Vanderbilt.scRNAseq_NK.cells
#> Sample_12929                                   0.010323869
#> Sample_15467                                   0.000000000
#> Sample_13634                                   0.003826791
#> Sample_14428                                   0.000000000
#> Sample_11817                                   0.096975660
#> Sample_14958                                   0.000000000
#>              Epidish_DWLS.Vanderbilt.scRNAseq_NK.cells
#> Sample_12929                               0.019684982
#> Sample_15467                               0.028860559
#> Sample_13634                               0.029073825
#> Sample_14428                               0.008479928
#> Sample_11817                               0.033017212
#> Sample_14958                               0.019837171
#>              CBSX_DWLS.Vanderbilt.scRNAseq_NK.cells
#> Sample_12929                             0.02141843
#> Sample_15467                             0.04799447
#> Sample_13634                             0.02451376
#> Sample_14428                             0.01043489
#> Sample_11817                             0.03246971
#> Sample_14958                             0.02250278
#>              DWLS_DWLS.Vanderbilt.scRNAseq_NK.cells
#> Sample_12929                             0.01615630
#> Sample_15467                             0.04113840
#> Sample_13634                             0.03557562
#> Sample_14428                             0.02525268
#> Sample_11817                             0.05192844
#> Sample_14958                             0.01622224
#>              DeconRNASeq_MOMF.Vanderbilt.scRNAseq_NK.cells
#> Sample_12929                                    0.06372751
#> Sample_15467                                    0.05778411
#> Sample_13634                                    0.08559219
#> Sample_14428                                    0.05369761
#> Sample_11817                                    0.23045855
#> Sample_14958                                    0.01793041
#>              Epidish_MOMF.Vanderbilt.scRNAseq_NK.cells
#> Sample_12929                                 0.0000000
#> Sample_15467                                 0.0000000
#> Sample_13634                                 0.0000000
#> Sample_14428                                 0.0000000
#> Sample_11817                                 0.1094569
#> Sample_14958                                 0.0000000
#>              CBSX_MOMF.Vanderbilt.scRNAseq_NK.cells
#> Sample_12929                              0.0000000
#> Sample_15467                              0.0000000
#> Sample_13634                              0.0000000
#> Sample_14428                              0.0000000
#> Sample_11817                              0.2034651
#> Sample_14958                              0.0000000
#>              DWLS_MOMF.Vanderbilt.scRNAseq_NK.cells DeconRNASeq_TIL10_NK.cells
#> Sample_12929                            0.000000000                  0.2049382
#> Sample_15467                            0.003923552                  0.3042587
#> Sample_13634                            0.000000000                  0.2728354
#> Sample_14428                            0.000000000                  0.2650475
#> Sample_11817                            0.110324124                  0.2351360
#> Sample_14958                            0.000000000                  0.2612998
#>              Epidish_TIL10_NK.cells CBSX_TIL10_NK.cells DWLS_TIL10_NK.cells
#> Sample_12929              0.1282225           0.1147049           0.1715932
#> Sample_15467              0.1903810           0.2052527           0.2813015
#> Sample_13634              0.2054313           0.1542484           0.1684603
#> Sample_14428              0.2232709           0.1561517           0.2671892
#> Sample_11817              0.1906075           0.2104001           0.2204049
#> Sample_14958              0.1438476           0.1554637           0.2093095
#>              AutogeneS_Vanderbilt_NK.cells BayesPrism_Vanderbilt_NK.cells
#> Sample_12929                    0.09291533                   0.0032956142
#> Sample_15467                    0.09510300                   0.0028999192
#> Sample_13634                    0.12804051                   0.0002882059
#> Sample_14428                    0.09138447                   0.0003580765
#> Sample_11817                    0.12125434                   0.1349485745
#> Sample_14958                    0.07722951                   0.0018557731
#>              Bisque_Vanderbilt_NK.cells CPM_Vanderbilt_NK.cells
#> Sample_12929                 0.00000000              0.07513825
#> Sample_15467                 0.00000000              0.07528490
#> Sample_13634                 0.00000000              0.07625413
#> Sample_14428                 0.00000000              0.07481891
#> Sample_11817                 0.05646167              0.07741560
#> Sample_14958                 0.00000000              0.07364427
#>              MuSic_Vanderbilt_NK.cells SCDC_Vanderbilt_NK.cells
#> Sample_12929                0.00000000                0.0000000
#> Sample_15467                0.01067030                0.0000000
#> Sample_13634                0.00000000                0.0000000
#> Sample_14428                0.00000000                0.0000000
#> Sample_11817                0.08710192                0.1682638
#> Sample_14958                0.00000000                0.0000000
#>              DeconRNASeq_LM22_NK.activated Epidish_LM22_NK.activated
#> Sample_12929                   0.001136701                0.03151656
#> Sample_15467                   0.000000000                0.06461130
#> Sample_13634                   0.064190911                0.09821165
#> Sample_14428                   0.047332852                0.07763429
#> Sample_11817                   0.057175641                0.11213213
#> Sample_14958                   0.014890039                0.00000000
#>              CBSX_LM22_NK.activated DWLS_LM22_NK.activated
#> Sample_12929             0.02694305             0.07521053
#> Sample_15467             0.06968701             0.11104735
#> Sample_13634             0.10556747             0.17290179
#> Sample_14428             0.07542900             0.12301956
#> Sample_11817             0.11472320             0.18050578
#> Sample_14958             0.01026422             0.01155771
#>              DeconRNASeq_LM22_NK.resting Epidish_LM22_NK.resting
#> Sample_12929                           0                       0
#> Sample_15467                           0                       0
#> Sample_13634                           0                       0
#> Sample_14428                           0                       0
#> Sample_11817                           0                       0
#> Sample_14958                           0                       0
#>              CBSX_LM22_NK.resting DWLS_LM22_NK.resting
#> Sample_12929                    0                    0
#> Sample_15467                    0                    0
#> Sample_13634                    0                    0
#> Sample_14428                    0                    0
#> Sample_11817                    0                    0
#> Sample_14958                    0                    0
#>              DeconRNASeq_CBSX.NSCLC.PBMCs.scRNAseq_NKT.cells
#> Sample_12929                                      0.08476669
#> Sample_15467                                      0.11275826
#> Sample_13634                                      0.15480418
#> Sample_14428                                      0.08998037
#> Sample_11817                                      0.11798262
#> Sample_14958                                      0.01945180
#>              Epidish_CBSX.NSCLC.PBMCs.scRNAseq_NKT.cells
#> Sample_12929                                  0.00000000
#> Sample_15467                                  0.04058525
#> Sample_13634                                  0.00000000
#> Sample_14428                                  0.00000000
#> Sample_11817                                  0.01680795
#> Sample_14958                                  0.00000000
#>              CBSX_CBSX.NSCLC.PBMCs.scRNAseq_NKT.cells
#> Sample_12929                              0.009337272
#> Sample_15467                              0.038731320
#> Sample_13634                              0.000000000
#> Sample_14428                              0.000000000
#> Sample_11817                              0.022068615
#> Sample_14958                              0.000000000
#>              DWLS_CBSX.NSCLC.PBMCs.scRNAseq_NKT.cells
#> Sample_12929                               0.00000000
#> Sample_15467                               0.06483126
#> Sample_13634                               0.00000000
#> Sample_14428                               0.00000000
#> Sample_11817                               0.02291887
#> Sample_14958                               0.00000000
#>              DeconRNASeq_BPRNACan_CD4.cells Epidish_BPRNACan_CD4.cells
#> Sample_12929                     0.15863181                 0.12238861
#> Sample_15467                     0.13793463                 0.10766298
#> Sample_13634                     0.15920195                 0.13899389
#> Sample_14428                     0.12190356                 0.09276576
#> Sample_11817                     0.06582137                 0.09649535
#> Sample_14958                     0.16051145                 0.08582969
#>              CBSX_BPRNACan_CD4.cells DWLS_BPRNACan_CD4.cells
#> Sample_12929              0.12958940              0.13567786
#> Sample_15467              0.13283167              0.13504475
#> Sample_13634              0.15046359              0.15045376
#> Sample_14428              0.09181963              0.11593519
#> Sample_11817              0.09555046              0.10225293
#> Sample_14958              0.07872194              0.08146516
#>              DeconRNASeq_BPRNACan3DProMet_CD4.cells
#> Sample_12929                             0.15581556
#> Sample_15467                             0.11722338
#> Sample_13634                             0.14530402
#> Sample_14428                             0.10060739
#> Sample_11817                             0.02056953
#> Sample_14958                             0.16355363
#>              Epidish_BPRNACan3DProMet_CD4.cells CBSX_BPRNACan3DProMet_CD4.cells
#> Sample_12929                         0.08516732                      0.07196211
#> Sample_15467                         0.09418202                      0.09552231
#> Sample_13634                         0.10028717                      0.11708169
#> Sample_14428                         0.07944658                      0.06764321
#> Sample_11817                         0.04218774                      0.00000000
#> Sample_14958                         0.06185907                      0.07805973
#>              DWLS_BPRNACan3DProMet_CD4.cells
#> Sample_12929                      0.11690968
#> Sample_15467                      0.11260793
#> Sample_13634                      0.10306438
#> Sample_14428                      0.08174810
#> Sample_11817                      0.02959747
#> Sample_14958                      0.08546863
#>              DeconRNASeq_BPRNACanProMet_CD4.cells
#> Sample_12929                           0.14287361
#> Sample_15467                           0.11033502
#> Sample_13634                           0.13854953
#> Sample_14428                           0.09549062
#> Sample_11817                           0.02842738
#> Sample_14958                           0.15071344
#>              Epidish_BPRNACanProMet_CD4.cells CBSX_BPRNACanProMet_CD4.cells
#> Sample_12929                       0.08330961                    0.09737615
#> Sample_15467                       0.10463988                    0.09596772
#> Sample_13634                       0.11376907                    0.12055053
#> Sample_14428                       0.08479802                    0.06235883
#> Sample_11817                       0.07853487                    0.02568744
#> Sample_14958                       0.07917743                    0.07277743
#>              DWLS_BPRNACanProMet_CD4.cells
#> Sample_12929                    0.11025558
#> Sample_15467                    0.12546913
#> Sample_13634                    0.09137578
#> Sample_14428                    0.08147625
#> Sample_11817                    0.07018862
#> Sample_14958                    0.10862935
#>              DeconRNASeq_BSeqSC.Vanderbilt.scRNAseq_CD4.cells
#> Sample_12929                                       0.05088918
#> Sample_15467                                       0.00000000
#> Sample_13634                                       0.02873937
#> Sample_14428                                       0.00000000
#> Sample_11817                                       0.00000000
#> Sample_14958                                       0.10599990
#>              Epidish_BSeqSC.Vanderbilt.scRNAseq_CD4.cells
#> Sample_12929                                    0.2101392
#> Sample_15467                                    0.3471547
#> Sample_13634                                    0.1883132
#> Sample_14428                                    0.1512663
#> Sample_11817                                    0.0000000
#> Sample_14958                                    0.2975461
#>              CBSX_BSeqSC.Vanderbilt.scRNAseq_CD4.cells
#> Sample_12929                                 0.1660348
#> Sample_15467                                 0.2389321
#> Sample_13634                                 0.1521329
#> Sample_14428                                 0.1057530
#> Sample_11817                                 0.0000000
#> Sample_14958                                 0.3109361
#>              DWLS_BSeqSC.Vanderbilt.scRNAseq_CD4.cells
#> Sample_12929                                 0.2274316
#> Sample_15467                                 0.3136259
#> Sample_13634                                 0.2082788
#> Sample_14428                                 0.1511036
#> Sample_11817                                 0.0000000
#> Sample_14958                                 0.3059956
#>              DeconRNASeq_CBSX.HNSCC.scRNAseq_CD4.cells
#> Sample_12929                                 0.5775410
#> Sample_15467                                 0.5920380
#> Sample_13634                                 0.5651255
#> Sample_14428                                 0.5319073
#> Sample_11817                                 0.5048403
#> Sample_14958                                 0.5014874
#>              Epidish_CBSX.HNSCC.scRNAseq_CD4.cells
#> Sample_12929                             0.6221499
#> Sample_15467                             0.6207258
#> Sample_13634                             0.6030765
#> Sample_14428                             0.5509125
#> Sample_11817                             0.6109726
#> Sample_14958                             0.5206283
#>              CBSX_CBSX.HNSCC.scRNAseq_CD4.cells
#> Sample_12929                          0.6694464
#> Sample_15467                          0.6263290
#> Sample_13634                          0.6001824
#> Sample_14428                          0.5608210
#> Sample_11817                          0.5937063
#> Sample_14958                          0.5819903
#>              DWLS_CBSX.HNSCC.scRNAseq_CD4.cells
#> Sample_12929                          0.5461802
#> Sample_15467                          0.5693315
#> Sample_13634                          0.5208585
#> Sample_14428                          0.4697400
#> Sample_11817                          0.5231035
#> Sample_14958                          0.4394429
#>              DeconRNASeq_CBSX.Melanoma.scRNAseq_CD4.cells
#> Sample_12929                                    0.5886365
#> Sample_15467                                    0.5895642
#> Sample_13634                                    0.5879559
#> Sample_14428                                    0.5281388
#> Sample_11817                                    0.6115777
#> Sample_14958                                    0.4833320
#>              Epidish_CBSX.Melanoma.scRNAseq_CD4.cells
#> Sample_12929                                0.7507289
#> Sample_15467                                0.7116527
#> Sample_13634                                0.6655216
#> Sample_14428                                0.6454969
#> Sample_11817                                0.6199395
#> Sample_14958                                0.6483968
#>              CBSX_CBSX.Melanoma.scRNAseq_CD4.cells
#> Sample_12929                             0.7619751
#> Sample_15467                             0.7543594
#> Sample_13634                             0.6276050
#> Sample_14428                             0.6649174
#> Sample_11817                             0.6028499
#> Sample_14958                             0.6418291
#>              DWLS_CBSX.Melanoma.scRNAseq_CD4.cells
#> Sample_12929                             0.5486114
#> Sample_15467                             0.5428704
#> Sample_13634                             0.5379074
#> Sample_14428                             0.4733685
#> Sample_11817                             0.4942136
#> Sample_14958                             0.4465808
#>              DeconRNASeq_CBSX.NSCLC.PBMCs.scRNAseq_CD4.cells
#> Sample_12929                                       0.2593089
#> Sample_15467                                       0.1971932
#> Sample_13634                                       0.2162361
#> Sample_14428                                       0.2043923
#> Sample_11817                                       0.1546205
#> Sample_14958                                       0.3276876
#>              Epidish_CBSX.NSCLC.PBMCs.scRNAseq_CD4.cells
#> Sample_12929                                   0.5938572
#> Sample_15467                                   0.5650069
#> Sample_13634                                   0.5116238
#> Sample_14428                                   0.5133723
#> Sample_11817                                   0.4489221
#> Sample_14958                                   0.6371673
#>              CBSX_CBSX.NSCLC.PBMCs.scRNAseq_CD4.cells
#> Sample_12929                                0.5358960
#> Sample_15467                                0.5040028
#> Sample_13634                                0.4976118
#> Sample_14428                                0.4894948
#> Sample_11817                                0.4256082
#> Sample_14958                                0.5582348
#>              DWLS_CBSX.NSCLC.PBMCs.scRNAseq_CD4.cells
#> Sample_12929                                0.3530620
#> Sample_15467                                0.3234232
#> Sample_13634                                0.2965076
#> Sample_14428                                0.2955267
#> Sample_11817                                0.2483747
#> Sample_14958                                0.3902552
#>              DeconRNASeq_CBSX.Vanderbilt.scRNAseq_CD4.cells
#> Sample_12929                                     0.32574187
#> Sample_15467                                     0.32820801
#> Sample_13634                                     0.32895393
#> Sample_14428                                     0.27903302
#> Sample_11817                                     0.05641508
#> Sample_14958                                     0.38669255
#>              Epidish_CBSX.Vanderbilt.scRNAseq_CD4.cells
#> Sample_12929                                 0.28838680
#> Sample_15467                                 0.39546785
#> Sample_13634                                 0.38822307
#> Sample_14428                                 0.32744817
#> Sample_11817                                 0.02878472
#> Sample_14958                                 0.42969794
#>              CBSX_CBSX.Vanderbilt.scRNAseq_CD4.cells
#> Sample_12929                               0.3310088
#> Sample_15467                               0.4161420
#> Sample_13634                               0.4108618
#> Sample_14428                               0.3407634
#> Sample_11817                               0.0358517
#> Sample_14958                               0.4243748
#>              DWLS_CBSX.Vanderbilt.scRNAseq_CD4.cells
#> Sample_12929                              0.20056809
#> Sample_15467                              0.24925391
#> Sample_13634                              0.29002403
#> Sample_14428                              0.21853126
#> Sample_11817                              0.01837871
#> Sample_14958                              0.27767830
#>              DeconRNASeq_CCLE.TIL10_CD4.cells Epidish_CCLE.TIL10_CD4.cells
#> Sample_12929                        0.1893579                 1.427132e-01
#> Sample_15467                        0.2463809                 1.392344e-01
#> Sample_13634                        0.1508483                 0.000000e+00
#> Sample_14428                        0.1121602                 0.000000e+00
#> Sample_11817                        0.0000000                 5.490039e-05
#> Sample_14958                        0.1017836                 9.343412e-02
#>              CBSX_CCLE.TIL10_CD4.cells DWLS_CCLE.TIL10_CD4.cells
#> Sample_12929                0.21844609                0.05564232
#> Sample_15467                0.13659093                0.06613753
#> Sample_13634                0.00000000                0.00000000
#> Sample_14428                0.00000000                0.00000000
#> Sample_11817                0.00000000                0.00000000
#> Sample_14958                0.03242821                0.04459947
#>              DeconRNASeq_DWLS.Vanderbilt.scRNAseq_CD4.cells
#> Sample_12929                                      0.4681462
#> Sample_15467                                      0.4324449
#> Sample_13634                                      0.4279173
#> Sample_14428                                      0.3217350
#> Sample_11817                                      0.0000000
#> Sample_14958                                      0.4507147
#>              Epidish_DWLS.Vanderbilt.scRNAseq_CD4.cells
#> Sample_12929                                  0.3240451
#> Sample_15467                                  0.3485706
#> Sample_13634                                  0.2851640
#> Sample_14428                                  0.2482018
#> Sample_11817                                  0.0000000
#> Sample_14958                                  0.3355539
#>              CBSX_DWLS.Vanderbilt.scRNAseq_CD4.cells
#> Sample_12929                               0.3079498
#> Sample_15467                               0.3489402
#> Sample_13634                               0.2849719
#> Sample_14428                               0.2635243
#> Sample_11817                               0.0000000
#> Sample_14958                               0.3647996
#>              DWLS_DWLS.Vanderbilt.scRNAseq_CD4.cells
#> Sample_12929                               0.2410025
#> Sample_15467                               0.2662216
#> Sample_13634                               0.2193668
#> Sample_14428                               0.1574162
#> Sample_11817                               0.0000000
#> Sample_14958                               0.2100867
#>              DeconRNASeq_MOMF.Vanderbilt.scRNAseq_CD4.cells
#> Sample_12929                                      0.3867391
#> Sample_15467                                      0.3762091
#> Sample_13634                                      0.4324978
#> Sample_14428                                      0.3775418
#> Sample_11817                                      0.0000000
#> Sample_14958                                      0.4224603
#>              Epidish_MOMF.Vanderbilt.scRNAseq_CD4.cells
#> Sample_12929                                0.014181321
#> Sample_15467                                0.019833145
#> Sample_13634                                0.053162531
#> Sample_14428                                0.007584618
#> Sample_11817                                0.000000000
#> Sample_14958                                0.008594416
#>              CBSX_MOMF.Vanderbilt.scRNAseq_CD4.cells
#> Sample_12929                              0.02231773
#> Sample_15467                              0.03993408
#> Sample_13634                              0.06258581
#> Sample_14428                              0.02335628
#> Sample_11817                              0.00000000
#> Sample_14958                              0.01416038
#>              DWLS_MOMF.Vanderbilt.scRNAseq_CD4.cells
#> Sample_12929                               0.3471554
#> Sample_15467                               0.4093145
#> Sample_13634                               0.3894274
#> Sample_14428                               0.3283160
#> Sample_11817                               0.0000000
#> Sample_14958                               0.3959862
#>              DeconRNASeq_TIL10_CD4.cells Epidish_TIL10_CD4.cells
#> Sample_12929                   0.2440898              0.21255646
#> Sample_15467                   0.3122417              0.27355915
#> Sample_13634                   0.2234088              0.02951750
#> Sample_14428                   0.1520318              0.00000000
#> Sample_11817                   0.0000000              0.06276711
#> Sample_14958                   0.1558666              0.10114539
#>              CBSX_TIL10_CD4.cells DWLS_TIL10_CD4.cells
#> Sample_12929            0.2295411           0.09213640
#> Sample_15467            0.2494138           0.09793053
#> Sample_13634            0.1512404           0.01783489
#> Sample_14428            0.1462109           0.00000000
#> Sample_11817            0.0000000           0.02365054
#> Sample_14958            0.1729309           0.03507391
#>              AutogeneS_Vanderbilt_CD4.cells BayesPrism_Vanderbilt_CD4.cells
#> Sample_12929                     0.08970091                     0.368512251
#> Sample_15467                     0.09821988                     0.384787342
#> Sample_13634                     0.10742635                     0.329446786
#> Sample_14428                     0.08467460                     0.226809865
#> Sample_11817                     0.10379974                     0.000397109
#> Sample_14958                     0.07777107                     0.347716582
#>              Bisque_Vanderbilt_CD4.cells CPM_Vanderbilt_CD4.cells
#> Sample_12929                   0.5175299               0.08754799
#> Sample_15467                   0.5635828               0.08861703
#> Sample_13634                   0.6103292               0.08938049
#> Sample_14428                   0.4966607               0.08717531
#> Sample_11817                   0.2688973               0.08536505
#> Sample_14958                   0.6536444               0.08628916
#>              MuSic_Vanderbilt_CD4.cells SCDC_Vanderbilt_CD4.cells
#> Sample_12929                  0.4296562                0.34611238
#> Sample_15467                  0.4231427                0.33303111
#> Sample_13634                  0.4589538                0.39709152
#> Sample_14428                  0.3933049                0.26998194
#> Sample_11817                  0.1075816                0.04458997
#> Sample_14958                  0.4857596                0.25324933
#>              DeconRNASeq_LM22_CD4.memory.activated
#> Sample_12929                            0.13565022
#> Sample_15467                            0.05816309
#> Sample_13634                            0.12686462
#> Sample_14428                            0.09648477
#> Sample_11817                            0.19248694
#> Sample_14958                            0.05684073
#>              Epidish_LM22_CD4.memory.activated CBSX_LM22_CD4.memory.activated
#> Sample_12929                        0.09495321                     0.10802903
#> Sample_15467                        0.03851698                     0.02395732
#> Sample_13634                        0.09903682                     0.09706731
#> Sample_14428                        0.07441828                     0.07516599
#> Sample_11817                        0.14299748                     0.14668631
#> Sample_14958                        0.08235136                     0.11959433
#>              DWLS_LM22_CD4.memory.activated DeconRNASeq_LM22_CD4.memory.resting
#> Sample_12929                     0.07015048                           0.3243447
#> Sample_15467                     0.02360880                           0.1696887
#> Sample_13634                     0.06902282                           0.1269924
#> Sample_14428                     0.05338027                           0.1375210
#> Sample_11817                     0.10495770                           0.0000000
#> Sample_14958                     0.09661162                           0.4267025
#>              Epidish_LM22_CD4.memory.resting CBSX_LM22_CD4.memory.resting
#> Sample_12929                       0.4443363                    0.4465069
#> Sample_15467                       0.4179596                    0.4294216
#> Sample_13634                       0.3282945                    0.3208500
#> Sample_14428                       0.3882154                    0.3940055
#> Sample_11817                       0.2693087                    0.2393298
#> Sample_14958                       0.5744762                    0.5557450
#>              DWLS_LM22_CD4.memory.resting DeconRNASeq_LM22_CD4.naive
#> Sample_12929                    0.4088353                          0
#> Sample_15467                    0.3586611                          0
#> Sample_13634                    0.2841106                          0
#> Sample_14428                    0.3461828                          0
#> Sample_11817                    0.2187039                          0
#> Sample_14958                    0.5333170                          0
#>              Epidish_LM22_CD4.naive CBSX_LM22_CD4.naive DWLS_LM22_CD4.naive
#> Sample_12929                      0                   0                   0
#> Sample_15467                      0                   0                   0
#> Sample_13634                      0                   0                   0
#> Sample_14428                      0                   0                   0
#> Sample_11817                      0                   0                   0
#> Sample_14958                      0                   0                   0
#>              Quantiseq_T.cells.non.regulatory Quantiseq_CD8.cells
#> Sample_12929                        0.0000000          0.08984339
#> Sample_15467                        0.3843607          0.14412745
#> Sample_13634                        0.0000000          0.30918408
#> Sample_14428                        0.0000000          0.30545815
#> Sample_11817                        0.0000000          0.37370976
#> Sample_14958                        0.2424611          0.12109299
#>              DeconRNASeq_BPRNACan_CD8.cells Epidish_BPRNACan_CD8.cells
#> Sample_12929                      0.2509110                  0.1689579
#> Sample_15467                      0.2912114                  0.2223026
#> Sample_13634                      0.3494285                  0.3739526
#> Sample_14428                      0.2666797                  0.1895448
#> Sample_11817                      0.4478384                  0.4345611
#> Sample_14958                      0.1826643                  0.1421458
#>              CBSX_BPRNACan_CD8.cells DWLS_BPRNACan_CD8.cells
#> Sample_12929               0.2429020               0.3272829
#> Sample_15467               0.2593832               0.3983280
#> Sample_13634               0.4387360               0.5496921
#> Sample_14428               0.2389596               0.3385064
#> Sample_11817               0.5337196               0.6227608
#> Sample_14958               0.1766867               0.3078326
#>              DeconRNASeq_BPRNACan3DProMet_CD8.cells
#> Sample_12929                              0.2666025
#> Sample_15467                              0.3123753
#> Sample_13634                              0.3735030
#> Sample_14428                              0.3006554
#> Sample_11817                              0.4880318
#> Sample_14958                              0.2022715
#>              Epidish_BPRNACan3DProMet_CD8.cells CBSX_BPRNACan3DProMet_CD8.cells
#> Sample_12929                          0.1744488                       0.2567939
#> Sample_15467                          0.2006562                       0.2684021
#> Sample_13634                          0.3885828                       0.4454342
#> Sample_14428                          0.1907309                       0.2320969
#> Sample_11817                          0.4243010                       0.5910427
#> Sample_14958                          0.1350170                       0.1608569
#>              DWLS_BPRNACan3DProMet_CD8.cells
#> Sample_12929                       0.4088277
#> Sample_15467                       0.3909771
#> Sample_13634                       0.6242681
#> Sample_14428                       0.4251363
#> Sample_11817                       0.7060201
#> Sample_14958                       0.3288050
#>              DeconRNASeq_BPRNACanProMet_CD8.cells
#> Sample_12929                            0.2235325
#> Sample_15467                            0.2735836
#> Sample_13634                            0.3360028
#> Sample_14428                            0.2631619
#> Sample_11817                            0.4436565
#> Sample_14958                            0.1632669
#>              Epidish_BPRNACanProMet_CD8.cells CBSX_BPRNACanProMet_CD8.cells
#> Sample_12929                        0.1579853                     0.2304475
#> Sample_15467                        0.1919020                     0.2316620
#> Sample_13634                        0.3424093                     0.3750343
#> Sample_14428                        0.1741597                     0.2200415
#> Sample_11817                        0.3377192                     0.4250334
#> Sample_14958                        0.1156284                     0.1484465
#>              DWLS_BPRNACanProMet_CD8.cells
#> Sample_12929                     0.3485983
#> Sample_15467                     0.3612240
#> Sample_13634                     0.5787590
#> Sample_14428                     0.3819545
#> Sample_11817                     0.5891298
#> Sample_14958                     0.2896396
#>              DeconRNASeq_BSeqSC.Vanderbilt.scRNAseq_CD8.cells
#> Sample_12929                                      0.032511066
#> Sample_15467                                      0.000000000
#> Sample_13634                                      0.138766570
#> Sample_14428                                      0.189435720
#> Sample_11817                                      0.000000000
#> Sample_14958                                      0.003661678
#>              Epidish_BSeqSC.Vanderbilt.scRNAseq_CD8.cells
#> Sample_12929                                    0.1269371
#> Sample_15467                                    0.0000000
#> Sample_13634                                    0.2313298
#> Sample_14428                                    0.2949857
#> Sample_11817                                    0.0000000
#> Sample_14958                                    0.0000000
#>              CBSX_BSeqSC.Vanderbilt.scRNAseq_CD8.cells
#> Sample_12929                                0.04795413
#> Sample_15467                                0.00000000
#> Sample_13634                                0.10627565
#> Sample_14428                                0.29264075
#> Sample_11817                                0.04838669
#> Sample_14958                                0.00000000
#>              DWLS_BSeqSC.Vanderbilt.scRNAseq_CD8.cells
#> Sample_12929                                0.12398835
#> Sample_15467                                0.03422853
#> Sample_13634                                0.22947192
#> Sample_14428                                0.29881889
#> Sample_11817                                0.02852463
#> Sample_14958                                0.00000000
#>              DeconRNASeq_CBSX.HNSCC.scRNAseq_CD8.cells
#> Sample_12929                                0.00000000
#> Sample_15467                                0.00000000
#> Sample_13634                                0.11920921
#> Sample_14428                                0.05538701
#> Sample_11817                                0.17356186
#> Sample_14958                                0.00000000
#>              Epidish_CBSX.HNSCC.scRNAseq_CD8.cells
#> Sample_12929                            0.08020634
#> Sample_15467                            0.09751501
#> Sample_13634                            0.25656933
#> Sample_14428                            0.12146004
#> Sample_11817                            0.25180710
#> Sample_14958                            0.05258985
#>              CBSX_CBSX.HNSCC.scRNAseq_CD8.cells
#> Sample_12929                         0.05715210
#> Sample_15467                         0.10582748
#> Sample_13634                         0.26913630
#> Sample_14428                         0.14067830
#> Sample_11817                         0.26433571
#> Sample_14958                         0.02996103
#>              DWLS_CBSX.HNSCC.scRNAseq_CD8.cells
#> Sample_12929                         0.09483753
#> Sample_15467                         0.11704282
#> Sample_13634                         0.32063041
#> Sample_14428                         0.14952516
#> Sample_11817                         0.30848369
#> Sample_14958                         0.06717554
#>              DeconRNASeq_CBSX.Melanoma.scRNAseq_CD8.cells
#> Sample_12929                                   0.00000000
#> Sample_15467                                   0.00000000
#> Sample_13634                                   0.04722047
#> Sample_14428                                   0.02401377
#> Sample_11817                                   0.14082524
#> Sample_14958                                   0.00000000
#>              Epidish_CBSX.Melanoma.scRNAseq_CD8.cells
#> Sample_12929                              0.004389785
#> Sample_15467                              0.033501642
#> Sample_13634                              0.177643768
#> Sample_14428                              0.090170518
#> Sample_11817                              0.271584652
#> Sample_14958                              0.000000000
#>              CBSX_CBSX.Melanoma.scRNAseq_CD8.cells
#> Sample_12929                           0.024057410
#> Sample_15467                           0.003082462
#> Sample_13634                           0.228712122
#> Sample_14428                           0.079396586
#> Sample_11817                           0.291774680
#> Sample_14958                           0.000000000
#>              DWLS_CBSX.Melanoma.scRNAseq_CD8.cells
#> Sample_12929                            0.01104012
#> Sample_15467                            0.04535838
#> Sample_13634                            0.20067551
#> Sample_14428                            0.10692995
#> Sample_11817                            0.31671371
#> Sample_14958                            0.00000000
#>              DeconRNASeq_CBSX.NSCLC.PBMCs.scRNAseq_CD8.cells
#> Sample_12929                                       0.2236606
#> Sample_15467                                       0.2435707
#> Sample_13634                                       0.2793718
#> Sample_14428                                       0.3101559
#> Sample_11817                                       0.3883292
#> Sample_14958                                       0.2137286
#>              Epidish_CBSX.NSCLC.PBMCs.scRNAseq_CD8.cells
#> Sample_12929                                   0.2184401
#> Sample_15467                                   0.1973895
#> Sample_13634                                   0.2943499
#> Sample_14428                                   0.2921000
#> Sample_11817                                   0.3834858
#> Sample_14958                                   0.1912348
#>              CBSX_CBSX.NSCLC.PBMCs.scRNAseq_CD8.cells
#> Sample_12929                                0.2279245
#> Sample_15467                                0.2191982
#> Sample_13634                                0.3044441
#> Sample_14428                                0.3158888
#> Sample_11817                                0.3973932
#> Sample_14958                                0.2242717
#>              DWLS_CBSX.NSCLC.PBMCs.scRNAseq_CD8.cells
#> Sample_12929                                0.3085932
#> Sample_15467                                0.2834784
#> Sample_13634                                0.3786092
#> Sample_14428                                0.3952723
#> Sample_11817                                0.5007998
#> Sample_14958                                0.2732853
#>              DeconRNASeq_CBSX.Vanderbilt.scRNAseq_CD8.cells
#> Sample_12929                                     0.06412879
#> Sample_15467                                     0.06040696
#> Sample_13634                                     0.12088550
#> Sample_14428                                     0.19283938
#> Sample_11817                                     0.11896729
#> Sample_14958                                     0.03068575
#>              Epidish_CBSX.Vanderbilt.scRNAseq_CD8.cells
#> Sample_12929                                 0.09979537
#> Sample_15467                                 0.12423915
#> Sample_13634                                 0.19961590
#> Sample_14428                                 0.18218457
#> Sample_11817                                 0.22618338
#> Sample_14958                                 0.02299550
#>              CBSX_CBSX.Vanderbilt.scRNAseq_CD8.cells
#> Sample_12929                              0.10376852
#> Sample_15467                              0.11144553
#> Sample_13634                              0.23754365
#> Sample_14428                              0.19876145
#> Sample_11817                              0.28156727
#> Sample_14958                              0.02788759
#>              DWLS_CBSX.Vanderbilt.scRNAseq_CD8.cells
#> Sample_12929                              0.09865535
#> Sample_15467                              0.11461345
#> Sample_13634                              0.21576775
#> Sample_14428                              0.17590335
#> Sample_11817                              0.23767561
#> Sample_14958                              0.01793475
#>              DeconRNASeq_CCLE.TIL10_CD8.cells Epidish_CCLE.TIL10_CD8.cells
#> Sample_12929                       0.06372088                    0.1375175
#> Sample_15467                       0.11247625                    0.1876341
#> Sample_13634                       0.21115887                    0.4171522
#> Sample_14428                       0.22277781                    0.3291305
#> Sample_11817                       0.31240706                    0.4003912
#> Sample_14958                       0.06390726                    0.1456259
#>              CBSX_CCLE.TIL10_CD8.cells DWLS_CCLE.TIL10_CD8.cells
#> Sample_12929                 0.1328382                 0.1387539
#> Sample_15467                 0.1921243                 0.1976624
#> Sample_13634                 0.4483334                 0.4370010
#> Sample_14428                 0.3608665                 0.3150623
#> Sample_11817                 0.3890739                 0.3984087
#> Sample_14958                 0.1988346                 0.1485482
#>              DeconRNASeq_DWLS.Vanderbilt.scRNAseq_CD8.cells
#> Sample_12929                                     0.06501618
#> Sample_15467                                     0.16404015
#> Sample_13634                                     0.38441698
#> Sample_14428                                     0.31214168
#> Sample_11817                                     0.40004691
#> Sample_14958                                     0.00000000
#>              Epidish_DWLS.Vanderbilt.scRNAseq_CD8.cells
#> Sample_12929                                 0.12235236
#> Sample_15467                                 0.10427061
#> Sample_13634                                 0.32853463
#> Sample_14428                                 0.26914069
#> Sample_11817                                 0.36009684
#> Sample_14958                                 0.07711878
#>              CBSX_DWLS.Vanderbilt.scRNAseq_CD8.cells
#> Sample_12929                              0.13266721
#> Sample_15467                              0.10307839
#> Sample_13634                              0.33371818
#> Sample_14428                              0.26290805
#> Sample_11817                              0.37493234
#> Sample_14958                              0.07556233
#>              DWLS_DWLS.Vanderbilt.scRNAseq_CD8.cells DeconRNASeq_LM22_CD8.cells
#> Sample_12929                              0.12416704                  0.2255494
#> Sample_15467                              0.10478289                  0.4256304
#> Sample_13634                              0.35126908                  0.4789189
#> Sample_14428                              0.23268213                  0.4524012
#> Sample_11817                              0.35414862                  0.4112670
#> Sample_14958                              0.07608557                  0.2077019
#>              Epidish_LM22_CD8.cells CBSX_LM22_CD8.cells DWLS_LM22_CD8.cells
#> Sample_12929              0.2389235           0.2353351           0.2497018
#> Sample_15467              0.3123995           0.3067022           0.3059270
#> Sample_13634              0.3675244           0.3822662           0.3743099
#> Sample_14428              0.2831413           0.2893933           0.2823510
#> Sample_11817              0.3162199           0.3466905           0.3323797
#> Sample_14958              0.1375796           0.1416164           0.1470463
#>              DeconRNASeq_MOMF.Vanderbilt.scRNAseq_CD8.cells
#> Sample_12929                                      0.0000000
#> Sample_15467                                      0.0000000
#> Sample_13634                                      0.0000000
#> Sample_14428                                      0.0251526
#> Sample_11817                                      0.0000000
#> Sample_14958                                      0.0000000
#>              Epidish_MOMF.Vanderbilt.scRNAseq_CD8.cells
#> Sample_12929                                0.006893623
#> Sample_15467                                0.005943847
#> Sample_13634                                0.035817842
#> Sample_14428                                0.005507161
#> Sample_11817                                0.003861807
#> Sample_14958                                0.001383623
#>              CBSX_MOMF.Vanderbilt.scRNAseq_CD8.cells
#> Sample_12929                             0.010860478
#> Sample_15467                             0.012123848
#> Sample_13634                             0.042102594
#> Sample_14428                             0.016129407
#> Sample_11817                             0.006906584
#> Sample_14958                             0.001838131
#>              DWLS_MOMF.Vanderbilt.scRNAseq_CD8.cells
#> Sample_12929                              0.12261709
#> Sample_15467                              0.09021772
#> Sample_13634                              0.19248301
#> Sample_14428                              0.19191908
#> Sample_11817                              0.14102376
#> Sample_14958                              0.05031589
#>              DeconRNASeq_TIL10_CD8.cells Epidish_TIL10_CD8.cells
#> Sample_12929                  0.06807457               0.1537428
#> Sample_15467                  0.12648481               0.1989455
#> Sample_13634                  0.22655778               0.4737753
#> Sample_14428                  0.23653594               0.4062627
#> Sample_11817                  0.35020540               0.4851040
#> Sample_14958                  0.08581882               0.2085298
#>              CBSX_TIL10_CD8.cells DWLS_TIL10_CD8.cells
#> Sample_12929            0.1540490            0.1770636
#> Sample_15467            0.2050842            0.2293398
#> Sample_13634            0.4283029            0.5173296
#> Sample_14428            0.3713066            0.4276973
#> Sample_11817            0.5034355            0.5297151
#> Sample_14958            0.2098683            0.2115553
#>              AutogeneS_Vanderbilt_CD8.cells BayesPrism_Vanderbilt_CD8.cells
#> Sample_12929                     0.09937055                      0.14071308
#> Sample_15467                     0.10694471                      0.17444617
#> Sample_13634                     0.12593189                      0.29810772
#> Sample_14428                     0.09975886                      0.28653508
#> Sample_11817                     0.12153405                      0.07479988
#> Sample_14958                     0.08345959                      0.06470504
#>              Bisque_Vanderbilt_CD8.cells CPM_Vanderbilt_CD8.cells
#> Sample_12929                  0.17778879               0.08692162
#> Sample_15467                  0.14462705               0.08710341
#> Sample_13634                  0.24017601               0.08820102
#> Sample_14428                  0.22909151               0.08661732
#> Sample_11817                  0.31733774               0.08633810
#> Sample_14958                  0.05596807               0.08467786
#>              MuSic_Vanderbilt_CD8.cells SCDC_Vanderbilt_CD8.cells
#> Sample_12929                 0.11005057                0.08658789
#> Sample_15467                 0.08360879                0.09024794
#> Sample_13634                 0.20886127                0.20139503
#> Sample_14428                 0.17045511                0.13334842
#> Sample_11817                 0.11213087                0.12202635
#> Sample_14958                 0.04437062                0.02446209
#>              Quantiseq_T.cells.regulatory
#> Sample_12929                    0.5789390
#> Sample_15467                    0.1432490
#> Sample_13634                    0.4125916
#> Sample_14428                    0.3210357
#> Sample_11817                    0.4306358
#> Sample_14958                    0.2737911
#>              DeconRNASeq_CCLE.TIL10_T.cells.regulatory
#> Sample_12929                                0.21286314
#> Sample_15467                                0.04343187
#> Sample_13634                                0.17631845
#> Sample_14428                                0.12996646
#> Sample_11817                                0.32238169
#> Sample_14958                                0.12105951
#>              Epidish_CCLE.TIL10_T.cells.regulatory
#> Sample_12929                             0.2360112
#> Sample_15467                             0.1920821
#> Sample_13634                             0.1984112
#> Sample_14428                             0.1239913
#> Sample_11817                             0.1409075
#> Sample_14958                             0.1988827
#>              CBSX_CCLE.TIL10_T.cells.regulatory
#> Sample_12929                          0.2434852
#> Sample_15467                          0.2036352
#> Sample_13634                          0.1627566
#> Sample_14428                          0.1110229
#> Sample_11817                          0.1579997
#> Sample_14958                          0.2042822
#>              DWLS_CCLE.TIL10_T.cells.regulatory
#> Sample_12929                         0.15766665
#> Sample_15467                         0.13544257
#> Sample_13634                         0.16209873
#> Sample_14428                         0.07495728
#> Sample_11817                         0.09444267
#> Sample_14958                         0.15258180
#>              DeconRNASeq_LM22_T.cells.regulatory
#> Sample_12929                                   0
#> Sample_15467                                   0
#> Sample_13634                                   0
#> Sample_14428                                   0
#> Sample_11817                                   0
#> Sample_14958                                   0
#>              Epidish_LM22_T.cells.regulatory CBSX_LM22_T.cells.regulatory
#> Sample_12929                      0.02394958                   0.01568465
#> Sample_15467                      0.00000000                   0.00000000
#> Sample_13634                      0.00000000                   0.00000000
#> Sample_14428                      0.00000000                   0.00000000
#> Sample_11817                      0.01321094                   0.01752975
#> Sample_14958                      0.00000000                   0.00000000
#>              DWLS_LM22_T.cells.regulatory DeconRNASeq_TIL10_T.cells.regulatory
#> Sample_12929                   0.01873639                           0.18288530
#> Sample_15467                   0.00000000                           0.00000000
#> Sample_13634                   0.00000000                           0.13005992
#> Sample_14428                   0.00000000                           0.09932707
#> Sample_11817                   0.01709326                           0.32797507
#> Sample_14958                   0.00000000                           0.10615630
#>              Epidish_TIL10_T.cells.regulatory CBSX_TIL10_T.cells.regulatory
#> Sample_12929                        0.2619935                     0.2761295
#> Sample_15467                        0.1317711                     0.1640561
#> Sample_13634                        0.1670335                     0.1178741
#> Sample_14428                        0.1124922                     0.0747640
#> Sample_11817                        0.1234425                     0.1378757
#> Sample_14958                        0.2099720                     0.1493627
#>              DWLS_TIL10_T.cells.regulatory
#> Sample_12929                    0.22700697
#> Sample_15467                    0.13160828
#> Sample_13634                    0.12517469
#> Sample_14428                    0.07961486
#> Sample_11817                    0.07319723
#> Sample_14958                    0.13857893
#>              DeconRNASeq_BSeqSC.Vanderbilt.scRNAseq_T.cells.helper
#> Sample_12929                                            0.09467411
#> Sample_15467                                            0.09204363
#> Sample_13634                                            0.14885865
#> Sample_14428                                            0.04903830
#> Sample_11817                                            0.21104551
#> Sample_14958                                            0.05648004
#>              Epidish_BSeqSC.Vanderbilt.scRNAseq_T.cells.helper
#> Sample_12929                                        0.00000000
#> Sample_15467                                        0.00000000
#> Sample_13634                                        0.06845635
#> Sample_14428                                        0.00000000
#> Sample_11817                                        0.23229460
#> Sample_14958                                        0.00000000
#>              CBSX_BSeqSC.Vanderbilt.scRNAseq_T.cells.helper
#> Sample_12929                                     0.00665805
#> Sample_15467                                     0.00000000
#> Sample_13634                                     0.05504977
#> Sample_14428                                     0.01592651
#> Sample_11817                                     0.25899494
#> Sample_14958                                     0.00000000
#>              DWLS_BSeqSC.Vanderbilt.scRNAseq_T.cells.helper
#> Sample_12929                                     0.00000000
#> Sample_15467                                     0.00000000
#> Sample_13634                                     0.06217389
#> Sample_14428                                     0.00000000
#> Sample_11817                                     0.22749585
#> Sample_14958                                     0.00000000
#>              DeconRNASeq_CBSX.Vanderbilt.scRNAseq_T.cells.helper
#> Sample_12929                                         0.009257011
#> Sample_15467                                         0.000000000
#> Sample_13634                                         0.050064070
#> Sample_14428                                         0.000000000
#> Sample_11817                                         0.153881411
#> Sample_14958                                         0.000000000
#>              Epidish_CBSX.Vanderbilt.scRNAseq_T.cells.helper
#> Sample_12929                                    0.0009724527
#> Sample_15467                                    0.0000000000
#> Sample_13634                                    0.0567231469
#> Sample_14428                                    0.0000000000
#> Sample_11817                                    0.1212766444
#> Sample_14958                                    0.0000000000
#>              CBSX_CBSX.Vanderbilt.scRNAseq_T.cells.helper
#> Sample_12929                                  0.001183829
#> Sample_15467                                  0.000000000
#> Sample_13634                                  0.039960141
#> Sample_14428                                  0.000000000
#> Sample_11817                                  0.130449831
#> Sample_14958                                  0.000000000
#>              DWLS_CBSX.Vanderbilt.scRNAseq_T.cells.helper
#> Sample_12929                                 3.083027e-05
#> Sample_15467                                 0.000000e+00
#> Sample_13634                                 4.503096e-02
#> Sample_14428                                 0.000000e+00
#> Sample_11817                                 1.022167e-01
#> Sample_14958                                 0.000000e+00
#>              DeconRNASeq_DWLS.Vanderbilt.scRNAseq_T.cells.helper
#> Sample_12929                                          0.00000000
#> Sample_15467                                          0.00000000
#> Sample_13634                                          0.03194612
#> Sample_14428                                          0.00000000
#> Sample_11817                                          0.20554569
#> Sample_14958                                          0.00000000
#>              Epidish_DWLS.Vanderbilt.scRNAseq_T.cells.helper
#> Sample_12929                                      0.00000000
#> Sample_15467                                      0.00000000
#> Sample_13634                                      0.07281426
#> Sample_14428                                      0.00000000
#> Sample_11817                                      0.22427532
#> Sample_14958                                      0.00000000
#>              CBSX_DWLS.Vanderbilt.scRNAseq_T.cells.helper
#> Sample_12929                                   0.00000000
#> Sample_15467                                   0.00000000
#> Sample_13634                                   0.06998749
#> Sample_14428                                   0.00000000
#> Sample_11817                                   0.21229599
#> Sample_14958                                   0.00000000
#>              DWLS_DWLS.Vanderbilt.scRNAseq_T.cells.helper
#> Sample_12929                                    0.0000000
#> Sample_15467                                    0.0000000
#> Sample_13634                                    0.0735878
#> Sample_14428                                    0.0000000
#> Sample_11817                                    0.1815146
#> Sample_14958                                    0.0000000
#>              DeconRNASeq_LM22_T.cells.helper Epidish_LM22_T.cells.helper
#> Sample_12929                       0.0000000                 0.000000000
#> Sample_15467                       0.0000000                 0.000000000
#> Sample_13634                       0.0000000                 0.006521269
#> Sample_14428                       0.0000000                 0.000000000
#> Sample_11817                       0.1172227                 0.055970351
#> Sample_14958                       0.0000000                 0.000000000
#>              CBSX_LM22_T.cells.helper DWLS_LM22_T.cells.helper
#> Sample_12929              0.000000000              0.005647572
#> Sample_15467              0.000000000              0.000000000
#> Sample_13634              0.008276072              0.006573443
#> Sample_14428              0.000000000              0.000000000
#> Sample_11817              0.043204729              0.045763125
#> Sample_14958              0.000000000              0.000000000
#>              DeconRNASeq_MOMF.Vanderbilt.scRNAseq_T.cells.helper
#> Sample_12929                                          0.14012561
#> Sample_15467                                          0.08530329
#> Sample_13634                                          0.16493169
#> Sample_14428                                          0.08279009
#> Sample_11817                                          0.43730883
#> Sample_14958                                          0.07156320
#>              Epidish_MOMF.Vanderbilt.scRNAseq_T.cells.helper
#> Sample_12929                                      0.08630974
#> Sample_15467                                      0.06603958
#> Sample_13634                                      0.52143007
#> Sample_14428                                      0.01871619
#> Sample_11817                                      0.17132649
#> Sample_14958                                      0.02113468
#>              CBSX_MOMF.Vanderbilt.scRNAseq_T.cells.helper
#> Sample_12929                                   0.13003294
#> Sample_15467                                   0.10567533
#> Sample_13634                                   0.54642906
#> Sample_14428                                   0.05119148
#> Sample_11817                                   0.27969483
#> Sample_14958                                   0.03676092
#>              DWLS_MOMF.Vanderbilt.scRNAseq_T.cells.helper
#> Sample_12929                                   0.10327507
#> Sample_15467                                   0.06668501
#> Sample_13634                                   0.19174965
#> Sample_14428                                   0.03656997
#> Sample_11817                                   0.39428777
#> Sample_14958                                   0.04354067
#>              AutogeneS_Vanderbilt_T.cells.helper
#> Sample_12929                          0.08440026
#> Sample_15467                          0.08949453
#> Sample_13634                          0.11105251
#> Sample_14428                          0.07816956
#> Sample_11817                          0.11827907
#> Sample_14958                          0.07310088
#>              BayesPrism_Vanderbilt_T.cells.helper
#> Sample_12929                          0.007222181
#> Sample_15467                          0.005040843
#> Sample_13634                          0.149241953
#> Sample_14428                          0.006344468
#> Sample_11817                          0.421813650
#> Sample_14958                          0.004937580
#>              Bisque_Vanderbilt_T.cells.helper CPM_Vanderbilt_T.cells.helper
#> Sample_12929                        0.0000000                    0.08174830
#> Sample_15467                        0.0000000                    0.08147008
#> Sample_13634                        0.0000000                    0.08297649
#> Sample_14428                        0.0000000                    0.08064530
#> Sample_11817                        0.1574478                    0.08405736
#> Sample_14958                        0.0000000                    0.08029408
#>              MuSic_Vanderbilt_T.cells.helper SCDC_Vanderbilt_T.cells.helper
#> Sample_12929                    0.0398684598                     0.10515528
#> Sample_15467                    0.0000000000                     0.00000000
#> Sample_13634                    0.0579526914                     0.09835915
#> Sample_14428                    0.0006106334                     0.00000000
#> Sample_11817                    0.3222539327                     0.38337426
#> Sample_14958                    0.0157513480                     0.03171695
#>              DeconRNASeq_LM22_T.cells.gamma.delta
#> Sample_12929                          0.057978091
#> Sample_15467                          0.000000000
#> Sample_13634                          0.008955659
#> Sample_14428                          0.000000000
#> Sample_11817                          0.095723599
#> Sample_14958                          0.000000000
#>              Epidish_LM22_T.cells.gamma.delta CBSX_LM22_T.cells.gamma.delta
#> Sample_12929                      0.000000000                   0.000000000
#> Sample_15467                      0.000000000                   0.000000000
#> Sample_13634                      0.008556306                   0.006105321
#> Sample_14428                      0.000000000                   0.000000000
#> Sample_11817                      0.001455573                   0.000000000
#> Sample_14958                      0.000000000                   0.000000000
#>              DWLS_LM22_T.cells.gamma.delta Quantiseq_Dendritic.cells
#> Sample_12929                   0.000000000              5.774138e-05
#> Sample_15467                   0.000000000              3.167201e-02
#> Sample_13634                   0.003508198              1.726903e-02
#> Sample_14428                   0.000000000              2.282905e-02
#> Sample_11817                   0.000000000              0.000000e+00
#> Sample_14958                   0.000000000              4.027668e-02
#>              DeconRNASeq_CBSX.HNSCC.scRNAseq_Dendritic.cells
#> Sample_12929                                     0.000000000
#> Sample_15467                                     0.000000000
#> Sample_13634                                     0.000000000
#> Sample_14428                                     0.000000000
#> Sample_11817                                     0.000000000
#> Sample_14958                                     0.006582442
#>              Epidish_CBSX.HNSCC.scRNAseq_Dendritic.cells
#> Sample_12929                                 0.018362972
#> Sample_15467                                 0.008980348
#> Sample_13634                                 0.011258252
#> Sample_14428                                 0.025188335
#> Sample_11817                                 0.011006476
#> Sample_14958                                 0.044083721
#>              CBSX_CBSX.HNSCC.scRNAseq_Dendritic.cells
#> Sample_12929                              0.004298630
#> Sample_15467                              0.004431053
#> Sample_13634                              0.005931916
#> Sample_14428                              0.002311522
#> Sample_11817                              0.020020675
#> Sample_14958                              0.003048366
#>              DWLS_CBSX.HNSCC.scRNAseq_Dendritic.cells
#> Sample_12929                               0.02516588
#> Sample_15467                               0.01777104
#> Sample_13634                               0.01601841
#> Sample_14428                               0.04420983
#> Sample_11817                               0.01610807
#> Sample_14958                               0.06121461
#>              DeconRNASeq_CCLE.TIL10_Dendritic.cells
#> Sample_12929                             0.05391961
#> Sample_15467                             0.05261403
#> Sample_13634                             0.06950979
#> Sample_14428                             0.02346286
#> Sample_11817                             0.03639156
#> Sample_14958                             0.02143548
#>              Epidish_CCLE.TIL10_Dendritic.cells CBSX_CCLE.TIL10_Dendritic.cells
#> Sample_12929                                  0                     0.000000000
#> Sample_15467                                  0                     0.000000000
#> Sample_13634                                  0                     0.000000000
#> Sample_14428                                  0                     0.000000000
#> Sample_11817                                  0                     0.000000000
#> Sample_14958                                  0                     0.003033416
#>              DWLS_CCLE.TIL10_Dendritic.cells DeconRNASeq_TIL10_Dendritic.cells
#> Sample_12929                               0                        0.06131398
#> Sample_15467                               0                        0.05910810
#> Sample_13634                               0                        0.08048030
#> Sample_14428                               0                        0.01789365
#> Sample_11817                               0                        0.04619290
#> Sample_14958                               0                        0.03082949
#>              Epidish_TIL10_Dendritic.cells CBSX_TIL10_Dendritic.cells
#> Sample_12929                             0                   0.000000
#> Sample_15467                             0                   0.000000
#> Sample_13634                             0                   0.022547
#> Sample_14428                             0                   0.000000
#> Sample_11817                             0                   0.000000
#> Sample_14958                             0                   0.000000
#>              DWLS_TIL10_Dendritic.cells
#> Sample_12929                          0
#> Sample_15467                          0
#> Sample_13634                          0
#> Sample_14428                          0
#> Sample_11817                          0
#> Sample_14958                          0
#>              DeconRNASeq_LM22_Dendritic.activated.cells
#> Sample_12929                                 0.06971335
#> Sample_15467                                 0.03136573
#> Sample_13634                                 0.05558909
#> Sample_14428                                 0.06205963
#> Sample_11817                                 0.01541343
#> Sample_14958                                 0.08452091
#>              Epidish_LM22_Dendritic.activated.cells
#> Sample_12929                            0.022425136
#> Sample_15467                            0.003361624
#> Sample_13634                            0.001074451
#> Sample_14428                            0.004210850
#> Sample_11817                            0.001896870
#> Sample_14958                            0.006266940
#>              CBSX_LM22_Dendritic.activated.cells
#> Sample_12929                         0.028158715
#> Sample_15467                         0.001084014
#> Sample_13634                         0.000333646
#> Sample_14428                         0.005813335
#> Sample_11817                         0.001901373
#> Sample_14958                         0.007268420
#>              DWLS_LM22_Dendritic.activated.cells
#> Sample_12929                        0.0208482929
#> Sample_15467                        0.0026581917
#> Sample_13634                        0.0003471019
#> Sample_14428                        0.0068877190
#> Sample_11817                        0.0024280057
#> Sample_14958                        0.0094642466
#>              DeconRNASeq_LM22_Dendritic.resting.cells
#> Sample_12929                              0.000000000
#> Sample_15467                              0.000000000
#> Sample_13634                              0.000000000
#> Sample_14428                              0.000000000
#> Sample_11817                              0.000000000
#> Sample_14958                              0.003831816
#>              Epidish_LM22_Dendritic.resting.cells
#> Sample_12929                          0.000000000
#> Sample_15467                          0.000000000
#> Sample_13634                          0.000000000
#> Sample_14428                          0.000000000
#> Sample_11817                          0.000000000
#> Sample_14958                          0.004559523
#>              CBSX_LM22_Dendritic.resting.cells
#> Sample_12929                       0.000000000
#> Sample_15467                       0.000000000
#> Sample_13634                       0.000000000
#> Sample_14428                       0.000000000
#> Sample_11817                       0.000000000
#> Sample_14958                       0.004938485
#>              DWLS_LM22_Dendritic.resting.cells DeconRNASeq_BPRNACan_Cancer
#> Sample_12929                                 0                   0.3933836
#> Sample_15467                                 0                   0.2915067
#> Sample_13634                                 0                   0.2217891
#> Sample_14428                                 0                   0.3907047
#> Sample_11817                                 0                   0.2208742
#> Sample_14958                                 0                   0.4929691
#>              Epidish_BPRNACan_Cancer CBSX_BPRNACan_Cancer DWLS_BPRNACan_Cancer
#> Sample_12929               0.6166786            0.5394085            0.4342145
#> Sample_15467               0.4786638            0.4308931            0.3065221
#> Sample_13634               0.2955773            0.2455961            0.1584682
#> Sample_14428               0.5634269            0.5372327            0.4081480
#> Sample_11817               0.3053772            0.2353544            0.1636794
#> Sample_14958               0.7248593            0.7092895            0.5608748
#>              DeconRNASeq_BPRNACan3DProMet_Cancer
#> Sample_12929                           0.4338922
#> Sample_15467                           0.3324035
#> Sample_13634                           0.2700817
#> Sample_14428                           0.4182591
#> Sample_11817                           0.2781732
#> Sample_14958                           0.5247391
#>              Epidish_BPRNACan3DProMet_Cancer CBSX_BPRNACan3DProMet_Cancer
#> Sample_12929                       0.6600968                    0.6120825
#> Sample_15467                       0.5373237                    0.5017719
#> Sample_13634                       0.3577828                    0.3114797
#> Sample_14428                       0.5920390                    0.5799616
#> Sample_11817                       0.3931124                    0.3351489
#> Sample_14958                       0.7712817                    0.7190106
#>              DWLS_BPRNACan3DProMet_Cancer DeconRNASeq_BPRNACanProMet_Cancer
#> Sample_12929                    0.3829061                         0.4524419
#> Sample_15467                    0.3247027                         0.3676302
#> Sample_13634                    0.1528269                         0.3078654
#> Sample_14428                    0.3612894                         0.4462972
#> Sample_11817                    0.1572533                         0.3208512
#> Sample_14958                    0.5436958                         0.5421875
#>              Epidish_BPRNACanProMet_Cancer CBSX_BPRNACanProMet_Cancer
#> Sample_12929                     0.6701242                  0.5997506
#> Sample_15467                     0.5322856                  0.5406724
#> Sample_13634                     0.3936203                  0.3812283
#> Sample_14428                     0.6061660                  0.5912652
#> Sample_11817                     0.4536191                  0.4347020
#> Sample_14958                     0.7633781                  0.7458288
#>              DWLS_BPRNACanProMet_Cancer DeconRNASeq_CCLE.TIL10_Cancer
#> Sample_12929                  0.4312181                    0.03651069
#> Sample_15467                  0.3389188                    0.04654308
#> Sample_13634                  0.2052716                    0.04140288
#> Sample_14428                  0.3813738                    0.00000000
#> Sample_11817                  0.2341834                    0.07588630
#> Sample_14958                  0.5423035                    0.11270874
#>              Epidish_CCLE.TIL10_Cancer CBSX_CCLE.TIL10_Cancer
#> Sample_12929                0.04975358             0.07735425
#> Sample_15467                0.03606305             0.02769213
#> Sample_13634                0.05899541             0.05676930
#> Sample_14428                0.03478234             0.02945810
#> Sample_11817                0.15917381             0.15359102
#> Sample_14958                0.07602620             0.14655656
#>              DWLS_CCLE.TIL10_Cancer AutogeneS_Vanderbilt_Cancer
#> Sample_12929             0.05494773                  0.03866988
#> Sample_15467             0.03065025                  0.02806758
#> Sample_13634             0.05540219                  0.02424841
#> Sample_14428             0.02817030                  0.04208894
#> Sample_11817             0.15538250                  0.02694110
#> Sample_14958             0.08142523                  0.03719849
#>              BayesPrism_Vanderbilt_Cancer Bisque_Vanderbilt_Cancer
#> Sample_12929                 2.035113e-03             4.531156e-05
#> Sample_15467                 5.504065e-03             0.000000e+00
#> Sample_13634                 1.450634e-05             0.000000e+00
#> Sample_14428                 1.680605e-02             0.000000e+00
#> Sample_11817                 7.011090e-03             0.000000e+00
#> Sample_14958                 4.569562e-03             0.000000e+00
#>              CPM_Vanderbilt_Cancer SCDC_Vanderbilt_Cancer
#> Sample_12929            0.05988876                      0
#> Sample_15467            0.05978602                      0
#> Sample_13634            0.05981467                      0
#> Sample_14428            0.06119085                      0
#> Sample_11817            0.06144992                      0
#> Sample_14958            0.06044250                      0
#>              DeconRNASeq_CBSX.HNSCC.scRNAseq_Cancer
#> Sample_12929                             0.02697111
#> Sample_15467                             0.02877165
#> Sample_13634                             0.04193146
#> Sample_14428                             0.01900377
#> Sample_11817                             0.05245200
#> Sample_14958                             0.01243299
#>              Epidish_CBSX.HNSCC.scRNAseq_Cancer CBSX_CBSX.HNSCC.scRNAseq_Cancer
#> Sample_12929                                  0                    0.0002680674
#> Sample_15467                                  0                    0.0000000000
#> Sample_13634                                  0                    0.0000000000
#> Sample_14428                                  0                    0.0000000000
#> Sample_11817                                  0                    0.0000000000
#> Sample_14958                                  0                    0.0000000000
#>              DWLS_CBSX.HNSCC.scRNAseq_Cancer
#> Sample_12929                               0
#> Sample_15467                               0
#> Sample_13634                               0
#> Sample_14428                               0
#> Sample_11817                               0
#> Sample_14958                               0
#>              DeconRNASeq_CBSX.Melanoma.scRNAseq_Cancer
#> Sample_12929                               0.004501803
#> Sample_15467                               0.013017878
#> Sample_13634                               0.014080190
#> Sample_14428                               0.007513155
#> Sample_11817                               0.001110995
#> Sample_14958                               0.013837996
#>              Epidish_CBSX.Melanoma.scRNAseq_Cancer
#> Sample_12929                           0.000000000
#> Sample_15467                           0.000000000
#> Sample_13634                           0.000000000
#> Sample_14428                           0.003180732
#> Sample_11817                           0.000000000
#> Sample_14958                           0.000000000
#>              CBSX_CBSX.Melanoma.scRNAseq_Cancer
#> Sample_12929                                  0
#> Sample_15467                                  0
#> Sample_13634                                  0
#> Sample_14428                                  0
#> Sample_11817                                  0
#> Sample_14958                                  0
#>              DWLS_CBSX.Melanoma.scRNAseq_Cancer
#> Sample_12929                        0.000000000
#> Sample_15467                        0.000000000
#> Sample_13634                        0.000000000
#> Sample_14428                        0.001977258
#> Sample_11817                        0.000000000
#> Sample_14958                        0.000000000
#>              DeconRNASeq_BSeqSC.Vanderbilt.scRNAseq_Endothelial
#> Sample_12929                                         0.00000000
#> Sample_15467                                         0.04936328
#> Sample_13634                                         0.00000000
#> Sample_14428                                         0.03940900
#> Sample_11817                                         0.00000000
#> Sample_14958                                         0.00000000
#>              Epidish_BSeqSC.Vanderbilt.scRNAseq_Endothelial
#> Sample_12929                                    0.005363973
#> Sample_15467                                    0.033564858
#> Sample_13634                                    0.004063253
#> Sample_14428                                    0.079849221
#> Sample_11817                                    0.000000000
#> Sample_14958                                    0.003713113
#>              CBSX_BSeqSC.Vanderbilt.scRNAseq_Endothelial
#> Sample_12929                                 0.015210663
#> Sample_15467                                 0.071991652
#> Sample_13634                                 0.004385862
#> Sample_14428                                 0.062223154
#> Sample_11817                                 0.000521994
#> Sample_14958                                 0.001674917
#>              DWLS_BSeqSC.Vanderbilt.scRNAseq_Endothelial
#> Sample_12929                                 0.006590844
#> Sample_15467                                 0.035215642
#> Sample_13634                                 0.007350917
#> Sample_14428                                 0.077298029
#> Sample_11817                                 0.000000000
#> Sample_14958                                 0.001661692
#>              DeconRNASeq_CBSX.HNSCC.scRNAseq_Endothelial
#> Sample_12929                                  0.03299768
#> Sample_15467                                  0.06232227
#> Sample_13634                                  0.03342908
#> Sample_14428                                  0.09667074
#> Sample_11817                                  0.02203442
#> Sample_14958                                  0.05295093
#>              Epidish_CBSX.HNSCC.scRNAseq_Endothelial
#> Sample_12929                              0.00000000
#> Sample_15467                              0.03895641
#> Sample_13634                              0.00000000
#> Sample_14428                              0.05036608
#> Sample_11817                              0.00000000
#> Sample_14958                              0.00363380
#>              CBSX_CBSX.HNSCC.scRNAseq_Endothelial
#> Sample_12929                          0.002888950
#> Sample_15467                          0.034062245
#> Sample_13634                          0.001135788
#> Sample_14428                          0.051244073
#> Sample_11817                          0.000000000
#> Sample_14958                          0.009290203
#>              DWLS_CBSX.HNSCC.scRNAseq_Endothelial
#> Sample_12929                         0.0000000000
#> Sample_15467                         0.0380053991
#> Sample_13634                         0.0000738302
#> Sample_14428                         0.0531245297
#> Sample_11817                         0.0000000000
#> Sample_14958                         0.0018018714
#>              DeconRNASeq_CBSX.Melanoma.scRNAseq_Endothelial
#> Sample_12929                                    0.003731548
#> Sample_15467                                    0.025255144
#> Sample_13634                                    0.013564052
#> Sample_14428                                    0.034667559
#> Sample_11817                                    0.007569591
#> Sample_14958                                    0.026382581
#>              Epidish_CBSX.Melanoma.scRNAseq_Endothelial
#> Sample_12929                                0.000095323
#> Sample_15467                                0.013672337
#> Sample_13634                                0.000000000
#> Sample_14428                                0.040068782
#> Sample_11817                                0.000000000
#> Sample_14958                                0.008673594
#>              CBSX_CBSX.Melanoma.scRNAseq_Endothelial
#> Sample_12929                            0.0004889137
#> Sample_15467                            0.0059512760
#> Sample_13634                            0.0004270818
#> Sample_14428                            0.0239074740
#> Sample_11817                            0.0000000000
#> Sample_14958                            0.0038185512
#>              DWLS_CBSX.Melanoma.scRNAseq_Endothelial
#> Sample_12929                            0.0001717085
#> Sample_15467                            0.0227259480
#> Sample_13634                            0.0003194849
#> Sample_14428                            0.0677316428
#> Sample_11817                            0.0000000000
#> Sample_14958                            0.0060256330
#>              DeconRNASeq_CBSX.Vanderbilt.scRNAseq_Endothelial
#> Sample_12929                                       0.00000000
#> Sample_15467                                       0.01276891
#> Sample_13634                                       0.00000000
#> Sample_14428                                       0.08027200
#> Sample_11817                                       0.00000000
#> Sample_14958                                       0.00000000
#>              Epidish_CBSX.Vanderbilt.scRNAseq_Endothelial
#> Sample_12929                                 0.0006728853
#> Sample_15467                                 0.0373565563
#> Sample_13634                                 0.0008973845
#> Sample_14428                                 0.0549904241
#> Sample_11817                                 0.0000000000
#> Sample_14958                                 0.0043851275
#>              CBSX_CBSX.Vanderbilt.scRNAseq_Endothelial
#> Sample_12929                              0.0017352968
#> Sample_15467                              0.0327669842
#> Sample_13634                              0.0008374295
#> Sample_14428                              0.0518225586
#> Sample_11817                              0.0006019568
#> Sample_14958                              0.0030574701
#>              DWLS_CBSX.Vanderbilt.scRNAseq_Endothelial
#> Sample_12929                              0.0017325583
#> Sample_15467                              0.0500042952
#> Sample_13634                              0.0015352707
#> Sample_14428                              0.0757298433
#> Sample_11817                              0.0005594518
#> Sample_14958                              0.0054693526
#>              DeconRNASeq_DWLS.Vanderbilt.scRNAseq_Endothelial
#> Sample_12929                                       0.00000000
#> Sample_15467                                       0.01624530
#> Sample_13634                                       0.00000000
#> Sample_14428                                       0.08640317
#> Sample_11817                                       0.00000000
#> Sample_14958                                       0.00000000
#>              Epidish_DWLS.Vanderbilt.scRNAseq_Endothelial
#> Sample_12929                                  0.002673007
#> Sample_15467                                  0.040102445
#> Sample_13634                                  0.004285010
#> Sample_14428                                  0.066811526
#> Sample_11817                                  0.001575612
#> Sample_14958                                  0.000000000
#>              CBSX_DWLS.Vanderbilt.scRNAseq_Endothelial
#> Sample_12929                              0.0120699919
#> Sample_15467                              0.0502516516
#> Sample_13634                              0.0033952358
#> Sample_14428                              0.0631955197
#> Sample_11817                              0.0012908653
#> Sample_14958                              0.0002220993
#>              DWLS_DWLS.Vanderbilt.scRNAseq_Endothelial
#> Sample_12929                                0.01213031
#> Sample_15467                                0.06806430
#> Sample_13634                                0.01310105
#> Sample_14428                                0.09481268
#> Sample_11817                                0.00998575
#> Sample_14958                                0.00000000
#>              DeconRNASeq_MOMF.Vanderbilt.scRNAseq_Endothelial
#> Sample_12929                                       0.00000000
#> Sample_15467                                       0.02114692
#> Sample_13634                                       0.00000000
#> Sample_14428                                       0.02780478
#> Sample_11817                                       0.00000000
#> Sample_14958                                       0.00000000
#>              Epidish_MOMF.Vanderbilt.scRNAseq_Endothelial
#> Sample_12929                                  0.013957134
#> Sample_15467                                  0.109916695
#> Sample_13634                                  0.025289277
#> Sample_14428                                  0.083262313
#> Sample_11817                                  0.003615293
#> Sample_14958                                  0.004324868
#>              CBSX_MOMF.Vanderbilt.scRNAseq_Endothelial
#> Sample_12929                                0.02094550
#> Sample_15467                                0.20210382
#> Sample_13634                                0.02153604
#> Sample_14428                                0.24329288
#> Sample_11817                                0.02068623
#> Sample_14958                                0.01558220
#>              DWLS_MOMF.Vanderbilt.scRNAseq_Endothelial
#> Sample_12929                               0.005305409
#> Sample_15467                               0.034600769
#> Sample_13634                               0.003280927
#> Sample_14428                               0.051623845
#> Sample_11817                               0.003547350
#> Sample_14958                               0.004115620
#>              AutogeneS_Vanderbilt_Endothelial BayesPrism_Vanderbilt_Endothelial
#> Sample_12929                       0.03324787                      0.0013942639
#> Sample_15467                       0.06681367                      0.0394659343
#> Sample_13634                       0.02191286                      0.0010132244
#> Sample_14428                       0.07733534                      0.0648155299
#> Sample_11817                       0.01159636                      0.0007353366
#> Sample_14958                       0.05875893                      0.0010497217
#>              Bisque_Vanderbilt_Endothelial CPM_Vanderbilt_Endothelial
#> Sample_12929                    0.00000000                 0.05768816
#> Sample_15467                    0.00000000                 0.05725126
#> Sample_13634                    0.00000000                 0.05673964
#> Sample_14428                    0.02123356                 0.05944656
#> Sample_11817                    0.00000000                 0.05749054
#> Sample_14958                    0.00000000                 0.05914023
#>              MuSic_Vanderbilt_Endothelial SCDC_Vanderbilt_Endothelial
#> Sample_12929                 0.0000000000                  0.00000000
#> Sample_15467                 0.0240181150                  0.02565142
#> Sample_13634                 0.0000000000                  0.00000000
#> Sample_14428                 0.0450928709                  0.10545610
#> Sample_11817                 0.0008391660                  0.00000000
#> Sample_14958                 0.0001872943                  0.00000000
#>              DeconRNASeq_LM22_Eosinophils Epidish_LM22_Eosinophils
#> Sample_12929                   0.06168650              0.002713931
#> Sample_15467                   0.03820898              0.005508230
#> Sample_13634                   0.04571844              0.004279569
#> Sample_14428                   0.05678867              0.004069398
#> Sample_11817                   0.03802461              0.000000000
#> Sample_14958                   0.09133458              0.007151631
#>              CBSX_LM22_Eosinophils DWLS_LM22_Eosinophils
#> Sample_12929          0.0033141651          0.0003393181
#> Sample_15467          0.0030538519          0.0071352479
#> Sample_13634          0.0032367605          0.0033503855
#> Sample_14428          0.0025069911          0.0024970301
#> Sample_11817          0.0001108839          0.0001725927
#> Sample_14958          0.0039149821          0.0031605188
#>              DeconRNASeq_BSeqSC.Vanderbilt.scRNAseq_Plasma
#> Sample_12929                                    0.06462794
#> Sample_15467                                    0.16901006
#> Sample_13634                                    0.08279237
#> Sample_14428                                    0.05867488
#> Sample_11817                                    0.08615495
#> Sample_14958                                    0.05803364
#>              Epidish_BSeqSC.Vanderbilt.scRNAseq_Plasma
#> Sample_12929                                0.09216294
#> Sample_15467                                0.23525712
#> Sample_13634                                0.07969257
#> Sample_14428                                0.05474487
#> Sample_11817                                0.05619553
#> Sample_14958                                0.00000000
#>              CBSX_BSeqSC.Vanderbilt.scRNAseq_Plasma
#> Sample_12929                             0.07362060
#> Sample_15467                             0.19302075
#> Sample_13634                             0.07621176
#> Sample_14428                             0.03606024
#> Sample_11817                             0.07403417
#> Sample_14958                             0.00000000
#>              DWLS_BSeqSC.Vanderbilt.scRNAseq_Plasma
#> Sample_12929                             0.07134969
#> Sample_15467                             0.19320588
#> Sample_13634                             0.06081066
#> Sample_14428                             0.03437077
#> Sample_11817                             0.04231801
#> Sample_14958                             0.00000000
#>              DeconRNASeq_CBSX.Vanderbilt.scRNAseq_Plasma
#> Sample_12929                                 0.015803713
#> Sample_15467                                 0.149837829
#> Sample_13634                                 0.025242106
#> Sample_14428                                 0.000000000
#> Sample_11817                                 0.003887516
#> Sample_14958                                 0.000000000
#>              Epidish_CBSX.Vanderbilt.scRNAseq_Plasma
#> Sample_12929                             0.035345450
#> Sample_15467                             0.093114487
#> Sample_13634                             0.036201693
#> Sample_14428                             0.015923718
#> Sample_11817                             0.029055238
#> Sample_14958                             0.002242461
#>              CBSX_CBSX.Vanderbilt.scRNAseq_Plasma
#> Sample_12929                          0.023724842
#> Sample_15467                          0.088996146
#> Sample_13634                          0.027666956
#> Sample_14428                          0.013376600
#> Sample_11817                          0.020112964
#> Sample_14958                          0.001709982
#>              DWLS_CBSX.Vanderbilt.scRNAseq_Plasma
#> Sample_12929                           0.08357384
#> Sample_15467                           0.20771763
#> Sample_13634                           0.09262883
#> Sample_14428                           0.03733156
#> Sample_11817                           0.07244289
#> Sample_14958                           0.00491841
#>              DeconRNASeq_DWLS.Vanderbilt.scRNAseq_Plasma
#> Sample_12929                                  0.01031056
#> Sample_15467                                  0.29505223
#> Sample_13634                                  0.05859561
#> Sample_14428                                  0.00000000
#> Sample_11817                                  0.01458989
#> Sample_14958                                  0.00000000
#>              Epidish_DWLS.Vanderbilt.scRNAseq_Plasma
#> Sample_12929                              0.08642010
#> Sample_15467                              0.24954893
#> Sample_13634                              0.08456694
#> Sample_14428                              0.05673640
#> Sample_11817                              0.06877087
#> Sample_14958                              0.01088708
#>              CBSX_DWLS.Vanderbilt.scRNAseq_Plasma
#> Sample_12929                          0.094527675
#> Sample_15467                          0.249215174
#> Sample_13634                          0.077186600
#> Sample_14428                          0.046591457
#> Sample_11817                          0.068434209
#> Sample_14958                          0.003259326
#>              DWLS_DWLS.Vanderbilt.scRNAseq_Plasma DeconRNASeq_LM22_Plasma
#> Sample_12929                          0.081253215              0.00000000
#> Sample_15467                          0.238941032              0.05127881
#> Sample_13634                          0.087318771              0.00000000
#> Sample_14428                          0.048892084              0.00000000
#> Sample_11817                          0.066837258              0.00000000
#> Sample_14958                          0.007411453              0.00000000
#>              Epidish_LM22_Plasma CBSX_LM22_Plasma DWLS_LM22_Plasma
#> Sample_12929         0.002426936     0.0003311265      0.000000000
#> Sample_15467         0.021467864     0.0185380432      0.025868668
#> Sample_13634         0.008773283     0.0021847463      0.002691934
#> Sample_14428         0.000000000     0.0000000000      0.000000000
#> Sample_11817         0.003124762     0.0001678755      0.000000000
#> Sample_14958         0.000000000     0.0000000000      0.000000000
#>              DeconRNASeq_MOMF.Vanderbilt.scRNAseq_Plasma
#> Sample_12929                                  0.05691805
#> Sample_15467                                  0.14431082
#> Sample_13634                                  0.06430750
#> Sample_14428                                  0.04637578
#> Sample_11817                                  0.06022123
#> Sample_14958                                  0.05148992
#>              Epidish_MOMF.Vanderbilt.scRNAseq_Plasma
#> Sample_12929                             0.023877294
#> Sample_15467                             0.069204123
#> Sample_13634                             0.080345690
#> Sample_14428                             0.009724206
#> Sample_11817                             0.011892392
#> Sample_14958                             0.006331327
#>              CBSX_MOMF.Vanderbilt.scRNAseq_Plasma
#> Sample_12929                          0.036920755
#> Sample_15467                          0.138790533
#> Sample_13634                          0.092585662
#> Sample_14428                          0.030713782
#> Sample_11817                          0.021162238
#> Sample_14958                          0.009872733
#>              DWLS_MOMF.Vanderbilt.scRNAseq_Plasma AutogeneS_Vanderbilt_Plasma
#> Sample_12929                           0.06865917                  0.05358517
#> Sample_15467                           0.16894332                  0.06609761
#> Sample_13634                           0.06777516                  0.06148343
#> Sample_14428                           0.04889073                  0.03612882
#> Sample_11817                           0.06234179                  0.05892252
#> Sample_14958                           0.03539249                  0.02751525
#>              BayesPrism_Vanderbilt_Plasma Bisque_Vanderbilt_Plasma
#> Sample_12929                  0.069519247               0.03867489
#> Sample_15467                  0.187184052               0.14081703
#> Sample_13634                  0.070565940               0.02773828
#> Sample_14428                  0.039837029               0.02859612
#> Sample_11817                  0.056940018               0.02497655
#> Sample_14958                  0.005173246               0.02037010
#>              CPM_Vanderbilt_Plasma MuSic_Vanderbilt_Plasma
#> Sample_12929            0.02157877              0.10541016
#> Sample_15467            0.02394167              0.25453145
#> Sample_13634            0.02208882              0.10996671
#> Sample_14428            0.02199686              0.08071130
#> Sample_11817            0.02106850              0.11110862
#> Sample_14958            0.02150433              0.06075838
#>              SCDC_Vanderbilt_Plasma DeconRNASeq_CBSX.HNSCC.scRNAseq_Myocytes
#> Sample_12929             0.11677836                              0.011532051
#> Sample_15467             0.30321875                              0.020855294
#> Sample_13634             0.13812143                              0.034826430
#> Sample_14428             0.08624986                              0.009525945
#> Sample_11817             0.07841454                              0.040570102
#> Sample_14958             0.03286964                              0.012975541
#>              Epidish_CBSX.HNSCC.scRNAseq_Myocytes
#> Sample_12929                                    0
#> Sample_15467                                    0
#> Sample_13634                                    0
#> Sample_14428                                    0
#> Sample_11817                                    0
#> Sample_14958                                    0
#>              CBSX_CBSX.HNSCC.scRNAseq_Myocytes
#> Sample_12929                                 0
#> Sample_15467                                 0
#> Sample_13634                                 0
#> Sample_14428                                 0
#> Sample_11817                                 0
#> Sample_14958                                 0
#>              DWLS_CBSX.HNSCC.scRNAseq_Myocytes
#> Sample_12929                                 0
#> Sample_15467                                 0
#> Sample_13634                                 0
#> Sample_14428                                 0
#> Sample_11817                                 0
#> Sample_14958                                 0
#>              DeconRNASeq_BSeqSC.Vanderbilt.scRNAseq_Fibroblasts
#> Sample_12929                                         0.09430749
#> Sample_15467                                         0.03215657
#> Sample_13634                                         0.03682437
#> Sample_14428                                         0.09549757
#> Sample_11817                                         0.00000000
#> Sample_14958                                         0.11226917
#>              Epidish_BSeqSC.Vanderbilt.scRNAseq_Fibroblasts
#> Sample_12929                                     0.09248438
#> Sample_15467                                     0.02438946
#> Sample_13634                                     0.02143870
#> Sample_14428                                     0.09267643
#> Sample_11817                                     0.00000000
#> Sample_14958                                     0.09954946
#>              CBSX_BSeqSC.Vanderbilt.scRNAseq_Fibroblasts
#> Sample_12929                                 0.119673058
#> Sample_15467                                 0.035285591
#> Sample_13634                                 0.057908945
#> Sample_14428                                 0.130161494
#> Sample_11817                                 0.001001802
#> Sample_14958                                 0.100970492
#>              DWLS_BSeqSC.Vanderbilt.scRNAseq_Fibroblasts
#> Sample_12929                                  0.08925166
#> Sample_15467                                  0.02558324
#> Sample_13634                                  0.02410767
#> Sample_14428                                  0.09181148
#> Sample_11817                                  0.00000000
#> Sample_14958                                  0.09953502
#>              DeconRNASeq_CBSX.Vanderbilt.scRNAseq_Fibroblasts
#> Sample_12929                                       0.04256729
#> Sample_15467                                       0.00000000
#> Sample_13634                                       0.00000000
#> Sample_14428                                       0.10709736
#> Sample_11817                                       0.00000000
#> Sample_14958                                       0.07918722
#>              Epidish_CBSX.Vanderbilt.scRNAseq_Fibroblasts
#> Sample_12929                                  0.042090704
#> Sample_15467                                  0.019679802
#> Sample_13634                                  0.006765333
#> Sample_14428                                  0.080694617
#> Sample_11817                                  0.000000000
#> Sample_14958                                  0.053538859
#>              CBSX_CBSX.Vanderbilt.scRNAseq_Fibroblasts
#> Sample_12929                               0.042496554
#> Sample_15467                               0.015789413
#> Sample_13634                               0.004910858
#> Sample_14428                               0.083153576
#> Sample_11817                               0.000000000
#> Sample_14958                               0.054251295
#>              DWLS_CBSX.Vanderbilt.scRNAseq_Fibroblasts
#> Sample_12929                                0.06195413
#> Sample_15467                                0.02574340
#> Sample_13634                                0.01055708
#> Sample_14428                                0.11784685
#> Sample_11817                                0.00000000
#> Sample_14958                                0.07547067
#>              DeconRNASeq_DWLS.Vanderbilt.scRNAseq_Fibroblasts
#> Sample_12929                                        0.1009148
#> Sample_15467                                        0.0000000
#> Sample_13634                                        0.0000000
#> Sample_14428                                        0.1771617
#> Sample_11817                                        0.0000000
#> Sample_14958                                        0.1095387
#>              Epidish_DWLS.Vanderbilt.scRNAseq_Fibroblasts
#> Sample_12929                                   0.06456902
#> Sample_15467                                   0.02706176
#> Sample_13634                                   0.01633387
#> Sample_14428                                   0.11185879
#> Sample_11817                                   0.00000000
#> Sample_14958                                   0.07792758
#>              CBSX_DWLS.Vanderbilt.scRNAseq_Fibroblasts
#> Sample_12929                                0.05376452
#> Sample_15467                                0.03944269
#> Sample_13634                                0.01530167
#> Sample_14428                                0.12722917
#> Sample_11817                                0.00000000
#> Sample_14958                                0.08299108
#>              DWLS_DWLS.Vanderbilt.scRNAseq_Fibroblasts
#> Sample_12929                                0.11371576
#> Sample_15467                                0.05094989
#> Sample_13634                                0.03369783
#> Sample_14428                                0.19151560
#> Sample_11817                                0.00000000
#> Sample_14958                                0.12490623
#>              DeconRNASeq_MOMF.Vanderbilt.scRNAseq_Fibroblasts
#> Sample_12929                                       0.08439310
#> Sample_15467                                       0.05578800
#> Sample_13634                                       0.03896078
#> Sample_14428                                       0.12169943
#> Sample_11817                                       0.01982122
#> Sample_14958                                       0.08559893
#>              Epidish_MOMF.Vanderbilt.scRNAseq_Fibroblasts
#> Sample_12929                                  0.074420992
#> Sample_15467                                  0.044595493
#> Sample_13634                                  0.063721403
#> Sample_14428                                  0.072100920
#> Sample_11817                                  0.003004878
#> Sample_14958                                  0.041158535
#>              CBSX_MOMF.Vanderbilt.scRNAseq_Fibroblasts
#> Sample_12929                                0.11503492
#> Sample_15467                                0.08608978
#> Sample_13634                                0.05361809
#> Sample_14428                                0.21571266
#> Sample_11817                                0.01993138
#> Sample_14958                                0.09786532
#>              DWLS_MOMF.Vanderbilt.scRNAseq_Fibroblasts
#> Sample_12929                               0.066086801
#> Sample_15467                               0.034264516
#> Sample_13634                               0.017336220
#> Sample_14428                               0.109833349
#> Sample_11817                               0.006248324
#> Sample_14958                               0.070324698
#>              AutogeneS_Vanderbilt_Fibroblasts BayesPrism_Vanderbilt_Fibroblasts
#> Sample_12929                      0.066303735                       0.080029031
#> Sample_15467                      0.041070555                       0.033020201
#> Sample_13634                      0.017538061                       0.011897193
#> Sample_14428                      0.094725652                       0.111010013
#> Sample_11817                      0.002794501                       0.000506695
#> Sample_14958                      0.105699515                       0.055338516
#>              Bisque_Vanderbilt_Fibroblasts CPM_Vanderbilt_Fibroblasts
#> Sample_12929                    0.03151627                 0.07220131
#> Sample_15467                    0.00000000                 0.07195892
#> Sample_13634                    0.00000000                 0.07140748
#> Sample_14428                    0.06628036                 0.07353627
#> Sample_11817                    0.00000000                 0.07057177
#> Sample_14958                    0.02104011                 0.07436491
#>              MuSic_Vanderbilt_Fibroblasts SCDC_Vanderbilt_Fibroblasts
#> Sample_12929                  0.090199272                  0.14231262
#> Sample_15467                  0.040154667                  0.06977975
#> Sample_13634                  0.015757947                  0.00000000
#> Sample_14428                  0.118567153                  0.22958140
#> Sample_11817                  0.007265644                  0.00000000
#> Sample_14958                  0.146653626                  0.27059675
#>              DeconRNASeq_BSeqSC.Vanderbilt.scRNAseq_Mast.cells
#> Sample_12929                                         0.1489899
#> Sample_15467                                         0.1624670
#> Sample_13634                                         0.1065515
#> Sample_14428                                         0.1033449
#> Sample_11817                                         0.1106900
#> Sample_14958                                         0.1226220
#>              Epidish_BSeqSC.Vanderbilt.scRNAseq_Mast.cells
#> Sample_12929                                    0.04110362
#> Sample_15467                                    0.03976158
#> Sample_13634                                    0.01425105
#> Sample_14428                                    0.01682468
#> Sample_11817                                    0.01303694
#> Sample_14958                                    0.05855101
#>              CBSX_BSeqSC.Vanderbilt.scRNAseq_Mast.cells
#> Sample_12929                                0.058954783
#> Sample_15467                                0.051539141
#> Sample_13634                                0.055597460
#> Sample_14428                                0.041497835
#> Sample_11817                                0.006197474
#> Sample_14958                                0.059254018
#>              DWLS_BSeqSC.Vanderbilt.scRNAseq_Mast.cells
#> Sample_12929                                 0.03070726
#> Sample_15467                                 0.04387606
#> Sample_13634                                 0.01639737
#> Sample_14428                                 0.01498408
#> Sample_11817                                 0.01803423
#> Sample_14958                                 0.05994475
#>              DeconRNASeq_CBSX.HNSCC.scRNAseq_Mast.cells
#> Sample_12929                                0.017202982
#> Sample_15467                                0.022386994
#> Sample_13634                                0.035583532
#> Sample_14428                                0.010664077
#> Sample_11817                                0.045228107
#> Sample_14958                                0.002255604
#>              Epidish_CBSX.HNSCC.scRNAseq_Mast.cells
#> Sample_12929                                      0
#> Sample_15467                                      0
#> Sample_13634                                      0
#> Sample_14428                                      0
#> Sample_11817                                      0
#> Sample_14958                                      0
#>              CBSX_CBSX.HNSCC.scRNAseq_Mast.cells
#> Sample_12929                        0.000000e+00
#> Sample_15467                        5.873523e-04
#> Sample_13634                        0.000000e+00
#> Sample_14428                        1.653605e-05
#> Sample_11817                        0.000000e+00
#> Sample_14958                        2.132278e-04
#>              DWLS_CBSX.HNSCC.scRNAseq_Mast.cells
#> Sample_12929                        0.000000e+00
#> Sample_15467                        1.316701e-03
#> Sample_13634                        0.000000e+00
#> Sample_14428                        0.000000e+00
#> Sample_11817                        0.000000e+00
#> Sample_14958                        2.035016e-06
#>              DeconRNASeq_CBSX.Vanderbilt.scRNAseq_Mast.cells
#> Sample_12929                                               0
#> Sample_15467                                               0
#> Sample_13634                                               0
#> Sample_14428                                               0
#> Sample_11817                                               0
#> Sample_14958                                               0
#>              Epidish_CBSX.Vanderbilt.scRNAseq_Mast.cells
#> Sample_12929                                0.0011452493
#> Sample_15467                                0.0021326304
#> Sample_13634                                0.0001676319
#> Sample_14428                                0.0000000000
#> Sample_11817                                0.0003366965
#> Sample_14958                                0.0016420724
#>              CBSX_CBSX.Vanderbilt.scRNAseq_Mast.cells
#> Sample_12929                             0.0009237418
#> Sample_15467                             0.0021730723
#> Sample_13634                             0.0003891489
#> Sample_14428                             0.0003992974
#> Sample_11817                             0.0009720201
#> Sample_14958                             0.0007952694
#>              DWLS_CBSX.Vanderbilt.scRNAseq_Mast.cells
#> Sample_12929                             0.0011892766
#> Sample_15467                             0.0024934443
#> Sample_13634                             0.0005263553
#> Sample_14428                             0.0007712280
#> Sample_11817                             0.0014671272
#> Sample_14958                             0.0023987436
#>              DeconRNASeq_DWLS.Vanderbilt.scRNAseq_Mast.cells
#> Sample_12929                                               0
#> Sample_15467                                               0
#> Sample_13634                                               0
#> Sample_14428                                               0
#> Sample_11817                                               0
#> Sample_14958                                               0
#>              Epidish_DWLS.Vanderbilt.scRNAseq_Mast.cells
#> Sample_12929                                0.0037963105
#> Sample_15467                                0.0085083718
#> Sample_13634                                0.0006749187
#> Sample_14428                                0.0000000000
#> Sample_11817                                0.0000000000
#> Sample_14958                                0.0091241050
#>              CBSX_DWLS.Vanderbilt.scRNAseq_Mast.cells
#> Sample_12929                             0.0030239198
#> Sample_15467                             0.0006787537
#> Sample_13634                             0.0006217278
#> Sample_14428                             0.0028347400
#> Sample_11817                             0.0000000000
#> Sample_14958                             0.0035169517
#>              DWLS_DWLS.Vanderbilt.scRNAseq_Mast.cells
#> Sample_12929                              0.006251281
#> Sample_15467                              0.018258512
#> Sample_13634                              0.000723287
#> Sample_14428                              0.006976615
#> Sample_11817                              0.000000000
#> Sample_14958                              0.012613437
#>              DeconRNASeq_MOMF.Vanderbilt.scRNAseq_Mast.cells
#> Sample_12929                                     0.042931390
#> Sample_15467                                     0.036698391
#> Sample_13634                                     0.004731648
#> Sample_14428                                     0.012452723
#> Sample_11817                                     0.017650384
#> Sample_14958                                     0.046658318
#>              Epidish_MOMF.Vanderbilt.scRNAseq_Mast.cells
#> Sample_12929                                  0.03072546
#> Sample_15467                                  0.02058147
#> Sample_13634                                  0.00000000
#> Sample_14428                                  0.00038257
#> Sample_11817                                  0.00000000
#> Sample_14958                                  0.06175322
#>              CBSX_MOMF.Vanderbilt.scRNAseq_Mast.cells
#> Sample_12929                               0.02923381
#> Sample_15467                               0.03569197
#> Sample_13634                               0.00000000
#> Sample_14428                               0.01024097
#> Sample_11817                               0.00000000
#> Sample_14958                               0.08830694
#>              DWLS_MOMF.Vanderbilt.scRNAseq_Mast.cells
#> Sample_12929                             0.0084579645
#> Sample_15467                             0.0048985995
#> Sample_13634                             0.0000000000
#> Sample_14428                             0.0008375458
#> Sample_11817                             0.0000000000
#> Sample_14958                             0.0265947654
#>              AutogeneS_Vanderbilt_Mast.cells BayesPrism_Vanderbilt_Mast.cells
#> Sample_12929                      0.05185007                     2.411959e-03
#> Sample_15467                      0.03353468                     3.726275e-03
#> Sample_13634                      0.03585458                     4.478907e-05
#> Sample_14428                      0.03418212                     3.024215e-04
#> Sample_11817                      0.03888348                     1.339297e-03
#> Sample_14958                      0.05387348                     1.703111e-02
#>              Bisque_Vanderbilt_Mast.cells CPM_Vanderbilt_Mast.cells
#> Sample_12929                  0.006027195                0.07327445
#> Sample_15467                  0.000000000                0.07251478
#> Sample_13634                  0.000000000                0.07179413
#> Sample_14428                  0.000000000                0.07207267
#> Sample_11817                  0.000000000                0.07114155
#> Sample_14958                  0.015631839                0.07397771
#>              SCDC_Vanderbilt_Mast.cells DeconRNASeq_LM22_Mast.activated.cells
#> Sample_12929                 0.00770682                          1.621456e-02
#> Sample_15467                 0.00000000                          0.000000e+00
#> Sample_13634                 0.00000000                          1.924995e-05
#> Sample_14428                 0.00000000                          3.851589e-02
#> Sample_11817                 0.00000000                          0.000000e+00
#> Sample_14958                 0.17712395                          5.185432e-02
#>              Epidish_LM22_Mast.activated.cells CBSX_LM22_Mast.activated.cells
#> Sample_12929                        0.05030938                     0.04675416
#> Sample_15467                        0.02229157                     0.02065814
#> Sample_13634                        0.01882968                     0.01708451
#> Sample_14428                        0.07600841                     0.06868051
#> Sample_11817                        0.01612101                     0.01862213
#> Sample_14958                        0.10189296                     0.08886100
#>              DWLS_LM22_Mast.activated.cells DeconRNASeq_LM22_Mast.resting.cells
#> Sample_12929                     0.06375953                                   0
#> Sample_15467                     0.03511714                                   0
#> Sample_13634                     0.02386700                                   0
#> Sample_14428                     0.09638970                                   0
#> Sample_11817                     0.02857985                                   0
#> Sample_14958                     0.13338576                                   0
#>              Epidish_LM22_Mast.resting.cells CBSX_LM22_Mast.resting.cells
#> Sample_12929                               0                            0
#> Sample_15467                               0                            0
#> Sample_13634                               0                            0
#> Sample_14428                               0                            0
#> Sample_11817                               0                            0
#> Sample_14958                               0                            0
#>              DWLS_LM22_Mast.resting.cells DeconRNASeq_CBSX.HNSCC.scRNAseq_CAF
#> Sample_12929                            0                          0.13021295
#> Sample_15467                            0                          0.08685233
#> Sample_13634                            0                          0.05310104
#> Sample_14428                            0                          0.14874276
#> Sample_11817                            0                          0.05224911
#> Sample_14958                            0                          0.24484010
#>              Epidish_CBSX.HNSCC.scRNAseq_CAF CBSX_CBSX.HNSCC.scRNAseq_CAF
#> Sample_12929                     0.094641746                  0.073377484
#> Sample_15467                     0.041831147                  0.026749477
#> Sample_13634                     0.004644859                  0.006267141
#> Sample_14428                     0.124584377                  0.114357771
#> Sample_11817                     0.000000000                  0.000000000
#> Sample_14958                     0.232312695                  0.230702016
#>              DWLS_CBSX.HNSCC.scRNAseq_CAF
#> Sample_12929                  0.104085068
#> Sample_15467                  0.048626576
#> Sample_13634                  0.005695984
#> Sample_14428                  0.138657475
#> Sample_11817                  0.000000000
#> Sample_14958                  0.247290851
#>              DeconRNASeq_CBSX.Melanoma.scRNAseq_CAF
#> Sample_12929                             0.18414944
#> Sample_15467                             0.10710039
#> Sample_13634                             0.08888836
#> Sample_14428                             0.15828271
#> Sample_11817                             0.05984192
#> Sample_14958                             0.28684215
#>              Epidish_CBSX.Melanoma.scRNAseq_CAF CBSX_CBSX.Melanoma.scRNAseq_CAF
#> Sample_12929                        0.129249703                     0.110221906
#> Sample_15467                        0.046903508                     0.037157012
#> Sample_13634                        0.010768166                     0.008877318
#> Sample_14428                        0.103338533                     0.102023037
#> Sample_11817                        0.002983952                     0.003127525
#> Sample_14958                        0.217758218                     0.228902098
#>              DWLS_CBSX.Melanoma.scRNAseq_CAF Quantiseq_uncharacterized_cell
#> Sample_12929                     0.158859616                   1.110223e-16
#> Sample_15467                     0.061511735                   0.000000e+00
#> Sample_13634                     0.014419191                   1.110223e-16
#> Sample_14428                     0.125389444                   0.000000e+00
#> Sample_11817                     0.004135128                   4.440892e-16
#> Sample_14958                     0.263542872                   2.220446e-16
#>              DeconRNASeq_BSeqSC.Vanderbilt.scRNAseq_T.cells.regulatory
#> Sample_12929                                                 0.1643852
#> Sample_15467                                                 0.1299620
#> Sample_13634                                                 0.1058887
#> Sample_14428                                                 0.1537091
#> Sample_11817                                                 0.0000000
#> Sample_14958                                                 0.1806885
#>              DeconRNASeq_BSeqSC.Vanderbilt.scRNAseq_Myeloid.cells
#> Sample_12929                                           0.07147301
#> Sample_15467                                           0.00000000
#> Sample_13634                                           0.00000000
#> Sample_14428                                           0.01761074
#> Sample_11817                                           0.01750106
#> Sample_14958                                           0.12779683
#>              DeconRNASeq_BSeqSC.Vanderbilt.scRNAseq_Mural.cells
#> Sample_12929                                         0.03801675
#> Sample_15467                                         0.03631036
#> Sample_13634                                         0.03732087
#> Sample_14428                                         0.06264671
#> Sample_11817                                         0.05627690
#> Sample_14958                                         0.15313684
#>              DeconRNASeq_BSeqSC.Vanderbilt.scRNAseq_T.cells.proliferative
#> Sample_12929                                                 0.0000000000
#> Sample_15467                                                 0.0004014175
#> Sample_13634                                                 0.0000000000
#> Sample_14428                                                 0.0000000000
#> Sample_11817                                                 0.1117063799
#> Sample_14958                                                 0.0000000000
#>              Epidish_BSeqSC.Vanderbilt.scRNAseq_T.cells.regulatory
#> Sample_12929                                            0.23655033
#> Sample_15467                                            0.06745026
#> Sample_13634                                            0.14306431
#> Sample_14428                                            0.14351883
#> Sample_11817                                            0.07195701
#> Sample_14958                                            0.18423374
#>              Epidish_BSeqSC.Vanderbilt.scRNAseq_Myeloid.cells
#> Sample_12929                                       0.15413730
#> Sample_15467                                       0.02472302
#> Sample_13634                                       0.02112918
#> Sample_14428                                       0.07217513
#> Sample_11817                                       0.04487419
#> Sample_14958                                       0.15656796
#>              Epidish_BSeqSC.Vanderbilt.scRNAseq_Mural.cells
#> Sample_12929                                    0.002932031
#> Sample_15467                                    0.006057943
#> Sample_13634                                    0.000000000
#> Sample_14428                                    0.021041875
#> Sample_11817                                    0.000000000
#> Sample_14958                                    0.091094086
#>              Epidish_BSeqSC.Vanderbilt.scRNAseq_T.cells.proliferative
#> Sample_12929                                              0.008061005
#> Sample_15467                                              0.096814382
#> Sample_13634                                              0.046929404
#> Sample_14428                                              0.000000000
#> Sample_11817                                              0.346973660
#> Sample_14958                                              0.086771647
#>              CBSX_BSeqSC.Vanderbilt.scRNAseq_T.cells.regulatory
#> Sample_12929                                         0.26100587
#> Sample_15467                                         0.13564229
#> Sample_13634                                         0.17458900
#> Sample_14428                                         0.17005771
#> Sample_11817                                         0.05697393
#> Sample_14958                                         0.16766781
#>              CBSX_BSeqSC.Vanderbilt.scRNAseq_Myeloid.cells
#> Sample_12929                                   0.131498000
#> Sample_15467                                   0.025747397
#> Sample_13634                                   0.004412374
#> Sample_14428                                   0.059264639
#> Sample_11817                                   0.046565467
#> Sample_14958                                   0.153611261
#>              CBSX_BSeqSC.Vanderbilt.scRNAseq_Mural.cells
#> Sample_12929                                0.0000000000
#> Sample_15467                                0.0000000000
#> Sample_13634                                0.0000000000
#> Sample_14428                                0.0002350892
#> Sample_11817                                0.0047260515
#> Sample_14958                                0.0914533406
#>              CBSX_BSeqSC.Vanderbilt.scRNAseq_T.cells.proliferative
#> Sample_12929                                           0.058594474
#> Sample_15467                                           0.117072761
#> Sample_13634                                           0.123439241
#> Sample_14428                                           0.003812569
#> Sample_11817                                           0.305265958
#> Sample_14958                                           0.098720118
#>              DWLS_BSeqSC.Vanderbilt.scRNAseq_T.cells.regulatory
#> Sample_12929                                         0.22635509
#> Sample_15467                                         0.10839286
#> Sample_13634                                         0.13047938
#> Sample_14428                                         0.14147382
#> Sample_11817                                         0.06332203
#> Sample_14958                                         0.16572155
#>              DWLS_BSeqSC.Vanderbilt.scRNAseq_Myeloid.cells
#> Sample_12929                                    0.16486022
#> Sample_15467                                    0.03235867
#> Sample_13634                                    0.02030000
#> Sample_14428                                    0.07239410
#> Sample_11817                                    0.04969638
#> Sample_14958                                    0.16039612
#>              DWLS_BSeqSC.Vanderbilt.scRNAseq_Mural.cells
#> Sample_12929                                 0.005461313
#> Sample_15467                                 0.006620870
#> Sample_13634                                 0.000000000
#> Sample_14428                                 0.030206510
#> Sample_11817                                 0.002106599
#> Sample_14958                                 0.093437401
#>              DWLS_BSeqSC.Vanderbilt.scRNAseq_T.cells.proliferative
#> Sample_12929                                            0.00000000
#> Sample_15467                                            0.08093014
#> Sample_13634                                            0.05340027
#> Sample_14428                                            0.00000000
#> Sample_11817                                            0.32650484
#> Sample_14958                                            0.09583602
#>              DeconRNASeq_CBSX.Vanderbilt.scRNAseq_T.cells.regulatory
#> Sample_12929                                               0.2468613
#> Sample_15467                                               0.1749222
#> Sample_13634                                               0.1958159
#> Sample_14428                                               0.1695693
#> Sample_11817                                               0.2688569
#> Sample_14958                                               0.1720885
#>              DeconRNASeq_CBSX.Vanderbilt.scRNAseq_Myeloid.cells
#> Sample_12929                                         0.19617617
#> Sample_15467                                         0.01964446
#> Sample_13634                                         0.01624903
#> Sample_14428                                         0.10770652
#> Sample_11817                                         0.06012304
#> Sample_14958                                         0.17096873
#>              DeconRNASeq_CBSX.Vanderbilt.scRNAseq_Mural.cells
#> Sample_12929                                       0.02207073
#> Sample_15467                                       0.00000000
#> Sample_13634                                       0.00000000
#> Sample_14428                                       0.00000000
#> Sample_11817                                       0.00000000
#> Sample_14958                                       0.16037729
#>              DeconRNASeq_CBSX.Vanderbilt.scRNAseq_T.cells.proliferative
#> Sample_12929                                                 0.05453349
#> Sample_15467                                                 0.11780158
#> Sample_13634                                                 0.11495587
#> Sample_14428                                                 0.05722428
#> Sample_11817                                                 0.20319516
#> Sample_14958                                                 0.00000000
#>              Epidish_CBSX.Vanderbilt.scRNAseq_T.cells.regulatory
#> Sample_12929                                           0.3158893
#> Sample_15467                                           0.1350057
#> Sample_13634                                           0.1560551
#> Sample_14428                                           0.1521637
#> Sample_11817                                           0.3104752
#> Sample_14958                                           0.1601471
#>              Epidish_CBSX.Vanderbilt.scRNAseq_Myeloid.cells
#> Sample_12929                                     0.13233340
#> Sample_15467                                     0.03039942
#> Sample_13634                                     0.02663606
#> Sample_14428                                     0.05780211
#> Sample_11817                                     0.04827712
#> Sample_14958                                     0.15029270
#>              Epidish_CBSX.Vanderbilt.scRNAseq_Mural.cells
#> Sample_12929                                  0.032416683
#> Sample_15467                                  0.018875502
#> Sample_13634                                  0.001922220
#> Sample_14428                                  0.029337208
#> Sample_11817                                  0.005032245
#> Sample_14958                                  0.132800694
#>              Epidish_CBSX.Vanderbilt.scRNAseq_T.cells.proliferative
#> Sample_12929                                             0.01878716
#> Sample_15467                                             0.01684536
#> Sample_13634                                             0.03329930
#> Sample_14428                                             0.01230539
#> Sample_11817                                             0.12855488
#> Sample_14958                                             0.02128868
#>              CBSX_CBSX.Vanderbilt.scRNAseq_T.cells.regulatory
#> Sample_12929                                        0.3029336
#> Sample_15467                                        0.1331767
#> Sample_13634                                        0.1659131
#> Sample_14428                                        0.1435287
#> Sample_11817                                        0.3002211
#> Sample_14958                                        0.1619405
#>              CBSX_CBSX.Vanderbilt.scRNAseq_Myeloid.cells
#> Sample_12929                                  0.12944581
#> Sample_15467                                  0.03317239
#> Sample_13634                                  0.02310116
#> Sample_14428                                  0.05779024
#> Sample_11817                                  0.04722874
#> Sample_14958                                  0.15005271
#>              CBSX_CBSX.Vanderbilt.scRNAseq_Mural.cells
#> Sample_12929                               0.021637078
#> Sample_15467                               0.015136317
#> Sample_13634                               0.001272230
#> Sample_14428                               0.021699667
#> Sample_11817                               0.004575455
#> Sample_14958                               0.134710798
#>              CBSX_CBSX.Vanderbilt.scRNAseq_T.cells.proliferative
#> Sample_12929                                          0.01618127
#> Sample_15467                                          0.01849070
#> Sample_13634                                          0.01938650
#> Sample_14428                                          0.01034595
#> Sample_11817                                          0.10357944
#> Sample_14958                                          0.01912456
#>              DWLS_CBSX.Vanderbilt.scRNAseq_T.cells.regulatory
#> Sample_12929                                       0.20947209
#> Sample_15467                                       0.08623451
#> Sample_13634                                       0.12351326
#> Sample_14428                                       0.10091835
#> Sample_11817                                       0.23283294
#> Sample_14958                                       0.11146950
#>              DWLS_CBSX.Vanderbilt.scRNAseq_Myeloid.cells
#> Sample_12929                                  0.25480757
#> Sample_15467                                  0.05568283
#> Sample_13634                                  0.05421637
#> Sample_14428                                  0.11220246
#> Sample_11817                                  0.09652651
#> Sample_14958                                  0.28896478
#>              DWLS_CBSX.Vanderbilt.scRNAseq_Mural.cells
#> Sample_12929                               0.039370764
#> Sample_15467                               0.019837526
#> Sample_13634                               0.002901562
#> Sample_14428                               0.037128989
#> Sample_11817                               0.005888162
#> Sample_14958                               0.170846972
#>              DWLS_CBSX.Vanderbilt.scRNAseq_T.cells.proliferative
#> Sample_12929                                         0.012616395
#> Sample_15467                                         0.010639218
#> Sample_13634                                         0.024021193
#> Sample_14428                                         0.008219412
#> Sample_11817                                         0.098326395
#> Sample_14958                                         0.016138494
#>              DeconRNASeq_DWLS.Vanderbilt.scRNAseq_T.cells.regulatory
#> Sample_12929                                              0.11016684
#> Sample_15467                                              0.00000000
#> Sample_13634                                              0.01548874
#> Sample_14428                                              0.00000000
#> Sample_11817                                              0.06297299
#> Sample_14958                                              0.00000000
#>              DeconRNASeq_DWLS.Vanderbilt.scRNAseq_Myeloid.cells
#> Sample_12929                                         0.23512149
#> Sample_15467                                         0.02876263
#> Sample_13634                                         0.03761943
#> Sample_14428                                         0.10255844
#> Sample_11817                                         0.09818968
#> Sample_14958                                         0.24071565
#>              DeconRNASeq_DWLS.Vanderbilt.scRNAseq_Mural.cells
#> Sample_12929                                         0.000000
#> Sample_15467                                         0.000000
#> Sample_13634                                         0.000000
#> Sample_14428                                         0.000000
#> Sample_11817                                         0.000000
#> Sample_14958                                         0.199031
#>              DeconRNASeq_DWLS.Vanderbilt.scRNAseq_T.cells.proliferative
#> Sample_12929                                                  0.0000000
#> Sample_15467                                                  0.0000000
#> Sample_13634                                                  0.0000000
#> Sample_14428                                                  0.0000000
#> Sample_11817                                                  0.1216792
#> Sample_14958                                                  0.0000000
#>              Epidish_DWLS.Vanderbilt.scRNAseq_T.cells.regulatory
#> Sample_12929                                          0.18814707
#> Sample_15467                                          0.03788838
#> Sample_13634                                          0.05281828
#> Sample_14428                                          0.07719813
#> Sample_11817                                          0.10321936
#> Sample_14958                                          0.13718759
#>              Epidish_DWLS.Vanderbilt.scRNAseq_Myeloid.cells
#> Sample_12929                                     0.14862598
#> Sample_15467                                     0.03903983
#> Sample_13634                                     0.03347209
#> Sample_14428                                     0.07879812
#> Sample_11817                                     0.07111798
#> Sample_14958                                     0.18759997
#>              Epidish_DWLS.Vanderbilt.scRNAseq_Mural.cells
#> Sample_12929                                  0.024172649
#> Sample_15467                                  0.014567754
#> Sample_13634                                  0.000000000
#> Sample_14428                                  0.002948833
#> Sample_11817                                  0.007108742
#> Sample_14958                                  0.135353874
#>              Epidish_DWLS.Vanderbilt.scRNAseq_T.cells.proliferative
#> Sample_12929                                            0.006918890
#> Sample_15467                                            0.007175462
#> Sample_13634                                            0.005948534
#> Sample_14428                                            0.000000000
#> Sample_11817                                            0.072673568
#> Sample_14958                                            0.004257860
#>              CBSX_DWLS.Vanderbilt.scRNAseq_T.cells.regulatory
#> Sample_12929                                       0.19544270
#> Sample_15467                                       0.03432485
#> Sample_13634                                       0.05629804
#> Sample_14428                                       0.05918596
#> Sample_11817                                       0.09501829
#> Sample_14958                                       0.10826621
#>              CBSX_DWLS.Vanderbilt.scRNAseq_Myeloid.cells
#> Sample_12929                                  0.15800640
#> Sample_15467                                  0.04240817
#> Sample_13634                                  0.03037984
#> Sample_14428                                  0.07539816
#> Sample_11817                                  0.06500273
#> Sample_14958                                  0.19244727
#>              CBSX_DWLS.Vanderbilt.scRNAseq_Mural.cells
#> Sample_12929                              0.0211293696
#> Sample_15467                              0.0000000000
#> Sample_13634                              0.0002545361
#> Sample_14428                              0.0000000000
#> Sample_11817                              0.0074106977
#> Sample_14958                              0.1413642855
#>              CBSX_DWLS.Vanderbilt.scRNAseq_T.cells.proliferative
#> Sample_12929                                         0.000000000
#> Sample_15467                                         0.000000000
#> Sample_13634                                         0.014745789
#> Sample_14428                                         0.000000000
#> Sample_11817                                         0.079393770
#> Sample_14958                                         0.001628136
#>              DWLS_DWLS.Vanderbilt.scRNAseq_T.cells.regulatory
#> Sample_12929                                       0.14495264
#> Sample_15467                                       0.02888326
#> Sample_13634                                       0.04839802
#> Sample_14428                                       0.06205411
#> Sample_11817                                       0.09289221
#> Sample_14958                                       0.10557436
#>              DWLS_DWLS.Vanderbilt.scRNAseq_Myeloid.cells
#> Sample_12929                                  0.20199813
#> Sample_15467                                  0.05805515
#> Sample_13634                                  0.05278984
#> Sample_14428                                  0.09490808
#> Sample_11817                                  0.09846717
#> Sample_14958                                  0.23560710
#>              DWLS_DWLS.Vanderbilt.scRNAseq_Mural.cells
#> Sample_12929                               0.040118979
#> Sample_15467                               0.020661578
#> Sample_13634                               0.000000000
#> Sample_14428                               0.003429951
#> Sample_11817                               0.006155154
#> Sample_14958                               0.194592135
#>              DWLS_DWLS.Vanderbilt.scRNAseq_T.cells.proliferative
#> Sample_12929                                         0.006787606
#> Sample_15467                                         0.003561155
#> Sample_13634                                         0.001472813
#> Sample_14428                                         0.000000000
#> Sample_11817                                         0.071675328
#> Sample_14958                                         0.007855032
#>              DeconRNASeq_MOMF.Vanderbilt.scRNAseq_T.cells.regulatory
#> Sample_12929                                                       0
#> Sample_15467                                                       0
#> Sample_13634                                                       0
#> Sample_14428                                                       0
#> Sample_11817                                                       0
#> Sample_14958                                                       0
#>              DeconRNASeq_MOMF.Vanderbilt.scRNAseq_Myeloid.cells
#> Sample_12929                                         0.11663363
#> Sample_15467                                         0.00000000
#> Sample_13634                                         0.00000000
#> Sample_14428                                         0.01748413
#> Sample_11817                                         0.03659651
#> Sample_14958                                         0.15381906
#>              DeconRNASeq_MOMF.Vanderbilt.scRNAseq_Mural.cells
#> Sample_12929                                        0.0000000
#> Sample_15467                                        0.0000000
#> Sample_13634                                        0.0000000
#> Sample_14428                                        0.0000000
#> Sample_11817                                        0.0000000
#> Sample_14958                                        0.1225844
#>              DeconRNASeq_MOMF.Vanderbilt.scRNAseq_T.cells.proliferative
#> Sample_12929                                                          0
#> Sample_15467                                                          0
#> Sample_13634                                                          0
#> Sample_14428                                                          0
#> Sample_11817                                                          0
#> Sample_14958                                                          0
#>              Epidish_MOMF.Vanderbilt.scRNAseq_T.cells.regulatory
#> Sample_12929                                         0.038463193
#> Sample_15467                                         0.000000000
#> Sample_13634                                         0.000000000
#> Sample_14428                                         0.002708607
#> Sample_11817                                         0.012810349
#> Sample_14958                                         0.014023188
#>              Epidish_MOMF.Vanderbilt.scRNAseq_Myeloid.cells
#> Sample_12929                                     0.25380510
#> Sample_15467                                     0.05239886
#> Sample_13634                                     0.12684406
#> Sample_14428                                     0.05904098
#> Sample_11817                                     0.05202178
#> Sample_14958                                     0.15028163
#>              Epidish_MOMF.Vanderbilt.scRNAseq_Mural.cells
#> Sample_12929                                 0.1234623985
#> Sample_15467                                 0.0629121256
#> Sample_13634                                 0.0000000000
#> Sample_14428                                 0.0009032092
#> Sample_11817                                 0.0133710785
#> Sample_14958                                 0.4735540808
#>              Epidish_MOMF.Vanderbilt.scRNAseq_T.cells.proliferative
#> Sample_12929                                              0.0000000
#> Sample_15467                                              0.0000000
#> Sample_13634                                              0.0000000
#> Sample_14428                                              0.0000000
#> Sample_11817                                              0.2190744
#> Sample_14958                                              0.0000000
#>              CBSX_MOMF.Vanderbilt.scRNAseq_T.cells.regulatory
#> Sample_12929                                      0.057307829
#> Sample_15467                                      0.000000000
#> Sample_13634                                      0.000000000
#> Sample_14428                                      0.005947311
#> Sample_11817                                      0.028377643
#> Sample_14958                                      0.021487335
#>              CBSX_MOMF.Vanderbilt.scRNAseq_Myeloid.cells
#> Sample_12929                                  0.38402152
#> Sample_15467                                  0.09986228
#> Sample_13634                                  0.13870194
#> Sample_14428                                  0.17483524
#> Sample_11817                                  0.09942054
#> Sample_14958                                  0.23164921
#>              CBSX_MOMF.Vanderbilt.scRNAseq_Mural.cells
#> Sample_12929                                0.12940658
#> Sample_15467                                0.11584083
#> Sample_13634                                0.00000000
#> Sample_14428                                0.04199161
#> Sample_11817                                0.00000000
#> Sample_14958                                0.43786256
#>              CBSX_MOMF.Vanderbilt.scRNAseq_T.cells.proliferative
#> Sample_12929                                         0.000000000
#> Sample_15467                                         0.000000000
#> Sample_13634                                         0.000000000
#> Sample_14428                                         0.000000000
#> Sample_11817                                         0.267185831
#> Sample_14958                                         0.000180479
#>              DWLS_MOMF.Vanderbilt.scRNAseq_T.cells.regulatory
#> Sample_12929                                       0.05753030
#> Sample_15467                                       0.00000000
#> Sample_13634                                       0.00000000
#> Sample_14428                                       0.01138085
#> Sample_11817                                       0.03787712
#> Sample_14958                                       0.04561199
#>              DWLS_MOMF.Vanderbilt.scRNAseq_Myeloid.cells
#> Sample_12929                                  0.15913515
#> Sample_15467                                  0.02934817
#> Sample_13634                                  0.02446240
#> Sample_14428                                  0.06689287
#> Sample_11817                                  0.06151705
#> Sample_14958                                  0.18292235
#>              DWLS_MOMF.Vanderbilt.scRNAseq_Mural.cells
#> Sample_12929                              0.0186377566
#> Sample_15467                              0.0088226791
#> Sample_13634                              0.0000000000
#> Sample_14428                              0.0003718955
#> Sample_11817                              0.0024182427
#> Sample_14958                              0.1343543419
#>              DWLS_MOMF.Vanderbilt.scRNAseq_T.cells.proliferative
#> Sample_12929                                         0.000000000
#> Sample_15467                                         0.000000000
#> Sample_13634                                         0.000000000
#> Sample_14428                                         0.000000000
#> Sample_11817                                         0.084242430
#> Sample_14958                                         0.001294676
#>              AutogeneS_Vanderbilt_Mural.cells
#> Sample_12929                      0.051998795
#> Sample_15467                      0.041596367
#> Sample_13634                      0.005190436
#> Sample_14428                      0.063277619
#> Sample_11817                      0.012500652
#> Sample_14958                      0.110246394
#>              AutogeneS_Vanderbilt_Myeloid.cells
#> Sample_12929                         0.09803409
#> Sample_15467                         0.06785874
#> Sample_13634                         0.06848324
#> Sample_14428                         0.07782836
#> Sample_11817                         0.08128467
#> Sample_14958                         0.08929118
#>              AutogeneS_Vanderbilt_T.cells.proliferative
#> Sample_12929                                 0.09147423
#> Sample_15467                                 0.10380037
#> Sample_13634                                 0.11842562
#> Sample_14428                                 0.08796909
#> Sample_11817                                 0.12954745
#> Sample_14958                                 0.07902115
#>              AutogeneS_Vanderbilt_T.cells.regulatory
#> Sample_12929                              0.08973076
#> Sample_15467                              0.09340894
#> Sample_13634                              0.10248124
#> Sample_14428                              0.07836314
#> Sample_11817                              0.10509620
#> Sample_14958                              0.07788381
#>              BayesPrism_Vanderbilt_T.cells.regulatory
#> Sample_12929                              0.107786347
#> Sample_15467                              0.000823808
#> Sample_13634                              0.001068608
#> Sample_14428                              0.036614660
#> Sample_11817                              0.035802318
#> Sample_14958                              0.096350176
#>              BayesPrism_Vanderbilt_Myeloid.cells
#> Sample_12929                          0.17660669
#> Sample_15467                          0.02955375
#> Sample_13634                          0.02087030
#> Sample_14428                          0.06148643
#> Sample_11817                          0.05915708
#> Sample_14958                          0.20250160
#>              BayesPrism_Vanderbilt_Mural.cells
#> Sample_12929                      0.0182993850
#> Sample_15467                      0.0089001292
#> Sample_13634                      0.0004907472
#> Sample_14428                      0.0118472655
#> Sample_11817                      0.0061655368
#> Sample_14958                      0.1985612077
#>              BayesPrism_Vanderbilt_T.cells.proliferative
#> Sample_12929                                1.335925e-04
#> Sample_15467                                8.604182e-05
#> Sample_13634                                1.294038e-03
#> Sample_14428                                2.299158e-05
#> Sample_11817                                1.394182e-01
#> Sample_14958                                1.398172e-04
#>              Bisque_Vanderbilt_Mural.cells Bisque_Vanderbilt_Myeloid.cells
#> Sample_12929                   0.005651334                     0.071305316
#> Sample_15467                   0.000000000                     0.000000000
#> Sample_13634                   0.000000000                     0.000000000
#> Sample_14428                   0.000000000                     0.002060977
#> Sample_11817                   0.000000000                     0.002127741
#> Sample_14958                   0.104547358                     0.083789428
#>              Bisque_Vanderbilt_T.cells.proliferative
#> Sample_12929                              0.00000000
#> Sample_15467                              0.00000000
#> Sample_13634                              0.00000000
#> Sample_14428                              0.00000000
#> Sample_11817                              0.01999624
#> Sample_14958                              0.00000000
#>              Bisque_Vanderbilt_T.cells.regulatory
#> Sample_12929                          0.066731902
#> Sample_15467                          0.000000000
#> Sample_13634                          0.000000000
#> Sample_14428                          0.000000000
#> Sample_11817                          0.020079493
#> Sample_14958                          0.009008387
#>              CPM_Vanderbilt_T.cells.regulatory CPM_Vanderbilt_Myeloid.cells
#> Sample_12929                        0.07864900                   0.07756185
#> Sample_15467                        0.07759760                   0.07369460
#> Sample_13634                        0.07872309                   0.07311986
#> Sample_14428                        0.07784863                   0.07464952
#> Sample_11817                        0.07895454                   0.07546384
#> Sample_14958                        0.07778900                   0.07847636
#>              CPM_Vanderbilt_Mural.cells CPM_Vanderbilt_T.cells.proliferative
#> Sample_12929                 0.06871054                           0.07023260
#> Sample_15467                 0.06791843                           0.06984449
#> Sample_13634                 0.06731927                           0.07027139
#> Sample_14428                 0.06931281                           0.06977977
#> Sample_11817                 0.06747253                           0.07410587
#> Sample_14958                 0.07328334                           0.06952174
#>              MuSic_Vanderbilt_T.cells.regulatory MuSic_Vanderbilt_Myeloid.cells
#> Sample_12929                          0.04814685                     0.13792689
#> Sample_15467                          0.00000000                     0.01892938
#> Sample_13634                          0.00000000                     0.01254660
#> Sample_14428                          0.00000000                     0.04694916
#> Sample_11817                          0.00000000                     0.04662957
#> Sample_14958                          0.02061328                     0.16663367
#>              MuSic_Vanderbilt_Mural.cells
#> Sample_12929                    0.0000000
#> Sample_15467                    0.0000000
#> Sample_13634                    0.0000000
#> Sample_14428                    0.0000000
#> Sample_11817                    0.0000000
#> Sample_14958                    0.0592722
#>              MuSic_Vanderbilt_T.cells.proliferative
#> Sample_12929                             0.00000000
#> Sample_15467                             0.00000000
#> Sample_13634                             0.00000000
#> Sample_14428                             0.00000000
#> Sample_11817                             0.09055202
#> Sample_14958                             0.00000000
#>              SCDC_Vanderbilt_T.cells.regulatory SCDC_Vanderbilt_Myeloid.cells
#> Sample_12929                                  0                    0.16760410
#> Sample_15467                                  0                    0.02714360
#> Sample_13634                                  0                    0.01706799
#> Sample_14428                                  0                    0.05527960
#> Sample_11817                                  0                    0.03442641
#> Sample_14958                                  0                    0.12956352
#>              SCDC_Vanderbilt_Mural.cells SCDC_Vanderbilt_T.cells.proliferative
#> Sample_12929                  0.00000000                             0.0000000
#> Sample_15467                  0.00000000                             0.0000000
#> Sample_13634                  0.00000000                             0.0000000
#> Sample_14428                  0.00000000                             0.0000000
#> Sample_11817                  0.00000000                             0.0925107
#> Sample_14958                  0.08041776                             0.0000000
```
