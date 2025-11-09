# Create pseudo bulk from single cell object

Create pseudo bulk from single cell object

## Usage

``` r
create_sc_pseudobulk(
  sc_obj,
  cells_labels,
  sample_labels,
  normalized = TRUE,
  file_name
)
```

## Arguments

- sc_obj:

  A Seurat single cell object

- cells_labels:

  A character vector with the cell labels (need to be of the same order
  as in the sc_obj)

- sample_labels:

  A character vector with the samples labels (need to be of the same
  order as in the sc_obj)

- normalized:

  Whether pseudobulk should be or not TPM normalized

- file_name:

  A string specifying the name of the .csv pseudobulk saved in Results/

## Value

A gene count matrix (genes as rows and samples as columns)
