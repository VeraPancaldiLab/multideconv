# Compute deconvolution methods with variable signatures

Compute deconvolution methods with variable signatures

## Usage

``` r
compute_methods_variable_signature(
  TPM_matrix,
  signatures,
  algos = c("CBSX", "Epidish", "DeconRNASeq", "DWLS", "MOMF"),
  signatures_select = NULL,
  cbsx.name,
  cbsx.token,
  doParallel = FALSE,
  workers = NULL,
  sc_obj = NULL
)
```

## Arguments

- TPM_matrix:

  A matrix with TPM normalized counts (samples as columns and genes
  symbols as rows)

- signatures:

  A path with a directory where signatures are located

- algos:

  A character vector with the methods to compute (Default methods are
  CBSX, Epidish, DeconRNASeq and DWLS)

- signatures_select:

  (Optional) A character vector with the signature names to run. If NULL
  (default), all available signatures are used (package + custom).

- cbsx.name:

  CIBERSORTx credential mail if CBSX will be run

- cbsx.token:

  CIBERSORTx credential token if CBSX will be run

- doParallel:

  Boolean value to specify if DWLS and CBSX should run in parallel
  (default is False)

- workers:

  Number of worker process to run during parallelization (default is
  NULL)

- sc_obj:

  A matrix with the counts from scRNAseq object (genes as rows and cells
  as columns) to run MOMF method. If NULL, MOMF is ignored.

## Value

A matrix with the deconvolution features corresponding to all
combinations of methods-signatures specified

## References

Sturm, G., Finotello, F., Petitprez, F., Zhang, J. D., Baumbach, J.,
Fridman, W. H., ..., List, M., Aneichyk, T. (2019). Comprehensive
evaluation of transcriptome-based cell-type quantification methods for
immuno-oncology. Bioinformatics, 35(14), i436-i445.
https://doi.org/10.1093/bioinformatics/btz363

Benchmarking second-generation methods for cell-type deconvolution of
transcriptomic data. Dietrich, Alexander and Merotto, Lorenzo and Pelz,
Konstantin and Eder, Bernhard and Zackl, Constantin and Reinisch,
Katharina and Edenhofer, Frank and Marini, Federico and Sturm, Gregor
and List, Markus and Finotello, Francesca. (2024)
https://doi.org/10.1101/2024.06.10.598226
