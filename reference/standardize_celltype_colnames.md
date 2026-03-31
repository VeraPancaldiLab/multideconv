# Standardize Cell Type Column Names

This function standardizes the column names of a matrix containing cell
type data.

## Usage

``` r
standardize_celltype_colnames(mat)
```

## Arguments

- mat:

  A matrix with cell type data.

## Value

A matrix with standardized cell type column names.

## Examples

``` r
mat <- matrix(rnorm(30), nrow = 10, ncol = 3)
colnames(mat) <- c("Macrophage_M0", "Macrophage_M1", "Macrophage_M2")
standardized_mat <- multideconv:::standardize_celltype_colnames(mat)

```
