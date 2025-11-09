# Computes MOMF

Computes MOMF

## Usage

``` r
computeMOMF(TPM_matrix, sc_object, signature_file, name_signature)
```

## Arguments

- TPM_matrix:

  A matrix with TPM normalized counts (genes symbols as rows and samples
  as columns).

- sc_object:

  A matrix with the counts from scRNAseq object (genes as rows and cells
  as columns)

- signature_file:

  The signature file to use.

- name_signature:

  Signature name to set for the deconvolution results.

## Value

A matrix with cell abundance deconvolve with MOMF
