# Computes DeconRNASeq

Computes DeconRNASeq

## Usage

``` r
computeDeconRNASeq(TPM_matrix, signature_file, name_signature)
```

## Arguments

- TPM_matrix:

  A matrix with TPM normalized counts (genes symbols as rows and samples
  as columns).

- signature_file:

  The signature file to use.

- name_signature:

  Signature name to set for the deconvolution results.

## Value

A matrix with cell abundance deconvolve with DeconRNASeq
