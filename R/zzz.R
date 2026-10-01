utils::globalVariables(c(
  "Correlation", "Label", "Pathway", "Pvalue", "Subgroup"
))

#' Create the Results output directory
#'
#' Creates `Results/` (or `Results/<subdir>`) in the working directory if it does not exist yet.
#' Every function that saves files calls this right before writing.
#'
#' @param subdir Optional subdirectory inside `Results/` (e.g. `"custom_signatures"`).
#'
#' @return Invisibly, the path of the directory.
#' @keywords internal
ensure_results_dir <- function(subdir = NULL) {
  path <- if (is.null(subdir)) "Results" else file.path("Results", subdir)
  dir.create(path, showWarnings = FALSE, recursive = TRUE)
  invisible(path)
}

#' Package load hook
#'
#' In interactive sessions, creates `Results/custom_signatures/` so users can drop custom signature
#' files there.
#'
#' @param libname,pkgname Library path and package name, supplied by R.
#' @noRd
.onLoad <- function(libname, pkgname) {
  # Only create Results/custom_signatures/ for interactive users (so they can
  # drop custom signatures there). Non-interactive runs (R CMD check, scripts)
  # must not write to the working directory at load time; functions that save
  # output create Results/ themselves via ensure_results_dir().
  if (interactive()) ensure_results_dir("custom_signatures")
}
