# Package index

## Main

Compute cell type deconvolution

- [`compute.deconvolution()`](https://verapancaldilab.github.io/multideconv/reference/compute.deconvolution.md)
  : Compute deconvolution
- [`compute.deconvolution.analysis()`](https://verapancaldilab.github.io/multideconv/reference/compute.deconvolution.analysis.md)
  : Compute cell type processing
- [`deconvolution_dictionary()`](https://verapancaldilab.github.io/multideconv/reference/deconvolution_dictionary.md)
  : Build a Deconvolution–Pathway Relationship Dictionary
- [`compute.deconvolution.preprocessing()`](https://verapancaldilab.github.io/multideconv/reference/compute.deconvolution.preprocessing.md)
  : Compute deconvolution preprocessing
- [`compute_methods_variable_signature()`](https://verapancaldilab.github.io/multideconv/reference/compute_methods_variable_signature.md)
  : Compute deconvolution methods with variable signatures
- [`replicate_deconvolution_subgroups()`](https://verapancaldilab.github.io/multideconv/reference/replicate_deconvolution_subgroups.md)
  : Replicate deconvolution subgroups in a new dataset
- [`prepare_multideconv_folds()`](https://verapancaldilab.github.io/multideconv/reference/prepare_multideconv_folds.md)
  : Prepare folds for multideconv cross-validation with processed
  training and test data

## Single cell functions

Single cell data manipulation for deconvolution

- [`create_metacells()`](https://verapancaldilab.github.io/multideconv/reference/create_metacells.md)
  : Create meta-cells from a single cell object using the KNN algorithm.
  This function is adapted from the R package hdWGCNA (Morabito et al.,
  2023)
- [`create_sc_pseudobulk()`](https://verapancaldilab.github.io/multideconv/reference/create_sc_pseudobulk.md)
  : Create pseudo bulk from single cell object
- [`create_sc_signatures()`](https://verapancaldilab.github.io/multideconv/reference/create_sc_signatures.md)
  : Create cell type signatures from scRNAseq
- [`compute_sc_deconvolution_methods()`](https://verapancaldilab.github.io/multideconv/reference/compute_sc_deconvolution_methods.md)
  : Compute second-generation deconvolution methods
- [`compute.benchmark()`](https://verapancaldilab.github.io/multideconv/reference/compute.benchmark.md)
  : Compute deconvolution benchmark

## Utils

Internal use (not exported functions)

- [`computeCBSX()`](https://verapancaldilab.github.io/multideconv/reference/computeCBSX.md)
  : Computes CIBERSORTx (CBSX) using one signature
- [`computeCBSX_parallel()`](https://verapancaldilab.github.io/multideconv/reference/computeCBSX_parallel.md)
  : Compute CIBERSORTx (CBSX) in parallel across multiple signatures
- [`computeDWLS()`](https://verapancaldilab.github.io/multideconv/reference/computeDWLS.md)
  : Computes DWLS
- [`computeDWLS_parallel()`](https://verapancaldilab.github.io/multideconv/reference/computeDWLS_parallel.md)
  : Compute DWLS in parallel across multiple signatures
- [`computeDeconRNASeq()`](https://verapancaldilab.github.io/multideconv/reference/computeDeconRNASeq.md)
  : Computes DeconRNASeq
- [`computeEpiDISH()`](https://verapancaldilab.github.io/multideconv/reference/computeEpiDISH.md)
  : Computes EpiDISH
- [`computeMCP()`](https://verapancaldilab.github.io/multideconv/reference/computeMCP.md)
  : Computes MCPcounter
- [`computeMOMF()`](https://verapancaldilab.github.io/multideconv/reference/computeMOMF.md)
  : Computes MOMF
- [`computeMOMF_parallel()`](https://verapancaldilab.github.io/multideconv/reference/computeMOMF_parallel.md)
  : Compute MOMF in parallel across multiple signatures
- [`computeQuantiseq()`](https://verapancaldilab.github.io/multideconv/reference/computeQuantiseq.md)
  : Computes QuanTIseq
- [`computeXCell()`](https://verapancaldilab.github.io/multideconv/reference/computeXCell.md)
  : Computes XCell
- [`compute_subgroups()`](https://verapancaldilab.github.io/multideconv/reference/compute_subgroups.md)
  : Compute deconvolution subgroups
- [`compute.cell.types()`](https://verapancaldilab.github.io/multideconv/reference/compute.cell.types.md)
  : Cell types split from deconvolution
- [`remove_subgroups()`](https://verapancaldilab.github.io/multideconv/reference/remove_subgroups.md)
  : Remove subgroups that have the same method across different
  signatures
- [`remove_low_variance()`](https://verapancaldilab.github.io/multideconv/reference/remove_low_variance.md)
  : Remove low variance deconvolution features
- [`find.maximum.iteration()`](https://verapancaldilab.github.io/multideconv/reference/find.maximum.iteration.md)
  : Find maximum iteration from subgroups
- [`removeCorrelatedFeatures()`](https://verapancaldilab.github.io/multideconv/reference/removeCorrelatedFeatures.md)
  : Remove high correlated cell deconvolution features
- [`correlation()`](https://verapancaldilab.github.io/multideconv/reference/correlation.md)
  : Perform pairwise correlation across all features

## Package Data

Example data

- [`raw_counts`](https://verapancaldilab.github.io/multideconv/reference/raw_counts.md)
  : Raw counts
- [`deconv_bulk`](https://verapancaldilab.github.io/multideconv/reference/deconv_bulk.md)
  : Bulk deconvolution matrix
- [`deconvolution`](https://verapancaldilab.github.io/multideconv/reference/deconvolution.md)
  : Deconvolution matrix
- [`metacells_data`](https://verapancaldilab.github.io/multideconv/reference/metacells_data.md)
  : Metacells data
- [`metacells_metadata`](https://verapancaldilab.github.io/multideconv/reference/metacells_metadata.md)
  : Metacells metadata
- [`pseudobulk`](https://verapancaldilab.github.io/multideconv/reference/pseudobulk.md)
  : Pseudobulk
- [`cells_groundtruth`](https://verapancaldilab.github.io/multideconv/reference/cells_groundtruth.md)
  : Cell groundtruth
- [`subgroups`](https://verapancaldilab.github.io/multideconv/reference/subgroups.md)
  : Cell subgroups
- [`sample_labels`](https://verapancaldilab.github.io/multideconv/reference/sample_labels.md)
  : Sample labels
- [`cell_labels`](https://verapancaldilab.github.io/multideconv/reference/cell_labels.md)
  : Cell labels
