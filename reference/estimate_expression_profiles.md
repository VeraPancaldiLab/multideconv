# Estimate Cell-Type-Specific Expression Profiles from Bulk Data

Uses non-negative least squares (NNLS) to decompose bulk gene expression
into cell-type-specific expression estimates, given known cell-type
fractions.

## Usage

``` r
estimate_expression_profiles(bulk_expr, cell_fracs)
```

## Arguments

- bulk_expr:

  A numeric matrix of bulk gene expression with genes as rows and
  samples as columns.

- cell_fracs:

  A numeric matrix of cell-type fractions with samples as rows and cell
  types as columns. Row names must match column names of `bulk_expr`.

## Value

A named list of matrices, one per cell type. Each matrix has samples as
rows and genes as columns, containing the estimated expression
contribution of that cell type.
