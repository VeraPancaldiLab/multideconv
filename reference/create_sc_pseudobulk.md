# Create pseudo bulk from single cell object

Sums the counts of all the cells of each sample, producing one bulk-like
expression profile per sample.

## Usage

``` r
create_sc_pseudobulk(
  sc_obj,
  cells_labels = NULL,
  sample_labels,
  normalized = TRUE,
  file_name = "Pseudobulk",
  return = TRUE
)
```

## Arguments

- sc_obj:

  A Seurat single cell object

- cells_labels:

  Not used (kept so existing calls keep working). The pseudobulk is
  aggregated per sample only.

- sample_labels:

  Name of the metadata column with the sample labels.

- normalized:

  Whether pseudobulk should be or not TPM normalized

- file_name:

  A string specifying the name of the .csv pseudobulk saved in Results/

- return:

  Whether to save or not the csv file with the pseudobulk in Results/

## Value

A gene count matrix (genes as rows and samples as columns)
