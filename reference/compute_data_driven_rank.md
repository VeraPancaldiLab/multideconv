# Rank Genes by Correlation With a Deconvolution Subgroup

Computes a data-driven gene ranking by correlating expression values
with a selected deconvolution subgroup across matched samples.

## Usage

``` r
compute_data_driven_rank(res, expr, deconv, subgroup, method = "spearman")
```

## Arguments

- res:

  Data frame containing at least a `gene` column with genes to evaluate.

- expr:

  Gene expression matrix with genes in rows and samples in columns.

- deconv:

  Deconvolution matrix with samples in rows and features/subgroups in
  columns.

- subgroup:

  Character scalar indicating the subgroup/feature column in `deconv`.

- method:

  Correlation method passed to
  [`stats::cor()`](https://rdrr.io/r/stats/cor.html), typically
  `"spearman"` or `"pearson"`.

## Value

A data frame sorted in descending correlation, with one column named
`correlation` and row names corresponding to genes.
