# Compute a Deconvolution Dictionary From Subgroup Gene Programs

For each subgroup, this function aggregates signature genes, ranks genes
by correlation with subgroup abundance, performs GSEA, and renames
subgroup labels using the top enriched pathway.

## Usage

``` r
compute_deconvolution_dictionary(
  subgroups,
  expr,
  pathways = NULL,
  plot = FALSE
)
```

## Arguments

- subgroups:

  Output list from
  [`compute.deconvolution.analysis()`](https://verapancaldilab.github.io/multideconv/reference/compute.deconvolution.analysis.md).

- expr:

  Gene expression matrix with genes in rows and samples in columns.

- pathways:

  Optional named list of pathways (`pathway -> genes`) used by fgsea. If
  `NULL`, Hallmark pathways are used.

- plot:

  Logical; if `TRUE`, save GSEA summary plots in `Results/`.

## Value

Updated `subgroups` list with renamed subgroup labels in
`"Deconvolution matrix"` and `"Deconvolution subgroups composition"`.
