# Relate Deconvolution Subgroups to Pathway Activities

Correlates deconvolution subgroup profiles with a pre-computed pathway
activity matrix, saves one heatmap per cell type to `Results/` and
returns the correlations and p-values.

## Usage

``` r
compute.subgroup.pathways(
  subgroups,
  pathways = NULL,
  file_name = "Test",
  height = NULL,
  width = NULL,
  par_mar = c(4, 25, 5, 3),
  pval = 0.05,
  corr_type = "pearson"
)
```

## Arguments

- subgroups:

  Output list from
  [`compute.deconvolution.analysis()`](https://verapancaldilab.github.io/multideconv/reference/compute.deconvolution.analysis.md).

- pathways:

  A numeric matrix or data frame with samples as rows and pathway
  activities as columns. Row names must match sample identifiers in
  `subgroups`.

- file_name:

  Character prefix used when naming output PDF files.

- height, width:

  Plot height and width in inches (passed to
  [`ggplot2::ggsave()`](https://ggplot2.tidyverse.org/reference/ggsave.html)).
  If `NULL` (default), the size is chosen from the number of subgroups
  and pathways.

- par_mar:

  Ignored; kept for backwards compatibility.

- pval:

  P-value threshold; correlations above this are not starred.

- corr_type:

  Correlation type, "pearson" (default) or "spearman".

## Value

Invisibly, a list with one element per cell type, each holding
`correlations` and `pvalues` (subgroups as rows, pathways as columns).
One PDF heatmap per cell type is also saved in `Results/`.
