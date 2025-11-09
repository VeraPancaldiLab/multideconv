# Perform pairwise correlation across all features

Perform pairwise correlation across all features

## Usage

``` r
correlation(data, corr_type = "spearman")
```

## Arguments

- data:

  Matrix with features to correlate

- corr_type:

  Correlation type whether "spearman" or "pearson".

## Value

Dataframe containing all significant correlations (pvalue \< 0.05)
