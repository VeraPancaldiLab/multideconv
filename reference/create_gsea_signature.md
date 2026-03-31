# Build a GSEA-Derived Signature Label for a Cell Subgroup

Runs fgsea on ranked genes and creates a subgroup signature name based
on the top positively enriched pathway.

## Usage

``` r
create_gsea_signature(gene_scores, cell_type, pathways = NULL, plot = FALSE)
```

## Arguments

- gene_scores:

  Data frame of ranked scores (as produced by
  [`compute_data_driven_rank()`](https://verapancaldilab.github.io/multideconv/reference/compute_data_driven_rank.md)).

- cell_type:

  Character label used as prefix in the generated signature name.

- pathways:

  Optional named list of pathways (`pathway -> genes`). If `NULL`,
  Hallmark pathways from `msigdbr` are used.

- plot:

  Logical; if `TRUE`, save a top-20 fgsea dot plot in `Results/`.

## Value

A list with two elements: `[[1]]` generated signature name, `[[2]]` a
named list of enriched pathways.
