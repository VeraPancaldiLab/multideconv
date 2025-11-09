# Cell types split from deconvolution

Cell types split from deconvolution

## Usage

``` r
compute.cell.types(data, cells_extra = NULL)
```

## Arguments

- data:

  A matrix with the deconvolution results

- cells_extra:

  A string specifying the cells names to consider and that are not
  including in the nomenclature of multideconv (see Readme)

## Value

A list containing:

- A sublist with each cell type features as an element recover from the
  different signatures

- Discarded cell types (this will happen if the cell types are not
  supported. See the READme for more information about this)

## Examples

``` r
data("deconvolution")

cells_types = compute.cell.types(deconvolution)
cells = cells_types[[1]]
cells_discarded = cells_types[[2]]
cells_types = compute.cell.types(deconvolution, cells_extra = c("mesenchymal", "basophils"))
```
