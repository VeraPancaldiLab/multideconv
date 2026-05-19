# Launch the multideconv Shiny app
# To run: open this file in RStudio and click "Source", or run:
#   Rscript launch_app.R

cat("Starting multideconv Shiny app...\n")
cat("Open your browser to: http://127.0.0.1:3838\n")
cat("Press Ctrl+C (or stop the R session) to quit.\n\n")

if (!requireNamespace("shiny", quietly = TRUE)) {
  stop("Package 'shiny' is not installed. Run: install.packages('shiny')", call. = FALSE)
}

# Allow uploads up to 2 GB
options(shiny.maxRequestSize = 2 * 1024^3)

shiny::runApp(
  appDir  = file.path(dirname(normalizePath("launch_app.R")), "inst", "shiny"),
  host    = "127.0.0.1",
  port    = 3838,
  launch.browser = TRUE
)
