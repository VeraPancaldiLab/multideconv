# Compute CIBERSORTx (CBSX) in parallel across multiple signatures

Compute CIBERSORTx (CBSX) in parallel across multiple signatures

## Usage

``` r
computeCBSX_parallel(TPM_matrix, signatures, name, password, workers)
```

## Arguments

- TPM_matrix:

  A matrix with TPM normalized counts (genes symbols as rows and samples
  as columns).

- signatures:

  Path where signatures files are located

- name:

  Credential email for running CIBERSORTx.

- password:

  Credential token for running CIBERSORTx.

- workers:

  Number of processes available to run on parallel.

## Value

A matrix with cell abundance deconvolve with CBSX
