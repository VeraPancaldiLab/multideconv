# multideconv Shiny app

This app exposes the main multideconv workflows from the package source and vignette:

1. `compute.deconvolution`
2. `compute.deconvolution.analysis`
3. `compute.benchmark`

It includes built-in example datasets and file upload options.

## Run

From the repository root:

```r
shiny::runApp("inst/shiny")
```

If `multideconv` is not installed, the app tries to load the package from source using `pkgload::load_all()`.
