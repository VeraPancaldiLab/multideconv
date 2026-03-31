# Remove high correlated cell deconvolution features

If two deconvolution features within a specific cell type are found to
be highly correlated, one feature is kept randomly for further analysis.

## Usage

``` r
removeCorrelatedFeatures(
  data,
  threshold,
  name,
  n_seed,
  corr_method = "spearman",
  batch = NULL
)
```

## Arguments

- data:

  Deconvolution matrix

- threshold:

  Threshold for defined high correlated features

- name:

  Cell type name corresponding to the given matrix in 'data'

- n_seed:

  Seed to ensure reproducibility regarding the choice of the feature.

- corr_method:

  Correlation type whether "spearman" or "pearson".

- batch:

  Optional batch covariate used to compute partial correlations.

## Value

A list containing

- Deconvolution matrix with only one deconvolution feature per
  high-correlated pair.

- Highly correlated features found

- Cell type name
