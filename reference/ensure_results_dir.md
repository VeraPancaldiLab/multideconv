# Create the Results output directory

Creates `Results/` (or `Results/<subdir>`) in the working directory if
it does not exist yet. Every function that saves files calls this right
before writing.

## Usage

``` r
ensure_results_dir(subdir = NULL)
```

## Arguments

- subdir:

  Optional subdirectory inside `Results/` (e.g. `"custom_signatures"`).

## Value

Invisibly, the path of the directory.
