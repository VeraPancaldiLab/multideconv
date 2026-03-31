# Computes QuanTIseq

Computes QuanTIseq

## Usage

``` r
computeQuantiseq(TPM_matrix, name_signature = "TIL10")
```

## Arguments

- TPM_matrix:

  A matrix with TPM normalized counts (genes symbols as rows and samples
  as columns).

- name_signature:

  Name used to tag output columns with the signature source.

## Value

A matrix with cell abundance deconvolve with QuanTIseq
