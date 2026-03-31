# Perform pairwise correlation across all features

Perform pairwise correlation across all features

## Usage

``` r
corr_subgroups(data, corr_type = "spearman", batch = NULL)
```

## Arguments

- data:

  Matrix with features to correlate

- corr_type:

  Correlation type whether "spearman" or "pearson".

- batch:

  Optional batch covariate used to compute partial correlations.

## Value

Dataframe containing all significant correlations (pvalue \< 0.05)
