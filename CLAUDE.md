# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What This Package Does

**multideconv** is an R package providing an integrative pipeline for combining multiple cell type deconvolution methods (both first- and second-generation) from bulk RNA-seq data. It harmonizes outputs across methods, removes redundant cell types via correlation analysis, and identifies robust cell subgroups.

## Development Commands

```r
# Load package for interactive development (no need to reinstall)
devtools::load_all()

# Build documentation from roxygen2 comments
devtools::document()

# Run R CMD check
devtools::check()

# Run tests (no tests currently exist, but infrastructure is ready)
devtools::test()

# Build and preview pkgdown site
pkgdown::build_site()

# Launch the Shiny app locally
shiny::runApp('inst/shiny', host='127.0.0.1', port=3838)
```

## Installation

```r
# Install from GitHub (requires authentication for private deps)
pak::pkg_install("VeraPancaldiLab/multideconv")
```

Several dependencies come from GitHub remotes (omnideconv, immunedeconv, DWLS, BayesPrism, MOMF, hdWGCNA, MCPcounter, bisque) — see `DESCRIPTION` for exact remotes.

CIBERSORTx requires separate credentials and Docker.

## Architecture

All exported functions live in a single file: `R/cell_deconvolution.R` (~3,200 lines). This is intentional — the package exposes 15 functions but keeps implementation together.

### Core Pipeline Flow

1. **`compute.deconvolution()`** — Runs multiple deconvolution methods on bulk RNA-seq counts. Iterates over methods in parallel (`doParallel`/`foreach`). Outputs per-method proportion matrices saved to `Results/`.

2. **`compute.deconvolution.analysis()`** — Post-processes deconvolution results:
   - Removes zero-heavy features (>90% zeros) and low-variance features
   - Removes highly correlated features (>0.9 Pearson correlation)
   - Standardizes cell type nomenclature across methods
   - Identifies cell subgroups via WGCNA (`hdWGCNA`)

3. **Single-cell workflow** — `create_metacells()` → `create_sc_pseudobulk()` / `create_sc_signatures()` → `compute_sc_deconvolution_methods()`. Constructs metacells using KNN to aggregate sparse single-cell data before running second-generation methods (DWLS, BayesPrism, MOMF via `omnideconv`).

### Method Categories

- **First-generation** (via `immunedeconv`): Quantiseq, MCP-counter, xCell, EPIC, DeconRNASeq, CIBERSORT, EpiDISH
- **Second-generation** (via `omnideconv`): DWLS, BayesPrism, MOMF — require single-cell reference signatures

### File Layout

- `R/cell_deconvolution.R` — All function implementations
- `R/data.R` — Documentation for built-in sample datasets
- `R/zzz.R` — `.onLoad()` creates `Results/` and `Results/custom_signatures/` directories on attach
- `inst/shiny/app.R` — Shiny app (4 tabs: Welcome, Deconvolution, Analysis, Benchmark)
- `inst/signatures/` — Bundled signature matrices
- `data/` — 10 sample datasets (bulk counts, single-cell metadata, ground truth, deconvolution results)
- `vignettes/` — 5 articles covering the full workflow: deconvolution → single-cell → benchmark → subgroups → ML

### Cell Type Nomenclature

The package enforces standardized cell type names via `standardize_celltype_colnames()`. When adding new deconvolution methods or modifying existing ones, ensure output column names are harmonized to the shared naming convention documented in the README.

### Custom Signatures

Users can add `.txt` signature files to `Results/custom_signatures/` (created on `.onLoad()`). These are picked up automatically by `compute.deconvolution()`.

### Parallel Execution

Long-running deconvolution steps use `doParallel`/`foreach` for method-level parallelism and `future`/`future.apply` for sample-level parallelism. When debugging, set `plan(sequential)` to disable parallelism.

## Testing Infrastructure

Tests use `testthat` edition 3 (configured in DESCRIPTION) but no test cases exist yet. The built-in datasets (`raw_counts`, `deconv_bulk`, `subgroups`, etc.) are the intended inputs for future tests — load them with `data(raw_counts)` etc.
