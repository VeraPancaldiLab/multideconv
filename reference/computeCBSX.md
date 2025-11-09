# Computes CIBERSORTx (CBSX) using one signature

Computes CIBERSORTx (CBSX) using one signature

## Usage

``` r
computeCBSX(TPM_matrix, signature_file, name, password, name_signature)
```

## Arguments

- TPM_matrix:

  A matrix with TPM normalized counts (genes symbols as rows and samples
  as columns).

- signature_file:

  The signature file to use.

- name:

  Credential email for running CIBERSORTx.

- password:

  Credential token for running CIBERSORTx.

- name_signature:

  Signature name to set for the deconvolution results.

## Value

A matrix with cell abundance deconvolve with CBSX
