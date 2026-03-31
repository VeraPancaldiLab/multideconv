# Relate Deconvolution Subgroups to PROGENy Pathways

Computes PROGENy pathway activity from normalized counts and evaluates
module relationships between subgroup profiles and pathway activity
profiles.

## Usage

``` r
compute_subgroups_pathways(
  subgroups,
  counts_norm,
  file_name = "Test",
  height = 6,
  width = 12,
  par_mar = c(4, 25, 5, 3),
  pval = 0.05
)
```

## Arguments

- subgroups:

  Output list from
  [`compute.deconvolution.analysis()`](https://verapancaldilab.github.io/multideconv/reference/compute.deconvolution.analysis.md).

- counts_norm:

  Normalized expression matrix with genes in rows and samples in
  columns.

- file_name:

  Prefix used to save output files.

- height:

  Plot height in inches.

- width:

  Plot width in inches.

- par_mar:

  Numeric vector passed to plot margins.

- pval:

  P-value threshold used in module relationship plots.

## Value

Invisibly returns `NULL`; side effects are generated output files.
