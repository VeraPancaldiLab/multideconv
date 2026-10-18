# multideconv

`multideconv` is an integrative pipeline for combining first- and
second-generation cell type deconvolution methods from bulk RNA-seq
data, as described in [Hurtado et al.,
2025](https://www.biorxiv.org/content/10.1101/2025.04.29.651220v2.article-info).

## Installation

`multideconv` requires R \>= 4.3.3. On R 4.3.0 to 4.3.2, first install a
newer version of the `Matrix` package (R 4.3.3 already includes it):

``` r

pak::pkg_install("Matrix@1.6-5")
```

To avoid GitHub API rate limit issues, set up a Personal Access Token
(PAT) before installing:

``` r

# install.packages(c("usethis", "gitcreds"))
usethis::create_github_token()
gitcreds::gitcreds_set()
```

Install `multideconv` from GitHub:

``` r

# install.packages("pak")
pak::pkg_install("VeraPancaldiLab/multideconv")
```

Two of the default methods of
[`compute.deconvolution()`](https://verapancaldilab.github.io/multideconv/reference/compute.deconvolution.md),
DeconRNASeq and DWLS, are optional dependencies and are not installed
automatically. Install them with:

``` r

pak::pkg_install(c("bioc/DeconRNASeq", "omnideconv/DWLS"))
```

DeconRNASeq was removed from Bioconductor (release 3.22), so it is
installed from Bioconductor’s GitHub mirror.

## Tutorials

Step-by-step tutorials are available in the **Articles** section of the
navigation bar:

- **Deconvolution with default methods** — run first-generation
  deconvolution and access built-in signatures
- **Cell type subgroup analysis** — derive cell-type subgroups and build
  a deconvolution dictionary
- **Single-cell deconvolution** — construct metacells and apply
  second-generation methods
- **Pseudo-bulk profiles and benchmarking** — create pseudo-bulk data,
  generate custom signatures, and benchmark performance
- **Machine learning workflows** — use subgroup features in
  cross-validated ML models

## Citation

If you use `multideconv` in a scientific publication, please cite:

> Hurtado, M., Essabbar, A., Khajavi, L., & Pancaldi, V. (2025).
> *multideconv – Integrative pipeline for cell type deconvolution from
> bulk RNAseq using first and second generation methods.* bioRxiv.
> <https://doi.org/10.1101/2025.04.29.651220>
