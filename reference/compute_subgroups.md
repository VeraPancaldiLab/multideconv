# Compute deconvolution subgroups

Groups the features of one cell type by complete-linkage hierarchical
clustering on their correlations: features end up in the same subgroup
only if every pair of them correlates at least `thres_corr`
(non-significant correlations, p \>= 0.05, count as 0). Each subgroup is
replaced by the row median of its members. The result does not depend on
the column order.

## Usage

``` r
compute_subgroups(
  deconvolution,
  thres_corr,
  corr_type,
  file_name,
  batch = NULL
)
```

## Arguments

- deconvolution:

  A matrix with the deconvolution features of one cell type (samples as
  rows)

- thres_corr:

  A numeric value with the minimum correlation allowed to group cell
  deconvolution features

- corr_type:

  Correlation type whether "spearman" or "pearson".

- file_name:

  Cell type name, used as prefix of the subgroup names
  (`<file_name>_Subgroup.<i>`)

- batch:

  Optional batch labels, one per sample in the same order as the rows. A
  factor or character is treated as categorical: correlations become
  partial correlations controlling for one indicator column per batch. A
  numeric vector is used as a single linear covariate.

## Value

A list containing

- A data frame with the final features: the subgroup medians plus the
  features that were not grouped

- The subgroups composition: a named list with the members of every
  subgroup
