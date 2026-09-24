withr::local_dir(withr::local_tempdir(), .local_envir = teardown_env())

test_that("compute.deconvolution skips CBSX when no credentials are given", {
  skip_on_cran()
  data("raw_counts", package = "multideconv", envir = environment())
  expect_warning(
    utils::capture.output(res <- compute.deconvolution(raw_counts, methods = c("Epidish", "CBSX"), return = FALSE)),
    "Skipping CBSX"
  )
  expect_equal(nrow(res), ncol(raw_counts))
  expect_false(any(grepl("^CBSX_", colnames(res))))
  expect_false(dir.exists("Results")) # cache directory is cleaned up
})
