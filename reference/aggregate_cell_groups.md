# Aggregate cell types into groups

Adds, for every method-signature combination, a new feature
`<method>_<signature>_<group>` with the sum of the cell types of the
group (e.g. Myeloid cells = macrophages + monocytes + dendritic cells).
Cell types are only summed within the same method-signature combination,
and the original features are kept.

## Usage

``` r
aggregate_cell_groups(
  deconvolution,
  cell_groups,
  min_types = 2,
  verbose = TRUE
)
```

## Arguments

- deconvolution:

  Deconvolution output of compute.deconvolution() with features as
  columns and samples as rows

- cell_groups:

  A named list: each name is a group and each element a character vector
  with the cell types to sum, written as in
  [`get_cell_type_nomenclature()`](https://verapancaldilab.github.io/multideconv/reference/get_cell_type_nomenclature.md)
  (e.g. `list(Myeloid.cells = c("Macrophages.M1", "Monocytes"))`). A
  group name can be a cell type of the nomenclature (e.g.
  `Myeloid.cells`): combinations that already estimate it are left as
  they are. Other group names must not contain `_` nor the name of a
  cell type of the nomenclature. The cell types of a group should not
  overlap (do not list a cell type together with its own subtypes).

- min_types:

  Minimum number of cell types of the group that a method-signature
  combination must have to be aggregated. Combinations with fewer are
  skipped (with 1, the group would be a copy of a single cell type).

- verbose:

  Boolean value to whether print the cell types summed in each
  method-signature combination

## Value

The deconvolution matrix with the group features added as new columns.

## Details

Group names that are not in the nomenclature (e.g. `Lymphocytes`) need
to be given in `cells_extra` to
[`compute.deconvolution.analysis()`](https://verapancaldilab.github.io/multideconv/reference/compute.deconvolution.analysis.md)
and
[`compute.benchmark()`](https://verapancaldilab.github.io/multideconv/reference/compute.benchmark.md).
The `cell_groups` argument of
[`compute.deconvolution.analysis()`](https://verapancaldilab.github.io/multideconv/reference/compute.deconvolution.analysis.md)
does both steps at once.

## Examples

``` r

data("deconvolution")

groups = list(Myeloid.cells = c("Macrophages.cells", "Macrophages.M0", "Macrophages.M1", "Macrophages.M2",
                                "Monocytes", "Dendritic.cells"),
              Lymphocytes = c("B.cells", "CD4.cells", "CD8.cells", "NK.cells"))

deconvolution_groups = aggregate_cell_groups(deconvolution, cell_groups = groups)
#> 
#> Group 'Myeloid.cells'
#>   Quantiseq: Macrophages.M1 + Macrophages.M2 + Monocytes + Dendritic.cells
#>   DeconRNASeq_BPRNACan: Macrophages.M0 + Macrophages.M1 + Macrophages.M2 + Monocytes
#>   Epidish_BPRNACan: Macrophages.M0 + Macrophages.M1 + Macrophages.M2 + Monocytes
#>   CBSX_BPRNACan: Macrophages.M0 + Macrophages.M1 + Macrophages.M2 + Monocytes
#>   DWLS_BPRNACan: Macrophages.M0 + Macrophages.M1 + Macrophages.M2 + Monocytes
#>   DeconRNASeq_BPRNACan3DProMet: Macrophages.M0 + Macrophages.M1 + Macrophages.M2 + Monocytes
#>   Epidish_BPRNACan3DProMet: Macrophages.M0 + Macrophages.M1 + Macrophages.M2 + Monocytes
#>   CBSX_BPRNACan3DProMet: Macrophages.M0 + Macrophages.M1 + Macrophages.M2 + Monocytes
#>   DWLS_BPRNACan3DProMet: Macrophages.M0 + Macrophages.M1 + Macrophages.M2 + Monocytes
#>   DeconRNASeq_BPRNACanProMet: Macrophages.M0 + Macrophages.M1 + Macrophages.M2 + Monocytes
#>   Epidish_BPRNACanProMet: Macrophages.M0 + Macrophages.M1 + Macrophages.M2 + Monocytes
#>   CBSX_BPRNACanProMet: Macrophages.M0 + Macrophages.M1 + Macrophages.M2 + Monocytes
#>   DWLS_BPRNACanProMet: Macrophages.M0 + Macrophages.M1 + Macrophages.M2 + Monocytes
#>   DeconRNASeq_BSeqSC.Vanderbilt.scRNAseq: already has Myeloid.cells (kept as it is)
#>   Epidish_BSeqSC.Vanderbilt.scRNAseq: already has Myeloid.cells (kept as it is)
#>   CBSX_BSeqSC.Vanderbilt.scRNAseq: already has Myeloid.cells (kept as it is)
#>   DWLS_BSeqSC.Vanderbilt.scRNAseq: already has Myeloid.cells (kept as it is)
#>   DeconRNASeq_CBSX.HNSCC.scRNAseq: Macrophages.cells + Dendritic.cells
#>   Epidish_CBSX.HNSCC.scRNAseq: Macrophages.cells + Dendritic.cells
#>   CBSX_CBSX.HNSCC.scRNAseq: Macrophages.cells + Dendritic.cells
#>   DWLS_CBSX.HNSCC.scRNAseq: Macrophages.cells + Dendritic.cells
#>   DeconRNASeq_CBSX.Melanoma.scRNAseq: skipped (1 member: Macrophages.cells)
#>   Epidish_CBSX.Melanoma.scRNAseq: skipped (1 member: Macrophages.cells)
#>   CBSX_CBSX.Melanoma.scRNAseq: skipped (1 member: Macrophages.cells)
#>   DWLS_CBSX.Melanoma.scRNAseq: skipped (1 member: Macrophages.cells)
#>   DeconRNASeq_CBSX.NSCLC.PBMCs.scRNAseq: skipped (1 member: Monocytes)
#>   Epidish_CBSX.NSCLC.PBMCs.scRNAseq: skipped (1 member: Monocytes)
#>   CBSX_CBSX.NSCLC.PBMCs.scRNAseq: skipped (1 member: Monocytes)
#>   DWLS_CBSX.NSCLC.PBMCs.scRNAseq: skipped (1 member: Monocytes)
#>   DeconRNASeq_CBSX.Vanderbilt.scRNAseq: already has Myeloid.cells (kept as it is)
#>   Epidish_CBSX.Vanderbilt.scRNAseq: already has Myeloid.cells (kept as it is)
#>   CBSX_CBSX.Vanderbilt.scRNAseq: already has Myeloid.cells (kept as it is)
#>   DWLS_CBSX.Vanderbilt.scRNAseq: already has Myeloid.cells (kept as it is)
#>   DeconRNASeq_CCLE.TIL10: Macrophages.M1 + Macrophages.M2 + Monocytes + Dendritic.cells
#>   Epidish_CCLE.TIL10: Macrophages.M1 + Macrophages.M2 + Monocytes + Dendritic.cells
#>   CBSX_CCLE.TIL10: Macrophages.M1 + Macrophages.M2 + Monocytes + Dendritic.cells
#>   DWLS_CCLE.TIL10: Macrophages.M1 + Macrophages.M2 + Monocytes + Dendritic.cells
#>   DeconRNASeq_DWLS.Vanderbilt.scRNAseq: already has Myeloid.cells (kept as it is)
#>   Epidish_DWLS.Vanderbilt.scRNAseq: already has Myeloid.cells (kept as it is)
#>   CBSX_DWLS.Vanderbilt.scRNAseq: already has Myeloid.cells (kept as it is)
#>   DWLS_DWLS.Vanderbilt.scRNAseq: already has Myeloid.cells (kept as it is)
#>   DeconRNASeq_MOMF.Vanderbilt.scRNAseq: already has Myeloid.cells (kept as it is)
#>   Epidish_MOMF.Vanderbilt.scRNAseq: already has Myeloid.cells (kept as it is)
#>   CBSX_MOMF.Vanderbilt.scRNAseq: already has Myeloid.cells (kept as it is)
#>   DWLS_MOMF.Vanderbilt.scRNAseq: already has Myeloid.cells (kept as it is)
#>   DeconRNASeq_TIL10: Macrophages.M1 + Macrophages.M2 + Monocytes + Dendritic.cells
#>   Epidish_TIL10: Macrophages.M1 + Macrophages.M2 + Monocytes + Dendritic.cells
#>   CBSX_TIL10: Macrophages.M1 + Macrophages.M2 + Monocytes + Dendritic.cells
#>   DWLS_TIL10: Macrophages.M1 + Macrophages.M2 + Monocytes + Dendritic.cells
#>   AutogeneS_Vanderbilt: already has Myeloid.cells (kept as it is)
#>   BayesPrism_Vanderbilt: already has Myeloid.cells (kept as it is)
#>   Bisque_Vanderbilt: already has Myeloid.cells (kept as it is)
#>   CPM_Vanderbilt: already has Myeloid.cells (kept as it is)
#>   MuSic_Vanderbilt: already has Myeloid.cells (kept as it is)
#>   SCDC_Vanderbilt: already has Myeloid.cells (kept as it is)
#>   DeconRNASeq_LM22: Macrophages.M0 + Macrophages.M1 + Macrophages.M2 + Monocytes
#>   Epidish_LM22: Macrophages.M0 + Macrophages.M1 + Macrophages.M2 + Monocytes
#>   CBSX_LM22: Macrophages.M0 + Macrophages.M1 + Macrophages.M2 + Monocytes
#>   DWLS_LM22: Macrophages.M0 + Macrophages.M1 + Macrophages.M2 + Monocytes
#> 
#> Group 'Lymphocytes'
#>   Quantiseq: B.cells + CD8.cells + NK.cells
#>   DeconRNASeq_BPRNACan: B.cells + CD4.cells + CD8.cells + NK.cells
#>   Epidish_BPRNACan: B.cells + CD4.cells + CD8.cells + NK.cells
#>   CBSX_BPRNACan: B.cells + CD4.cells + CD8.cells + NK.cells
#>   DWLS_BPRNACan: B.cells + CD4.cells + CD8.cells + NK.cells
#>   DeconRNASeq_BPRNACan3DProMet: B.cells + CD4.cells + CD8.cells + NK.cells
#>   Epidish_BPRNACan3DProMet: B.cells + CD4.cells + CD8.cells + NK.cells
#>   CBSX_BPRNACan3DProMet: B.cells + CD4.cells + CD8.cells + NK.cells
#>   DWLS_BPRNACan3DProMet: B.cells + CD4.cells + CD8.cells + NK.cells
#>   DeconRNASeq_BPRNACanProMet: B.cells + CD4.cells + CD8.cells + NK.cells
#>   Epidish_BPRNACanProMet: B.cells + CD4.cells + CD8.cells + NK.cells
#>   CBSX_BPRNACanProMet: B.cells + CD4.cells + CD8.cells + NK.cells
#>   DWLS_BPRNACanProMet: B.cells + CD4.cells + CD8.cells + NK.cells
#>   DeconRNASeq_BSeqSC.Vanderbilt.scRNAseq: B.cells + CD4.cells + CD8.cells + NK.cells
#>   Epidish_BSeqSC.Vanderbilt.scRNAseq: B.cells + CD4.cells + CD8.cells + NK.cells
#>   CBSX_BSeqSC.Vanderbilt.scRNAseq: B.cells + CD4.cells + CD8.cells + NK.cells
#>   DWLS_BSeqSC.Vanderbilt.scRNAseq: B.cells + CD4.cells + CD8.cells + NK.cells
#>   DeconRNASeq_CBSX.HNSCC.scRNAseq: B.cells + CD4.cells + CD8.cells
#>   Epidish_CBSX.HNSCC.scRNAseq: B.cells + CD4.cells + CD8.cells
#>   CBSX_CBSX.HNSCC.scRNAseq: B.cells + CD4.cells + CD8.cells
#>   DWLS_CBSX.HNSCC.scRNAseq: B.cells + CD4.cells + CD8.cells
#>   DeconRNASeq_CBSX.Melanoma.scRNAseq: B.cells + CD4.cells + CD8.cells + NK.cells
#>   Epidish_CBSX.Melanoma.scRNAseq: B.cells + CD4.cells + CD8.cells + NK.cells
#>   CBSX_CBSX.Melanoma.scRNAseq: B.cells + CD4.cells + CD8.cells + NK.cells
#>   DWLS_CBSX.Melanoma.scRNAseq: B.cells + CD4.cells + CD8.cells + NK.cells
#>   DeconRNASeq_CBSX.NSCLC.PBMCs.scRNAseq: B.cells + CD4.cells + CD8.cells + NK.cells
#>   Epidish_CBSX.NSCLC.PBMCs.scRNAseq: B.cells + CD4.cells + CD8.cells + NK.cells
#>   CBSX_CBSX.NSCLC.PBMCs.scRNAseq: B.cells + CD4.cells + CD8.cells + NK.cells
#>   DWLS_CBSX.NSCLC.PBMCs.scRNAseq: B.cells + CD4.cells + CD8.cells + NK.cells
#>   DeconRNASeq_CBSX.Vanderbilt.scRNAseq: B.cells + CD4.cells + CD8.cells + NK.cells
#>   Epidish_CBSX.Vanderbilt.scRNAseq: B.cells + CD4.cells + CD8.cells + NK.cells
#>   CBSX_CBSX.Vanderbilt.scRNAseq: B.cells + CD4.cells + CD8.cells + NK.cells
#>   DWLS_CBSX.Vanderbilt.scRNAseq: B.cells + CD4.cells + CD8.cells + NK.cells
#>   DeconRNASeq_CCLE.TIL10: B.cells + CD4.cells + CD8.cells + NK.cells
#>   Epidish_CCLE.TIL10: B.cells + CD4.cells + CD8.cells + NK.cells
#>   CBSX_CCLE.TIL10: B.cells + CD4.cells + CD8.cells + NK.cells
#>   DWLS_CCLE.TIL10: B.cells + CD4.cells + CD8.cells + NK.cells
#>   DeconRNASeq_DWLS.Vanderbilt.scRNAseq: B.cells + CD4.cells + CD8.cells + NK.cells
#>   Epidish_DWLS.Vanderbilt.scRNAseq: B.cells + CD4.cells + CD8.cells + NK.cells
#>   CBSX_DWLS.Vanderbilt.scRNAseq: B.cells + CD4.cells + CD8.cells + NK.cells
#>   DWLS_DWLS.Vanderbilt.scRNAseq: B.cells + CD4.cells + CD8.cells + NK.cells
#>   DeconRNASeq_MOMF.Vanderbilt.scRNAseq: B.cells + CD4.cells + CD8.cells + NK.cells
#>   Epidish_MOMF.Vanderbilt.scRNAseq: B.cells + CD4.cells + CD8.cells + NK.cells
#>   CBSX_MOMF.Vanderbilt.scRNAseq: B.cells + CD4.cells + CD8.cells + NK.cells
#>   DWLS_MOMF.Vanderbilt.scRNAseq: B.cells + CD4.cells + CD8.cells + NK.cells
#>   DeconRNASeq_TIL10: B.cells + CD4.cells + CD8.cells + NK.cells
#>   Epidish_TIL10: B.cells + CD4.cells + CD8.cells + NK.cells
#>   CBSX_TIL10: B.cells + CD4.cells + CD8.cells + NK.cells
#>   DWLS_TIL10: B.cells + CD4.cells + CD8.cells + NK.cells
#>   AutogeneS_Vanderbilt: B.cells + CD4.cells + CD8.cells + NK.cells
#>   BayesPrism_Vanderbilt: B.cells + CD4.cells + CD8.cells + NK.cells
#>   Bisque_Vanderbilt: B.cells + CD4.cells + CD8.cells + NK.cells
#>   CPM_Vanderbilt: B.cells + CD4.cells + CD8.cells + NK.cells
#>   MuSic_Vanderbilt: B.cells + CD4.cells + CD8.cells + NK.cells
#>   SCDC_Vanderbilt: B.cells + CD4.cells + CD8.cells + NK.cells
#>   DeconRNASeq_LM22: skipped (1 member: CD8.cells)
#>   Epidish_LM22: skipped (1 member: CD8.cells)
#>   CBSX_LM22: skipped (1 member: CD8.cells)
#>   DWLS_LM22: skipped (1 member: CD8.cells)
```
