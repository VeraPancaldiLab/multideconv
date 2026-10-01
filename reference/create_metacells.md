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
  max_shared = 10,
  n_workers = 4,
  min_meta = 10
)
```

## Arguments

- sc_object:

  A Seurat object with raw counts and a PCA already computed
  (`RunPCA()`), used to find each cell's nearest neighbours.

- labels_column:

  Name of the metadata column with the cell type labels.

- samples_column:

  Name of the metadata column with the sample labels.

- exclude_cells:

  Cell types to discard from metacell algorithm.

- min_cells:

  The minimum number of cells in a particular grouping to construct
  metacells.

- k:

  Number of nearest neighbors to aggregate for KNN algorithm.

- max_shared:

  The maximum number of cells to be shared across two metacells (keep it
  below `k`, otherwise metacells can overlap completely).

- n_workers:

  Number of cores to use for paralellization.

- min_meta:

  Minimum number of metacells allowed. Below this number, metacells of
  this cell type will be discarded.

## Value

A list with two elements:

- The metacell count matrix (genes as rownames and metacells as
  columns): each metacell is the sum of the counts of its `k` cells

- The metadata matrix corresponding to the metacell object

## References

Langfelder, P., Horvath, S. WGCNA: an R package for weighted correlation
network analysis. BMC Bioinformatics 9, 559 (2008).
https://doi.org/10.1186/1471-2105-9-559

Morabito, S., Reese, F., Rahimzadeh, N., Miyoshi, E., & Swarup, V.
(2023). hdWGCNA identifies co-expression networks in high-dimensional
transcriptomics data. Cell Reports Methods, 3(6), 100498.
https://doi.org/10.1016/j.crmeth.2023.100498
