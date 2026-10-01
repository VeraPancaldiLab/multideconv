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

  Optional batch labels, one per sample in the same order as the rows. A
  factor or character is treated as categorical: correlations become
  partial correlations controlling for one indicator column per batch. A
  numeric vector is used as a single linear covariate.

## Value

Dataframe containing all significant correlations (pvalue \< 0.05)
