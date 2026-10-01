# Create cell type signatures from scRNAseq

Create cell type signatures from scRNAseq

## Usage

``` r
create_sc_signatures(
  sc_obj,
  sc_metadata,
  cells_labels,
  sample_labels,
  credentials.mail = NULL,
  credentials.token = NULL,
  bulk_rna = NULL,
  cell_markers = NULL,
  name_signature = NULL,
  methods_sig = c("DWLS", "CIBERSORTx", "MOMF", "BSeqsc")
)
```

## Arguments

- sc_obj:

  A matrix with the counts from scRNAseq object (genes as rows and cells
  as columns)

- sc_metadata:

  Dataframe with metadata from the single cell object. The matrix should
  include the columns cell_label and sample_label.

- cells_labels:

  Name of the `sc_metadata` column with the cell type labels. The labels
  become the cell type names of the signatures, so they must follow the
  multideconv nomenclature (see
  [`get_cell_type_nomenclature()`](https://verapancaldilab.github.io/multideconv/reference/get_cell_type_nomenclature.md)
  and the README); otherwise those cell types are discarded later by
  [`compute.deconvolution.analysis()`](https://verapancaldilab.github.io/multideconv/reference/compute.deconvolution.analysis.md).

- sample_labels:

  Name of the `sc_metadata` column with the sample labels.

- credentials.mail:

  (Optional) Credential email for running CIBERSORTx If not provided,
  CIBERSORTx method will not be run.

- credentials.token:

  (Optional) Credential token for running CIBERSORTx. If not provided,
  CIBERSORTx method will not be run.

- bulk_rna:

  A matrix of bulk data. Rows are genes, columns are samples. This is
  needed for MOMF method, if not given the method will not be run.

- cell_markers:

  Named list with the genes markers names as Symbol per cell types to be
  used to create the signature using the BSeq-SC method. If NULL, the
  method will be ignored during the signature creation.

- name_signature:

  A string indicating the signature name, used in the file names (e.g.
  `DWLS-<name_signature>-scRNAseq.txt`). It must not contain `_`
  (replaced by `-`), which separates method, signature and cell type in
  the deconvolution column names.

- methods_sig:

  A character vector specifying which methods to run. Options are
  "DWLS", "CIBERSORTx" (or "CBSX"), "MOMF", and "BSeqsc". Default runs
  all available methods.

## Value

A list containing the cell signatures per method. Signatures are
directly saved in Results/custom_signatures folder (an existing file
with the same name is overwritten), these will be used to run
deconvolution.

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
