# Canonical cell type nomenclature used by multideconv

Returns the vector of cell type names recognized by multideconv's
deconvolution output column naming (e.g. "B.cells", "CD4.regulatory",
"Plasma").

## Usage

``` r
get_cell_type_nomenclature(cells_extra = NULL)
```

## Arguments

- cells_extra:

  Optional character vector of additional cell type names to append
  (e.g. names from a custom signature not included by default).

## Value

A character vector of cell type names.

## Examples

``` r
get_cell_type_nomenclature()
#>  [1] "B.cells"                      "B.naive.cells"               
#>  [3] "B.memory.cells"               "Macrophages.cells"           
#>  [5] "Macrophages.M0"               "Macrophages.M1"              
#>  [7] "Macrophages.M2"               "Monocytes"                   
#>  [9] "Neutrophils"                  "NK.cells"                    
#> [11] "NK.activated"                 "NK.resting"                  
#> [13] "NKT.cells"                    "CD4.cells"                   
#> [15] "CD4.memory.activated"         "CD4.memory.resting"          
#> [17] "CD4.naive"                    "CD8.cells"                   
#> [19] "CD4.regulatory"               "CD4.non.regulatory"          
#> [21] "T.cells.helper"               "T.cells.gamma.delta"         
#> [23] "Dendritic.cells"              "Dendritic.activated.cells"   
#> [25] "Dendritic.resting.cells"      "Cancer"                      
#> [27] "Endothelial"                  "Eosinophils"                 
#> [29] "Plasma"                       "Myocytes"                    
#> [31] "Fibroblasts"                  "Mast.cells"                  
#> [33] "Mast.activated.cells"         "Mast.resting.cells"          
#> [35] "CAF"                          "Dendritic.plasmacytoid.cells"
#> [37] "Myeloid.cells"                "Basophils"                   
#> [39] "Epithelial"                   "Pericytes"                   
#> [41] "Mural.cells"                  "T.cells.proliferative"       
#> [43] "uncharacterized_cell"        
get_cell_type_nomenclature(cells_extra = "mesenchymal")
#>  [1] "B.cells"                      "B.naive.cells"               
#>  [3] "B.memory.cells"               "Macrophages.cells"           
#>  [5] "Macrophages.M0"               "Macrophages.M1"              
#>  [7] "Macrophages.M2"               "Monocytes"                   
#>  [9] "Neutrophils"                  "NK.cells"                    
#> [11] "NK.activated"                 "NK.resting"                  
#> [13] "NKT.cells"                    "CD4.cells"                   
#> [15] "CD4.memory.activated"         "CD4.memory.resting"          
#> [17] "CD4.naive"                    "CD8.cells"                   
#> [19] "CD4.regulatory"               "CD4.non.regulatory"          
#> [21] "T.cells.helper"               "T.cells.gamma.delta"         
#> [23] "Dendritic.cells"              "Dendritic.activated.cells"   
#> [25] "Dendritic.resting.cells"      "Cancer"                      
#> [27] "Endothelial"                  "Eosinophils"                 
#> [29] "Plasma"                       "Myocytes"                    
#> [31] "Fibroblasts"                  "Mast.cells"                  
#> [33] "Mast.activated.cells"         "Mast.resting.cells"          
#> [35] "CAF"                          "Dendritic.plasmacytoid.cells"
#> [37] "Myeloid.cells"                "Basophils"                   
#> [39] "Epithelial"                   "Pericytes"                   
#> [41] "Mural.cells"                  "T.cells.proliferative"       
#> [43] "uncharacterized_cell"         "mesenchymal"                 
```
