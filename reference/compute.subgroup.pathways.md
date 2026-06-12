# Relate Deconvolution Subgroups to Pathway Activities

Correlates deconvolution subgroup profiles with a pre-computed pathway
activity matrix and saves one heatmap per cell type to `Results/`. Use
an external tool such as
[CellTFusion](https://github.com/VeraPancaldiLab/CellTFusion) to compute
pathway activity scores (e.g. PROGENy) before calling this function.

## Usage

``` r
compute.subgroup.pathways(
  subgroups,
  pathways = NULL,
  file_name = "Test",
  height = 6,
  width = 12,
  par_mar = c(4, 25, 5, 3),
  pval = 0.05
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

- height:

  Plot height in inches (passed to
  [`ggplot2::ggsave()`](https://ggplot2.tidyverse.org/reference/ggsave.html)).

- width:

  Plot width in inches (passed to
  [`ggplot2::ggsave()`](https://ggplot2.tidyverse.org/reference/ggsave.html)).

- par_mar:

  Ignored; kept for backwards compatibility.

- pval:

  P-value threshold; correlations above this are not starred.

## Value

Invisibly returns `NULL`; side effects are PDF files in `Results/`.
