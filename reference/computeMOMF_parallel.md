# Compute MOMF in parallel across multiple signatures

Compute MOMF in parallel across multiple signatures

## Usage

``` r
computeMOMF_parallel(TPM_matrix, sc_object, signatures, workers)
```

## Arguments

- TPM_matrix:

  A matrix with TPM normalized counts (genes symbols as rows and samples
  as columns).

- sc_object:

  A matrix with the counts from scRNAseq object (genes as rows and cells
  as columns)

- signatures:

  Path where signatures files are located

- workers:

  Number of processes available to run on parallel.

## Value

A matrix with cell abundance deconvolve with MOMF
