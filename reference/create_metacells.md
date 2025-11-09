# Create meta-cells from a single cell object using the KNN algorithm. This function is adapted from the R package hdWGCNA (Morabito et al., 2023)

Create meta-cells from a single cell object using the KNN algorithm.
This function is adapted from the R package hdWGCNA (Morabito et al.,
2023)

## Usage

``` r
create_metacells(
  sc_object,
  labels_column,
  samples_column,
  exclude_cells = NULL,
  min_cells = 50,
  k = 15,
  max_shared = 15,
  n_workers = 4,
  min_meta = 10
)
```

## Arguments

- sc_object:

  A matrix with the counts from scRNAseq object (genes as rows and cells
  as columns)

- labels_column:

  A character vector with the cell labels (need to be of the same order
  as in the sc_object)

- samples_column:

  A character vector with the samples labels (need to be of the same
  order as in the sc_object)

- exclude_cells:

  Cell types to discard from metacell algorithm.

- min_cells:

  The minimum number of cells in a particular grouping to construct
  metacells.

- k:

  Number of nearest neighbors to aggregate for KNN algorithm.

- max_shared:

  The maximum number of cells to be shared across two metacells.

- n_workers:

  Number of cores to use for paralellization.

- min_meta:

  Minimum number of metacells allowed. Below this number, metacells of
  this cell type will be discarded.

## Value

A list with two elements:

- The metacell count matrix (genes as rownames and cells as columns)

- The metadata matrix corresponding to the metacell object

## References

Langfelder, P., Horvath, S. WGCNA: an R package for weighted correlation
network analysis. BMC Bioinformatics 9, 559 (2008).
https://doi.org/10.1186/1471-2105-9-559

Morabito, S., Reese, F., Rahimzadeh, N., Miyoshi, E., & Swarup, V.
(2023). hdWGCNA identifies co-expression networks in high-dimensional
transcriptomics data. Cell Reports Methods, 3(6), 100498.
https://doi.org/10.1016/j.crmeth.2023.100498
