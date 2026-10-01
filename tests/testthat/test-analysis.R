# Keep any Results/ output out of the package tree
withr::local_dir(withr::local_tempdir(), .local_envir = teardown_env())

test_that("get_cell_type_nomenclature returns the vocabulary plus extras", {
  ct <- get_cell_type_nomenclature()
  expect_type(ct, "character")
  expect_true(all(c("B.cells", "CD8.cells", "CD4.regulatory") %in% ct))
  expect_equal(tail(get_cell_type_nomenclature("mesenchymal"), 1), "mesenchymal")
  expect_false(any(duplicated(get_cell_type_nomenclature("Myeloid.cells"))))
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
  res <- compute.deconvolution.analysis(deconvolution, corr = 0.7)
  expect_named(res)
  expect_equal(nrow(res[["Deconvolution matrix"]]), nrow(deconvolution))
  expect_false(dir.exists("Results")) # return = FALSE must not write anything

  rep <- replicate_deconvolution_subgroups(res, deconvolution)
  expect_setequal(colnames(rep), colnames(res[["Deconvolution matrix"]]))
  expect_equal(as.matrix(rep[, colnames(res[["Deconvolution matrix"]])]),
               as.matrix(res[["Deconvolution matrix"]]), ignore_attr = TRUE)
})

test_that("compute_subgroups only groups features whose every pair correlates >= corr, whatever the column order", {
  set.seed(1); n <- 30; a <- rnorm(n); b <- rnorm(n)
  y <- data.frame(M1_S_B.cells = a + rnorm(n, sd = 0.2), M2_S_B.cells = a + rnorm(n, sd = 0.2), M3_S_B.cells = a + rnorm(n, sd = 0.2),
                  M4_S_B.cells = b + rnorm(n, sd = 0.2), M5_S_B.cells = b + rnorm(n, sd = 0.2), M6_S_B.cells = rnorm(n))
  res <- multideconv:::compute_subgroups(y, 0.7, "spearman", "B.cells")
  expect_equal(lapply(res[[2]], sort), list(B.cells_Subgroup.1 = c("M1_S_B.cells", "M2_S_B.cells", "M3_S_B.cells"),
                                            B.cells_Subgroup.2 = c("M4_S_B.cells", "M5_S_B.cells")))
  for (g in res[[2]]) expect_gte(min(cor(y[, g], method = "spearman")), 0.7)
  shuffled <- multideconv:::compute_subgroups(y[, c(6, 4, 2, 5, 1, 3)], 0.7, "spearman", "B.cells")
  expect_equal(lapply(shuffled[[2]], sort), lapply(res[[2]], sort))
})

test_that("compute_subgroups groups same-method features and keeps names of ungrouped ones", {
  set.seed(3)
  y <- data.frame(A_S1_B.cells = runif(20)); y$A_S2_B.cells <- y$A_S1_B.cells
  y$C_S_B.cells <- runif(20); y$D_S_B.cells <- runif(20)
  res <- multideconv:::compute_subgroups(y, 0.7, "spearman", "B.cells")
  expect_length(res, 2)
  expect_setequal(colnames(res[[1]]), c("B.cells_Subgroup.1", "C_S_B.cells", "D_S_B.cells"))
  expect_equal(res[[2]]$B.cells_Subgroup.1, c("A_S1_B.cells", "A_S2_B.cells"))
  expect_equal(res[[1]]$C_S_B.cells, y$C_S_B.cells)
})

test_that("replicate_deconvolution_subgroups computes subgroup medians, also from earlier subgroups", {
  test <- data.frame(a = 1:3, b = 3:5, c = 10:12)
  groups <- list(B.cells = list(B.cells_Subgroup.1 = c("a", "b"),
                                B.cells_Subgroup.2 = c("c", "B.cells_Subgroup.1")))
  res <- list(`Deconvolution subgroups composition` = groups,
              `Deconvolution matrix` = data.frame(B.cells_Subgroup.1 = 0, B.cells_Subgroup.2 = 0))
  out <- replicate_deconvolution_subgroups(res, test)
  expect_equal(out$B.cells_Subgroup.1, c(2, 3, 4))
  expect_equal(out$B.cells_Subgroup.2, c(6, 7, 8))
})

test_that("aggregate_cell_groups sums cell types within each method-signature combination", {
  d <- data.frame(M1_S_Macrophages.M1 = c(0.1, 0.2), M1_S_Monocytes = c(0.3, 0.1), M1_S_B.cells = c(0.6, 0.7),
                  M2_S_Myeloid.cells = c(0.4, 0.3), M2_S_Monocytes = c(0.2, 0.1), M2_S_Macrophages.M1 = c(0.1, 0.1),
                  M3_S_Monocytes = c(0.5, 0.4), M3_S_B.cells = c(0.5, 0.6))
  groups <- list(Myeloid.cells = c("Macrophages.M1", "Monocytes"))
  utils::capture.output(out <- aggregate_cell_groups(d, groups))
  expect_equal(out$M1_S_Myeloid.cells, c(0.4, 0.3))   # sum of its two members
  expect_equal(out$M2_S_Myeloid.cells, c(0.4, 0.3))   # already estimated: kept as it is
  expect_false("M3_S_Myeloid.cells" %in% colnames(out)) # a single member: skipped
  expect_equal(out[, colnames(d)], d)                 # original features are kept
  expect_equal(aggregate_cell_groups(out, groups, verbose = FALSE), out)
  expect_true("M3_S_Myeloid.cells" %in% colnames(aggregate_cell_groups(d, groups, min_types = 1, verbose = FALSE)))

  expect_warning(aggregate_cell_groups(d, list(Myeloid.cells = c("Monocytes", "Macrophages.M1", "Monocyte")), verbose = FALSE), "Monocyte$")
  expect_error(aggregate_cell_groups(d, list(c("Monocytes", "B.cells"))), "named list")
  expect_error(aggregate_cell_groups(d, list(All.B.cells = c("Monocytes", "B.cells"))), "Group names")
})

test_that("cell groups are analysed as a cell type and replicated in new data", {
  data("deconvolution", package = "multideconv", envir = environment())
  groups <- list(Lymphocytes = c("B.cells", "CD4.cells", "CD8.cells", "NK.cells"))
  res <- compute.deconvolution.analysis(deconvolution[1:10, ], cell_groups = groups)
  expect_equal(res[["Cell groups"]], groups)
  expect_true(any(grepl("Lymphocytes", colnames(res[["Deconvolution matrix"]]))))
  expect_false(any(duplicated(colnames(res[["Deconvolution matrix"]]))))
  expect_null(compute.deconvolution.analysis(deconvolution[1:10, ])[["Cell groups"]])

  # Raw deconvolution of new samples: the groups are aggregated before replicating the subgroups
  rep <- expect_no_warning(replicate_deconvolution_subgroups(res, deconvolution[11:15, ]))
  expect_equal(colnames(rep), colnames(res[["Deconvolution matrix"]]))
  expect_false(anyNA(rep))
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
  folds <- prepare_multideconv_folds(dd, folds = list(F1 = 1:10, F2 = 5:15), ncores = 1)
  expect_named(folds, c("F1", "F2"))
  expect_true(all(file.exists(file.path("Results", c("fold_F1.rds", "fold_F2.rds")))))
  expect_equal(nrow(folds$F1$test_data), 5)

  groups <- list(Lymphocytes = c("B.cells", "CD4.cells", "CD8.cells", "NK.cells"))
  folds <- prepare_multideconv_folds(dd, folds = list(F1 = 1:10), ncores = 1, cell_groups = groups)
  expect_true(any(grepl("Lymphocytes", colnames(folds$F1$train_data))))
  expect_setequal(colnames(folds$F1$test_data), setdiff(colnames(folds$F1$train_data), "target"))
  expect_false(anyNA(folds$F1$test_data))
})

test_that("prepare_multideconv_folds handles survival outcomes given as time and event columns", {
  data("deconvolution", package = "multideconv", envir = environment())
  dd <- deconvolution
  dd$time <- seq_len(nrow(dd)) * 10
  dd$event <- rep(c(1, 0), length.out = nrow(dd))

  folds <- prepare_multideconv_folds(dd, folds = list(F1 = 1:10, F2 = 5:15), ncores = 1)
  tr <- folds$F1$train_data; te <- folds$F1$test_data
  expect_true(all(c("time", "event") %in% colnames(tr)))
  expect_true(all(c("time", "event") %in% colnames(te)))
  expect_false("target" %in% colnames(tr))
  expect_equal(te$time, dd$time[folds$F1$rowIndex])
  expect_setequal(setdiff(colnames(te), c("time", "event")), setdiff(colnames(tr), c("time", "event")))

  final <- prepare_multideconv_folds(dd[1:15, ], bestune = data.frame())
  expect_equal(final[[1]]$event, dd$event[1:15])
  expect_false("target" %in% colnames(final[[1]]))
})

test_that("prepare_multideconv_folds requires an outcome in data", {
  data("deconvolution", package = "multideconv", envir = environment())
  expect_error(prepare_multideconv_folds(deconvolution, folds = list(F1 = 1:10), ncores = 1),
               "must contain a 'target' column")
})
