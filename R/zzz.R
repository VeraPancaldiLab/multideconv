utils::globalVariables(c(
  "Correlation", "Label", "Pathway", "Pvalue", "Subgroup"
))

# Create the Results/ output directory (and optional subdirectory) in the
# working directory on demand, right before a function writes into it.
ensure_results_dir <- function(subdir = NULL) {
  path <- if (is.null(subdir)) "Results" else file.path("Results", subdir)
  dir.create(path, showWarnings = FALSE, recursive = TRUE)
  invisible(path)
}

.onLoad <- function(libname, pkgname) {
  # Only create Results/custom_signatures/ for interactive users (so they can
  # drop custom signatures there). Non-interactive runs (R CMD check, scripts)
  # must not write to the working directory at load time; functions that save
  # output create Results/ themselves via ensure_results_dir().
  if (interactive()) ensure_results_dir("custom_signatures")
}
