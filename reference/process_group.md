# Build metacells for one cell type and sample group

Worker function of
[`create_metacells()`](https://verapancaldilab.github.io/multideconv/reference/create_metacells.md):
runs hdWGCNA's `MetacellsByGroups()` on the cells of one cell type from
one sample and returns the metacell counts and metadata.

## Usage

``` r
process_group(
  data,
  min_cells = 50,
  k = 15,
  max_shared = 10,
  labels_column,
  samples_column
)
```

## Arguments

- data:

  A Seurat object with the cells of one cell type from one sample (must
  contain a `pca` reduction).

- min_cells:

  Minimum number of cells required to build metacells; smaller groups
  are skipped.

- k:

  Number of nearest neighbours aggregated into each metacell.

- max_shared:

  Maximum number of cells shared between two metacells.

- labels_column:

  Name of the metadata column with the cell type labels.

- samples_column:

  Name of the metadata column with the sample labels.

## Value

A list with `counts` (genes x metacells matrix of summed counts) and
`metadata` (metacell metadata), or `NULL` if the group has fewer than
`min_cells` cells.
