# Build a Deconvolution–Pathway Relationship Dictionary

The `deconvolution_dictionary()` function integrates cell-type–specific
deconvolution features with a pathway activity matrix. It identifies
globally consistent pathway clusters and reannotates each deconvolution
feature according to its association with those pathway clusters.

The function first computes a global correlation matrix between the full
deconvolution matrix and the provided pathway activity matrix, performs
hierarchical clustering on the pathways, and automatically determines
the optimal number of pathway clusters using the silhouette method. Each
deconvolution feature within each cell type is then correlated with the
pathways, scored against the global clusters, and classified into the
cluster with which it is most strongly associated.

## Usage

``` r
deconvolution_dictionary(deconv_subgroups, pathway_matrix)
```

## Arguments

- deconv_subgroups:

  Output of
  [`compute.deconvolution.analysis()`](https://verapancaldilab.github.io/multideconv/reference/compute.deconvolution.analysis.md)

- pathway_matrix:

  A numeric matrix or data frame of pathway activities (rows = samples,
  columns = pathways), with the same row names as the deconvolution
  matrices. Can be any pathway or feature activity matrix.

## Value

An updated version of `deconv_subgroups` containing:

- `Deconvolution matrix`:

  A rebuilt deconvolution matrix obtained by column-binding all
  cell-type–specific subgroups after relabeling features with their
  corresponding pathway cluster.

- `Deconvolution subgroups per cell types`:

  The list of cell-type– specific matrices, each with feature names
  updated to reflect their cluster classification (e.g.,
  `"FeatureA_Cluster_1"`).

- `Clusters`:

  A list of globally defined pathway clusters (e.g., `$Cluster_1`,
  `$Cluster_2`, ...), where each element contains the pathways belonging
  to that cluster.

## Details

- The optimal number of pathway clusters (\\k\\) is determined
  automatically using the silhouette width criterion via
  [`factoextra::fviz_nbclust()`](https://rdrr.io/pkg/factoextra/man/fviz_nbclust.html).

- The clustering is performed globally across all pathways, ensuring
  consistent interpretation of clusters across all cell types.

- Each deconvolution feature is assigned to the pathway cluster with the
  highest eigenvector score.

## See also

`compute.modules.relationship`,
[`fviz_nbclust`](https://rdrr.io/pkg/factoextra/man/fviz_nbclust.html),
[`hclust`](https://rdrr.io/r/stats/hclust.html),
[`cutree`](https://rdrr.io/r/stats/cutree.html)
