# Keep any Results/ output out of the package tree
withr::local_dir(withr::local_tempdir(), .local_envir = teardown_env())

test_that("get_cell_type_nomenclature returns the vocabulary plus extras", {
  ct <- get_cell_type_nomenclature()
  expect_type(ct, "character")
  expect_true(all(c("B.cells", "CD8.cells", "CD4.regulatory") %in% ct))
  expect_equal(tail(get_cell_type_nomenclature("Myeloid.cells"), 1), "Myeloid.cells")
})

test_that("standardize_celltype_colnames harmonises macrophage names", {
  mat <- matrix(runif(30), nrow = 10, ncol = 3)
  colnames(mat) <- c("CBSX_LM22_Macrophages M0", "Quantiseq_TIL10_Macrophage.M1", "DWLS_Sig_Macrophages M2")
  expect_setequal(colnames(standardize_celltype_colnames(mat)),
                  c("CBSX_LM22_Macrophages.M0", "Quantiseq_TIL10_Macrophages.M1", "DWLS_Sig_Macrophages.M2"))
})

test_that("preprocessing handles method-signature combinations with a single column", {
  m <- data.frame(Epidish_X_B.cells = rep(0.5, 3), Epidish_X_CD8.cells = 0.5, Solo_Y_B.cells = 1)
  expect_no_error(out <- suppressWarnings(utils::capture.output(
    res <- multideconv:::compute.deconvolution.preprocessing(m))))
  expect_equal(ncol(res), 3)
})

test_that("compute.deconvolution.analysis runs and its subgroups replicate exactly", {
  data("deconvolution", package = "multideconv", envir = environment())
  res <- compute.deconvolution.analysis(deconvolution, corr = 0.7, seed = 123)
  expect_named(res)
  expect_equal(nrow(res[["Deconvolution matrix"]]), nrow(deconvolution))
  expect_false(dir.exists("Results")) # return = FALSE must not write anything

  rep <- replicate_deconvolution_subgroups(res, deconvolution)
  expect_setequal(colnames(rep), colnames(res[["Deconvolution matrix"]]))
  expect_equal(as.matrix(rep[, colnames(res[["Deconvolution matrix"]])]),
               as.matrix(res[["Deconvolution matrix"]]), ignore_attr = TRUE)
})

test_that("removeCorrelatedFeatures prunes correlated pairs with and without batch", {
  set.seed(1)
  d <- data.frame(a = rnorm(20)); d$b <- d$a + rnorm(20, sd = 0.01); d$c <- rnorm(20); d$e <- rnorm(20)
  expect_length(multideconv:::removeCorrelatedFeatures(d, 0.9, "x", 1)[[1]], 3)
  kept_batch <- suppressWarnings(multideconv:::removeCorrelatedFeatures(d, 0.9, "x", 1, batch = rep(1:2, 10))[[1]])
  expect_equal(ncol(kept_batch), 3)
})

test_that("compute_subgroups keeps correct names when dropping duplicated features", {
  set.seed(3)
  y <- data.frame(A_S1_B.cells = runif(20)); y$A_S2_B.cells <- y$A_S1_B.cells
  y$C_S_B.cells <- runif(20); y$D_S_B.cells <- runif(20)
  out <- multideconv:::compute_subgroups(y, 0.7, "spearman", "B.cells")[[1]]
  expect_equal(colnames(out), c("A_S1_B.cells", "C_S_B.cells", "D_S_B.cells"))
  expect_equal(out$C_S_B.cells, y$C_S_B.cells)
})

test_that("replicate_deconvolution_subgroups does not confuse Iteration.1 with Iteration.10", {
  test <- data.frame(a = 1:3, b = 3:5, c = 10:12)
  groups <- list(B.cells = list(
    B.cells_Subgroup.1.Iteration.1 = c("a", "b"),
    B.cells_Subgroup.1.Iteration.10 = c("c", "B.cells_Subgroup.1.Iteration.1")
  ))
  res <- list(`Deconvolution subgroups composition` = groups,
              `Deconvolution matrix` = data.frame(B.cells_Subgroup.1.Iteration.10 = 0))
  expect_equal(multideconv:::find.maximum.iteration(groups), 10)
  out <- replicate_deconvolution_subgroups(res, test)
  expect_equal(out$B.cells_Subgroup.1.Iteration.10, c(6, 7, 8))
})

test_that("compute.benchmark works with one or many ground-truth cell types", {
  data("deconvolution", package = "multideconv", envir = environment())
  data("cells_groundtruth", package = "multideconv", envir = environment())
  full <- compute.benchmark(deconvolution, cells_groundtruth, scatter = FALSE)
  expect_true("average" %in% rownames(full))
  one <- compute.benchmark(deconvolution, cells_groundtruth[, "B.cells", drop = FALSE], scatter = FALSE)
  expect_equal(rownames(one), c("B.cells", "average"))
})

test_that("prepare_multideconv_folds returns and saves the processed folds", {
  data("deconvolution", package = "multideconv", envir = environment())
  dd <- deconvolution
  dd$target <- rep(c("a", "b"), length.out = nrow(dd))
  folds <- prepare_multideconv_folds(dd, folds = list(F1 = 1:10, F2 = 5:15), ncores = 1, seed = 1)
  expect_named(folds, c("F1", "F2"))
  expect_true(all(file.exists(file.path("Results", c("fold_F1.rds", "fold_F2.rds")))))
  expect_equal(nrow(folds$F1$test_data), 5)
})
