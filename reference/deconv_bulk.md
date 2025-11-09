# Bulk deconvolution matrix

A matrix with the cell type deconvolution features obtained from
compute.deconvolution() from the bulk RNAseq of Mariathasan et al.
(2018)

## Usage

``` r
deconv_bulk
```

## Format

Matrix with samples as rows and deconvolution features as columns

## Examples

``` r
data(deconv_bulk)
head(deconv_bulk)
#>                 Quantiseq_B.cells DeconRNASeq_BPRNACan_B.cells
#> SAM7f0d9cc7f001       0.050210988                   0.12730707
#> SAM4305ab968b90       0.008603929                   0.12937121
#> SAMcf018fee2acd       0.042857608                   0.12722785
#> SAMcc4675f394a1       0.025216439                   0.09446695
#> SAM49f9b2e57aa5       0.022668958                   0.11521148
#> SAM2e7aa8fa0ab3       0.012022510                   0.11793460
#>                 Epidish_BPRNACan_B.cells DeconRNASeq_BPRNACan3DProMet_B.cells
#> SAM7f0d9cc7f001             3.563950e-02                          0.074600081
#> SAM4305ab968b90             1.073465e-04                          0.079469135
#> SAMcf018fee2acd             1.708482e-02                          0.074560748
#> SAMcc4675f394a1             9.074189e-05                          0.001921238
#> SAM49f9b2e57aa5             1.900745e-02                          0.065863621
#> SAM2e7aa8fa0ab3             4.130289e-03                          0.063705401
#>                 Epidish_BPRNACan3DProMet_B.cells
#> SAM7f0d9cc7f001                      0.051634688
#> SAM4305ab968b90                      0.007359397
#> SAMcf018fee2acd                      0.024649003
#> SAMcc4675f394a1                      0.000000000
#> SAM49f9b2e57aa5                      0.025668504
#> SAM2e7aa8fa0ab3                      0.008716558
#>                 DeconRNASeq_BPRNACanProMet_B.cells
#> SAM7f0d9cc7f001                        0.077084903
#> SAM4305ab968b90                        0.089485917
#> SAMcf018fee2acd                        0.079894796
#> SAMcc4675f394a1                        0.003895105
#> SAM49f9b2e57aa5                        0.074591627
#> SAM2e7aa8fa0ab3                        0.066830620
#>                 Epidish_BPRNACanProMet_B.cells
#> SAM7f0d9cc7f001                    0.061927146
#> SAM4305ab968b90                    0.013455460
#> SAMcf018fee2acd                    0.029724100
#> SAMcc4675f394a1                    0.002167176
#> SAM49f9b2e57aa5                    0.032688442
#> SAM2e7aa8fa0ab3                    0.011090919
#>                 DeconRNASeq_CBSX.HNSCC.scRNAseq_B.cells
#> SAM7f0d9cc7f001                               0.1228965
#> SAM4305ab968b90                               0.1237223
#> SAMcf018fee2acd                               0.1443982
#> SAMcc4675f394a1                               0.1312310
#> SAM49f9b2e57aa5                               0.2134935
#> SAM2e7aa8fa0ab3                               0.2153588
#>                 Epidish_CBSX.HNSCC.scRNAseq_B.cells
#> SAM7f0d9cc7f001                         0.025626151
#> SAM4305ab968b90                         0.000000000
#> SAMcf018fee2acd                         0.080914523
#> SAMcc4675f394a1                         0.001434758
#> SAM49f9b2e57aa5                         0.137032856
#> SAM2e7aa8fa0ab3                         0.282602048
#>                 DeconRNASeq_CBSX.Melanoma.scRNAseq_B.cells
#> SAM7f0d9cc7f001                                 0.09589523
#> SAM4305ab968b90                                 0.11643874
#> SAMcf018fee2acd                                 0.10175787
#> SAMcc4675f394a1                                 0.09048480
#> SAM49f9b2e57aa5                                 0.14838878
#> SAM2e7aa8fa0ab3                                 0.15776522
#>                 Epidish_CBSX.Melanoma.scRNAseq_B.cells
#> SAM7f0d9cc7f001                            0.066233918
#> SAM4305ab968b90                            0.008756584
#> SAMcf018fee2acd                            0.009133098
#> SAMcc4675f394a1                            0.000000000
#> SAM49f9b2e57aa5                            0.036205984
#> SAM2e7aa8fa0ab3                            0.005377105
#>                 DeconRNASeq_CBSX.NSCLC.PBMCs.scRNAseq_B.cells
#> SAM7f0d9cc7f001                                     0.3574003
#> SAM4305ab968b90                                     0.3949259
#> SAMcf018fee2acd                                     0.3881010
#> SAMcc4675f394a1                                     0.3250339
#> SAM49f9b2e57aa5                                     0.3592329
#> SAM2e7aa8fa0ab3                                     0.3842798
#>                 Epidish_CBSX.NSCLC.PBMCs.scRNAseq_B.cells
#> SAM7f0d9cc7f001                                 0.9270601
#> SAM4305ab968b90                                 0.7335563
#> SAMcf018fee2acd                                 0.8704203
#> SAMcc4675f394a1                                 0.7806137
#> SAM49f9b2e57aa5                                 0.7666496
#> SAM2e7aa8fa0ab3                                 0.9091358
#>                 DeconRNASeq_CCLE.TIL10_B.cells Epidish_CCLE.TIL10_B.cells
#> SAM7f0d9cc7f001                     0.09479171                 0.00432432
#> SAM4305ab968b90                     0.08913280                 0.00000000
#> SAMcf018fee2acd                     0.08813311                 0.00000000
#> SAMcc4675f394a1                     0.12318305                 0.00000000
#> SAM49f9b2e57aa5                     0.10906816                 0.00000000
#> SAM2e7aa8fa0ab3                     0.09201921                 0.00000000
#>                 DeconRNASeq_TIL10_B.cells Epidish_TIL10_B.cells
#> SAM7f0d9cc7f001                 0.1233515                     0
#> SAM4305ab968b90                 0.1430621                     0
#> SAMcf018fee2acd                 0.1202673                     0
#> SAMcc4675f394a1                 0.1465164                     0
#> SAM49f9b2e57aa5                 0.1548673                     0
#> SAM2e7aa8fa0ab3                 0.1363611                     0
#>                 DWLS_BPRNACan_B.cells DWLS_BPRNACan3DProMet_B.cells
#> SAM7f0d9cc7f001           0.036380235                   0.082113616
#> SAM4305ab968b90           0.000000000                   0.006740926
#> SAMcf018fee2acd           0.014454504                   0.027725394
#> SAMcc4675f394a1           0.002439566                   0.002995142
#> SAM49f9b2e57aa5           0.015003689                   0.029905266
#> SAM2e7aa8fa0ab3           0.005002816                   0.012872153
#>                 DWLS_BPRNACanProMet_B.cells DWLS_CBSX.HNSCC.scRNAseq_B.cells
#> SAM7f0d9cc7f001                 0.099040918                        0.1166403
#> SAM4305ab968b90                 0.009802299                        0.0000000
#> SAMcf018fee2acd                 0.037233606                        0.2845757
#> SAMcc4675f394a1                 0.007154637                        0.0000000
#> SAM49f9b2e57aa5                 0.043583721                        0.4125924
#> SAM2e7aa8fa0ab3                 0.014245233                        0.6063532
#>                 DWLS_CBSX.Melanoma.scRNAseq_B.cells
#> SAM7f0d9cc7f001                        0.1213991261
#> SAM4305ab968b90                        0.0000000000
#> SAMcf018fee2acd                        0.0000000000
#> SAMcc4675f394a1                        0.0000000000
#> SAM49f9b2e57aa5                        0.0577397017
#> SAM2e7aa8fa0ab3                        0.0002493709
#>                 DWLS_CBSX.NSCLC.PBMCs.scRNAseq_B.cells DWLS_CCLE.TIL10_B.cells
#> SAM7f0d9cc7f001                              0.9294624            0.0000000000
#> SAM4305ab968b90                              0.6502671            0.0000000000
#> SAMcf018fee2acd                              0.8206030            0.0008377193
#> SAMcc4675f394a1                              0.6808452            0.0000000000
#> SAM49f9b2e57aa5                              0.8696199            0.0016930444
#> SAM2e7aa8fa0ab3                              0.7149709            0.0014282883
#>                 DWLS_TIL10_B.cells CBSX_BPRNACan_B.cells
#> SAM7f0d9cc7f001                  0          0.0268574443
#> SAM4305ab968b90                  0          0.0002625395
#> SAMcf018fee2acd                  0          0.0117017235
#> SAMcc4675f394a1                  0          0.0000000000
#> SAM49f9b2e57aa5                  0          0.0128700566
#> SAM2e7aa8fa0ab3                  0          0.0026788330
#>                 CBSX_BPRNACan3DProMet_B.cells CBSX_BPRNACanProMet_B.cells
#> SAM7f0d9cc7f001                   0.053311989                6.503006e-02
#> SAM4305ab968b90                   0.001824221                5.271856e-03
#> SAMcf018fee2acd                   0.022139355                2.506626e-02
#> SAMcc4675f394a1                   0.000000000                2.859268e-05
#> SAM49f9b2e57aa5                   0.019103605                3.313647e-02
#> SAM2e7aa8fa0ab3                   0.003678276                3.753517e-03
#>                 CBSX_CBSX.HNSCC.scRNAseq_B.cells
#> SAM7f0d9cc7f001                      0.026470635
#> SAM4305ab968b90                      0.000000000
#> SAMcf018fee2acd                      0.081951704
#> SAMcc4675f394a1                      0.005175019
#> SAM49f9b2e57aa5                      0.113686186
#> SAM2e7aa8fa0ab3                      0.283804619
#>                 CBSX_CBSX.Melanoma.scRNAseq_B.cells
#> SAM7f0d9cc7f001                          0.03742227
#> SAM4305ab968b90                          0.00000000
#> SAMcf018fee2acd                          0.00000000
#> SAMcc4675f394a1                          0.00000000
#> SAM49f9b2e57aa5                          0.02164871
#> SAM2e7aa8fa0ab3                          0.00000000
#>                 CBSX_CBSX.NSCLC.PBMCs.scRNAseq_B.cells CBSX_CCLE.TIL10_B.cells
#> SAM7f0d9cc7f001                              0.7894881             0.009153725
#> SAM4305ab968b90                              0.8017509             0.009178479
#> SAMcf018fee2acd                              0.8642097             0.000000000
#> SAMcc4675f394a1                              0.7403158             0.000000000
#> SAM49f9b2e57aa5                              0.8290278             0.001887849
#> SAM2e7aa8fa0ab3                              0.6040372             0.016370300
#>                 CBSX_TIL10_B.cells DeconRNASeq_LM22_B.naive.cells
#> SAM7f0d9cc7f001                  0                     0.22200799
#> SAM4305ab968b90                  0                     0.08149786
#> SAMcf018fee2acd                  0                     0.08255508
#> SAMcc4675f394a1                  0                     0.11196381
#> SAM49f9b2e57aa5                  0                     0.19081659
#> SAM2e7aa8fa0ab3                  0                     0.14424239
#>                 Epidish_LM22_B.naive.cells DWLS_LM22_B.naive.cells
#> SAM7f0d9cc7f001                 0.07807449              0.04386876
#> SAM4305ab968b90                 0.14885959              0.06050735
#> SAMcf018fee2acd                 0.01677318              0.03015016
#> SAMcc4675f394a1                 0.03344129              0.00000000
#> SAM49f9b2e57aa5                 0.15756858              0.17770542
#> SAM2e7aa8fa0ab3                 0.03239494              0.04378562
#>                 CBSX_LM22_B.naive.cells DeconRNASeq_LM22_B.memory.cells
#> SAM7f0d9cc7f001              0.05019440                               0
#> SAM4305ab968b90              0.07287193                               0
#> SAMcf018fee2acd              0.02523554                               0
#> SAMcc4675f394a1              0.00000000                               0
#> SAM49f9b2e57aa5              0.20246576                               0
#> SAM2e7aa8fa0ab3              0.03064947                               0
#>                 Epidish_LM22_B.memory.cells DWLS_LM22_B.memory.cells
#> SAM7f0d9cc7f001                  0.09204022               0.10921697
#> SAM4305ab968b90                  0.00000000               0.00000000
#> SAMcf018fee2acd                  0.02237843               0.00319934
#> SAMcc4675f394a1                  0.00000000               0.00000000
#> SAM49f9b2e57aa5                  0.01449040               0.04507033
#> SAM2e7aa8fa0ab3                  0.00000000               0.00000000
#>                 CBSX_LM22_B.memory.cells
#> SAM7f0d9cc7f001               0.17006058
#> SAM4305ab968b90               0.00000000
#> SAMcf018fee2acd               0.01537247
#> SAMcc4675f394a1               0.00000000
#> SAM49f9b2e57aa5               0.00000000
#> SAM2e7aa8fa0ab3               0.00000000
#>                 DeconRNASeq_CBSX.HNSCC.scRNAseq_Macrophages.cells
#> SAM7f0d9cc7f001                                        0.04932691
#> SAM4305ab968b90                                        0.04142978
#> SAMcf018fee2acd                                        0.07250694
#> SAMcc4675f394a1                                        0.05909018
#> SAM49f9b2e57aa5                                        0.03851747
#> SAM2e7aa8fa0ab3                                        0.04703351
#>                 Epidish_CBSX.HNSCC.scRNAseq_Macrophages.cells
#> SAM7f0d9cc7f001                                    0.02084187
#> SAM4305ab968b90                                    0.00000000
#> SAMcf018fee2acd                                    0.05867367
#> SAMcc4675f394a1                                    0.06151472
#> SAM49f9b2e57aa5                                    0.00000000
#> SAM2e7aa8fa0ab3                                    0.02469197
#>                 DeconRNASeq_CBSX.Melanoma.scRNAseq_Macrophages.cells
#> SAM7f0d9cc7f001                                           0.09054257
#> SAM4305ab968b90                                           0.13016251
#> SAMcf018fee2acd                                           0.13702906
#> SAMcc4675f394a1                                           0.09526639
#> SAM49f9b2e57aa5                                           0.07679836
#> SAM2e7aa8fa0ab3                                           0.04918923
#>                 Epidish_CBSX.Melanoma.scRNAseq_Macrophages.cells
#> SAM7f0d9cc7f001                                       0.06354379
#> SAM4305ab968b90                                       0.16900265
#> SAMcf018fee2acd                                       0.21544643
#> SAMcc4675f394a1                                       0.09855208
#> SAM49f9b2e57aa5                                       0.08637205
#> SAM2e7aa8fa0ab3                                       0.08673941
#>                 DWLS_CBSX.HNSCC.scRNAseq_Macrophages.cells
#> SAM7f0d9cc7f001                                 0.03232704
#> SAM4305ab968b90                                 0.00000000
#> SAMcf018fee2acd                                 0.05610745
#> SAMcc4675f394a1                                 0.07638105
#> SAM49f9b2e57aa5                                 0.00000000
#> SAM2e7aa8fa0ab3                                 0.00756202
#>                 DWLS_CBSX.Melanoma.scRNAseq_Macrophages.cells
#> SAM7f0d9cc7f001                                     0.1587079
#> SAM4305ab968b90                                     0.3105012
#> SAMcf018fee2acd                                     0.4551175
#> SAMcc4675f394a1                                     0.2440977
#> SAM49f9b2e57aa5                                     0.1882428
#> SAM2e7aa8fa0ab3                                     0.2295739
#>                 CBSX_CBSX.HNSCC.scRNAseq_Macrophages.cells
#> SAM7f0d9cc7f001                                 0.02120099
#> SAM4305ab968b90                                 0.00000000
#> SAMcf018fee2acd                                 0.05544792
#> SAMcc4675f394a1                                 0.05078828
#> SAM49f9b2e57aa5                                 0.02476562
#> SAM2e7aa8fa0ab3                                 0.02165093
#>                 CBSX_CBSX.Melanoma.scRNAseq_Macrophages.cells
#> SAM7f0d9cc7f001                                    0.07209887
#> SAM4305ab968b90                                    0.13131014
#> SAMcf018fee2acd                                    0.21167284
#> SAMcc4675f394a1                                    0.09090779
#> SAM49f9b2e57aa5                                    0.11259995
#> SAM2e7aa8fa0ab3                                    0.08111223
#>                 DeconRNASeq_BPRNACan_Macrophages.M0
#> SAM7f0d9cc7f001                         0.027994399
#> SAM4305ab968b90                         0.008386654
#> SAMcf018fee2acd                         0.028393247
#> SAMcc4675f394a1                         0.025815486
#> SAM49f9b2e57aa5                         0.024021881
#> SAM2e7aa8fa0ab3                         0.000000000
#>                 Epidish_BPRNACan_Macrophages.M0
#> SAM7f0d9cc7f001                    0.000000e+00
#> SAM4305ab968b90                    0.000000e+00
#> SAMcf018fee2acd                    4.395661e-05
#> SAMcc4675f394a1                    0.000000e+00
#> SAM49f9b2e57aa5                    3.629821e-04
#> SAM2e7aa8fa0ab3                    0.000000e+00
#>                 DeconRNASeq_BPRNACan3DProMet_Macrophages.M0
#> SAM7f0d9cc7f001                                  0.01475592
#> SAM4305ab968b90                                  0.00000000
#> SAMcf018fee2acd                                  0.01430916
#> SAMcc4675f394a1                                  0.01192612
#> SAM49f9b2e57aa5                                  0.00892975
#> SAM2e7aa8fa0ab3                                  0.00000000
#>                 Epidish_BPRNACan3DProMet_Macrophages.M0
#> SAM7f0d9cc7f001                            0.0000000000
#> SAM4305ab968b90                            0.0001578082
#> SAMcf018fee2acd                            0.0002703305
#> SAMcc4675f394a1                            0.0000000000
#> SAM49f9b2e57aa5                            0.0004626976
#> SAM2e7aa8fa0ab3                            0.0000000000
#>                 DeconRNASeq_BPRNACanProMet_Macrophages.M0
#> SAM7f0d9cc7f001                                0.01847098
#> SAM4305ab968b90                                0.00000000
#> SAMcf018fee2acd                                0.01764295
#> SAMcc4675f394a1                                0.01663120
#> SAM49f9b2e57aa5                                0.01608167
#> SAM2e7aa8fa0ab3                                0.00000000
#>                 Epidish_BPRNACanProMet_Macrophages.M0
#> SAM7f0d9cc7f001                          0.0000000000
#> SAM4305ab968b90                          0.0010825139
#> SAMcf018fee2acd                          0.0007596935
#> SAMcc4675f394a1                          0.0000000000
#> SAM49f9b2e57aa5                          0.0009299892
#> SAM2e7aa8fa0ab3                          0.0000000000
#>                 DeconRNASeq_LM22_Macrophages.M0 Epidish_LM22_Macrophages.M0
#> SAM7f0d9cc7f001                      0.06266741                  0.03458268
#> SAM4305ab968b90                      0.13731085                  0.00000000
#> SAMcf018fee2acd                      0.15828673                  0.12587020
#> SAMcc4675f394a1                      0.11112788                  0.23688839
#> SAM49f9b2e57aa5                      0.10389749                  0.03295175
#> SAM2e7aa8fa0ab3                      0.11246561                  0.07925979
#>                 DWLS_BPRNACan_Macrophages.M0
#> SAM7f0d9cc7f001                  0.002303352
#> SAM4305ab968b90                  0.000000000
#> SAMcf018fee2acd                  0.005098964
#> SAMcc4675f394a1                  0.001473074
#> SAM49f9b2e57aa5                  0.006085792
#> SAM2e7aa8fa0ab3                  0.000000000
#>                 DWLS_BPRNACan3DProMet_Macrophages.M0
#> SAM7f0d9cc7f001                         0.0017488597
#> SAM4305ab968b90                         0.0000000000
#> SAMcf018fee2acd                         0.0051837357
#> SAMcc4675f394a1                         0.0006084742
#> SAM49f9b2e57aa5                         0.0052075940
#> SAM2e7aa8fa0ab3                         0.0000000000
#>                 DWLS_BPRNACanProMet_Macrophages.M0 DWLS_LM22_Macrophages.M0
#> SAM7f0d9cc7f001                        0.002613764               0.06691313
#> SAM4305ab968b90                        0.018570008               0.01945229
#> SAMcf018fee2acd                        0.004960789               0.17307234
#> SAMcc4675f394a1                        0.000000000               0.22256684
#> SAM49f9b2e57aa5                        0.006259882               0.04993736
#> SAM2e7aa8fa0ab3                        0.000000000               0.07488416
#>                 CBSX_BPRNACan_Macrophages.M0
#> SAM7f0d9cc7f001                 0.0025832263
#> SAM4305ab968b90                 0.0001323447
#> SAMcf018fee2acd                 0.0006412060
#> SAMcc4675f394a1                 0.0004589866
#> SAM49f9b2e57aa5                 0.0006513166
#> SAM2e7aa8fa0ab3                 0.0000000000
#>                 CBSX_BPRNACan3DProMet_Macrophages.M0
#> SAM7f0d9cc7f001                         0.0028965270
#> SAM4305ab968b90                         0.0001735021
#> SAMcf018fee2acd                         0.0007064447
#> SAMcc4675f394a1                         0.0000000000
#> SAM49f9b2e57aa5                         0.0006586961
#> SAM2e7aa8fa0ab3                         0.0000000000
#>                 CBSX_BPRNACanProMet_Macrophages.M0 CBSX_LM22_Macrophages.M0
#> SAM7f0d9cc7f001                       0.0000000000               0.04634511
#> SAM4305ab968b90                       0.0009745591               0.01932961
#> SAMcf018fee2acd                       0.0001075361               0.11400714
#> SAMcc4675f394a1                       0.0000000000               0.19177044
#> SAM49f9b2e57aa5                       0.0001886322               0.05864097
#> SAM2e7aa8fa0ab3                       0.0000000000               0.07631753
#>                 Quantiseq_Macrophages.M1 DeconRNASeq_BPRNACan_Macrophages.M1
#> SAM7f0d9cc7f001              0.024261967                          0.08610919
#> SAM4305ab968b90              0.000000000                          0.10628172
#> SAMcf018fee2acd              0.000000000                          0.08698983
#> SAMcc4675f394a1              0.005849826                          0.06995662
#> SAM49f9b2e57aa5              0.000000000                          0.08174149
#> SAM2e7aa8fa0ab3              0.000000000                          0.10223870
#>                 Epidish_BPRNACan_Macrophages.M1
#> SAM7f0d9cc7f001                    3.387422e-04
#> SAM4305ab968b90                    0.000000e+00
#> SAMcf018fee2acd                    0.000000e+00
#> SAMcc4675f394a1                    1.333769e-03
#> SAM49f9b2e57aa5                    0.000000e+00
#> SAM2e7aa8fa0ab3                    5.045961e-05
#>                 DeconRNASeq_BPRNACan3DProMet_Macrophages.M1
#> SAM7f0d9cc7f001                                   0.1375581
#> SAM4305ab968b90                                   0.1470234
#> SAMcf018fee2acd                                   0.1371288
#> SAMcc4675f394a1                                   0.1260597
#> SAM49f9b2e57aa5                                   0.1288714
#> SAM2e7aa8fa0ab3                                   0.1391059
#>                 Epidish_BPRNACan3DProMet_Macrophages.M1
#> SAM7f0d9cc7f001                            0.0004185453
#> SAM4305ab968b90                            0.0000000000
#> SAMcf018fee2acd                            0.0000000000
#> SAMcc4675f394a1                            0.0014597204
#> SAM49f9b2e57aa5                            0.0000000000
#> SAM2e7aa8fa0ab3                            0.0000620991
#>                 DeconRNASeq_BPRNACanProMet_Macrophages.M1
#> SAM7f0d9cc7f001                                 0.1293349
#> SAM4305ab968b90                                 0.1372509
#> SAMcf018fee2acd                                 0.1269982
#> SAMcc4675f394a1                                 0.1174678
#> SAM49f9b2e57aa5                                 0.1162783
#> SAM2e7aa8fa0ab3                                 0.1323608
#>                 Epidish_BPRNACanProMet_Macrophages.M1
#> SAM7f0d9cc7f001                          4.015389e-05
#> SAM4305ab968b90                          0.000000e+00
#> SAMcf018fee2acd                          0.000000e+00
#> SAMcc4675f394a1                          7.821641e-04
#> SAM49f9b2e57aa5                          0.000000e+00
#> SAM2e7aa8fa0ab3                          0.000000e+00
#>                 DeconRNASeq_CCLE.TIL10_Macrophages.M1
#> SAM7f0d9cc7f001                            0.35023592
#> SAM4305ab968b90                            0.02548979
#> SAMcf018fee2acd                            0.28010046
#> SAMcc4675f394a1                            0.34152184
#> SAM49f9b2e57aa5                            0.05557486
#> SAM2e7aa8fa0ab3                            0.11199082
#>                 Epidish_CCLE.TIL10_Macrophages.M1
#> SAM7f0d9cc7f001                        0.10347675
#> SAM4305ab968b90                        0.00000000
#> SAMcf018fee2acd                        0.04238972
#> SAMcc4675f394a1                        0.11455431
#> SAM49f9b2e57aa5                        0.00000000
#> SAM2e7aa8fa0ab3                        0.05870060
#>                 DeconRNASeq_LM22_Macrophages.M1 Epidish_LM22_Macrophages.M1
#> SAM7f0d9cc7f001                      0.00000000                 0.000000000
#> SAM4305ab968b90                      0.07140198                 0.000000000
#> SAMcf018fee2acd                      0.03257394                 0.000000000
#> SAMcc4675f394a1                      0.03492150                 0.000000000
#> SAM49f9b2e57aa5                      0.04719671                 0.003465623
#> SAM2e7aa8fa0ab3                      0.07737779                 0.060097028
#>                 DeconRNASeq_TIL10_Macrophages.M1 Epidish_TIL10_Macrophages.M1
#> SAM7f0d9cc7f001                       0.42681828                    0.1960388
#> SAM4305ab968b90                       0.06911571                    0.0000000
#> SAMcf018fee2acd                       0.35716841                    0.1176216
#> SAMcc4675f394a1                       0.36554880                    0.3060761
#> SAM49f9b2e57aa5                       0.10526485                    0.0000000
#> SAM2e7aa8fa0ab3                       0.16705275                    0.4622038
#>                 DWLS_BPRNACan_Macrophages.M1
#> SAM7f0d9cc7f001                            0
#> SAM4305ab968b90                            0
#> SAMcf018fee2acd                            0
#> SAMcc4675f394a1                            0
#> SAM49f9b2e57aa5                            0
#> SAM2e7aa8fa0ab3                            0
#>                 DWLS_BPRNACan3DProMet_Macrophages.M1
#> SAM7f0d9cc7f001                                    0
#> SAM4305ab968b90                                    0
#> SAMcf018fee2acd                                    0
#> SAMcc4675f394a1                                    0
#> SAM49f9b2e57aa5                                    0
#> SAM2e7aa8fa0ab3                                    0
#>                 DWLS_BPRNACanProMet_Macrophages.M1
#> SAM7f0d9cc7f001                        0.000000000
#> SAM4305ab968b90                        0.000000000
#> SAMcf018fee2acd                        0.000000000
#> SAMcc4675f394a1                        0.003182723
#> SAM49f9b2e57aa5                        0.000000000
#> SAM2e7aa8fa0ab3                        0.000000000
#>                 DWLS_CCLE.TIL10_Macrophages.M1 DWLS_LM22_Macrophages.M1
#> SAM7f0d9cc7f001                     0.15436509              0.000000000
#> SAM4305ab968b90                     0.00000000              0.000000000
#> SAMcf018fee2acd                     0.02555603              0.000000000
#> SAMcc4675f394a1                     0.11653271              0.012561180
#> SAM49f9b2e57aa5                     0.00000000              0.005569976
#> SAM2e7aa8fa0ab3                     0.09015368              0.145155769
#>                 DWLS_TIL10_Macrophages.M1 CBSX_BPRNACan_Macrophages.M1
#> SAM7f0d9cc7f001                0.35174866                            0
#> SAM4305ab968b90                0.00000000                            0
#> SAMcf018fee2acd                0.02603301                            0
#> SAMcc4675f394a1                0.27071376                            0
#> SAM49f9b2e57aa5                0.09299969                            0
#> SAM2e7aa8fa0ab3                0.61411033                            0
#>                 CBSX_BPRNACan3DProMet_Macrophages.M1
#> SAM7f0d9cc7f001                          0.000000000
#> SAM4305ab968b90                          0.000000000
#> SAMcf018fee2acd                          0.000000000
#> SAMcc4675f394a1                          0.002389825
#> SAM49f9b2e57aa5                          0.000000000
#> SAM2e7aa8fa0ab3                          0.000000000
#>                 CBSX_BPRNACanProMet_Macrophages.M1
#> SAM7f0d9cc7f001                       0.0005713071
#> SAM4305ab968b90                       0.0000000000
#> SAMcf018fee2acd                       0.0000000000
#> SAMcc4675f394a1                       0.0031569945
#> SAM49f9b2e57aa5                       0.0000000000
#> SAM2e7aa8fa0ab3                       0.0000000000
#>                 CBSX_CCLE.TIL10_Macrophages.M1 CBSX_LM22_Macrophages.M1
#> SAM7f0d9cc7f001                    0.142221822              0.000000000
#> SAM4305ab968b90                    0.010621452              0.000000000
#> SAMcf018fee2acd                    0.014409362              0.000000000
#> SAMcc4675f394a1                    0.101247619              0.006703372
#> SAM49f9b2e57aa5                    0.005635027              0.009577312
#> SAM2e7aa8fa0ab3                    0.070992926              0.046674701
#>                 CBSX_TIL10_Macrophages.M1 Quantiseq_Macrophages.M2
#> SAM7f0d9cc7f001                 0.2918758               0.04255419
#> SAM4305ab968b90                 0.0000000               0.02354171
#> SAMcf018fee2acd                 0.1125917               0.09870767
#> SAMcc4675f394a1                 0.5875108               0.03366905
#> SAM49f9b2e57aa5                 0.0000000               0.01292400
#> SAM2e7aa8fa0ab3                 0.1720276               0.01781348
#>                 DeconRNASeq_BPRNACan_Macrophages.M2
#> SAM7f0d9cc7f001                           0.1307625
#> SAM4305ab968b90                           0.1398885
#> SAMcf018fee2acd                           0.1318713
#> SAMcc4675f394a1                           0.1141129
#> SAM49f9b2e57aa5                           0.1220610
#> SAM2e7aa8fa0ab3                           0.1289573
#>                 Epidish_BPRNACan_Macrophages.M2
#> SAM7f0d9cc7f001                    0.0001887924
#> SAM4305ab968b90                    0.0000000000
#> SAMcf018fee2acd                    0.0002880365
#> SAMcc4675f394a1                    0.0000000000
#> SAM49f9b2e57aa5                    0.0000000000
#> SAM2e7aa8fa0ab3                    0.0000000000
#>                 DeconRNASeq_BPRNACan3DProMet_Macrophages.M2
#> SAM7f0d9cc7f001                                   0.1853022
#> SAM4305ab968b90                                   0.1885421
#> SAMcf018fee2acd                                   0.1843019
#> SAMcc4675f394a1                                   0.1727004
#> SAM49f9b2e57aa5                                   0.1704670
#> SAM2e7aa8fa0ab3                                   0.1772120
#>                 Epidish_BPRNACan3DProMet_Macrophages.M2
#> SAM7f0d9cc7f001                            0.0002085931
#> SAM4305ab968b90                            0.0000000000
#> SAMcf018fee2acd                            0.0002861600
#> SAMcc4675f394a1                            0.0000000000
#> SAM49f9b2e57aa5                            0.0000000000
#> SAM2e7aa8fa0ab3                            0.0000000000
#>                 DeconRNASeq_BPRNACanProMet_Macrophages.M2
#> SAM7f0d9cc7f001                                 0.1858417
#> SAM4305ab968b90                                 0.1837226
#> SAMcf018fee2acd                                 0.1816951
#> SAMcc4675f394a1                                 0.1730774
#> SAM49f9b2e57aa5                                 0.1679860
#> SAM2e7aa8fa0ab3                                 0.1762989
#>                 Epidish_BPRNACanProMet_Macrophages.M2
#> SAM7f0d9cc7f001                          0.0002160989
#> SAM4305ab968b90                          0.0000000000
#> SAMcf018fee2acd                          0.0002783674
#> SAMcc4675f394a1                          0.0000000000
#> SAM49f9b2e57aa5                          0.0000000000
#> SAM2e7aa8fa0ab3                          0.0000000000
#>                 DeconRNASeq_CCLE.TIL10_Macrophages.M2
#> SAM7f0d9cc7f001                            0.02830864
#> SAM4305ab968b90                            0.08334035
#> SAMcf018fee2acd                            0.08451151
#> SAMcc4675f394a1                            0.01649599
#> SAM49f9b2e57aa5                            0.06892321
#> SAM2e7aa8fa0ab3                            0.06240585
#>                 Epidish_CCLE.TIL10_Macrophages.M2
#> SAM7f0d9cc7f001                       0.157593594
#> SAM4305ab968b90                       0.022082438
#> SAMcf018fee2acd                       0.120163970
#> SAMcc4675f394a1                       0.065934692
#> SAM49f9b2e57aa5                       0.005408858
#> SAM2e7aa8fa0ab3                       0.036687497
#>                 DeconRNASeq_TIL10_Macrophages.M2 Epidish_TIL10_Macrophages.M2
#> SAM7f0d9cc7f001                       0.05137795                   0.31100605
#> SAM4305ab968b90                       0.14771388                   0.29587423
#> SAMcf018fee2acd                       0.11761147                   0.08635246
#> SAMcc4675f394a1                       0.03787343                   0.08716274
#> SAM49f9b2e57aa5                       0.12383391                   0.02333727
#> SAM2e7aa8fa0ab3                       0.10106745                   0.11116081
#>                 DWLS_BPRNACan_Macrophages.M2
#> SAM7f0d9cc7f001                 0.0002349228
#> SAM4305ab968b90                 0.0000000000
#> SAMcf018fee2acd                 0.0052782052
#> SAMcc4675f394a1                 0.0006625274
#> SAM49f9b2e57aa5                 0.0000000000
#> SAM2e7aa8fa0ab3                 0.0000000000
#>                 DWLS_BPRNACan3DProMet_Macrophages.M2
#> SAM7f0d9cc7f001                         0.0100119120
#> SAM4305ab968b90                         0.0017344695
#> SAMcf018fee2acd                         0.0070570914
#> SAMcc4675f394a1                         0.0005231855
#> SAM49f9b2e57aa5                         0.0006013781
#> SAM2e7aa8fa0ab3                         0.0004286789
#>                 DWLS_BPRNACanProMet_Macrophages.M2
#> SAM7f0d9cc7f001                       0.0004292112
#> SAM4305ab968b90                       0.0000000000
#> SAMcf018fee2acd                       0.0085323678
#> SAMcc4675f394a1                       0.0008078611
#> SAM49f9b2e57aa5                       0.0000000000
#> SAM2e7aa8fa0ab3                       0.0000000000
#>                 DWLS_CCLE.TIL10_Macrophages.M2 DWLS_TIL10_Macrophages.M2
#> SAM7f0d9cc7f001                    0.104436193                0.16526788
#> SAM4305ab968b90                    0.013389249                0.15746835
#> SAMcf018fee2acd                    0.174652925                0.39472285
#> SAMcc4675f394a1                    0.012882222                0.00000000
#> SAM49f9b2e57aa5                    0.004940769                0.00142606
#> SAM2e7aa8fa0ab3                    0.002532487                0.01858152
#>                 CBSX_BPRNACan_Macrophages.M2
#> SAM7f0d9cc7f001                 0.000000e+00
#> SAM4305ab968b90                 0.000000e+00
#> SAMcf018fee2acd                 1.800060e-04
#> SAMcc4675f394a1                 6.682840e-05
#> SAM49f9b2e57aa5                 1.799779e-05
#> SAM2e7aa8fa0ab3                 0.000000e+00
#>                 CBSX_BPRNACan3DProMet_Macrophages.M2
#> SAM7f0d9cc7f001                         0.000000e+00
#> SAM4305ab968b90                         0.000000e+00
#> SAMcf018fee2acd                         1.935345e-04
#> SAMcc4675f394a1                         0.000000e+00
#> SAM49f9b2e57aa5                         1.525881e-05
#> SAM2e7aa8fa0ab3                         0.000000e+00
#>                 CBSX_BPRNACanProMet_Macrophages.M2
#> SAM7f0d9cc7f001                       0.0002222082
#> SAM4305ab968b90                       0.0000000000
#> SAMcf018fee2acd                       0.0002821489
#> SAMcc4675f394a1                       0.0000000000
#> SAM49f9b2e57aa5                       0.0000000000
#> SAM2e7aa8fa0ab3                       0.0000000000
#>                 CBSX_CCLE.TIL10_Macrophages.M2 CBSX_TIL10_Macrophages.M2
#> SAM7f0d9cc7f001                    0.039699845                0.16869098
#> SAM4305ab968b90                    0.008777602                0.04552310
#> SAMcf018fee2acd                    0.120193594                0.10553239
#> SAMcc4675f394a1                    0.014409259                0.08393194
#> SAM49f9b2e57aa5                    0.039841623                0.43019251
#> SAM2e7aa8fa0ab3                    0.055073768                0.24180598
#>                 DeconRNASeq_LM22_Macrophages.M2 Epidish_LM22_Macrophages.M2
#> SAM7f0d9cc7f001                     0.025825608                  0.08115124
#> SAM4305ab968b90                     0.000000000                  0.24987205
#> SAMcf018fee2acd                     0.027464529                  0.15675115
#> SAMcc4675f394a1                     0.081372076                  0.05867075
#> SAM49f9b2e57aa5                     0.000000000                  0.06333735
#> SAM2e7aa8fa0ab3                     0.004871071                  0.07661403
#>                 DWLS_LM22_Macrophages.M2 CBSX_LM22_Macrophages.M2
#> SAM7f0d9cc7f001               0.06218970               0.04996445
#> SAM4305ab968b90               0.16277004               0.15173430
#> SAMcf018fee2acd               0.11571848               0.21297169
#> SAMcc4675f394a1               0.06413972               0.07008905
#> SAM49f9b2e57aa5               0.04667151               0.00940865
#> SAM2e7aa8fa0ab3               0.03445278               0.05964796
#>                 Quantiseq_Monocytes DeconRNASeq_BPRNACan_Monocytes
#> SAM7f0d9cc7f001                   0                      0.1071899
#> SAM4305ab968b90                   0                      0.1023924
#> SAMcf018fee2acd                   0                      0.1041118
#> SAMcc4675f394a1                   0                      0.1092755
#> SAM49f9b2e57aa5                   0                      0.0964071
#> SAM2e7aa8fa0ab3                   0                      0.1040177
#>                 Epidish_BPRNACan_Monocytes
#> SAM7f0d9cc7f001                0.007723127
#> SAM4305ab968b90                0.001456189
#> SAMcf018fee2acd                0.015859509
#> SAMcc4675f394a1                0.017373087
#> SAM49f9b2e57aa5                0.005372694
#> SAM2e7aa8fa0ab3                0.003779825
#>                 DeconRNASeq_BPRNACan3DProMet_Monocytes
#> SAM7f0d9cc7f001                             0.10826023
#> SAM4305ab968b90                             0.09551774
#> SAMcf018fee2acd                             0.10384860
#> SAMcc4675f394a1                             0.11302181
#> SAM49f9b2e57aa5                             0.09432388
#> SAM2e7aa8fa0ab3                             0.10334477
#>                 Epidish_BPRNACan3DProMet_Monocytes
#> SAM7f0d9cc7f001                        0.015111561
#> SAM4305ab968b90                        0.001915069
#> SAMcf018fee2acd                        0.027840000
#> SAMcc4675f394a1                        0.014452073
#> SAM49f9b2e57aa5                        0.006480510
#> SAM2e7aa8fa0ab3                        0.008100573
#>                 DeconRNASeq_BPRNACanProMet_Monocytes
#> SAM7f0d9cc7f001                           0.09516898
#> SAM4305ab968b90                           0.08418712
#> SAMcf018fee2acd                           0.09178475
#> SAMcc4675f394a1                           0.09906743
#> SAM49f9b2e57aa5                           0.08126538
#> SAM2e7aa8fa0ab3                           0.08994167
#>                 Epidish_BPRNACanProMet_Monocytes
#> SAM7f0d9cc7f001                     0.0062192064
#> SAM4305ab968b90                     0.0008831197
#> SAMcf018fee2acd                     0.0144746017
#> SAMcc4675f394a1                     0.0084748841
#> SAM49f9b2e57aa5                     0.0030291790
#> SAM2e7aa8fa0ab3                     0.0038739188
#>                 DeconRNASeq_CBSX.NSCLC.PBMCs.scRNAseq_Monocytes
#> SAM7f0d9cc7f001                                       0.2833120
#> SAM4305ab968b90                                       0.2679940
#> SAMcf018fee2acd                                       0.2908829
#> SAMcc4675f394a1                                       0.2912994
#> SAM49f9b2e57aa5                                       0.2822728
#> SAM2e7aa8fa0ab3                                       0.3004752
#>                 Epidish_CBSX.NSCLC.PBMCs.scRNAseq_Monocytes
#> SAM7f0d9cc7f001                                  0.01116936
#> SAM4305ab968b90                                  0.06047921
#> SAMcf018fee2acd                                  0.02876239
#> SAMcc4675f394a1                                  0.05567865
#> SAM49f9b2e57aa5                                  0.04641955
#> SAM2e7aa8fa0ab3                                  0.03655602
#>                 DeconRNASeq_CCLE.TIL10_Monocytes Epidish_CCLE.TIL10_Monocytes
#> SAM7f0d9cc7f001                       0.00000000                   0.00000000
#> SAM4305ab968b90                       0.01996775                   0.00000000
#> SAMcf018fee2acd                       0.00000000                   0.23897062
#> SAMcc4675f394a1                       0.00000000                   0.00000000
#> SAM49f9b2e57aa5                       0.02127234                   0.05755838
#> SAM2e7aa8fa0ab3                       0.00000000                   0.00000000
#>                 DeconRNASeq_LM22_Monocytes Epidish_LM22_Monocytes
#> SAM7f0d9cc7f001                 0.04390475             0.04454453
#> SAM4305ab968b90                 0.05663578             0.06383860
#> SAMcf018fee2acd                 0.06723569             0.03506724
#> SAMcc4675f394a1                 0.12327740             0.14429770
#> SAM49f9b2e57aa5                 0.07044572             0.04761333
#> SAM2e7aa8fa0ab3                 0.05474257             0.07574987
#>                 DeconRNASeq_TIL10_Monocytes Epidish_TIL10_Monocytes
#> SAM7f0d9cc7f001                  0.00000000              0.01948821
#> SAM4305ab968b90                  0.02768913              0.00000000
#> SAMcf018fee2acd                  0.00000000              0.62219648
#> SAMcc4675f394a1                  0.00000000              0.00000000
#> SAM49f9b2e57aa5                  0.02387271              0.67365538
#> SAM2e7aa8fa0ab3                  0.00000000              0.00000000
#>                 DWLS_BPRNACan_Monocytes DWLS_BPRNACan3DProMet_Monocytes
#> SAM7f0d9cc7f001             0.012273780                    2.074700e-02
#> SAM4305ab968b90             0.002602435                    5.896592e-05
#> SAMcf018fee2acd             0.024498176                    4.602245e-02
#> SAMcc4675f394a1             0.030679687                    3.593961e-02
#> SAM49f9b2e57aa5             0.005817064                    1.715247e-02
#> SAM2e7aa8fa0ab3             0.009255249                    1.595579e-02
#>                 DWLS_BPRNACanProMet_Monocytes
#> SAM7f0d9cc7f001                  0.0158397253
#> SAM4305ab968b90                  0.0008272754
#> SAMcf018fee2acd                  0.0210629584
#> SAMcc4675f394a1                  0.0125572225
#> SAM49f9b2e57aa5                  0.0018698964
#> SAM2e7aa8fa0ab3                  0.0112370378
#>                 DWLS_CBSX.NSCLC.PBMCs.scRNAseq_Monocytes
#> SAM7f0d9cc7f001                               0.01509677
#> SAM4305ab968b90                               0.33541430
#> SAMcf018fee2acd                               0.16319638
#> SAMcc4675f394a1                               0.20036461
#> SAM49f9b2e57aa5                               0.13038013
#> SAM2e7aa8fa0ab3                               0.11590297
#>                 DWLS_CCLE.TIL10_Monocytes DWLS_LM22_Monocytes
#> SAM7f0d9cc7f001                0.00000000          0.06399306
#> SAM4305ab968b90                0.00000000          0.08460824
#> SAMcf018fee2acd                0.15185698          0.05324541
#> SAMcc4675f394a1                0.00000000          0.20466402
#> SAM49f9b2e57aa5                0.02282099          0.06704571
#> SAM2e7aa8fa0ab3                0.00000000          0.08124093
#>                 DWLS_TIL10_Monocytes CBSX_BPRNACan_Monocytes
#> SAM7f0d9cc7f001           0.05871242            0.0153841756
#> SAM4305ab968b90           0.00000000            0.0000000000
#> SAMcf018fee2acd           0.47418932            0.0100262150
#> SAMcc4675f394a1           0.19696812            0.0139365151
#> SAM49f9b2e57aa5           0.40682700            0.0023650592
#> SAM2e7aa8fa0ab3           0.00000000            0.0001291922
#>                 CBSX_BPRNACan3DProMet_Monocytes CBSX_BPRNACanProMet_Monocytes
#> SAM7f0d9cc7f001                     0.015764833                  3.556337e-03
#> SAM4305ab968b90                     0.000000000                  0.000000e+00
#> SAMcf018fee2acd                     0.017586944                  4.491585e-03
#> SAMcc4675f394a1                     0.008597910                  3.807218e-03
#> SAM49f9b2e57aa5                     0.007531023                  7.411793e-06
#> SAM2e7aa8fa0ab3                     0.002439348                  3.365214e-04
#>                 CBSX_CBSX.NSCLC.PBMCs.scRNAseq_Monocytes
#> SAM7f0d9cc7f001                              0.000000000
#> SAM4305ab968b90                              0.108430388
#> SAMcf018fee2acd                              0.003651009
#> SAMcc4675f394a1                              0.057786038
#> SAM49f9b2e57aa5                              0.042990719
#> SAM2e7aa8fa0ab3                              0.037343880
#>                 CBSX_CCLE.TIL10_Monocytes CBSX_LM22_Monocytes
#> SAM7f0d9cc7f001               0.106790731          0.04868462
#> SAM4305ab968b90               0.001298823          0.08685585
#> SAMcf018fee2acd               0.340599803          0.02858694
#> SAMcc4675f394a1               0.000000000          0.20248630
#> SAM49f9b2e57aa5               0.000000000          0.04587064
#> SAM2e7aa8fa0ab3               0.000000000          0.11047669
#>                 CBSX_TIL10_Monocytes Quantiseq_Neutrophils
#> SAM7f0d9cc7f001           0.07325332            0.16895713
#> SAM4305ab968b90           0.28948867            0.10152607
#> SAMcf018fee2acd           0.31421953            0.14111957
#> SAMcc4675f394a1           0.05905361            0.09917499
#> SAM49f9b2e57aa5           0.00000000            0.12735754
#> SAM2e7aa8fa0ab3           0.00000000            0.36118750
#>                 DeconRNASeq_BPRNACan_Neutrophils Epidish_BPRNACan_Neutrophils
#> SAM7f0d9cc7f001                       0.06804785                 0.0002105469
#> SAM4305ab968b90                       0.07840177                 0.0000000000
#> SAMcf018fee2acd                       0.07565927                 0.0000000000
#> SAMcc4675f394a1                       0.13968250                 0.0000000000
#> SAM49f9b2e57aa5                       0.06026786                 0.0000000000
#> SAM2e7aa8fa0ab3                       0.07167249                 0.0000000000
#>                 DeconRNASeq_BPRNACan3DProMet_Neutrophils
#> SAM7f0d9cc7f001                              0.016207265
#> SAM4305ab968b90                              0.025225811
#> SAMcf018fee2acd                              0.025923918
#> SAMcc4675f394a1                              0.096815038
#> SAM49f9b2e57aa5                              0.008281735
#> SAM2e7aa8fa0ab3                              0.022974099
#>                 Epidish_BPRNACan3DProMet_Neutrophils
#> SAM7f0d9cc7f001                         0.0006450161
#> SAM4305ab968b90                         0.0000000000
#> SAMcf018fee2acd                         0.0013533978
#> SAMcc4675f394a1                         0.0000000000
#> SAM49f9b2e57aa5                         0.0000000000
#> SAM2e7aa8fa0ab3                         0.0000000000
#>                 DeconRNASeq_BPRNACanProMet_Neutrophils
#> SAM7f0d9cc7f001                             0.02869901
#> SAM4305ab968b90                             0.02918039
#> SAMcf018fee2acd                             0.03476956
#> SAMcc4675f394a1                             0.10942712
#> SAM49f9b2e57aa5                             0.01720697
#> SAM2e7aa8fa0ab3                             0.03392025
#>                 Epidish_BPRNACanProMet_Neutrophils
#> SAM7f0d9cc7f001                        0.003198365
#> SAM4305ab968b90                        0.000000000
#> SAMcf018fee2acd                        0.003308617
#> SAMcc4675f394a1                        0.000000000
#> SAM49f9b2e57aa5                        0.000000000
#> SAM2e7aa8fa0ab3                        0.001095786
#>                 DeconRNASeq_CCLE.TIL10_Neutrophils
#> SAM7f0d9cc7f001                          0.1333322
#> SAM4305ab968b90                          0.1229635
#> SAMcf018fee2acd                          0.1382692
#> SAMcc4675f394a1                          0.1242944
#> SAM49f9b2e57aa5                          0.1229768
#> SAM2e7aa8fa0ab3                          0.2562540
#>                 Epidish_CCLE.TIL10_Neutrophils DeconRNASeq_LM22_Neutrophils
#> SAM7f0d9cc7f001                     0.11480060                   0.01802812
#> SAM4305ab968b90                     0.02982781                   0.03370223
#> SAMcf018fee2acd                     0.05912271                   0.00000000
#> SAMcc4675f394a1                     0.22140537                   0.00278148
#> SAM49f9b2e57aa5                     0.01853300                   0.04431914
#> SAM2e7aa8fa0ab3                     0.05354165                   0.01476839
#>                 Epidish_LM22_Neutrophils DeconRNASeq_TIL10_Neutrophils
#> SAM7f0d9cc7f001              0.032291274                     0.1601845
#> SAM4305ab968b90              0.000000000                     0.1841693
#> SAMcf018fee2acd              0.007401024                     0.1714383
#> SAMcc4675f394a1              0.000000000                     0.1302208
#> SAM49f9b2e57aa5              0.000000000                     0.1783853
#> SAM2e7aa8fa0ab3              0.000000000                     0.3182448
#>                 Epidish_TIL10_Neutrophils DWLS_BPRNACan_Neutrophils
#> SAM7f0d9cc7f001                 0.2891078                         0
#> SAM4305ab968b90                 0.7041258                         0
#> SAMcf018fee2acd                 0.1196928                         0
#> SAMcc4675f394a1                 0.6067612                         0
#> SAM49f9b2e57aa5                 0.3030074                         0
#> SAM2e7aa8fa0ab3                 0.4181740                         0
#>                 DWLS_BPRNACan3DProMet_Neutrophils
#> SAM7f0d9cc7f001                       0.010220144
#> SAM4305ab968b90                       0.000000000
#> SAMcf018fee2acd                       0.004698693
#> SAMcc4675f394a1                       0.000000000
#> SAM49f9b2e57aa5                       0.000000000
#> SAM2e7aa8fa0ab3                       0.002400074
#>                 DWLS_BPRNACanProMet_Neutrophils DWLS_CCLE.TIL10_Neutrophils
#> SAM7f0d9cc7f001                    0.0168216802                 0.152645898
#> SAM4305ab968b90                    0.0000000000                 0.025615490
#> SAMcf018fee2acd                    0.0064718938                 0.063519295
#> SAMcc4675f394a1                    0.0000000000                 0.327460750
#> SAM49f9b2e57aa5                    0.0005252674                 0.003430617
#> SAM2e7aa8fa0ab3                    0.0031102499                 0.034154620
#>                 DWLS_LM22_Neutrophils DWLS_TIL10_Neutrophils
#> SAM7f0d9cc7f001           0.017953990              0.2268184
#> SAM4305ab968b90           0.000000000              0.6711649
#> SAMcf018fee2acd           0.000000000              0.1050548
#> SAMcc4675f394a1           0.005787715              0.5174490
#> SAM49f9b2e57aa5           0.000000000              0.4956176
#> SAM2e7aa8fa0ab3           0.000000000              0.3404508
#>                 CBSX_BPRNACan_Neutrophils CBSX_BPRNACan3DProMet_Neutrophils
#> SAM7f0d9cc7f001                         0                      2.830190e-03
#> SAM4305ab968b90                         0                      0.000000e+00
#> SAMcf018fee2acd                         0                      5.673961e-04
#> SAMcc4675f394a1                         0                      0.000000e+00
#> SAM49f9b2e57aa5                         0                      0.000000e+00
#> SAM2e7aa8fa0ab3                         0                      3.362699e-05
#>                 CBSX_BPRNACanProMet_Neutrophils CBSX_CCLE.TIL10_Neutrophils
#> SAM7f0d9cc7f001                    0.0034759832                  0.07693861
#> SAM4305ab968b90                    0.0000000000                  0.01156911
#> SAMcf018fee2acd                    0.0029090514                  0.04515882
#> SAMcc4675f394a1                    0.0000000000                  0.22416840
#> SAM49f9b2e57aa5                    0.0000000000                  0.03846246
#> SAM2e7aa8fa0ab3                    0.0004672195                  0.06266863
#>                 CBSX_LM22_Neutrophils CBSX_TIL10_Neutrophils Quantiseq_NK.cells
#> SAM7f0d9cc7f001           0.049276161              0.1694140        0.023402440
#> SAM4305ab968b90           0.000000000              0.4677364        0.009455304
#> SAMcf018fee2acd           0.013929526              0.3065805        0.014343271
#> SAMcc4675f394a1           0.003465526              0.1465159        0.022211886
#> SAM49f9b2e57aa5           0.000000000              0.3347749        0.008001406
#> SAM2e7aa8fa0ab3           0.000000000              0.1173247        0.004232379
#>                 DeconRNASeq_BPRNACan_NK.cells Epidish_BPRNACan_NK.cells
#> SAM7f0d9cc7f001                    0.06144643                         0
#> SAM4305ab968b90                    0.07655463                         0
#> SAMcf018fee2acd                    0.06380983                         0
#> SAMcc4675f394a1                    0.06156468                         0
#> SAM49f9b2e57aa5                    0.05511556                         0
#> SAM2e7aa8fa0ab3                    0.06787318                         0
#>                 DeconRNASeq_BPRNACan3DProMet_NK.cells
#> SAM7f0d9cc7f001                            0.12007180
#> SAM4305ab968b90                            0.12036872
#> SAMcf018fee2acd                            0.11643997
#> SAMcc4675f394a1                            0.08037563
#> SAM49f9b2e57aa5                            0.10293768
#> SAM2e7aa8fa0ab3                            0.11464557
#>                 Epidish_BPRNACan3DProMet_NK.cells
#> SAM7f0d9cc7f001                                 0
#> SAM4305ab968b90                                 0
#> SAMcf018fee2acd                                 0
#> SAMcc4675f394a1                                 0
#> SAM49f9b2e57aa5                                 0
#> SAM2e7aa8fa0ab3                                 0
#>                 DeconRNASeq_BPRNACanProMet_NK.cells
#> SAM7f0d9cc7f001                          0.12810684
#> SAM4305ab968b90                          0.12111534
#> SAMcf018fee2acd                          0.12094385
#> SAMcc4675f394a1                          0.08866026
#> SAM49f9b2e57aa5                          0.10765941
#> SAM2e7aa8fa0ab3                          0.12103323
#>                 Epidish_BPRNACanProMet_NK.cells
#> SAM7f0d9cc7f001                    0.000000e+00
#> SAM4305ab968b90                    0.000000e+00
#> SAMcf018fee2acd                    0.000000e+00
#> SAMcc4675f394a1                    0.000000e+00
#> SAM49f9b2e57aa5                    0.000000e+00
#> SAM2e7aa8fa0ab3                    2.186225e-05
#>                 DeconRNASeq_CBSX.Melanoma.scRNAseq_NK.cells
#> SAM7f0d9cc7f001                                  0.07646177
#> SAM4305ab968b90                                  0.10189531
#> SAMcf018fee2acd                                  0.08797142
#> SAMcc4675f394a1                                  0.09019247
#> SAM49f9b2e57aa5                                  0.09409038
#> SAM2e7aa8fa0ab3                                  0.08238104
#>                 Epidish_CBSX.Melanoma.scRNAseq_NK.cells
#> SAM7f0d9cc7f001                                       0
#> SAM4305ab968b90                                       0
#> SAMcf018fee2acd                                       0
#> SAMcc4675f394a1                                       0
#> SAM49f9b2e57aa5                                       0
#> SAM2e7aa8fa0ab3                                       0
#>                 DeconRNASeq_CBSX.NSCLC.PBMCs.scRNAseq_NK.cells
#> SAM7f0d9cc7f001                                      0.1698515
#> SAM4305ab968b90                                      0.1670864
#> SAMcf018fee2acd                                      0.1732648
#> SAMcc4675f394a1                                      0.1962110
#> SAM49f9b2e57aa5                                      0.1689838
#> SAM2e7aa8fa0ab3                                      0.1609834
#>                 Epidish_CBSX.NSCLC.PBMCs.scRNAseq_NK.cells
#> SAM7f0d9cc7f001                                          0
#> SAM4305ab968b90                                          0
#> SAMcf018fee2acd                                          0
#> SAMcc4675f394a1                                          0
#> SAM49f9b2e57aa5                                          0
#> SAM2e7aa8fa0ab3                                          0
#>                 DeconRNASeq_CCLE.TIL10_NK.cells Epidish_CCLE.TIL10_NK.cells
#> SAM7f0d9cc7f001                      0.06039053                 0.000000000
#> SAM4305ab968b90                      0.06958601                 0.000000000
#> SAMcf018fee2acd                      0.04508061                 0.008406046
#> SAMcc4675f394a1                      0.08702270                 0.000000000
#> SAM49f9b2e57aa5                      0.07278632                 0.000000000
#> SAM2e7aa8fa0ab3                      0.06259406                 0.005355673
#>                 DeconRNASeq_TIL10_NK.cells Epidish_TIL10_NK.cells
#> SAM7f0d9cc7f001                 0.08146503            0.000000000
#> SAM4305ab968b90                 0.11359639            0.000000000
#> SAMcf018fee2acd                 0.06815560            0.000000000
#> SAMcc4675f394a1                 0.10601600            0.000000000
#> SAM49f9b2e57aa5                 0.10146812            0.000000000
#> SAM2e7aa8fa0ab3                 0.09757298            0.008461328
#>                 DWLS_BPRNACan_NK.cells DWLS_BPRNACan3DProMet_NK.cells
#> SAM7f0d9cc7f001                      0                              0
#> SAM4305ab968b90                      0                              0
#> SAMcf018fee2acd                      0                              0
#> SAMcc4675f394a1                      0                              0
#> SAM49f9b2e57aa5                      0                              0
#> SAM2e7aa8fa0ab3                      0                              0
#>                 DWLS_BPRNACanProMet_NK.cells
#> SAM7f0d9cc7f001                  0.000000000
#> SAM4305ab968b90                  0.000000000
#> SAMcf018fee2acd                  0.000000000
#> SAMcc4675f394a1                  0.000000000
#> SAM49f9b2e57aa5                  0.000000000
#> SAM2e7aa8fa0ab3                  0.002299035
#>                 DWLS_CBSX.Melanoma.scRNAseq_NK.cells
#> SAM7f0d9cc7f001                          0.000112454
#> SAM4305ab968b90                          0.000000000
#> SAMcf018fee2acd                          0.000000000
#> SAMcc4675f394a1                          0.000000000
#> SAM49f9b2e57aa5                          0.000000000
#> SAM2e7aa8fa0ab3                          0.000000000
#>                 DWLS_CBSX.NSCLC.PBMCs.scRNAseq_NK.cells
#> SAM7f0d9cc7f001                                0.000000
#> SAM4305ab968b90                                0.000000
#> SAMcf018fee2acd                                0.000000
#> SAMcc4675f394a1                                0.000000
#> SAM49f9b2e57aa5                                0.000000
#> SAM2e7aa8fa0ab3                                0.118806
#>                 DWLS_CCLE.TIL10_NK.cells DWLS_TIL10_NK.cells
#> SAM7f0d9cc7f001              0.016213787          0.00000000
#> SAM4305ab968b90              0.003943308          0.00000000
#> SAMcf018fee2acd              0.004384350          0.00000000
#> SAMcc4675f394a1              0.014572537          0.01486914
#> SAM49f9b2e57aa5              0.000000000          0.00000000
#> SAM2e7aa8fa0ab3              0.005850197          0.00000000
#>                 CBSX_BPRNACan_NK.cells CBSX_BPRNACan3DProMet_NK.cells
#> SAM7f0d9cc7f001                      0                              0
#> SAM4305ab968b90                      0                              0
#> SAMcf018fee2acd                      0                              0
#> SAMcc4675f394a1                      0                              0
#> SAM49f9b2e57aa5                      0                              0
#> SAM2e7aa8fa0ab3                      0                              0
#>                 CBSX_BPRNACanProMet_NK.cells
#> SAM7f0d9cc7f001                            0
#> SAM4305ab968b90                            0
#> SAMcf018fee2acd                            0
#> SAMcc4675f394a1                            0
#> SAM49f9b2e57aa5                            0
#> SAM2e7aa8fa0ab3                            0
#>                 CBSX_CBSX.Melanoma.scRNAseq_NK.cells
#> SAM7f0d9cc7f001                                    0
#> SAM4305ab968b90                                    0
#> SAMcf018fee2acd                                    0
#> SAMcc4675f394a1                                    0
#> SAM49f9b2e57aa5                                    0
#> SAM2e7aa8fa0ab3                                    0
#>                 CBSX_CBSX.NSCLC.PBMCs.scRNAseq_NK.cells
#> SAM7f0d9cc7f001                              0.00000000
#> SAM4305ab968b90                              0.00000000
#> SAMcf018fee2acd                              0.00000000
#> SAMcc4675f394a1                              0.00000000
#> SAM49f9b2e57aa5                              0.00000000
#> SAM2e7aa8fa0ab3                              0.02834543
#>                 CBSX_CCLE.TIL10_NK.cells CBSX_TIL10_NK.cells
#> SAM7f0d9cc7f001              0.001005566          0.00000000
#> SAM4305ab968b90              0.012055057          0.11135636
#> SAMcf018fee2acd              0.000000000          0.00000000
#> SAMcc4675f394a1              0.014650806          0.01383836
#> SAM49f9b2e57aa5              0.008039773          0.00000000
#> SAM2e7aa8fa0ab3              0.019321361          0.02421114
#>                 DeconRNASeq_LM22_NK.activated Epidish_LM22_NK.activated
#> SAM7f0d9cc7f001                   0.000000000                0.00000000
#> SAM4305ab968b90                   0.007719701                0.02541734
#> SAMcf018fee2acd                   0.000000000                0.02377531
#> SAMcc4675f394a1                   0.000000000                0.00000000
#> SAM49f9b2e57aa5                   0.000000000                0.00000000
#> SAM2e7aa8fa0ab3                   0.012069870                0.08524576
#>                 DWLS_LM22_NK.activated CBSX_LM22_NK.activated
#> SAM7f0d9cc7f001             0.00000000             0.00000000
#> SAM4305ab968b90             0.00000000             0.00000000
#> SAMcf018fee2acd             0.03823334             0.01134565
#> SAMcc4675f394a1             0.00000000             0.00000000
#> SAM49f9b2e57aa5             0.00000000             0.00456191
#> SAM2e7aa8fa0ab3             0.16046831             0.06897311
#>                 DeconRNASeq_LM22_NK.resting Epidish_LM22_NK.resting
#> SAM7f0d9cc7f001                 0.000000000             0.028704844
#> SAM4305ab968b90                 0.067962353             0.004255925
#> SAMcf018fee2acd                 0.000000000             0.000000000
#> SAMcc4675f394a1                 0.026058312             0.028160832
#> SAM49f9b2e57aa5                 0.004815376             0.037073355
#> SAM2e7aa8fa0ab3                 0.027179316             0.000000000
#>                 DWLS_LM22_NK.resting CBSX_LM22_NK.resting
#> SAM7f0d9cc7f001           0.04326824          0.021881310
#> SAM4305ab968b90           0.08623066          0.053953442
#> SAMcf018fee2acd           0.00000000          0.003610059
#> SAMcc4675f394a1           0.07672307          0.055432805
#> SAM49f9b2e57aa5           0.02530973          0.000000000
#> SAM2e7aa8fa0ab3           0.00000000          0.000000000
#>                 DeconRNASeq_CBSX.NSCLC.PBMCs.scRNAseq_NKT.cells
#> SAM7f0d9cc7f001                                       0.1332183
#> SAM4305ab968b90                                       0.1410772
#> SAMcf018fee2acd                                       0.1134181
#> SAMcc4675f394a1                                       0.1362632
#> SAM49f9b2e57aa5                                       0.1496804
#> SAM2e7aa8fa0ab3                                       0.1424695
#>                 Epidish_CBSX.NSCLC.PBMCs.scRNAseq_NKT.cells
#> SAM7f0d9cc7f001                                  0.06177058
#> SAM4305ab968b90                                  0.20596451
#> SAMcf018fee2acd                                  0.10081728
#> SAMcc4675f394a1                                  0.16370762
#> SAM49f9b2e57aa5                                  0.18693083
#> SAM2e7aa8fa0ab3                                  0.05430822
#>                 DWLS_CBSX.NSCLC.PBMCs.scRNAseq_NKT.cells
#> SAM7f0d9cc7f001                               0.00000000
#> SAM4305ab968b90                               0.01431857
#> SAMcf018fee2acd                               0.00000000
#> SAMcc4675f394a1                               0.00000000
#> SAM49f9b2e57aa5                               0.00000000
#> SAM2e7aa8fa0ab3                               0.00000000
#>                 CBSX_CBSX.NSCLC.PBMCs.scRNAseq_NKT.cells
#> SAM7f0d9cc7f001                              0.007907787
#> SAM4305ab968b90                              0.089818755
#> SAMcf018fee2acd                              0.053735788
#> SAMcc4675f394a1                              0.000000000
#> SAM49f9b2e57aa5                              0.000000000
#> SAM2e7aa8fa0ab3                              0.000000000
#>                 DeconRNASeq_BPRNACan_CD4.cells Epidish_BPRNACan_CD4.cells
#> SAM7f0d9cc7f001                    0.003057217                0.003650957
#> SAM4305ab968b90                    0.018579064                0.000000000
#> SAMcf018fee2acd                    0.001964087                0.000000000
#> SAMcc4675f394a1                    0.000000000                0.000000000
#> SAM49f9b2e57aa5                    0.002453176                0.000000000
#> SAM2e7aa8fa0ab3                    0.000000000                0.000000000
#>                 DeconRNASeq_BPRNACan3DProMet_CD4.cells
#> SAM7f0d9cc7f001                                      0
#> SAM4305ab968b90                                      0
#> SAMcf018fee2acd                                      0
#> SAMcc4675f394a1                                      0
#> SAM49f9b2e57aa5                                      0
#> SAM2e7aa8fa0ab3                                      0
#>                 Epidish_BPRNACan3DProMet_CD4.cells
#> SAM7f0d9cc7f001                        0.013332870
#> SAM4305ab968b90                        0.005266562
#> SAMcf018fee2acd                        0.006890017
#> SAMcc4675f394a1                        0.000000000
#> SAM49f9b2e57aa5                        0.000000000
#> SAM2e7aa8fa0ab3                        0.002809990
#>                 DeconRNASeq_BPRNACanProMet_CD4.cells
#> SAM7f0d9cc7f001                          0.000000000
#> SAM4305ab968b90                          0.001330704
#> SAMcf018fee2acd                          0.000000000
#> SAMcc4675f394a1                          0.000000000
#> SAM49f9b2e57aa5                          0.000000000
#> SAM2e7aa8fa0ab3                          0.000000000
#>                 Epidish_BPRNACanProMet_CD4.cells
#> SAM7f0d9cc7f001                      0.023645622
#> SAM4305ab968b90                      0.007360001
#> SAMcf018fee2acd                      0.013732907
#> SAMcc4675f394a1                      0.000000000
#> SAM49f9b2e57aa5                      0.003251246
#> SAM2e7aa8fa0ab3                      0.006466450
#>                 DeconRNASeq_CBSX.HNSCC.scRNAseq_CD4.cells
#> SAM7f0d9cc7f001                               0.018937852
#> SAM4305ab968b90                               0.001325428
#> SAMcf018fee2acd                               0.015426364
#> SAMcc4675f394a1                               0.007805199
#> SAM49f9b2e57aa5                               0.027677685
#> SAM2e7aa8fa0ab3                               0.008138801
#>                 Epidish_CBSX.HNSCC.scRNAseq_CD4.cells
#> SAM7f0d9cc7f001                            0.18856633
#> SAM4305ab968b90                            0.00000000
#> SAMcf018fee2acd                            0.19511491
#> SAMcc4675f394a1                            0.07285318
#> SAM49f9b2e57aa5                            0.20176915
#> SAM2e7aa8fa0ab3                            0.07050168
#>                 DeconRNASeq_CBSX.Melanoma.scRNAseq_CD4.cells
#> SAM7f0d9cc7f001                                   0.07161836
#> SAM4305ab968b90                                   0.07890048
#> SAMcf018fee2acd                                   0.07567607
#> SAMcc4675f394a1                                   0.07173726
#> SAM49f9b2e57aa5                                   0.07369131
#> SAM2e7aa8fa0ab3                                   0.05237417
#>                 Epidish_CBSX.Melanoma.scRNAseq_CD4.cells
#> SAM7f0d9cc7f001                               0.19627107
#> SAM4305ab968b90                               0.00000000
#> SAMcf018fee2acd                               0.12477645
#> SAMcc4675f394a1                               0.03003806
#> SAM49f9b2e57aa5                               0.11241055
#> SAM2e7aa8fa0ab3                               0.06119466
#>                 DeconRNASeq_CBSX.NSCLC.PBMCs.scRNAseq_CD4.cells
#> SAM7f0d9cc7f001                                      0.05621776
#> SAM4305ab968b90                                      0.02891655
#> SAMcf018fee2acd                                      0.02692121
#> SAMcc4675f394a1                                      0.04720163
#> SAM49f9b2e57aa5                                      0.03983019
#> SAM2e7aa8fa0ab3                                      0.01179213
#>                 Epidish_CBSX.NSCLC.PBMCs.scRNAseq_CD4.cells
#> SAM7f0d9cc7f001                                           0
#> SAM4305ab968b90                                           0
#> SAMcf018fee2acd                                           0
#> SAMcc4675f394a1                                           0
#> SAM49f9b2e57aa5                                           0
#> SAM2e7aa8fa0ab3                                           0
#>                 DeconRNASeq_CCLE.TIL10_CD4.cells Epidish_CCLE.TIL10_CD4.cells
#> SAM7f0d9cc7f001                                0                   0.00000000
#> SAM4305ab968b90                                0                   0.00000000
#> SAMcf018fee2acd                                0                   0.00000000
#> SAMcc4675f394a1                                0                   0.03983314
#> SAM49f9b2e57aa5                                0                   0.00000000
#> SAM2e7aa8fa0ab3                                0                   0.02531609
#>                 DeconRNASeq_TIL10_CD4.cells Epidish_TIL10_CD4.cells
#> SAM7f0d9cc7f001                           0                       0
#> SAM4305ab968b90                           0                       0
#> SAMcf018fee2acd                           0                       0
#> SAMcc4675f394a1                           0                       0
#> SAM49f9b2e57aa5                           0                       0
#> SAM2e7aa8fa0ab3                           0                       0
#>                 DWLS_BPRNACan_CD4.cells DWLS_BPRNACan3DProMet_CD4.cells
#> SAM7f0d9cc7f001            0.0006493082                      0.03194948
#> SAM4305ab968b90            0.0000000000                      0.01736014
#> SAMcf018fee2acd            0.0000000000                      0.01626107
#> SAMcc4675f394a1            0.0000000000                      0.00000000
#> SAM49f9b2e57aa5            0.0000000000                      0.01458711
#> SAM2e7aa8fa0ab3            0.0000000000                      0.01071577
#>                 DWLS_BPRNACanProMet_CD4.cells
#> SAM7f0d9cc7f001                    0.05612062
#> SAM4305ab968b90                    0.02382326
#> SAMcf018fee2acd                    0.02288326
#> SAMcc4675f394a1                    0.00000000
#> SAM49f9b2e57aa5                    0.02040018
#> SAM2e7aa8fa0ab3                    0.01443047
#>                 DWLS_CBSX.HNSCC.scRNAseq_CD4.cells
#> SAM7f0d9cc7f001                         0.12309554
#> SAM4305ab968b90                         0.02417588
#> SAMcf018fee2acd                         0.09125760
#> SAMcc4675f394a1                         0.02075301
#> SAM49f9b2e57aa5                         0.06694491
#> SAM2e7aa8fa0ab3                         0.03051627
#>                 DWLS_CBSX.Melanoma.scRNAseq_CD4.cells
#> SAM7f0d9cc7f001                           0.109387085
#> SAM4305ab968b90                           0.002447217
#> SAMcf018fee2acd                           0.065654212
#> SAMcc4675f394a1                           0.013965738
#> SAM49f9b2e57aa5                           0.090387826
#> SAM2e7aa8fa0ab3                           0.037474898
#>                 DWLS_CBSX.NSCLC.PBMCs.scRNAseq_CD4.cells
#> SAM7f0d9cc7f001                                        0
#> SAM4305ab968b90                                        0
#> SAMcf018fee2acd                                        0
#> SAMcc4675f394a1                                        0
#> SAM49f9b2e57aa5                                        0
#> SAM2e7aa8fa0ab3                                        0
#>                 DWLS_CCLE.TIL10_CD4.cells DWLS_TIL10_CD4.cells
#> SAM7f0d9cc7f001               0.000000000                    0
#> SAM4305ab968b90               0.000000000                    0
#> SAMcf018fee2acd               0.009505097                    0
#> SAMcc4675f394a1               0.010039945                    0
#> SAM49f9b2e57aa5               0.000000000                    0
#> SAM2e7aa8fa0ab3               0.002622014                    0
#>                 CBSX_BPRNACan_CD4.cells CBSX_BPRNACan3DProMet_CD4.cells
#> SAM7f0d9cc7f001                       0                    0.0018777797
#> SAM4305ab968b90                       0                    0.0006551909
#> SAMcf018fee2acd                       0                    0.0054072782
#> SAMcc4675f394a1                       0                    0.0000000000
#> SAM49f9b2e57aa5                       0                    0.0055903807
#> SAM2e7aa8fa0ab3                       0                    0.0035452284
#>                 CBSX_BPRNACanProMet_CD4.cells
#> SAM7f0d9cc7f001                   0.026943059
#> SAM4305ab968b90                   0.002506110
#> SAMcf018fee2acd                   0.011139287
#> SAMcc4675f394a1                   0.000000000
#> SAM49f9b2e57aa5                   0.004661851
#> SAM2e7aa8fa0ab3                   0.004641277
#>                 CBSX_CBSX.HNSCC.scRNAseq_CD4.cells
#> SAM7f0d9cc7f001                         0.18051700
#> SAM4305ab968b90                         0.00000000
#> SAMcf018fee2acd                         0.20246252
#> SAMcc4675f394a1                         0.06190600
#> SAM49f9b2e57aa5                         0.15741680
#> SAM2e7aa8fa0ab3                         0.07273624
#>                 CBSX_CBSX.Melanoma.scRNAseq_CD4.cells
#> SAM7f0d9cc7f001                            0.21282252
#> SAM4305ab968b90                            0.01264318
#> SAMcf018fee2acd                            0.13022434
#> SAMcc4675f394a1                            0.03037305
#> SAM49f9b2e57aa5                            0.18728766
#> SAM2e7aa8fa0ab3                            0.07033139
#>                 CBSX_CBSX.NSCLC.PBMCs.scRNAseq_CD4.cells
#> SAM7f0d9cc7f001                               0.20260414
#> SAM4305ab968b90                               0.00000000
#> SAMcf018fee2acd                               0.07840351
#> SAMcc4675f394a1                               0.00000000
#> SAM49f9b2e57aa5                               0.00000000
#> SAM2e7aa8fa0ab3                               0.00000000
#>                 CBSX_CCLE.TIL10_CD4.cells CBSX_TIL10_CD4.cells
#> SAM7f0d9cc7f001              0.0008987954           0.00000000
#> SAM4305ab968b90              0.0000000000           0.06647772
#> SAMcf018fee2acd              0.0000000000           0.00000000
#> SAMcc4675f394a1              0.0243766783           0.00000000
#> SAM49f9b2e57aa5              0.0011199587           0.00000000
#> SAM2e7aa8fa0ab3              0.0000000000           0.00000000
#>                 DeconRNASeq_LM22_T.cells.CD4.memory.activated
#> SAM7f0d9cc7f001                                   0.003638885
#> SAM4305ab968b90                                   0.022400879
#> SAMcf018fee2acd                                   0.031123098
#> SAMcc4675f394a1                                   0.032888149
#> SAM49f9b2e57aa5                                   0.045319678
#> SAM2e7aa8fa0ab3                                   0.042038973
#>                 Epidish_LM22_T.cells.CD4.memory.activated
#> SAM7f0d9cc7f001                               0.061159306
#> SAM4305ab968b90                               0.000000000
#> SAMcf018fee2acd                               0.015159780
#> SAMcc4675f394a1                               0.001494555
#> SAM49f9b2e57aa5                               0.033500669
#> SAM2e7aa8fa0ab3                               0.012756696
#>                 DWLS_LM22_T.cells.CD4.memory.activated
#> SAM7f0d9cc7f001                            0.049708667
#> SAM4305ab968b90                            0.000000000
#> SAMcf018fee2acd                            0.000000000
#> SAMcc4675f394a1                            0.001914541
#> SAM49f9b2e57aa5                            0.026067301
#> SAM2e7aa8fa0ab3                            0.000000000
#>                 CBSX_LM22_T.cells.CD4.memory.activated
#> SAM7f0d9cc7f001                             0.03321858
#> SAM4305ab968b90                             0.00000000
#> SAMcf018fee2acd                             0.01108448
#> SAMcc4675f394a1                             0.00257027
#> SAM49f9b2e57aa5                             0.03585677
#> SAM2e7aa8fa0ab3                             0.00000000
#>                 DeconRNASeq_LM22_T.cells.CD4.memory.resting
#> SAM7f0d9cc7f001                                  0.19901562
#> SAM4305ab968b90                                  0.00000000
#> SAMcf018fee2acd                                  0.13048023
#> SAMcc4675f394a1                                  0.03667965
#> SAM49f9b2e57aa5                                  0.00000000
#> SAM2e7aa8fa0ab3                                  0.04238739
#>                 Epidish_LM22_T.cells.CD4.memory.resting
#> SAM7f0d9cc7f001                               0.3817369
#> SAM4305ab968b90                               0.3364124
#> SAMcf018fee2acd                               0.5144529
#> SAMcc4675f394a1                               0.3787908
#> SAM49f9b2e57aa5                               0.2697398
#> SAM2e7aa8fa0ab3                               0.4639731
#>                 DWLS_LM22_T.cells.CD4.memory.resting
#> SAM7f0d9cc7f001                            0.3429360
#> SAM4305ab968b90                            0.2940950
#> SAMcf018fee2acd                            0.4908357
#> SAMcc4675f394a1                            0.2729609
#> SAM49f9b2e57aa5                            0.2497449
#> SAM2e7aa8fa0ab3                            0.3464909
#>                 CBSX_LM22_T.cells.CD4.memory.resting DeconRNASeq_LM22_CD4.naive
#> SAM7f0d9cc7f001                            0.3301782                 0.14123191
#> SAM4305ab968b90                            0.3712513                 0.01951152
#> SAMcf018fee2acd                            0.4472554                 0.08789033
#> SAMcc4675f394a1                            0.3222343                 0.12080160
#> SAM49f9b2e57aa5                            0.2277957                 0.15906024
#> SAM2e7aa8fa0ab3                            0.4196218                 0.06201114
#>                 Epidish_LM22_CD4.naive DWLS_LM22_CD4.naive CBSX_LM22_CD4.naive
#> SAM7f0d9cc7f001             0.08164175          0.05377599          0.07321164
#> SAM4305ab968b90             0.12645151          0.01549952          0.00000000
#> SAMcf018fee2acd             0.00000000          0.00000000          0.00000000
#> SAMcc4675f394a1             0.09828073          0.11124875          0.12248357
#> SAM49f9b2e57aa5             0.29919921          0.28307714          0.28897170
#> SAM2e7aa8fa0ab3             0.00000000          0.00000000          0.13066508
#>                 Quantiseq_T.cells.non.regulatory Quantiseq_CD8.cells
#> SAM7f0d9cc7f001                       0.01070804        0.0045958589
#> SAM4305ab968b90                       0.00000000        0.0000000000
#> SAMcf018fee2acd                       0.00000000        0.0004544755
#> SAMcc4675f394a1                       0.00000000        0.0000000000
#> SAM49f9b2e57aa5                       0.00000000        0.0000000000
#> SAM2e7aa8fa0ab3                       0.00000000        0.0006722600
#>                 DeconRNASeq_BPRNACan_CD8.cells Epidish_BPRNACan_CD8.cells
#> SAM7f0d9cc7f001                     0.08209232                0.000895226
#> SAM4305ab968b90                     0.06343498                0.000000000
#> SAMcf018fee2acd                     0.07661078                0.000000000
#> SAMcc4675f394a1                     0.03312227                0.000000000
#> SAM49f9b2e57aa5                     0.07276147                0.000000000
#> SAM2e7aa8fa0ab3                     0.06940845                0.000000000
#>                 DeconRNASeq_BPRNACan3DProMet_CD8.cells
#> SAM7f0d9cc7f001                                      0
#> SAM4305ab968b90                                      0
#> SAMcf018fee2acd                                      0
#> SAMcc4675f394a1                                      0
#> SAM49f9b2e57aa5                                      0
#> SAM2e7aa8fa0ab3                                      0
#>                 Epidish_BPRNACan3DProMet_CD8.cells
#> SAM7f0d9cc7f001                                  0
#> SAM4305ab968b90                                  0
#> SAMcf018fee2acd                                  0
#> SAMcc4675f394a1                                  0
#> SAM49f9b2e57aa5                                  0
#> SAM2e7aa8fa0ab3                                  0
#>                 DeconRNASeq_BPRNACanProMet_CD8.cells
#> SAM7f0d9cc7f001                                    0
#> SAM4305ab968b90                                    0
#> SAMcf018fee2acd                                    0
#> SAMcc4675f394a1                                    0
#> SAM49f9b2e57aa5                                    0
#> SAM2e7aa8fa0ab3                                    0
#>                 Epidish_BPRNACanProMet_CD8.cells
#> SAM7f0d9cc7f001                                0
#> SAM4305ab968b90                                0
#> SAMcf018fee2acd                                0
#> SAMcc4675f394a1                                0
#> SAM49f9b2e57aa5                                0
#> SAM2e7aa8fa0ab3                                0
#>                 DeconRNASeq_CBSX.HNSCC.scRNAseq_CD8.cells
#> SAM7f0d9cc7f001                                0.07960389
#> SAM4305ab968b90                                0.10168528
#> SAMcf018fee2acd                                0.06366972
#> SAMcc4675f394a1                                0.09252541
#> SAM49f9b2e57aa5                                0.05292514
#> SAM2e7aa8fa0ab3                                0.07855027
#>                 Epidish_CBSX.HNSCC.scRNAseq_CD8.cells
#> SAM7f0d9cc7f001                                     0
#> SAM4305ab968b90                                     0
#> SAMcf018fee2acd                                     0
#> SAMcc4675f394a1                                     0
#> SAM49f9b2e57aa5                                     0
#> SAM2e7aa8fa0ab3                                     0
#>                 DeconRNASeq_CBSX.Melanoma.scRNAseq_CD8.cells
#> SAM7f0d9cc7f001                                 0.0000000000
#> SAM4305ab968b90                                 0.0000000000
#> SAMcf018fee2acd                                 0.0000000000
#> SAMcc4675f394a1                                 0.0000000000
#> SAM49f9b2e57aa5                                 0.0000000000
#> SAM2e7aa8fa0ab3                                 0.0005763765
#>                 Epidish_CBSX.Melanoma.scRNAseq_CD8.cells
#> SAM7f0d9cc7f001                                        0
#> SAM4305ab968b90                                        0
#> SAMcf018fee2acd                                        0
#> SAMcc4675f394a1                                        0
#> SAM49f9b2e57aa5                                        0
#> SAM2e7aa8fa0ab3                                        0
#>                 DeconRNASeq_CBSX.NSCLC.PBMCs.scRNAseq_CD8.cells
#> SAM7f0d9cc7f001                                     0.000000000
#> SAM4305ab968b90                                     0.000000000
#> SAMcf018fee2acd                                     0.007412034
#> SAMcc4675f394a1                                     0.003990898
#> SAM49f9b2e57aa5                                     0.000000000
#> SAM2e7aa8fa0ab3                                     0.000000000
#>                 Epidish_CBSX.NSCLC.PBMCs.scRNAseq_CD8.cells
#> SAM7f0d9cc7f001                                           0
#> SAM4305ab968b90                                           0
#> SAMcf018fee2acd                                           0
#> SAMcc4675f394a1                                           0
#> SAM49f9b2e57aa5                                           0
#> SAM2e7aa8fa0ab3                                           0
#>                 DeconRNASeq_CCLE.TIL10_CD8.cells Epidish_CCLE.TIL10_CD8.cells
#> SAM7f0d9cc7f001                       0.04185382                            0
#> SAM4305ab968b90                       0.05555173                            0
#> SAMcf018fee2acd                       0.03690628                            0
#> SAMcc4675f394a1                       0.07516815                            0
#> SAM49f9b2e57aa5                       0.06321497                            0
#> SAM2e7aa8fa0ab3                       0.05696032                            0
#>                 DeconRNASeq_LM22_CD8.cells Epidish_LM22_CD8.cells
#> SAM7f0d9cc7f001                          0              0.0000000
#> SAM4305ab968b90                          0              0.0000000
#> SAMcf018fee2acd                          0              0.0000000
#> SAMcc4675f394a1                          0              0.0000000
#> SAM49f9b2e57aa5                          0              0.0000000
#> SAM2e7aa8fa0ab3                          0              0.0575324
#>                 DeconRNASeq_TIL10_CD8.cells Epidish_TIL10_CD8.cells
#> SAM7f0d9cc7f001                  0.06136648                       0
#> SAM4305ab968b90                  0.08284880                       0
#> SAMcf018fee2acd                  0.06343736                       0
#> SAMcc4675f394a1                  0.09104802                       0
#> SAM49f9b2e57aa5                  0.08793396                       0
#> SAM2e7aa8fa0ab3                  0.08259947                       0
#>                 DWLS_BPRNACan_CD8.cells DWLS_BPRNACan3DProMet_CD8.cells
#> SAM7f0d9cc7f001             0.001863238                               0
#> SAM4305ab968b90             0.000000000                               0
#> SAMcf018fee2acd             0.000000000                               0
#> SAMcc4675f394a1             0.000000000                               0
#> SAM49f9b2e57aa5             0.000000000                               0
#> SAM2e7aa8fa0ab3             0.000000000                               0
#>                 DWLS_BPRNACanProMet_CD8.cells
#> SAM7f0d9cc7f001                             0
#> SAM4305ab968b90                             0
#> SAMcf018fee2acd                             0
#> SAMcc4675f394a1                             0
#> SAM49f9b2e57aa5                             0
#> SAM2e7aa8fa0ab3                             0
#>                 DWLS_CBSX.HNSCC.scRNAseq_CD8.cells
#> SAM7f0d9cc7f001                                  0
#> SAM4305ab968b90                                  0
#> SAMcf018fee2acd                                  0
#> SAMcc4675f394a1                                  0
#> SAM49f9b2e57aa5                                  0
#> SAM2e7aa8fa0ab3                                  0
#>                 DWLS_CBSX.Melanoma.scRNAseq_CD8.cells
#> SAM7f0d9cc7f001                                     0
#> SAM4305ab968b90                                     0
#> SAMcf018fee2acd                                     0
#> SAMcc4675f394a1                                     0
#> SAM49f9b2e57aa5                                     0
#> SAM2e7aa8fa0ab3                                     0
#>                 DWLS_CBSX.NSCLC.PBMCs.scRNAseq_CD8.cells
#> SAM7f0d9cc7f001                               0.05544086
#> SAM4305ab968b90                               0.00000000
#> SAMcf018fee2acd                               0.01620067
#> SAMcc4675f394a1                               0.11879017
#> SAM49f9b2e57aa5                               0.00000000
#> SAM2e7aa8fa0ab3                               0.05032011
#>                 DWLS_CCLE.TIL10_CD8.cells DWLS_LM22_CD8.cells
#> SAM7f0d9cc7f001               0.000000000          0.00000000
#> SAM4305ab968b90               0.002136290          0.00000000
#> SAMcf018fee2acd               0.000000000          0.00000000
#> SAMcc4675f394a1               0.000000000          0.00000000
#> SAM49f9b2e57aa5               0.000000000          0.00000000
#> SAM2e7aa8fa0ab3               0.003448304          0.04009268
#>                 DWLS_TIL10_CD8.cells CBSX_BPRNACan_CD8.cells
#> SAM7f0d9cc7f001                    0             0.000000000
#> SAM4305ab968b90                    0             0.000000000
#> SAMcf018fee2acd                    0             0.000000000
#> SAMcc4675f394a1                    0             0.000000000
#> SAM49f9b2e57aa5                    0             0.000000000
#> SAM2e7aa8fa0ab3                    0             0.000308469
#>                 CBSX_BPRNACan3DProMet_CD8.cells CBSX_BPRNACanProMet_CD8.cells
#> SAM7f0d9cc7f001                    0.0000000000                  0.0000000000
#> SAM4305ab968b90                    0.0000000000                  0.0000000000
#> SAMcf018fee2acd                    0.0000000000                  0.0000000000
#> SAMcc4675f394a1                    0.0000000000                  0.0000000000
#> SAM49f9b2e57aa5                    0.0000000000                  0.0000000000
#> SAM2e7aa8fa0ab3                    0.0004154687                  0.0004624965
#>                 CBSX_CBSX.HNSCC.scRNAseq_CD8.cells
#> SAM7f0d9cc7f001                                  0
#> SAM4305ab968b90                                  0
#> SAMcf018fee2acd                                  0
#> SAMcc4675f394a1                                  0
#> SAM49f9b2e57aa5                                  0
#> SAM2e7aa8fa0ab3                                  0
#>                 CBSX_CBSX.Melanoma.scRNAseq_CD8.cells
#> SAM7f0d9cc7f001                                     0
#> SAM4305ab968b90                                     0
#> SAMcf018fee2acd                                     0
#> SAMcc4675f394a1                                     0
#> SAM49f9b2e57aa5                                     0
#> SAM2e7aa8fa0ab3                                     0
#>                 CBSX_CBSX.NSCLC.PBMCs.scRNAseq_CD8.cells
#> SAM7f0d9cc7f001                                0.0000000
#> SAM4305ab968b90                                0.0000000
#> SAMcf018fee2acd                                0.0000000
#> SAMcc4675f394a1                                0.2018982
#> SAM49f9b2e57aa5                                0.1279815
#> SAM2e7aa8fa0ab3                                0.3302735
#>                 CBSX_CCLE.TIL10_CD8.cells CBSX_LM22_CD8.cells
#> SAM7f0d9cc7f001               0.004254491         0.002472256
#> SAM4305ab968b90               0.011980175         0.045316751
#> SAMcf018fee2acd               0.000000000         0.022777108
#> SAMcc4675f394a1               0.000000000         0.000000000
#> SAM49f9b2e57aa5               0.005044944         0.000000000
#> SAM2e7aa8fa0ab3               0.014647198         0.000000000
#>                 CBSX_TIL10_CD8.cells Quantiseq_T.cells.regulatory
#> SAM7f0d9cc7f001          0.000000000                 0.0306341266
#> SAM4305ab968b90          0.000000000                 0.0005524799
#> SAMcf018fee2acd          0.005414829                 0.0207888231
#> SAMcc4675f394a1          0.013444783                 0.0031793914
#> SAM49f9b2e57aa5          0.000000000                 0.0069047073
#> SAM2e7aa8fa0ab3          0.013248499                 0.0035831130
#>                 DeconRNASeq_CCLE.TIL10_T.cells.regulatory
#> SAM7f0d9cc7f001                                0.07432659
#> SAM4305ab968b90                                0.13539643
#> SAMcf018fee2acd                                0.08093144
#> SAMcc4675f394a1                                0.09234658
#> SAM49f9b2e57aa5                                0.13745610
#> SAM2e7aa8fa0ab3                                0.06349765
#>                 Epidish_CCLE.TIL10_T.cells.regulatory
#> SAM7f0d9cc7f001                            0.11787406
#> SAM4305ab968b90                            0.00000000
#> SAMcf018fee2acd                            0.03816677
#> SAMcc4675f394a1                            0.00000000
#> SAM49f9b2e57aa5                            0.00000000
#> SAM2e7aa8fa0ab3                            0.00000000
#>                 DeconRNASeq_LM22_T.cells.regulatory
#> SAM7f0d9cc7f001                          0.00000000
#> SAM4305ab968b90                          0.01965499
#> SAMcf018fee2acd                          0.00000000
#> SAMcc4675f394a1                          0.00000000
#> SAM49f9b2e57aa5                          0.00000000
#> SAM2e7aa8fa0ab3                          0.03093711
#>                 Epidish_LM22_T.cells.regulatory
#> SAM7f0d9cc7f001                               0
#> SAM4305ab968b90                               0
#> SAMcf018fee2acd                               0
#> SAMcc4675f394a1                               0
#> SAM49f9b2e57aa5                               0
#> SAM2e7aa8fa0ab3                               0
#>                 DeconRNASeq_TIL10_T.cells.regulatory
#> SAM7f0d9cc7f001                           0.09543620
#> SAM4305ab968b90                           0.22004605
#> SAMcf018fee2acd                           0.10192160
#> SAMcc4675f394a1                           0.12277655
#> SAM49f9b2e57aa5                           0.22437386
#> SAM2e7aa8fa0ab3                           0.09710142
#>                 Epidish_TIL10_T.cells.regulatory
#> SAM7f0d9cc7f001                       0.18435922
#> SAM4305ab968b90                       0.00000000
#> SAMcf018fee2acd                       0.05413665
#> SAMcc4675f394a1                       0.00000000
#> SAM49f9b2e57aa5                       0.00000000
#> SAM2e7aa8fa0ab3                       0.00000000
#>                 DWLS_CCLE.TIL10_T.cells.regulatory DWLS_LM22_T.cells.regulatory
#> SAM7f0d9cc7f001                        0.076107348                            0
#> SAM4305ab968b90                        0.004083009                            0
#> SAMcf018fee2acd                        0.011114057                            0
#> SAMcc4675f394a1                        0.000000000                            0
#> SAM49f9b2e57aa5                        0.002709457                            0
#> SAM2e7aa8fa0ab3                        0.009790098                            0
#>                 DWLS_TIL10_T.cells.regulatory
#> SAM7f0d9cc7f001                   0.197452686
#> SAM4305ab968b90                   0.005405410
#> SAMcf018fee2acd                   0.000000000
#> SAMcc4675f394a1                   0.000000000
#> SAM49f9b2e57aa5                   0.003129678
#> SAM2e7aa8fa0ab3                   0.026857389
#>                 CBSX_CCLE.TIL10_T.cells.regulatory CBSX_LM22_T.cells.regulatory
#> SAM7f0d9cc7f001                         0.11621395                  0.007856236
#> SAM4305ab968b90                         0.02223830                  0.000000000
#> SAMcf018fee2acd                         0.02008606                  0.000000000
#> SAMcc4675f394a1                         0.00000000                  0.000000000
#> SAM49f9b2e57aa5                         0.01823494                  0.000000000
#> SAM2e7aa8fa0ab3                         0.05007006                  0.000000000
#>                 CBSX_TIL10_T.cells.regulatory DeconRNASeq_LM22_T.cells.helper
#> SAM7f0d9cc7f001                    0.29676592                      0.00000000
#> SAM4305ab968b90                    0.01941780                      0.08389950
#> SAMcf018fee2acd                    0.15566100                      0.00000000
#> SAMcc4675f394a1                    0.09570463                      0.00000000
#> SAM49f9b2e57aa5                    0.23503255                      0.06256773
#> SAM2e7aa8fa0ab3                    0.12162845                      0.01772861
#>                 Epidish_LM22_T.cells.helper DWLS_LM22_T.cells.helper
#> SAM7f0d9cc7f001                 0.000000000               0.04044449
#> SAM4305ab968b90                 0.000000000               0.00000000
#> SAMcf018fee2acd                 0.004625797               0.00000000
#> SAMcc4675f394a1                 0.000000000               0.00000000
#> SAM49f9b2e57aa5                 0.000000000               0.00000000
#> SAM2e7aa8fa0ab3                 0.000000000               0.00000000
#>                 CBSX_LM22_T.cells.helper DeconRNASeq_LM22_T.cells.gamma.delta
#> SAM7f0d9cc7f001             0.0257797309                           0.00000000
#> SAM4305ab968b90             0.0000000000                           0.00000000
#> SAMcf018fee2acd             0.0055103787                           0.00000000
#> SAMcc4675f394a1             0.0000000000                           0.00000000
#> SAM49f9b2e57aa5             0.0000000000                           0.02220682
#> SAM2e7aa8fa0ab3             0.0009856267                           0.00000000
#>                 Epidish_LM22_T.cells.gamma.delta DWLS_LM22_T.cells.gamma.delta
#> SAM7f0d9cc7f001                                0                             0
#> SAM4305ab968b90                                0                             0
#> SAMcf018fee2acd                                0                             0
#> SAMcc4675f394a1                                0                             0
#> SAM49f9b2e57aa5                                0                             0
#> SAM2e7aa8fa0ab3                                0                             0
#>                 CBSX_LM22_T.cells.gamma.delta Quantiseq_Dendritic.cells
#> SAM7f0d9cc7f001                             0                         0
#> SAM4305ab968b90                             0                         0
#> SAMcf018fee2acd                             0                         0
#> SAMcc4675f394a1                             0                         0
#> SAM49f9b2e57aa5                             0                         0
#> SAM2e7aa8fa0ab3                             0                         0
#>                 DeconRNASeq_CBSX.HNSCC.scRNAseq_Dendritic.cells
#> SAM7f0d9cc7f001                                      0.03098842
#> SAM4305ab968b90                                      0.06184732
#> SAMcf018fee2acd                                      0.03090844
#> SAMcc4675f394a1                                      0.04358986
#> SAM49f9b2e57aa5                                      0.03755790
#> SAM2e7aa8fa0ab3                                      0.03557088
#>                 Epidish_CBSX.HNSCC.scRNAseq_Dendritic.cells
#> SAM7f0d9cc7f001                                 0.000000000
#> SAM4305ab968b90                                 0.205111049
#> SAMcf018fee2acd                                 0.000000000
#> SAMcc4675f394a1                                 0.000000000
#> SAM49f9b2e57aa5                                 0.001964013
#> SAM2e7aa8fa0ab3                                 0.000000000
#>                 DeconRNASeq_CCLE.TIL10_Dendritic.cells
#> SAM7f0d9cc7f001                                      0
#> SAM4305ab968b90                                      0
#> SAMcf018fee2acd                                      0
#> SAMcc4675f394a1                                      0
#> SAM49f9b2e57aa5                                      0
#> SAM2e7aa8fa0ab3                                      0
#>                 Epidish_CCLE.TIL10_Dendritic.cells
#> SAM7f0d9cc7f001                                  0
#> SAM4305ab968b90                                  0
#> SAMcf018fee2acd                                  0
#> SAMcc4675f394a1                                  0
#> SAM49f9b2e57aa5                                  0
#> SAM2e7aa8fa0ab3                                  0
#>                 DeconRNASeq_TIL10_Dendritic.cells Epidish_TIL10_Dendritic.cells
#> SAM7f0d9cc7f001                        0.00000000                             0
#> SAM4305ab968b90                        0.01175869                             0
#> SAMcf018fee2acd                        0.00000000                             0
#> SAMcc4675f394a1                        0.00000000                             0
#> SAM49f9b2e57aa5                        0.00000000                             0
#> SAM2e7aa8fa0ab3                        0.00000000                             0
#>                 DWLS_CBSX.HNSCC.scRNAseq_Dendritic.cells
#> SAM7f0d9cc7f001                               0.00000000
#> SAM4305ab968b90                               0.06816785
#> SAMcf018fee2acd                               0.00000000
#> SAMcc4675f394a1                               0.00000000
#> SAM49f9b2e57aa5                               0.00000000
#> SAM2e7aa8fa0ab3                               0.00000000
#>                 DWLS_CCLE.TIL10_Dendritic.cells DWLS_TIL10_Dendritic.cells
#> SAM7f0d9cc7f001                      0.00000000                  0.0000000
#> SAM4305ab968b90                      0.00000000                  0.1659614
#> SAMcf018fee2acd                      0.00000000                  0.0000000
#> SAMcc4675f394a1                      0.00000000                  0.0000000
#> SAM49f9b2e57aa5                      0.00000000                  0.0000000
#> SAM2e7aa8fa0ab3                      0.00775628                  0.0000000
#>                 CBSX_CBSX.HNSCC.scRNAseq_Dendritic.cells
#> SAM7f0d9cc7f001                              0.003888387
#> SAM4305ab968b90                              0.018280685
#> SAMcf018fee2acd                              0.000000000
#> SAMcc4675f394a1                              0.000000000
#> SAM49f9b2e57aa5                              0.000000000
#> SAM2e7aa8fa0ab3                              0.000000000
#>                 CBSX_CCLE.TIL10_Dendritic.cells CBSX_TIL10_Dendritic.cells
#> SAM7f0d9cc7f001                     0.000000000                  0.0000000
#> SAM4305ab968b90                     0.003450972                  0.0000000
#> SAMcf018fee2acd                     0.000000000                  0.0000000
#> SAMcc4675f394a1                     0.000000000                  0.0000000
#> SAM49f9b2e57aa5                     0.028650577                  0.0000000
#> SAM2e7aa8fa0ab3                     0.084414737                  0.3097536
#>                 DeconRNASeq_LM22_Dendritic.activated.cells
#> SAM7f0d9cc7f001                                 0.14291924
#> SAM4305ab968b90                                 0.03484681
#> SAMcf018fee2acd                                 0.15924029
#> SAMcc4675f394a1                                 0.07216657
#> SAM49f9b2e57aa5                                 0.02537457
#> SAM2e7aa8fa0ab3                                 0.06215558
#>                 Epidish_LM22_Dendritic.activated.cells
#> SAM7f0d9cc7f001                             0.05198053
#> SAM4305ab968b90                             0.02567112
#> SAMcf018fee2acd                             0.05336905
#> SAMcc4675f394a1                             0.00000000
#> SAM49f9b2e57aa5                             0.00000000
#> SAM2e7aa8fa0ab3                             0.01638979
#>                 DWLS_LM22_Dendritic.activated.cells
#> SAM7f0d9cc7f001                          0.04317965
#> SAM4305ab968b90                          0.03817598
#> SAMcf018fee2acd                          0.08194612
#> SAMcc4675f394a1                          0.00000000
#> SAM49f9b2e57aa5                          0.00000000
#> SAM2e7aa8fa0ab3                          0.00000000
#>                 CBSX_LM22_Dendritic.activated.cells
#> SAM7f0d9cc7f001                          0.05420664
#> SAM4305ab968b90                          0.02904857
#> SAMcf018fee2acd                          0.06226579
#> SAMcc4675f394a1                          0.00000000
#> SAM49f9b2e57aa5                          0.00000000
#> SAM2e7aa8fa0ab3                          0.00000000
#>                 DeconRNASeq_LM22_Dendritic.resting.cells
#> SAM7f0d9cc7f001                               0.00000000
#> SAM4305ab968b90                               0.05032054
#> SAMcf018fee2acd                               0.04132734
#> SAMcc4675f394a1                               0.05472260
#> SAM49f9b2e57aa5                               0.04213175
#> SAM2e7aa8fa0ab3                               0.04742901
#>                 Epidish_LM22_Dendritic.resting.cells
#> SAM7f0d9cc7f001                           0.00000000
#> SAM4305ab968b90                           0.00000000
#> SAMcf018fee2acd                           0.00000000
#> SAMcc4675f394a1                           0.00000000
#> SAM49f9b2e57aa5                           0.02109297
#> SAM2e7aa8fa0ab3                           0.00000000
#>                 DWLS_LM22_Dendritic.resting.cells
#> SAM7f0d9cc7f001                       0.000000000
#> SAM4305ab968b90                       0.000000000
#> SAMcf018fee2acd                       0.000000000
#> SAMcc4675f394a1                       0.006260851
#> SAM49f9b2e57aa5                       0.018817858
#> SAM2e7aa8fa0ab3                       0.000000000
#>                 CBSX_LM22_Dendritic.resting.cells DeconRNASeq_BPRNACan_Cancer
#> SAM7f0d9cc7f001                       0.000000000                   0.3059931
#> SAM4305ab968b90                       0.002626360                   0.2767090
#> SAMcf018fee2acd                       0.000000000                   0.3033619
#> SAMcc4675f394a1                       0.006812696                   0.3520030
#> SAM49f9b2e57aa5                       0.041687314                   0.3699590
#> SAM2e7aa8fa0ab3                       0.000000000                   0.3378976
#>                 Epidish_BPRNACan_Cancer DeconRNASeq_BPRNACan3DProMet_Cancer
#> SAM7f0d9cc7f001               0.9513531                           0.3432444
#> SAM4305ab968b90               0.9984365                           0.3438531
#> SAMcf018fee2acd               0.9667237                           0.3434869
#> SAMcc4675f394a1               0.9812024                           0.3971800
#> SAM49f9b2e57aa5               0.9752569                           0.4203250
#> SAM2e7aa8fa0ab3               0.9920394                           0.3790123
#>                 Epidish_BPRNACan3DProMet_Cancer
#> SAM7f0d9cc7f001                       0.9186487
#> SAM4305ab968b90                       0.9853012
#> SAMcf018fee2acd                       0.9387111
#> SAMcc4675f394a1                       0.9840882
#> SAM49f9b2e57aa5                       0.9673883
#> SAM2e7aa8fa0ab3                       0.9803108
#>                 DeconRNASeq_BPRNACanProMet_Cancer Epidish_BPRNACanProMet_Cancer
#> SAM7f0d9cc7f001                         0.3372927                     0.9047534
#> SAM4305ab968b90                         0.3537270                     0.9772189
#> SAMcf018fee2acd                         0.3462708                     0.9377217
#> SAMcc4675f394a1                         0.3917737                     0.9885758
#> SAM49f9b2e57aa5                         0.4189307                     0.9601011
#> SAM2e7aa8fa0ab3                         0.3796146                     0.9774511
#>                 DeconRNASeq_CCLE.TIL10_Cancer Epidish_CCLE.TIL10_Cancer
#> SAM7f0d9cc7f001                     0.2167606                 0.5019307
#> SAM4305ab968b90                     0.3985716                 0.9480897
#> SAMcf018fee2acd                     0.2460674                 0.4927802
#> SAMcc4675f394a1                     0.1399672                 0.5582725
#> SAM49f9b2e57aa5                     0.3487272                 0.9184998
#> SAM2e7aa8fa0ab3                     0.2942781                 0.8203985
#>                 DWLS_BPRNACan_Cancer DWLS_BPRNACan3DProMet_Cancer
#> SAM7f0d9cc7f001            0.9462952                    0.8432090
#> SAM4305ab968b90            0.9973976                    0.9741055
#> SAMcf018fee2acd            0.9506701                    0.8930516
#> SAMcc4675f394a1            0.9647451                    0.9599336
#> SAM49f9b2e57aa5            0.9730935                    0.9325462
#> SAM2e7aa8fa0ab3            0.9857419                    0.9576275
#>                 DWLS_BPRNACanProMet_Cancer DWLS_CCLE.TIL10_Cancer
#> SAM7f0d9cc7f001                  0.8091341              0.4962317
#> SAM4305ab968b90                  0.9469772              0.9508327
#> SAMcf018fee2acd                  0.8988551              0.5585735
#> SAMcc4675f394a1                  0.9762976              0.5185118
#> SAM49f9b2e57aa5                  0.9273610              0.9644051
#> SAM2e7aa8fa0ab3                  0.9546780              0.8422640
#>                 CBSX_BPRNACan_Cancer CBSX_BPRNACan3DProMet_Cancer
#> SAM7f0d9cc7f001            0.9551752                    0.9233187
#> SAM4305ab968b90            0.9996051                    0.9973471
#> SAMcf018fee2acd            0.9774508                    0.9533990
#> SAMcc4675f394a1            0.9855377                    0.9890123
#> SAM49f9b2e57aa5            0.9840956                    0.9671010
#> SAM2e7aa8fa0ab3            0.9968835                    0.9898881
#>                 CBSX_BPRNACanProMet_Cancer CBSX_CCLE.TIL10_Cancer
#> SAM7f0d9cc7f001                  0.9002010              0.5028225
#> SAM4305ab968b90                  0.9912475              0.9088300
#> SAMcf018fee2acd                  0.9560041              0.4595524
#> SAMcc4675f394a1                  0.9930072              0.6211472
#> SAM49f9b2e57aa5                  0.9620056              0.8530828
#> SAM2e7aa8fa0ab3                  0.9903390              0.6264410
#>                 DeconRNASeq_CBSX.HNSCC.scRNAseq_Cancer
#> SAM7f0d9cc7f001                              0.1121599
#> SAM4305ab968b90                              0.2399226
#> SAMcf018fee2acd                              0.1567460
#> SAMcc4675f394a1                              0.1449843
#> SAM49f9b2e57aa5                              0.1719949
#> SAM2e7aa8fa0ab3                              0.1355759
#>                 Epidish_CBSX.HNSCC.scRNAseq_Cancer
#> SAM7f0d9cc7f001                        0.000000000
#> SAM4305ab968b90                        0.629830569
#> SAMcf018fee2acd                        0.036514262
#> SAMcc4675f394a1                        0.008416453
#> SAM49f9b2e57aa5                        0.072516163
#> SAM2e7aa8fa0ab3                        0.074335069
#>                 DeconRNASeq_CBSX.Melanoma.scRNAseq_Cancer
#> SAM7f0d9cc7f001                                 0.1044827
#> SAM4305ab968b90                                 0.1719294
#> SAMcf018fee2acd                                 0.1512741
#> SAMcc4675f394a1                                 0.1288809
#> SAM49f9b2e57aa5                                 0.1575740
#> SAM2e7aa8fa0ab3                                 0.1061901
#>                 Epidish_CBSX.Melanoma.scRNAseq_Cancer
#> SAM7f0d9cc7f001                            0.00000000
#> SAM4305ab968b90                            0.01205854
#> SAMcf018fee2acd                            0.00000000
#> SAMcc4675f394a1                            0.00000000
#> SAM49f9b2e57aa5                            0.00000000
#> SAM2e7aa8fa0ab3                            0.00000000
#>                 DWLS_CBSX.HNSCC.scRNAseq_Cancer
#> SAM7f0d9cc7f001                      0.00000000
#> SAM4305ab968b90                      0.82969901
#> SAMcf018fee2acd                      0.04881382
#> SAMcc4675f394a1                      0.00000000
#> SAM49f9b2e57aa5                      0.09358478
#> SAM2e7aa8fa0ab3                      0.06952298
#>                 DWLS_CBSX.Melanoma.scRNAseq_Cancer
#> SAM7f0d9cc7f001                        0.000000000
#> SAM4305ab968b90                        0.001511533
#> SAMcf018fee2acd                        0.000000000
#> SAMcc4675f394a1                        0.000000000
#> SAM49f9b2e57aa5                        0.000000000
#> SAM2e7aa8fa0ab3                        0.000000000
#>                 CBSX_CBSX.HNSCC.scRNAseq_Cancer
#> SAM7f0d9cc7f001                     0.000000000
#> SAM4305ab968b90                     0.429162390
#> SAMcf018fee2acd                     0.013959496
#> SAMcc4675f394a1                     0.008788338
#> SAM49f9b2e57aa5                     0.127286496
#> SAM2e7aa8fa0ab3                     0.086123346
#>                 CBSX_CBSX.Melanoma.scRNAseq_Cancer
#> SAM7f0d9cc7f001                        0.000000000
#> SAM4305ab968b90                        0.003176567
#> SAMcf018fee2acd                        0.000000000
#> SAMcc4675f394a1                        0.000000000
#> SAM49f9b2e57aa5                        0.004778485
#> SAM2e7aa8fa0ab3                        0.000000000
#>                 DeconRNASeq_CBSX.HNSCC.scRNAseq_Endothelial
#> SAM7f0d9cc7f001                                  0.07009230
#> SAM4305ab968b90                                  0.08571589
#> SAMcf018fee2acd                                  0.09206739
#> SAMcc4675f394a1                                  0.06705171
#> SAM49f9b2e57aa5                                  0.07321845
#> SAM2e7aa8fa0ab3                                  0.05167305
#>                 Epidish_CBSX.HNSCC.scRNAseq_Endothelial
#> SAM7f0d9cc7f001                             0.054809711
#> SAM4305ab968b90                             0.014585068
#> SAMcf018fee2acd                             0.055019079
#> SAMcc4675f394a1                             0.007124352
#> SAM49f9b2e57aa5                             0.000000000
#> SAM2e7aa8fa0ab3                             0.000000000
#>                 DeconRNASeq_CBSX.Melanoma.scRNAseq_Endothelial
#> SAM7f0d9cc7f001                                      0.1247419
#> SAM4305ab968b90                                      0.1847182
#> SAMcf018fee2acd                                      0.1672997
#> SAMcc4675f394a1                                      0.2070710
#> SAM49f9b2e57aa5                                      0.1639431
#> SAM2e7aa8fa0ab3                                      0.1168617
#>                 Epidish_CBSX.Melanoma.scRNAseq_Endothelial
#> SAM7f0d9cc7f001                                0.023242689
#> SAM4305ab968b90                                0.000000000
#> SAMcf018fee2acd                                0.040308180
#> SAMcc4675f394a1                                0.051210106
#> SAM49f9b2e57aa5                                0.003342393
#> SAM2e7aa8fa0ab3                                0.001146507
#>                 DWLS_CBSX.HNSCC.scRNAseq_Endothelial
#> SAM7f0d9cc7f001                           0.04775027
#> SAM4305ab968b90                           0.02591334
#> SAMcf018fee2acd                           0.05412059
#> SAMcc4675f394a1                           0.02952635
#> SAM49f9b2e57aa5                           0.03380707
#> SAM2e7aa8fa0ab3                           0.00000000
#>                 DWLS_CBSX.Melanoma.scRNAseq_Endothelial
#> SAM7f0d9cc7f001                             0.010145101
#> SAM4305ab968b90                             0.000000000
#> SAMcf018fee2acd                             0.054395953
#> SAMcc4675f394a1                             0.021664262
#> SAM49f9b2e57aa5                             0.001982544
#> SAM2e7aa8fa0ab3                             0.000000000
#>                 CBSX_CBSX.HNSCC.scRNAseq_Endothelial
#> SAM7f0d9cc7f001                           0.05828204
#> SAM4305ab968b90                           0.27001372
#> SAMcf018fee2acd                           0.06006527
#> SAMcc4675f394a1                           0.01745065
#> SAM49f9b2e57aa5                           0.00000000
#> SAM2e7aa8fa0ab3                           0.00000000
#>                 CBSX_CBSX.Melanoma.scRNAseq_Endothelial
#> SAM7f0d9cc7f001                              0.03347226
#> SAM4305ab968b90                              0.00000000
#> SAMcf018fee2acd                              0.05441364
#> SAMcc4675f394a1                              0.05776272
#> SAM49f9b2e57aa5                              0.00620126
#> SAM2e7aa8fa0ab3                              0.00000000
#>                 DeconRNASeq_LM22_Eosinophils Epidish_LM22_Eosinophils
#> SAM7f0d9cc7f001                  0.012325953              0.001167543
#> SAM4305ab968b90                  0.042706117              0.000000000
#> SAMcf018fee2acd                  0.010125537              0.000000000
#> SAMcc4675f394a1                  0.000000000              0.000000000
#> SAM49f9b2e57aa5                  0.009065499              0.000000000
#> SAM2e7aa8fa0ab3                  0.050881064              0.000000000
#>                 DWLS_LM22_Eosinophils CBSX_LM22_Eosinophils
#> SAM7f0d9cc7f001           0.007998892            0.00000000
#> SAM4305ab968b90           0.003829277            0.00000000
#> SAMcf018fee2acd           0.001767786            0.00000000
#> SAMcc4675f394a1           0.000000000            0.00000000
#> SAM49f9b2e57aa5           0.000000000            0.00000000
#> SAM2e7aa8fa0ab3           0.000000000            0.01835881
#>                 DeconRNASeq_LM22_Plasma.cells Epidish_LM22_Plasma.cells
#> SAM7f0d9cc7f001                    0.00000000               0.000000000
#> SAM4305ab968b90                    0.14134690               0.019221425
#> SAMcf018fee2acd                    0.08097855               0.000000000
#> SAMcc4675f394a1                    0.08027983               0.006529829
#> SAM49f9b2e57aa5                    0.06970544               0.000000000
#> SAM2e7aa8fa0ab3                    0.09440011               0.024790468
#>                 DWLS_LM22_Plasma.cells CBSX_LM22_Plasma.cells
#> SAM7f0d9cc7f001             0.00000000            0.000000000
#> SAM4305ab968b90             0.01920268            0.015268182
#> SAMcf018fee2acd             0.00000000            0.000000000
#> SAMcc4675f394a1             0.01028627            0.007459067
#> SAM49f9b2e57aa5             0.00000000            0.024239223
#> SAM2e7aa8fa0ab3             0.03428100            0.014991613
#>                 DeconRNASeq_CBSX.HNSCC.scRNAseq_Myocytes
#> SAM7f0d9cc7f001                               0.11642166
#> SAM4305ab968b90                               0.11759367
#> SAMcf018fee2acd                               0.09656803
#> SAMcc4675f394a1                               0.12970883
#> SAM49f9b2e57aa5                               0.09762623
#> SAM2e7aa8fa0ab3                               0.10932117
#>                 Epidish_CBSX.HNSCC.scRNAseq_Myocytes
#> SAM7f0d9cc7f001                                    0
#> SAM4305ab968b90                                    0
#> SAMcf018fee2acd                                    0
#> SAMcc4675f394a1                                    0
#> SAM49f9b2e57aa5                                    0
#> SAM2e7aa8fa0ab3                                    0
#>                 DWLS_CBSX.HNSCC.scRNAseq_Myocytes
#> SAM7f0d9cc7f001                                 0
#> SAM4305ab968b90                                 0
#> SAMcf018fee2acd                                 0
#> SAMcc4675f394a1                                 0
#> SAM49f9b2e57aa5                                 0
#> SAM2e7aa8fa0ab3                                 0
#>                 CBSX_CBSX.HNSCC.scRNAseq_Myocytes
#> SAM7f0d9cc7f001                                 0
#> SAM4305ab968b90                                 0
#> SAMcf018fee2acd                                 0
#> SAMcc4675f394a1                                 0
#> SAM49f9b2e57aa5                                 0
#> SAM2e7aa8fa0ab3                                 0
#>                 DeconRNASeq_CBSX.HNSCC.scRNAseq_Mast.cells
#> SAM7f0d9cc7f001                                  0.1136651
#> SAM4305ab968b90                                  0.1224298
#> SAMcf018fee2acd                                  0.1089920
#> SAMcc4675f394a1                                  0.1302096
#> SAM49f9b2e57aa5                                  0.1089771
#> SAM2e7aa8fa0ab3                                  0.1153096
#>                 Epidish_CBSX.HNSCC.scRNAseq_Mast.cells
#> SAM7f0d9cc7f001                                      0
#> SAM4305ab968b90                                      0
#> SAMcf018fee2acd                                      0
#> SAMcc4675f394a1                                      0
#> SAM49f9b2e57aa5                                      0
#> SAM2e7aa8fa0ab3                                      0
#>                 DWLS_CBSX.HNSCC.scRNAseq_Mast.cells
#> SAM7f0d9cc7f001                                   0
#> SAM4305ab968b90                                   0
#> SAMcf018fee2acd                                   0
#> SAMcc4675f394a1                                   0
#> SAM49f9b2e57aa5                                   0
#> SAM2e7aa8fa0ab3                                   0
#>                 CBSX_CBSX.HNSCC.scRNAseq_Mast.cells
#> SAM7f0d9cc7f001                                   0
#> SAM4305ab968b90                                   0
#> SAMcf018fee2acd                                   0
#> SAMcc4675f394a1                                   0
#> SAM49f9b2e57aa5                                   0
#> SAM2e7aa8fa0ab3                                   0
#>                 DeconRNASeq_LM22_Mast.activated.cells
#> SAM7f0d9cc7f001                           0.008180541
#> SAM4305ab968b90                           0.000000000
#> SAMcf018fee2acd                           0.000000000
#> SAMcc4675f394a1                           0.000000000
#> SAM49f9b2e57aa5                           0.000000000
#> SAM2e7aa8fa0ab3                           0.000000000
#>                 Epidish_LM22_Mast.activated.cells
#> SAM7f0d9cc7f001                        0.02212100
#> SAM4305ab968b90                        0.00000000
#> SAMcf018fee2acd                        0.00000000
#> SAMcc4675f394a1                        0.01155209
#> SAM49f9b2e57aa5                        0.01996695
#> SAM2e7aa8fa0ab3                        0.01519610
#>                 DWLS_LM22_Mast.activated.cells CBSX_LM22_Mast.activated.cells
#> SAM7f0d9cc7f001                     0.02354786                     0.02267745
#> SAM4305ab968b90                     0.00000000                     0.00000000
#> SAMcf018fee2acd                     0.00000000                     0.01022264
#> SAMcc4675f394a1                     0.00000000                     0.00000000
#> SAM49f9b2e57aa5                     0.00000000                     0.00000000
#> SAM2e7aa8fa0ab3                     0.03914789                     0.02263764
#>                 DeconRNASeq_LM22_Mast.resting.cells
#> SAM7f0d9cc7f001                          0.12025398
#> SAM4305ab968b90                          0.12908198
#> SAMcf018fee2acd                          0.09071866
#> SAMcc4675f394a1                          0.11095915
#> SAM49f9b2e57aa5                          0.10307726
#> SAM2e7aa8fa0ab3                          0.10231399
#>                 Epidish_LM22_Mast.resting.cells DWLS_LM22_Mast.resting.cells
#> SAM7f0d9cc7f001                     0.008803654                  0.031004593
#> SAM4305ab968b90                     0.000000000                  0.215628974
#> SAMcf018fee2acd                     0.024375930                  0.011831316
#> SAMcc4675f394a1                     0.001893088                  0.010886169
#> SAM49f9b2e57aa5                     0.000000000                  0.004982798
#> SAM2e7aa8fa0ab3                     0.000000000                  0.000000000
#>                 CBSX_LM22_Mast.resting.cells
#> SAM7f0d9cc7f001                  0.013992599
#> SAM4305ab968b90                  0.151743664
#> SAMcf018fee2acd                  0.015825208
#> SAMcc4675f394a1                  0.008492642
#> SAM49f9b2e57aa5                  0.050923999
#> SAM2e7aa8fa0ab3                  0.000000000
#>                 DeconRNASeq_CBSX.HNSCC.scRNAseq_CAF
#> SAM7f0d9cc7f001                           0.2859075
#> SAM4305ab968b90                           0.1043279
#> SAMcf018fee2acd                           0.2187169
#> SAMcc4675f394a1                           0.1938040
#> SAM49f9b2e57aa5                           0.1780117
#> SAM2e7aa8fa0ab3                           0.2034680
#>                 Epidish_CBSX.HNSCC.scRNAseq_CAF
#> SAM7f0d9cc7f001                       0.7101559
#> SAM4305ab968b90                       0.1504733
#> SAMcf018fee2acd                       0.5737636
#> SAMcc4675f394a1                       0.8486565
#> SAM49f9b2e57aa5                       0.5867178
#> SAM2e7aa8fa0ab3                       0.5478692
#>                 DeconRNASeq_CBSX.Melanoma.scRNAseq_CAF
#> SAM7f0d9cc7f001                              0.4362575
#> SAM4305ab968b90                              0.2159553
#> SAMcf018fee2acd                              0.2789918
#> SAMcc4675f394a1                              0.3163672
#> SAM49f9b2e57aa5                              0.2855141
#> SAM2e7aa8fa0ab3                              0.4346621
#>                 Epidish_CBSX.Melanoma.scRNAseq_CAF DWLS_CBSX.HNSCC.scRNAseq_CAF
#> SAM7f0d9cc7f001                          0.6507085                   0.68018688
#> SAM4305ab968b90                          0.8101822                   0.05204392
#> SAMcf018fee2acd                          0.6103358                   0.46512483
#> SAMcc4675f394a1                          0.8201997                   0.87333960
#> SAM49f9b2e57aa5                          0.7616690                   0.39307087
#> SAM2e7aa8fa0ab3                          0.8455423                   0.28604556
#>                 DWLS_CBSX.Melanoma.scRNAseq_CAF CBSX_CBSX.HNSCC.scRNAseq_CAF
#> SAM7f0d9cc7f001                       0.6002483                    0.7096410
#> SAM4305ab968b90                       0.6855401                    0.2825432
#> SAMcf018fee2acd                       0.4248323                    0.5861131
#> SAMcc4675f394a1                       0.7202723                    0.8558917
#> SAM49f9b2e57aa5                       0.6616472                    0.5768449
#> SAM2e7aa8fa0ab3                       0.7327018                    0.5356849
#>                 CBSX_CBSX.Melanoma.scRNAseq_CAF Quantiseq_uncharacterized_cell
#> SAM7f0d9cc7f001                       0.6441841                      0.6446753
#> SAM4305ab968b90                       0.8528701                      0.8563205
#> SAMcf018fee2acd                       0.6036892                      0.6817286
#> SAMcc4675f394a1                       0.8209564                      0.8106984
#> SAM49f9b2e57aa5                       0.6674839                      0.8221434
#> SAM2e7aa8fa0ab3                       0.8485564                      0.6004888
```
