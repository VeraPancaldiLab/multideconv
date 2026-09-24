# Prepare folds for multideconv cross-validation with processed training and test data

This function processes a dataset for k-fold cross-validation using the
multideconv framework. For each fold, it generates training and test
datasets by computing deconvolution subgroups features from the
deconvolution matrix. It also processes the entire dataset once to
provide a final processed training set.

## Usage

``` r
prepare_multideconv_folds(
  data,
  folds = NULL,
  bestune = NULL,
  ncores = NULL,
  time_var = NULL,
  event_var = NULL,
  trait.positive = NULL,
  cells_extra = NULL,
  corr = 0.7,
  corr_type = "spearman",
  zero_thr = 0.9,
  var_quantile = 0.25,
  prune_thr = 0.9,
  seed = NULL,
  batch = NULL
)
```

## Arguments

- data:

  A matrix or data frame of deconvolution features (samples x features)
  and a column named `target` indicating class labels.

- folds:

  A list of integer vectors indicating row indices for the training set
  in each fold. The test set is implicitly defined as the complement.

- bestune:

  Optional tuning object; when provided, folds are skipped and full-data
  processing is returned.

- ncores:

  Number of CPU cores for parallel fold processing.

- time_var:

  Optional survival time vector used when target labels are not
  provided.

- event_var:

  Optional survival event vector used when target labels are not
  provided.

- trait.positive:

  Label in `event_var` that defines event = 1.

- cells_extra:

  Optional character vector of additional cell labels to include.

- corr:

  Minimum correlation threshold passed to
  [`compute.deconvolution.analysis()`](https://verapancaldilab.github.io/multideconv/reference/compute.deconvolution.analysis.md).

- corr_type:

  Correlation type passed to
  [`compute.deconvolution.analysis()`](https://verapancaldilab.github.io/multideconv/reference/compute.deconvolution.analysis.md).

- zero_thr:

  Maximum zero fraction passed to
  [`compute.deconvolution.analysis()`](https://verapancaldilab.github.io/multideconv/reference/compute.deconvolution.analysis.md).

- var_quantile:

  Variance quantile threshold passed to
  [`compute.deconvolution.analysis()`](https://verapancaldilab.github.io/multideconv/reference/compute.deconvolution.analysis.md).

- prune_thr:

  Pruning correlation threshold passed to
  [`compute.deconvolution.analysis()`](https://verapancaldilab.github.io/multideconv/reference/compute.deconvolution.analysis.md).

- seed:

  Random seed passed to
  [`compute.deconvolution.analysis()`](https://verapancaldilab.github.io/multideconv/reference/compute.deconvolution.analysis.md).

- batch:

  Optional batch covariate passed to
  [`compute.deconvolution.analysis()`](https://verapancaldilab.github.io/multideconv/reference/compute.deconvolution.analysis.md).

## Value

- When `bestune` is `NULL` (fold mode): invisibly, a named list of
  processed folds, each also saved to `Results/fold_<fold name>.rds`.
  Each fold contains:

  - `train_data`: Processed training data with cell group features and
    `target` column.

  - `test_data`: Test data projected into the learned cell group feature
    space.

  - `obs_test`: True class labels (or survival time/event) for the test
    set.

  - `rowIndex`: Row indices corresponding to the test set.

  - `fold_name`: Fold name if provided in the `folds` list.

- When `bestune` is provided: a list with the processed feature matrix
  for the full dataset (including the `target` column), the full
  [`compute.deconvolution.analysis()`](https://verapancaldilab.github.io/multideconv/reference/compute.deconvolution.analysis.md)
  output, and `bestune`.

## Details

The function runs the
[`compute.deconvolution.analysis()`](https://verapancaldilab.github.io/multideconv/reference/compute.deconvolution.analysis.md)
function on each fold's training set and uses the trained projection to
compute the test set representation. It also runs multideconv on the
full dataset to return the complete processed training set.
