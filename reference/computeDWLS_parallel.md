# Compute DWLS in parallel across multiple signatures

Compute DWLS in parallel across multiple signatures

## Usage

``` r
computeDWLS_parallel(TPM_matrix, signatures, workers)
```

## Arguments

- TPM_matrix:

  A matrix with TPM normalized counts (genes symbols as rows and samples
  as columns).

- signatures:

  Path where signatures files are located

- workers:

  Number of processes available to run on parallel.

## Value

A matrix with cell abundance deconvolve with DWLS
