

utils::globalVariables(c("mcp", "xcell" ,"i", ".", "samples_ids", "multisession", ".data", "Patient", "var", "id", "P", "sig_p", "r", "y", "p", "average", "Cells", "variable", "value", "pval_value", "gene", "weight", "statistic", "condition", "score", "padj", "NES", "pathway", "size", "sig", "source"))

#' Standardize Cell Type Column Names
#'
#' This function standardizes the column names of a matrix containing cell type data.
#'
#' @param mat A matrix with cell type data.
#'
#' @returns A matrix with standardized cell type column names.
#' @examples
#' mat <- matrix(rnorm(30), nrow = 10, ncol = 3)
#' colnames(mat) <- c("Macrophage_M0", "Macrophage_M1", "Macrophage_M2")
#' standardized_mat <- multideconv:::standardize_celltype_colnames(mat)
#' 
#' 
standardize_celltype_colnames <- function(mat) {
  if (is.null(rownames(mat))) rownames(mat) <- seq_len(nrow(mat))
  empty <- mat[, FALSE, drop = FALSE]
  # initialize blocks as a named list of empty matrices
  names_order <- c("B","B.naive","B.memory","Macrophages","M0","M1","M2","Monocytes","Neutrophils",
                   "NK","NK.activated","NK.resting","NKT","CD4","CD4.memory.activated","CD4.memory.resting",
                   "CD4.naive","CD4.non.regulatory","CD4.regulatory","CD8","Thelper","Tgamma","Dendritic",
                   "Dendritic.activated","Dendritic.resting","Cancer","Endothelial","Eosinophils","Plasma",
                   "Myocytes","Fibroblasts","Mast","Mast.activated","Mast.resting","CAF","extra")
  
  blocks <- setNames(rep(list(empty), length(names_order)), names_order)

  # helper function to safe-grep columns
  cols <- function(pat, x = mat, ignore.case = TRUE, value = FALSE) {
    grep(pat, colnames(x), ignore.case = ignore.case, value = value)
  }

  ## Macrophages and subtypes
  blocks$Macrophages <- mat[, cols("acrophage"), drop = FALSE]
  blocks$M0 <- mat[, cols("M0"), drop = FALSE]
  blocks$M1 <- mat[, cols("M1"), drop = FALSE]
  blocks$M2 <- mat[, cols("M2"), drop = FALSE]
  if (length(cols("LM22", blocks$M2)) > 0) blocks$M2 <- blocks$M2[, -cols("LM22", blocks$M2), drop = FALSE]
  test <- mat[, cols("LM22"), drop = FALSE]
  if (ncol(test)) test <- test[, cols("Macrophages.M2", test), drop = FALSE]
  if (ncol(test)) blocks$M2 <- cbind(blocks$M2, test)

  idx <- which(colnames(blocks$Macrophages) %in% c(colnames(blocks$M0), colnames(blocks$M1), colnames(blocks$M2)))
  if (length(idx)) blocks$Macrophages <- blocks$Macrophages[, -idx, drop = FALSE]
  if (ncol(blocks$Macrophages)) {
    mat <- mat[, !colnames(mat) %in% colnames(blocks$Macrophages), drop = FALSE]
    colnames(blocks$Macrophages) <- stringr::str_replace(colnames(blocks$Macrophages), "Macrophages", "Macrophages.cells")
    colnames(blocks$Macrophages) <- stringr::str_replace(colnames(blocks$Macrophages), "Macrophage(?!.)", "Macrophages.cells")
  }

  if (ncol(blocks$M0)) {
    mat <- mat[, !colnames(mat) %in% colnames(blocks$M0), drop = FALSE]
    colnames(blocks$M0) <- stringr::str_replace(colnames(blocks$M0), "Macrophages_M0", "Macrophages.M0")
    colnames(blocks$M0) <- stringr::str_replace(colnames(blocks$M0), "Macrophage_M0", "Macrophages.M0")
    colnames(blocks$M0) <- stringr::str_replace(colnames(blocks$M0), "_M0", "_Macrophages.M0")
    colnames(blocks$M0) <- stringr::str_replace(colnames(blocks$M0), "^M0$", "Macrophages.M0")
  }

  if (ncol(blocks$M1)) {
    mat <- mat[, !colnames(mat) %in% colnames(blocks$M1), drop = FALSE]
    colnames(blocks$M1) <- stringr::str_replace(colnames(blocks$M1), "Macrophages_M1", "Macrophages.M1")
    colnames(blocks$M1) <- stringr::str_replace(colnames(blocks$M1), "Macrophage_M1", "Macrophages.M1")
    colnames(blocks$M1) <- stringr::str_replace(colnames(blocks$M1), "_M1", "_Macrophages.M1")
    colnames(blocks$M1) <- stringr::str_replace(colnames(blocks$M1), "^M1$", "Macrophages.M1")
  }
  if (ncol(blocks$M2)) {
    mat <- mat[, !colnames(mat) %in% colnames(blocks$M2), drop = FALSE]
    colnames(blocks$M2) <- stringr::str_replace(colnames(blocks$M2), "Macrophage_M2", "Macrophages.M2")
    colnames(blocks$M2) <- stringr::str_replace(colnames(blocks$M2), "Macrophages_M2", "Macrophages.M2")
    colnames(blocks$M2) <- stringr::str_replace(colnames(blocks$M2), "_M2", "_Macrophages.M2")
    colnames(blocks$M2) <- stringr::str_replace(colnames(blocks$M2), "^M2$", "Macrophages.M2")
  }

  ## Monocytes
  blocks$Monocytes <- mat[, cols("Mono|mono"), drop = FALSE]
  if (ncol(blocks$Monocytes)) {
    mat <- mat[, !colnames(mat) %in% colnames(blocks$Monocytes), drop = FALSE]
    colnames(blocks$Monocytes) <- stringr::str_replace(colnames(blocks$Monocytes), "Monocytic_lineage", "Monocytes")
    colnames(blocks$Monocytes) <- stringr::str_replace(colnames(blocks$Monocytes), "Monocyte(?!s)", "Monocytes")
    colnames(blocks$Monocytes) <- stringr::str_replace(colnames(blocks$Monocytes), "Mono(?!cytes)", "Monocytes")
  }

  ## Neutrophils
  blocks$Neutrophils <- mat[, cols("Neu"), drop = FALSE]
  if (ncol(blocks$Neutrophils)) {
    mat <- mat[, !colnames(mat) %in% colnames(blocks$Neutrophils), drop = FALSE]
    colnames(blocks$Neutrophils) <- stringr::str_replace(colnames(blocks$Neutrophils), "Neutrophil(?!s)", "Neutrophils")
    colnames(blocks$Neutrophils) <- stringr::str_replace(colnames(blocks$Neutrophils), "Neu(?!trophils)", "Neutrophils")
  }

  ## NK and subtypes
  blocks$NK <- mat[, cols("NK"), drop = FALSE]
  blocks$NKT <- if (ncol(blocks$NK)) blocks$NK[, cols("NKT", blocks$NK), drop = FALSE] else empty
  blocks$NK.activated <- if (ncol(blocks$NK)) blocks$NK[, cols("activated", blocks$NK, value = TRUE), drop = FALSE] else empty
  blocks$NK.resting <- if (ncol(blocks$NK)) blocks$NK[, cols("resting", blocks$NK, value = TRUE), drop = FALSE] else empty
  idx <- which(colnames(blocks$NK) %in% c(colnames(blocks$NK.activated), colnames(blocks$NK.resting), colnames(blocks$NKT)))
  if (length(idx)) blocks$NK <- blocks$NK[, -idx, drop = FALSE]
  if (ncol(blocks$NK)) {
    mat <- mat[, !colnames(mat) %in% colnames(blocks$NK), drop = FALSE]
    colnames(blocks$NK) <- stringr::str_replace(colnames(blocks$NK), "NK(?!.)", "NK.cells")
    colnames(blocks$NK) <- stringr::str_replace(colnames(blocks$NK), "NK_cells", "NK.cells")
    colnames(blocks$NK) <- stringr::str_replace(colnames(blocks$NK), "NK_cell", "NK.cells")
  }
  if (ncol(blocks$NKT)) {
    mat <- mat[, !colnames(mat) %in% colnames(blocks$NKT), drop = FALSE]
    colnames(blocks$NKT) <- stringr::str_replace(colnames(blocks$NKT), "NKT_", "NKT.")
  }
  if (ncol(blocks$NK.activated)) {
    mat <- mat[, !colnames(mat) %in% colnames(blocks$NK.activated), drop = FALSE]
    colnames(blocks$NK.activated) <- stringr::str_replace(colnames(blocks$NK.activated), "NK.cells.activated", "NK.activated")
    colnames(blocks$NK.activated) <- stringr::str_replace(colnames(blocks$NK.activated), "NK.cells_activated", "NK.activated")
  }
  if (ncol(blocks$NK.resting)) {
    mat <- mat[, !colnames(mat) %in% colnames(blocks$NK.resting), drop = FALSE]
    colnames(blocks$NK.resting) <- stringr::str_replace(colnames(blocks$NK.resting), "NK.cells.resting", "NK.resting")
    colnames(blocks$NK.resting) <- stringr::str_replace(colnames(blocks$NK.resting), "NK.cells_resting", "NK.resting")
  }

  ## CD4 and subtypes
  lower <- stringr::str_to_lower(colnames(mat))
  is_cd4 <- grepl("\\bcd4\\b|reg|regulatory", lower)
  is_tcell_variant <- grepl("(^|[^a-z0-9])(t|tcell|t\\.cells|t_cells|t cells)([^a-z0-9]|$)", lower, perl = TRUE)
  is_memory <- grepl("memory", lower)
  cd4_idx <- which(is_cd4 | (is_tcell_variant & is_memory))
  blocks$CD4 <- mat[, cd4_idx, drop = FALSE]
  
  blocks$CD4.memory.activated <- if (ncol(blocks$CD4)) blocks$CD4[, cols("activated", blocks$CD4), drop = FALSE] else empty
  blocks$CD4.memory.resting <- if (ncol(blocks$CD4)) blocks$CD4[, cols("resting", blocks$CD4), drop = FALSE] else empty
  blocks$CD4.naive <- if (ncol(blocks$CD4)) blocks$CD4[, cols("naive", blocks$CD4), drop = FALSE] else empty
  if (ncol(blocks$CD4)) {
    cn <- colnames(blocks$CD4)
    canon <- stringr::str_to_lower(stringr::str_replace_all(cn, "[ _\\-]+", "."))
    non_reg_idx <- grep("(^|\\.)non[._-]?regulatory(\\.|$)", canon, perl = TRUE)
    reg_idx <- grep("(^|\\.)((tregs?)|tregulatory|t\\.cells\\.regulatory)(\\.|$)", canon, perl = TRUE)
    
    blocks$CD4.non.regulatory <- if(length(non_reg_idx) > 0) blocks$CD4[, non_reg_idx, drop = FALSE] else empty
    blocks$CD4.regulatory <- if(length(reg_idx) > 0) blocks$CD4[, reg_idx, drop = FALSE] else empty
  }

  idx <- which(colnames(blocks$CD4) %in% c(colnames(blocks$CD4.memory.activated), colnames(blocks$CD4.memory.resting), colnames(blocks$CD4.naive), colnames(blocks$CD4.non.regulatory), colnames(blocks$CD4.regulatory)))
  if (length(idx)) blocks$CD4 <- blocks$CD4[, -idx, drop = FALSE]
  if (ncol(blocks$CD4)) {
    mat <- mat[, !colnames(mat) %in% colnames(blocks$CD4), drop = FALSE]
    colnames(blocks$CD4) <- stringr::str_replace(colnames(blocks$CD4), "T.cells.CD4(?!\\.cells)", "CD4.cells")
    colnames(blocks$CD4) <- stringr::str_replace(colnames(blocks$CD4), "_CD4$", "_CD4.cells")
    colnames(blocks$CD4) <- stringr::str_replace(colnames(blocks$CD4), "^CD4(?!\\.cells)", "CD4.cells")
  }
  if (ncol(blocks$CD4.memory.activated)) {
    mat <- mat[, !colnames(mat) %in% colnames(blocks$CD4.memory.activated), drop = FALSE]
    colnames(blocks$CD4.memory.activated) <- stringr::str_replace(colnames(blocks$CD4.memory.activated), "CD4_memory_activated", "CD4.memory.activated")
    colnames(blocks$CD4.memory.activated) <- stringr::str_replace(colnames(blocks$CD4.memory.activated), "T.cells.CD4.memory.activated", "CD4.memory.activated")
  }
  if (ncol(blocks$CD4.memory.resting)) {
    mat <- mat[, !colnames(mat) %in% colnames(blocks$CD4.memory.resting), drop = FALSE]
    colnames(blocks$CD4.memory.resting) <- stringr::str_replace(colnames(blocks$CD4.memory.resting), "CD4_memory_resting", "CD4.memory.resting")
    colnames(blocks$CD4.memory.resting) <- stringr::str_replace(colnames(blocks$CD4.memory.resting), "T.cells.CD4.memory.resting", "CD4.memory.resting")
  }
  if (ncol(blocks$CD4.naive)) {
    mat <- mat[, !colnames(mat) %in% colnames(blocks$CD4.naive), drop = FALSE]
    colnames(blocks$CD4.naive) <- stringr::str_replace(colnames(blocks$CD4.naive), "CD4_naive", "CD4.naive")
    colnames(blocks$CD4.naive) <- stringr::str_replace(colnames(blocks$CD4.naive), "CD4._naive", "CD4.naive")
    colnames(blocks$CD4.naive) <- stringr::str_replace(colnames(blocks$CD4.naive), "T.cells.CD4.naive", "CD4.naive")
    colnames(blocks$CD4.naive) <- stringr::str_replace(colnames(blocks$CD4.naive), "T_cells_CD4.naive", "CD4.naive")
  }
  if (ncol(blocks$CD4.non.regulatory)) {
    mat <- mat[, !colnames(mat) %in% colnames(blocks$CD4.non.regulatory), drop = FALSE]
    colnames(blocks$CD4.non.regulatory) <- stringr::str_replace(
      colnames(blocks$CD4.non.regulatory),
      "(?i)^(.*?)(?:_)?(T[_\\.-]?cell[_\\.-]?CD4[_\\.-]?.*non[._-]?regulatory.*|T[_\\.-]?cells?[_\\.-]?.*non[._-]?regulatory.*|CD4[_\\.-]?non[._-]?regulatory.*|T\\.cells\\.non\\.regulatory|T_cells_non_regulatory|nonregulatory|non[\\W_]?reg)$",
      "CD4.non.regulatory"
    )
  }
  if (ncol(blocks$CD4.regulatory)){
    mat <- mat[, !colnames(mat) %in% colnames(blocks$CD4.regulatory), drop = FALSE]
    colnames(blocks$CD4.regulatory) <- stringr::str_replace(
      colnames(blocks$CD4.regulatory),
      "(?i)^(.*?)(?:_)?(T[_\\.-]?cell[_\\.-]?regulatory.*|T[_\\.-]?cells?[_\\.-]?regulatory.*|T\\.cells\\.regulatory.*|tregs?\\.?$|tregulatory.*|regulatory.*)$",
      "CD4.regulatory"
    )
  }

  ## CD8
  blocks$CD8 <- mat[, cols("CD8"), drop = FALSE]
  if (ncol(blocks$CD8)) {
    mat <- mat[, !colnames(mat) %in% colnames(blocks$CD8), drop = FALSE]
    colnames(blocks$CD8) <- stringr::str_replace(colnames(blocks$CD8), "T_cells_CD8", "CD8.cells")
    colnames(blocks$CD8) <- stringr::str_replace(colnames(blocks$CD8), "T_cell_CD8", "CD8.cells")
    colnames(blocks$CD8) <- stringr::str_replace(colnames(blocks$CD8), "CD8_T_cells", "CD8.cells")
    colnames(blocks$CD8) <- stringr::str_replace(colnames(blocks$CD8), "T.cells.CD8", "CD8.cells")
    colnames(blocks$CD8) <- stringr::str_replace(colnames(blocks$CD8), "CD8(?!.)", "CD8.cells")
    colnames(blocks$CD8) <- stringr::str_replace(colnames(blocks$CD8), "CD8.cells.", "CD8.cells")
  }


  ## Thelper
  blocks$Thelper <- mat[, cols("helper"), drop = FALSE]
  if (ncol(blocks$Thelper)) {
    mat <- mat[, !colnames(mat) %in% colnames(blocks$Thelper), drop = FALSE]
    colnames(blocks$Thelper) <- stringr::str_replace(colnames(blocks$Thelper), "T.cells.follicular.helper", "T.cells.helper")
    colnames(blocks$Thelper) <- stringr::str_replace(colnames(blocks$Thelper), "T_cells_follicular_helper", "T.cells.helper")
  }

  ## Tgamma
  blocks$Tgamma <- mat[, cols("gamma"), drop = FALSE]
  if (ncol(blocks$Tgamma)) {
    mat <- mat[, !colnames(mat) %in% colnames(blocks$Tgamma), drop = FALSE]
    colnames(blocks$Tgamma) <- stringr::str_replace(colnames(blocks$Tgamma), "T_cells_gamma_delta", "T.cells.gamma.delta")
    colnames(blocks$Tgamma) <- stringr::str_replace(colnames(blocks$Tgamma), "T_cell_gamma_delta", "T.cells.gamma.delta")
  }

  ## Dendritic and subtypes
  blocks$Dendritic <- mat[, cols("endritic"), drop = FALSE]
  blocks$Dendritic.activated <- if (ncol(blocks$Dendritic)) blocks$Dendritic[, cols("activated", blocks$Dendritic), drop = FALSE] else empty
  blocks$Dendritic.resting <- if (ncol(blocks$Dendritic)) blocks$Dendritic[, cols("resting", blocks$Dendritic), drop = FALSE] else empty
  idx <- which(colnames(blocks$Dendritic) %in% c(colnames(blocks$Dendritic.activated), colnames(blocks$Dendritic.resting)))
  if (length(idx)) blocks$Dendritic <- blocks$Dendritic[, -idx, drop = FALSE]
  if (ncol(blocks$Dendritic)) {
    mat <- mat[, !colnames(mat) %in% colnames(blocks$Dendritic), drop = FALSE]
    colnames(blocks$Dendritic) <- stringr::str_replace(colnames(blocks$Dendritic), "Myeloid_dendritic_cells", "Dendritic.cells")
    colnames(blocks$Dendritic) <- stringr::str_replace(colnames(blocks$Dendritic), "Myeloid_dendritic_cell", "Dendritic.cells")
    colnames(blocks$Dendritic) <- stringr::str_replace(colnames(blocks$Dendritic), "Dendritic_cells", "Dendritic.cells")
  }
  if (ncol(blocks$Dendritic.activated)) {
    mat <- mat[, !colnames(mat) %in% colnames(blocks$Dendritic.activated), drop = FALSE]
    colnames(blocks$Dendritic.activated) <- stringr::str_replace(colnames(blocks$Dendritic.activated), "dendritic_cell_activated", "Dendritic.activated.cells")
    colnames(blocks$Dendritic.activated) <- stringr::str_replace(colnames(blocks$Dendritic.activated), "Dendritic.cells.activated", "Dendritic.activated.cells")
    colnames(blocks$Dendritic.activated) <- stringr::str_replace(colnames(blocks$Dendritic.activated), "Dendritic_cells_activated", "Dendritic.activated.cells")
  }
  if (ncol(blocks$Dendritic.resting)) {
    mat <- mat[, !colnames(mat) %in% colnames(blocks$Dendritic.resting), drop = FALSE]
    colnames(blocks$Dendritic.resting) <- stringr::str_replace(colnames(blocks$Dendritic.resting), "Dendritic.cells.resting", "Dendritic.resting.cells")
    colnames(blocks$Dendritic.resting) <- stringr::str_replace(colnames(blocks$Dendritic.resting), "Dendritic_cells_resting", "Dendritic.resting.cells")
  }

  ## CAF
  blocks$CAF <- mat[, cols("CAF|Cancer_associated_fibroblast"), drop = FALSE]
  if (ncol(blocks$CAF)) {
    mat <- mat[, !colnames(mat) %in% colnames(blocks$CAF), drop = FALSE]
    colnames(blocks$CAF) <- stringr::str_replace(colnames(blocks$CAF), "Cancer_associated_fibroblast", "CAF")
    colnames(blocks$CAF) <- stringr::str_replace(colnames(blocks$CAF), "CAFs", "CAF")
  }

  ## Cancer / malignant
  blocks$Cancer <- mat[, cols("ancer"), drop = FALSE]
  if (ncol(blocks$Cancer)) {
    mat <- mat[, !colnames(mat) %in% colnames(blocks$Cancer), drop = FALSE]
    colnames(blocks$Cancer) <- stringr::str_replace(colnames(blocks$Cancer), "cancer", "Cancer")
    colnames(blocks$Cancer) <- stringr::str_replace(colnames(blocks$Cancer), "Cancer.cells", "Cancer")
  }
  blocks$malignant <- mat[, cols("alignant"), drop = FALSE]
  if (ncol(blocks$malignant)) {
    mat <- mat[, !colnames(mat) %in% colnames(blocks$malignant), drop = FALSE]
    colnames(blocks$malignant) <- stringr::str_replace(colnames(blocks$malignant), "Malignant", "Cancer")
    colnames(blocks$malignant) <- stringr::str_replace(colnames(blocks$malignant), "Cancer_cells", "Cancer")
    colnames(blocks$malignant) <- stringr::str_replace(colnames(blocks$malignant), "Cancer.cells", "Cancer")
    if (ncol(blocks$Cancer)) blocks$Cancer <- cbind(blocks$Cancer, blocks$malignant) else blocks$Cancer <- blocks$malignant
  }

  ## Endothelial
  blocks$Endothelial <- mat[, cols("dothelial"), drop = FALSE]
  if (ncol(blocks$Endothelial)) {
    mat <- mat[, !colnames(mat) %in% colnames(blocks$Endothelial), drop = FALSE]
    colnames(blocks$Endothelial) <- stringr::str_replace(colnames(blocks$Endothelial), "Endothelial_cells", "Endothelial")
    colnames(blocks$Endothelial) <- stringr::str_replace(colnames(blocks$Endothelial), "Endothelial.cells", "Endothelial")
    colnames(blocks$Endothelial) <- stringr::str_replace(colnames(blocks$Endothelial), "Endothelial_cell", "Endothelial")
  }

  ## Eosinophils
  blocks$Eosinophils <- mat[, cols("osinophil"), drop = FALSE]
  if (ncol(blocks$Eosinophils)) {
    mat <- mat[, !colnames(mat) %in% colnames(blocks$Eosinophils), drop = FALSE]
    colnames(blocks$Eosinophils) <- stringr::str_replace(colnames(blocks$Eosinophils), "Eosinophil(?!.)", "Eosinophils")
  }

  ## Plasma
  blocks$Plasma <- mat[, cols("lasma"), drop = FALSE]
  if (ncol(blocks$Plasma)) {
    mat <- mat[, !colnames(mat) %in% colnames(blocks$Plasma), drop = FALSE]
    colnames(blocks$Plasma) <- stringr::str_replace(colnames(blocks$Plasma), "plasma(?!.)", "Plasma")
    colnames(blocks$Plasma) <- stringr::str_replace(colnames(blocks$Plasma), "Plasma_cells", "Plasma")
    colnames(blocks$Plasma) <- stringr::str_replace(colnames(blocks$Plasma), "Plasma.cells", "Plasma")
  }

  ## Myocytes / Fibroblasts
  blocks$Myocytes <- mat[, cols("yocytes"), drop = FALSE]
  if (ncol(blocks$Myocytes)) mat <- mat[, !colnames(mat) %in% colnames(blocks$Myocytes), drop = FALSE]
  blocks$Fibroblasts <- mat[, cols("ibroblast"), drop = FALSE]
  if (ncol(blocks$Fibroblasts)) mat <- mat[, !colnames(mat) %in% colnames(blocks$Fibroblasts), drop = FALSE]

  ## Mast and subtypes
  blocks$Mast <- mat[, cols("Mast"), drop = FALSE]
  blocks$Mast.activated <- if (ncol(blocks$Mast)) blocks$Mast[, cols("activated", blocks$Mast), drop = FALSE] else empty
  blocks$Mast.resting <- if (ncol(blocks$Mast)) blocks$Mast[, cols("resting", blocks$Mast), drop = FALSE] else empty
  idx <- which(colnames(blocks$Mast) %in% c(colnames(blocks$Mast.activated), colnames(blocks$Mast.resting)))
  if (length(idx)) blocks$Mast <- blocks$Mast[, -idx, drop = FALSE]
  if (ncol(blocks$Mast)) {
    mat <- mat[, !colnames(mat) %in% colnames(blocks$Mast), drop = FALSE]
    colnames(blocks$Mast) <- stringr::str_replace(colnames(blocks$Mast), "Mast_cell(?!.)", "Mast.cells")
    colnames(blocks$Mast) <- stringr::str_replace(colnames(blocks$Mast), "Mast_cells", "Mast.cells")
  }
  if (ncol(blocks$Mast.activated)) {
    mat <- mat[, !colnames(mat) %in% colnames(blocks$Mast.activated), drop = FALSE]
    colnames(blocks$Mast.activated) <- stringr::str_replace(colnames(blocks$Mast.activated), "Mast.cells.activated", "Mast.activated.cells")
    colnames(blocks$Mast.activated) <- stringr::str_replace(colnames(blocks$Mast.activated), "Mast_cells_activated", "Mast.activated.cells")
  }
  if (ncol(blocks$Mast.resting)) {
    mat <- mat[, !colnames(mat) %in% colnames(blocks$Mast.resting), drop = FALSE]
    colnames(blocks$Mast.resting) <- stringr::str_replace(colnames(blocks$Mast.resting), "Mast.cells.resting", "Mast.resting.cells")
    colnames(blocks$Mast.resting) <- stringr::str_replace(colnames(blocks$Mast.resting), "Mast_cells_resting", "Mast.resting.cells")
  }

  ## B cells (naive / memory) and final B
  blocks$B.naive <- mat[, cols("naive"), drop = FALSE]
  if (ncol(blocks$B.naive)) {
    mat <- mat[, !colnames(mat) %in% colnames(blocks$B.naive), drop = FALSE]
    colnames(blocks$B.naive) <- stringr::str_replace(colnames(blocks$B.naive), "B.cells.naive", "B.naive.cells")
    colnames(blocks$B.naive) <- stringr::str_replace(colnames(blocks$B.naive), "B_cells_naive", "B.naive.cells")
    colnames(blocks$B.naive) <- stringr::str_replace(colnames(blocks$B.naive), "B_cell_naive", "B.naive.cells")
  }

  blocks$B.memory <- mat[, cols("memory"), drop = FALSE]
  if (ncol(blocks$B.memory)) {
    mat <- mat[, !colnames(mat) %in% colnames(blocks$B.memory), drop = FALSE]
    colnames(blocks$B.memory) <- stringr::str_replace(colnames(blocks$B.memory), "B.cells.memory", "B.memory.cells")
    colnames(blocks$B.memory) <- stringr::str_replace(colnames(blocks$B.memory), "B_cells_memory", "B.memory.cells")
    colnames(blocks$B.memory) <- stringr::str_replace(colnames(blocks$B.memory), "B_cell_memory", "B.memory.cells")
  }

  idx <- which(colnames(mat) %in% c(colnames(blocks$B.naive), colnames(blocks$B.memory)))
  if (length(idx)) mat <- mat[, -idx, drop = FALSE]

  if (ncol(mat)) {
    colnames(mat) <- stringr::str_replace(colnames(mat), "B_cells", "B.cells")
    colnames(mat) <- stringr::str_replace(colnames(mat), "B_cell", "B.cells")
    colnames(mat) <- stringr::str_replace(colnames(mat), "B_lineage", "B.cells")
    colnames(mat) <- stringr::str_replace(colnames(mat), "_B(?!.)", "_B.cells")
    colnames(mat) <- stringr::str_replace(colnames(mat), "^B$", "B.cells")
    blocks$B <- mat[, cols("B.cells"), drop = FALSE]
    if (ncol(blocks$B)) mat <- mat[, !colnames(mat) %in% colnames(blocks$B), drop = FALSE]
  }

  ## remaining are extra
  blocks$extra <- mat

  # assemble in fixed order (include any created on the fly like malignant)
  final_names <- c("B","B.naive","B.memory","Macrophages","M0","M1","M2","Monocytes","Neutrophils",
                   "NK","NK.activated","NK.resting","NKT","CD4","CD4.memory.activated","CD4.memory.resting",
                   "CD4.naive","CD4.non.regulatory","CD4.regulatory","CD8","Thelper","Tgamma","Dendritic",
                   "Dendritic.activated","Dendritic.resting","Cancer","Endothelial","Eosinophils","Plasma",
                   "Myocytes","Fibroblasts","Mast","Mast.activated","Mast.resting","CAF","extra")
  existing <- intersect(final_names, names(blocks))
  cell_types <- do.call(cbind, unname(blocks[existing]))

  return(cell_types)
}

#' Compute deconvolution preprocessing
#'
#' Give consistent names and patterns following the method_signature_cell structure to the deconvolution features
#'
#' @param deconv A dataframe with the unprocessed deconvolution features
#'
#' @return A matrix of the preprocessed deconvolution features with fixed and consistent names across the different methods and signatures following the nomenclature specified in multideconv (see Readme)
#' @examples
#'
#' data("deconvolution")
#'
#' deconvolution = multideconv:::compute.deconvolution.preprocessing(deconvolution)
#'
compute.deconvolution.preprocessing = function(deconv){
  cat("Preprocessing deconvolution features...............................................................\n\n")

  #Remove NA (this need to be check -- not possible to have NAs values in deconv)
  deconv <- deconv %>%
    dplyr::mutate(dplyr::across(dplyr::everything(), ~ tidyr::replace_na(.x, 0)))

  ##### Edit cell names for consistency across features

  cell_types = standardize_celltype_colnames(deconv)

  cat("Checking consistency in deconvolution cell fractions across patients...............................................................\n\n")

  combinations = c("Quantiseq", "Epidish_BPRNACan_",  "Epidish_BPRNACanProMet", "Epidish_BPRNACan3DProMet", "Epidish_CBSX.HNSCC.scRNAseq", "Epidish_CBSX.Melanoma.scRNAseq",
                   "Epidish_CBSX.NSCLC.PBMCs.scRNAseq", "Epidish_CCLE.TIL10", "Epidish_TIL10", "Epidish_LM22", "DeconRNASeq_BPRNACan_", "DeconRNASeq_BPRNACanProMet",
                   "DeconRNASeq_BPRNACan3DProMet", "DeconRNASeq_CBSX.HNSCC.scRNAseq", "DeconRNASeq_CBSX.Melanoma.scRNAseq", "DeconRNASeq_CBSX.NSCLC.PBMCs.scRNAseq", "DeconRNASeq_CCLE.TIL10",
                   "DeconRNASeq_TIL10", "DeconRNASeq_LM22", "CBSX_BPRNACan_", "CBSX_BPRNACanProMet", "CBSX_BPRNACan3DProMet", "CBSX_CBSX.HNSCC.scRNAseq",
                   "CBSX_CBSX.Melanoma.scRNAseq", "CBSX_CBSX.NSCLC.PBMCs.scRNAseq", "CBSX_CCLE.TIL10", "CBSX_TIL10", "CBSX_LM22", "DWLS_BPRNACan_",  "DWLS_BPRNACanProMet", "DWLS_BPRNACan3DProMet", "DWLS_CBSX.HNSCC.scRNAseq", "Epidish_CBSX.Melanoma.scRNAseq",
                   "DWLS_CBSX.NSCLC.PBMCs.scRNAseq", "DWLS_CCLE.TIL10", "DWLS_TIL10", "DWLS_LM22")

  error = F
  for(i in combinations){
    idx = grep(i, colnames(cell_types))
    if(length(idx)>0){
      mat = cell_types[,idx] #A matrix of samples as rows and features only with combination[i] as columns
      sums = round(rowSums(mat), 2)
      if(all(sums == 1) == F){
        cat(paste("\n\nTotal sum across samples of combination", i, "is not 1! Remember these are proportions and the total should be 1\n"))
        cat("Samples which sum with combination", i, "is not 1:\n\n", paste0(names(sums)[sums != 1], collapse = "\n"), "\n")
        error = T
      }else{
        cat(paste("\nTotal sum across samples of combination", i, "is", round(sum(mat[1, ]), 2))) #Print only sum of 1st row
      }
    }
  }

  if(error){
    warning("\nPlease verify your matrix")
  }

  return(cell_types)
}


#' Cell types split from deconvolution
#'
#' @param data A matrix with the deconvolution results
#' @param cells_extra A string specifying the cells names to consider and that are not including in the nomenclature of multideconv (see Readme)
#'
#' @return A list containing:
#' - A sublist with each cell type features as an element recover from the different signatures
#' - Discarded cell types (this will happen if the cell types are not supported. See the READme for more information about this)
#'
#' @examples
#'
#' data("deconvolution")
#'
#' cells_types = multideconv:::compute.cell.types(deconvolution)
#' cells = cells_types[[1]]
#' cells_discarded = cells_types[[2]]
#' extra_cells <- c("mesenchymal", "basophils")
#' cells_types <- multideconv:::compute.cell.types(
#'   deconvolution,
#'   cells_extra = extra_cells
#' )
#'
compute.cell.types = function(data, cells_extra = NULL){
  ##### B cells
  B = grep("B.cells", colnames(data))
  B = data[, B, drop = FALSE]
  ##### B naive
  B.naive = grep("B.naive.cells", colnames(data))
  B.naive = data[, B.naive, drop = FALSE]
  ##### B memory
  B.memory = grep("B.memory.cells", colnames(data))
  B.memory = data[, B.memory, drop = FALSE]
  ##### Macrophages (M0, M1, M2)
  Macrophages = grep("Macrophages.cells", colnames(data))
  Macrophages = data[, Macrophages, drop = FALSE]
  M0 = grep("Macrophages.M0", colnames(data))
  M0 = data[, M0, drop = FALSE]
  M1 = grep("Macrophages.M1", colnames(data))
  M1 = data[, M1, drop = FALSE]
  M2 = grep("Macrophages.M2", colnames(data))
  M2 = data[, M2, drop = FALSE]
  ##### Monocytes
  Monocytes = grep("Monocytes", colnames(data))
  Monocytes = data[, Monocytes, drop = FALSE]
  ##### Neutrophils
  Neutrophils = grep("Neutrophils", colnames(data))
  Neutrophils = data[, Neutrophils, drop = FALSE]
  ##### NK cells (activated, resting)
  NK = grep("NK.cells", colnames(data))
  NK = data[, NK, drop = FALSE]
  NK.activated = grep("NK.activated", colnames(data))
  NK.activated = data[, NK.activated, drop = FALSE]
  NK.resting = grep("NK.resting", colnames(data))
  NK.resting = data[, NK.resting, drop = FALSE]
  ##### NKT cells
  NKT = grep("NKT.cells", colnames(data))
  NKT = data[, NKT, drop = FALSE]
  ##### CD4 cells (activated, resting)
  CD4 = grep("CD4.cells", colnames(data))
  CD4 = data[, CD4, drop = FALSE]
  #memory = CD4[,grep("memory", colnames(CD4))]
  #helper = CD4[,grep("Th", colnames(CD4))]
  #CD4 = CD4[,-which(colnames(CD4)%in%c(colnames(memory), colnames(helper)))]
  CD4.memory.activated = grep("CD4.memory.activated", colnames(data))
  CD4.memory.activated = data[, CD4.memory.activated, drop = FALSE]
  CD4.memory.resting = grep("CD4.memory.resting", colnames(data))
  CD4.memory.resting = data[, CD4.memory.resting, drop = FALSE]
  CD4.naive = grep("CD4.naive", colnames(data))
  CD4.naive = data[, CD4.naive, drop = FALSE]
  ##### CD8 cells
  CD8 = grep("CD8.cells", colnames(data))
  CD8 = data[, CD8, drop = FALSE]
  #naive = grep("naive", colnames(CD8))
  #naive = CD8[, naive, drop = FALSE]
  #memory = grep("memory", colnames(CD8))
  #memory = CD8[, memory, drop = FALSE]
  #CD8 = CD8[,-which(colnames(CD8)%in%c(colnames(memory), colnames(naive)))]
  ##### Regulatory T cells
  CD4.regulatory = grep("CD4.regulatory", colnames(data))
  CD4.regulatory = data[, CD4.regulatory, drop = FALSE]
  ##### Non regulatory T cells
  CD4.non.regulatory = grep("CD4.non.regulatory", colnames(data))
  CD4.non.regulatory = data[, CD4.non.regulatory, drop = FALSE]
  ##### Helper T cells
  Thelper = grep("T.cells.helper", colnames(data))
  Thelper = data[, Thelper, drop = FALSE]
  ##### Gamma delta T cells
  Tgamma = grep("T.cells.gamma.delta", colnames(data))
  Tgamma = data[, Tgamma, drop = FALSE]
  ##### Dendritic cells (activated, resting)
  Dendritic = grep("Dendritic.cells", colnames(data))
  Dendritic = data[, Dendritic, drop = FALSE]
  Dendritic.activated = grep("Dendritic.activated.cells", colnames(data))
  Dendritic.activated = data[, Dendritic.activated, drop = FALSE]
  Dendritic.resting = grep("Dendritic.resting.cells", colnames(data))
  Dendritic.resting = data[, Dendritic.resting, drop = FALSE]
  ##### Cancer cells
  Cancer = grep("Cancer", colnames(data))
  Cancer = data[, Cancer, drop = FALSE]
  ##### Endothelial cells
  Endothelial = grep("Endothelial", colnames(data))
  Endothelial = data[, Endothelial, drop = FALSE]
  ##### Eosinophils cells
  Eosinophils = grep("Eosinophils", colnames(data))
  Eosinophils = data[, Eosinophils, drop = FALSE]
  ##### Plasma cells
  Plasma = grep("Plasma", colnames(data))
  Plasma = data[, Plasma, drop = FALSE]
  ##### Myocytes cells
  Myocytes = grep("Myocytes", colnames(data))
  Myocytes = data[, Myocytes, drop = FALSE]
  ##### Fibroblasts cells
  Fibroblasts = grep("Fibroblasts", colnames(data))
  Fibroblasts = data[, Fibroblasts, drop = FALSE]
  ##### Mast cells
  Mast = grep("Mast.cells", colnames(data))
  Mast = data[, Mast, drop = FALSE]
  Mast.activated = grep("Mast.activated.cells", colnames(data))
  Mast.activated = data[, Mast.activated, drop = FALSE]
  Mast.resting = grep("Mast.resting.cells", colnames(data))
  Mast.resting = data[, Mast.resting, drop = FALSE]
  ##### CAF cells
  CAF = grep("CAF", colnames(data))
  CAF = data[, CAF, drop = FALSE]

  #####Output list
  cell_types = list(B, B.naive, B.memory, Macrophages, M0, M1, M2, Monocytes, Neutrophils, NK, NK.activated, NK.resting, NKT, CD4, CD4.memory.activated, CD4.memory.resting, CD4.naive,
                    CD8, CD4.regulatory, CD4.non.regulatory, Thelper, Tgamma, Dendritic, Dendritic.activated, Dendritic.resting, Cancer, Endothelial, Eosinophils, Plasma, Myocytes, Fibroblasts, Mast, Mast.activated,
                    Mast.resting, CAF)

  names(cell_types) = c("B.cells", "B.naive.cells", "B.memory.cells", "Macrophages.cells", "Macrophages.M0", "Macrophages.M1", "Macrophages.M2", "Monocytes", "Neutrophils", "NK.cells", "NK.activated", "NK.resting", "NKT.cells", "CD4.cells", "CD4.memory.activated",
                        "CD4.memory.resting", "CD4.naive", "CD8.cells", "CD4.regulatory", "CD4.non.regulatory","T.cells.helper", "T.cells.gamma.delta", "Dendritic.cells", "Dendritic.activated.cells", "Dendritic.resting.cells", "Cancer", "Endothelial",
                        "Eosinophils", "Plasma", "Myocytes", "Fibroblasts", "Mast.cells", "Mast.activated.cells", "Mast.resting.cells", "CAF")

  cell_types_matrix = cbind(B, B.naive, B.memory, Macrophages, M0, M1, M2, Monocytes, Neutrophils, NK, NK.activated, NK.resting, NKT, CD4, CD4.memory.activated, CD4.memory.resting, CD4.naive,
                            CD8, CD4.regulatory, CD4.non.regulatory, Thelper, Tgamma, Dendritic, Dendritic.activated, Dendritic.resting, Cancer, Endothelial, Eosinophils, Plasma, Myocytes, Fibroblasts, Mast, Mast.activated,
                            Mast.resting, CAF)

  ####Add extra cells (if exist)
  if(is.null(cells_extra) == F){
    extra = list()
    for (i in 1:length(cells_extra)){
      extra[[i]] = grep(cells_extra[i], colnames(data))
      extra[[i]] = data[, extra[[i]], drop = FALSE]
      names(extra)[i] = cells_extra[[i]]
    }
    extra_df = do.call(cbind, unname(extra))

    cell_types = c(cell_types, extra)
    cell_types_matrix = cbind(cell_types_matrix, extra_df)
  }

  ####Discarded cell types
  cell_types_discarded = data[,!(colnames(data)%in%colnames(cell_types_matrix)), drop = F]

  return(list(cell_types, cell_types_discarded))

}

#' Remove high correlated cell deconvolution features
#'
#' If two deconvolution features within a specific cell type are found to be highly correlated, one feature is kept randomly for further analysis.
#'
#' @param data Deconvolution matrix
#' @param threshold Threshold for defined high correlated features
#' @param name Cell type name corresponding to the given matrix in 'data'
#' @param n_seed Seed to ensure reproducibility regarding the choice of the feature.
#' @param corr_method Correlation type whether "spearman" or "pearson".
#' @param batch Optional batch covariate used to compute partial correlations.
#'
#' @return A list containing
#'
#' - Deconvolution matrix with only one deconvolution feature per high-correlated pair.
#' - Highly correlated features found
#' - Cell type name
#'
removeCorrelatedFeatures <- function(data, threshold, name, n_seed, corr_method = "spearman", batch = NULL) {

  features_high_corr = c()
  cell_name = c()

  # Compute correlation matrix
  if(is.null(batch)){
    corr_matrix <- stats::cor(data, method = corr_method)
  } else {
    if(is.factor(batch) || is.character(batch)) batch <- as.numeric(as.factor(batch))
    # Pairwise partial correlation
    corr_matrix <- matrix(NA, ncol=ncol(data), nrow=ncol(data))
    colnames(corr_matrix) <- colnames(data)
    rownames(corr_matrix) <- colnames(data)
    for(i in 1:(ncol(data)-1)){
      for(j in (i+1):ncol(data)){
        pc <- ppcor::pcor.test(data[[i]], data[[j]], batch)
        corr_matrix[i,j] <- pc$estimate
        corr_matrix[j,i] <- pc$estimate
      }
    }
  }
  # Find highly correlated features
  contador = 1
  while(nrow(corr_matrix)>0){
    set.seed(n_seed)
    feature = data.frame(corr_matrix[1, , drop = FALSE]) #Extract first row feature
    feature = feature %>%                                #Take only high corr above threshold
      dplyr::mutate_all(~ifelse(. > threshold, ., NA))
    feature <- feature[, colSums(!is.na(feature)) == nrow(feature), drop = FALSE]

    corr_matrix = corr_matrix[-which(rownames(corr_matrix)%in%colnames(feature)),-which(colnames(corr_matrix)%in%colnames(feature)), drop = F] #Remove already joined features

    if(ncol(feature)>1){
      keep = colnames(feature)[sample(ncol(feature), size = 1)] #From high corr group, keep only one feature

      if(length(features_high_corr)>0){
        features_high_corr = c(features_high_corr, colnames(feature))
      }else{
        features_high_corr = colnames(feature)
      }

      feature = feature[,-which(colnames(feature)%in%keep), drop = F]

      if(contador==1){
        new_data <- data[, -which(colnames(data)%in%colnames(feature)), drop = F] #Remove rest of the features from original data
      }else{
        new_data <- new_data[, -which(colnames(new_data)%in%colnames(feature)), drop = F] #Remove rest of the features from original data
      }
      contador = contador + 1
      cell_name = name
    }else{
      if(contador == 1){
        new_data = data
      }else{ #If it already started the loop
        new_data = new_data
      }
    }
  }

  if(length(cell_name)==0){
    cell_name = NULL
  }

  return(list(new_data, features_high_corr, cell_name))
}

#' Remove subgroups that have the same method across different signatures
#'
#' @param groups Cell groups of features within cell types.
#'
#' @return List of position of groups which have features of same method.
#'
remove_subgroups = function(groups){
  lis = c()
  for (pos in 1:length(groups)){
    x = c()
    if(length(groups[[pos]])!=0){
      for (i in 1:length(groups[[pos]])) {
        x =  c(x,stringr::str_split(groups[[pos]][[i]], "_")[[1]][[1]])
      }
      if(length(unique(x)) == 1){
        lis = c(lis, pos)
      }
    }
  }

  return(lis)
}

#' Compute deconvolution subgroups
#'
#' @param deconvolution A matrix with unprocessed cell deconvolution results
#' @param thres_corr A numeric value with the minimum correlation allowed to group cell deconvolution features
#' @param corr_type Correlation type whether "spearman" or "pearson".
#' @param file_name Base name for subgroup
#' @param batch Optional batch covariate used to compute partial correlations.
#'
#' @return A list containing
#'
#' - A matrix with the processed deconvolution features
#' - Cell subgroups obtained by linear correlation
#' - Cell subgroups obtained by proportionality correlation
#' - Discard cell features either because of low variance or high zero number
#'
compute_subgroups = function(deconvolution, thres_corr, corr_type, file_name, batch = NULL){
  data = data.frame(deconvolution)

  cell_subgroups = list()
  #cell_groups_similarity = list()
  cell_groups_discard = list()
  if (ncol(data) < 2) {
    return(list(data, cell_subgroups, cell_groups_discard))
  }else{
    # #################### Proportionality-based correlation (DEPRECATED)
    # is_similar <- function(value1, value2, threshold) {return(abs(value1 - value2) <= threshold)}
    # similarity_matrix <- matrix(FALSE, nrow = ncol(data), ncol = ncol(data), dimnames = list(names(data), names(data)))
    # for (col1 in names(data)) {
    #   for (col2 in names(data)) {
    #     similarity <- all(mapply(is_similar, data[[col1]], data[[col2]], MoreArgs = list(0.05))) #similarity threshold = 0.05
    #     similarity_matrix[col1, col2] <- similarity
    #   }
    # }
    # get_upper_tri <- function(cormat){
    #   cormat[lower.tri(cormat, diag = T)]<- NA
    #   return(cormat)
    # }
    # upper_tri <- get_upper_tri(similarity_matrix)
    # x <- melt(upper_tri) %>%
    #   na.omit() %>%
    #   mutate_all(as.character)
    # indice = 1
    # subgroup = list()
    # vec = unique(x$Var1)
    # while(length(vec)>0){
    #   sub = x[which(x$Var1%in%vec[1]),]
    #   sub = sub[which(sub$value==T),]
    #   if(nrow(sub)!=0){
    #     subgroup[[indice]] = c(vec[1], sub$Var2)
    #     x = x[-which(x$Var1%in%subgroup[[indice]]),] #Variable 1
    #     x = x[-which(x$Var2%in%subgroup[[indice]]),] #Variable 2
    #     vec = vec[-which(vec%in%subgroup[[indice]])]
    #     indice = indice + 1
    #   }else{
    #     indice = indice
    #     vec = vec[-1]
    #   }
    # }
    #
    # if(length(subgroup)!=0){
    #   for (i in 1:length(subgroup)){
    #     names(subgroup)[i] = paste0(file_name, "_Subgroup.Similarity.", i) #Name subgroups
    #   }
    #   lis = remove_subgroups(subgroup) #Map subgroups with same method
    #   if(length(lis)>0){
    #     cell_groups_discard = subgroup[lis]
    #     subgroup = subgroup[-lis] #Remove subgroups if all subgroupped features belong to the same method
    #   }
    #
    #   if(length(subgroup)!=0){  #check if after removal of subgroups with equal method, you still have subgroups
    #     cell_groups_similarity = subgroup
    #     data_sub = c()
    #     for(i in 1:length(cell_groups_similarity)){ #Create data frame with features subgroupped
    #       sub = data.frame(data[,colnames(data)%in%cell_groups_similarity[[i]]]) #Map features that are inside each subgroup from input (deconvolution)
    #       sub$median = matrixStats::rowMedians(as.matrix(sub), useNames = FALSE) #Compute median of subgroups across patients
    #       data_sub = data.frame(cbind(data_sub, sub$median)) #Save median in a new data frame
    #       colnames(data_sub)[i] = names(cell_groups_similarity)[i]
    #       name = colnames(data)[which(!(colnames(data)%in%cell_groups_similarity[[i]]))]
    #       data = data[,-which(colnames(data)%in%cell_groups_similarity[[i]])] #Remove from deconvolution features that are subgrouped
    #       if(ncol(data.frame(data))==1){
    #         data = as.data.frame(data)
    #         colnames(data)[1] = name
    #       }
    #     }
    #
    #     rownames(data_sub) = rownames(data) #List of patients
    #     data_sub = data.frame(data_sub[,colnames(data_sub)%in%names(cell_groups_similarity)])
    #     colnames(data_sub) = names(cell_groups_similarity)
    #
    #     data = cbind(data, data_sub) #Join subgroups in deconvolution file
    #   }else{
    #     cell_groups_similarity = list()
    #   }
    #   k = 2
    # }else{
    #   k = 3
    # }
    # if(ncol(data) == 1){ #everything is already subgroupped
    #   return(list(data, cell_subgroups, cell_groups_similarity, cell_groups_discard))
    # }

    #################### Linear-based correlation
    #if(k==2 | k==3){
    terminate = FALSE
    iteration = 1
    while (terminate == FALSE) {
      corr_df <- corr_subgroups(data, corr_type = corr_type, batch = batch)
      vec = colnames(data)
      indice = 1
      subgroup = list()
      data_sub = c()
      while(length(vec)>0){ #Keep running until no features are left
        if(vec[1] %in% corr_df$measure1){ #Check if feature still no-grouped
          tab = corr_df[corr_df$measure1 == vec[1],] #Take one feature against the others
          tab = tab[tab$r>thres_corr,] #Select features corr above the threshold
          if(nrow(tab)!=0){ #If algorithm found features above corr
            subgroup[[indice]] = c(vec[1], tab$measure2) #Save features as subgroup
            idx = which(corr_df$measure1 %in% subgroup[[indice]])
            if(length(idx)>0){corr_df = corr_df[-idx,]} #Remove features already subgroupped
            idy = which(corr_df$measure2 %in% subgroup[[indice]])
            if(length(idy)>0){corr_df = corr_df[-idy,]} #Remove features already subgroupped
            vec = vec[-which(vec%in%subgroup[[indice]])] #Remove feature already subgroupped from vector
            indice = indice + 1
          }else{ #Condition when there is no correlation above the threshold (features no subgroupped)
            corr_df = corr_df[-which(corr_df$measure1 == vec[1]),] #Remove variable from corr matrix to keep subgrouping the others
            if(length(which(corr_df$measure2==vec[1]))>0){corr_df = corr_df[-which(corr_df$measure2 == vec[1]),]}
            vec = vec[-1] #Remove variable from vector to keep analyzing the others
            indice = indice #Not increase index cause no subgroup appeared
          }
        }else{ #If feature is not in corr matrix it means that there is no any significant correlation against it and other features
          vec = vec[-1] #Remove variable from vector to keep analyzing the others
          indice = indice  #Not increase index cause no subgroup appeared
        }
      }

      if(length(subgroup)!=0){
        for (i in 1:length(subgroup)){ #Name subgroups
          names(subgroup)[i] = paste0(file_name, "_Subgroup.", i, ".Iteration.", iteration)
        }
        ###Check whenever some subgroups belong to the same method
        if(iteration == 1){
          idx = remove_subgroups(subgroup) #Map subgroups with same method
          if(length(idx)>0){
            if(length(cell_groups_discard)>0){
              cell_groups_discard = c(cell_groups_discard, subgroup[idx])
              duplica = which(duplicated(cell_groups_discard)) #check if there are subgroups duplicated discarded
              if(length(duplica)>0){
                cell_groups_discard = cell_groups_discard[-duplica]
              }
            }
            else{
              cell_groups_discard = subgroup[idx]
            }
            subgroup = subgroup[-idx] #Remove subgroups if all subgroupped features belong to the same method
          }
        }

        if(length(subgroup)!=0){ #check if after removal of subgroups with equal method, you still have subgroups (when iteration == 1)
          #Take median expression of subgroups
          for(i in 1:length(subgroup)){ #Create data frame with features subgroupped
            sub = data.frame(data[,colnames(data)%in%subgroup[[i]]]) #Map features that are inside each subgroup from input (deconvolution)
            sub$median = matrixStats::rowMedians(as.matrix(sub), useNames = FALSE) #Compute median of subgroup across patients
            data_sub = cbind(data_sub, sub$median) #Save median in a new data frame
            colnames(data_sub)[i] = names(subgroup)[i]
            name = colnames(data)[which(!(colnames(data)%in%subgroup[[i]]))]
            data = data.frame(data[,-which(colnames(data)%in%subgroup[[i]]), drop = FALSE]) #Remove from deconvolution features that are subgrouped
            if(ncol(data.frame(data))==1){
              data = as.data.frame(data)
              colnames(data)[1] = name
            }
          }

          rownames(data_sub) = rownames(data) #List of patients

          if(iteration == 1){ #Save what is inside the first subgroups
            cell_subgroups = subgroup
            data_sub = data.frame(data_sub[,colnames(data_sub)%in%names(cell_subgroups), drop = FALSE])
            colnames(data_sub) = names(cell_subgroups)
          }else{
            for (i in 1:length(subgroup)) {
              cell_subgroups[[length(cell_subgroups)+1]] = subgroup[[i]]
              names(cell_subgroups)[length(cell_subgroups)] = names(subgroup)[i]
            }
          }

          if(ncol(data)!=0){
            data = cbind(data, data_sub)
          }else{
            data = data_sub #data will be 0 if all deconvolution features have been subgroupped
            terminate = TRUE
          }
          iteration = iteration + 1
        }else{
          terminate = TRUE #when the only subgroup that keep grouping is composed from the same method
        }

      }else{
        terminate = TRUE
      }
    }

    if(is.null(data_sub)==FALSE){
      data = cbind(data, data_sub)
    }

    idx = which(duplicated(t(data)))
    if(length(idx)>0){
      names = colnames(data)[idx]
      data = data[,-idx, drop = F]
      colnames(data) = names
    }
    #}

    return(list(data, cell_subgroups, cell_groups_discard))
  }

}

#' Perform pairwise correlation across all features
#'
#' @param data Matrix with features to correlate
#' @param corr_type Correlation type whether "spearman" or "pearson".
#' @param batch Optional batch covariate used to compute partial correlations.
#'
#' @return Dataframe containing all significant correlations (pvalue < 0.05)
#'
corr_subgroups <- function(data, corr_type = "spearman", batch = NULL) {
  if (!is.null(batch)) {
    # Convert batch to numeric if factor or character
    if(is.factor(batch) || is.character(batch)){
      batch <- as.numeric(as.factor(batch))
    }

    # Compute all pairwise partial correlations controlling for batch
    vec <- colnames(data)
    corr_df <- data.frame(measure1 = character(0), measure2 = character(0),
                          r = numeric(0), p = numeric(0))
    for(i in 1:(length(vec)-1)){
      for(j in (i+1):length(vec)){
        pc <- ppcor::pcor.test(data[[vec[i]]], data[[vec[j]]], batch, method = corr_type)
        corr_df <- rbind(corr_df, data.frame(measure1 = vec[i],
                                             measure2 = vec[j],
                                             r = pc$estimate,
                                             p = pc$p.value))
      }
    }
  } else {
    # Original correlation using Hmisc::rcorr
    M <- Hmisc::rcorr(data.matrix(data), type = corr_type)
    Mdf <- purrr::map(M[c("r", "P", "n")], ~data.frame(.x))
    corr_df <- Mdf %>%
      purrr::map(~tibble::rownames_to_column(.x, var = "measure1")) %>%
      purrr::map(~tidyr::pivot_longer(.x, -measure1, names_to = "measure2")) %>%
      dplyr::bind_rows(.id = "id") %>%
      tidyr::pivot_wider(names_from = id, values_from = value) %>%
      dplyr::rename(p = P) %>%
      dplyr::mutate(sig_p = ifelse(p < 0.05, TRUE, FALSE),
                    p_if_sig = ifelse(sig_p, p, NA),
                    r_if_sig = ifelse(sig_p, r, NA))
    corr_df <- stats::na.omit(corr_df)
    corr_df <- corr_df[which(corr_df$sig_p == TRUE), ]
    corr_df <- corr_df[order(corr_df$r, decreasing = TRUE), ]
  }

  corr_df$AbsR <- abs(corr_df$r)
  return(corr_df)
}


#' Remove low variance deconvolution features
#'
#' @param data Deconvolution features
#' @param plot Whether to save or not the plot of variance distribution in the Results/ directory.
#'
#' @return A list containing
#'
#' - Deconvolution matrix after removal of low variance.
#' - Discarded low variance features.
#'
remove_low_variance <- function(data, plot = FALSE) {
  vars <- apply(data, 2, var)
  threshold = summary(vars)[[2]]
  low_variance <- which(vars < threshold)

  if(plot){
    grDevices::pdf("Results/Distribution_variances_deconvolution.pdf")
    graphics::hist(vars, main = "Distribution of deconvolution variances across samples\nRemoving features below threshold (low variance)", xlab = "Variance", col = "skyblue", border = "white", xlim = range(vars))
    graphics::lines(stats::density(vars), col = "red", lwd = 2)
    graphics::legend("topright", legend = c("Density", paste("Threshold =", round(threshold, 5))), col = c("red", "orange"), lty = c(1, 2), lwd = c(2, 2))

    # Shade region below threshold
    graphics::abline(v = threshold, col = "orange", lwd = 2, lty = 2)
    x <- stats::density(vars)$x
    y <- stats::density(vars)$y
    graphics::polygon(c(min(x[vars < threshold]), x[vars < threshold], max(x[vars < threshold])),
            c(0, y[vars < threshold], 0), col = grDevices::adjustcolor("orange", alpha.f = 0.3), border = NA)
    grDevices::dev.off()
  }

  data_filt = data[,-low_variance, drop = F]
  low_var_features = data[,low_variance, drop = F]

  res = list(data_filt, low_var_features)
  return(res)
}

#' Compute cell type processing
#'
#' @param deconvolution Deconvolution output of compute.deconvolution() with features as columns and samples as rows
#' @param corr Minimum correlation threshold for subgroupping the deconvolution features
#' @param corr_type Correlation type for computing the cell subgroups, whether "spearman" or "pearson".
#' @param seed A numeric value to specificy the seed. This ensures reproducibility during the choice step of high correlated features.
#' @param batch Optional batch covariate used to compute partial correlations.
#' @param cells_extra A string specifying the cells names to consider and that are not including in the nomenclature of multideconv (see Readme)
#' @param file_name A string specifying the file name of the .csv file with the deconvolution subgroups
#' @param return Boolean value to whether return and saved the plot and csv files of deconvolution generated during the run inside the Results/ directory.
#' @param verbose Boolen value to whether print or no the function messages
#'
#' @return A list containing
#'
#' - A matrix with the deconvolution after processing
#' - The deconvolution subgroups per cell type
#' - The deconvolution subgroups composition
#' - The deconvolution groups discarded caused they are all belonging to the same method
#' - The discarded features because they contain a high number of zeros across samples (> 90%)
#' - Discarded features due to low variance across samples
#' - Discarded cell types because they are not supported in the pipeline
#' - High correlated deconvolution pairs (>high_corr)
#'
#' @export
#'
#' @examples
#'
#' data("deconvolution")
#'
#' processed_deconvolution = compute.deconvolution.analysis(deconvolution, corr = 0.7, seed = 123)
#'
#' processed_deconvolution = compute.deconvolution.analysis(deconvolution, cells_extra = "mesenchymal")
#'
compute.deconvolution.analysis <- function(deconvolution, corr = 0.7, corr_type = "spearman", seed = NULL, batch = NULL, cells_extra = NULL, file_name = NULL, return = FALSE, verbose = FALSE){
  deconvolution.mat = deconvolution

  # #####Unsupervised filtering
  #
  #Remove high zero number features
  if(verbose){
    cat(paste0("Removing features with high zero number 90%...............................................................\n\n"))
  }

  deconvolution.mat = deconvolution.mat[, colSums(deconvolution.mat == 0, na.rm=TRUE) < round(0.9*nrow(deconvolution.mat)) , drop=FALSE]
  diff_colnames <- setdiff(colnames(deconvolution), colnames(deconvolution.mat))
  zero_features <- deconvolution[, diff_colnames]

  #Remove low_variance features
  if(verbose){
    cat(paste0("Removing low variance features...............................................................\n\n"))
  }

  variance = remove_low_variance(deconvolution.mat, plot = return)
  deconvolution.mat = variance[[1]]
  low_variance_features = variance[[2]]

  # #Scale deconvolution features by columns for making them comparable between cell types (0-1).
  # cat("Scaling deconvolution features for comparison between cell types...............................................................\n\n")
  # for (i in 1:ncol(deconvolution.mat)) {
  #   deconvolution.mat[,i] = deconvolution.mat[,i]/max(deconvolution.mat[,i])
  # }

  #####Cell types split
  if(verbose){
    cat("Splitting deconvolution features per cell type...............................................................\n\n")
  }

  cells_types = compute.cell.types(deconvolution.mat, cells_extra)
  cells = cells_types[[1]]
  cells_discarded = cells_types[[2]]

  ######Pairwise correlation filtering (Highly correlated variables >0.9) within cell types
  if(verbose){
    cat("Finding group of features with high correlation between each other...............................................................\n\n")
  }

  features_high_corr = list()
  j = 1
  for (i in 1:length(cells)) {
    data = cells[[i]]
    if(is.null(ncol(data))==T){
      cells[[i]] = data
    }else if(ncol(data)>1){
      data = removeCorrelatedFeatures(data, 0.9, names(cells)[i], seed, corr_method = corr_type, batch = batch)
      cells[[i]] = data[[1]]
      if(length(data[[2]])>0 && is.null(data[[3]])==F){
        features_high_corr[[j]] = data[[2]]
        names(features_high_corr)[j] = data[[3]]
        j = j+1
      }
    }
  }

  #####Subgrouping of deconvolution features
  res = list()
  groups = list()
  #groups_similarity = list()
  groups_discard = list()
  for (i in 1:length(cells)) {
    x = compute_subgroups(cells[[i]], file_name = names(cells)[i], thres_corr = corr, corr_type = corr_type, batch = batch)
    res = c(res, x[1])
    groups = c(groups, x[2])
    #groups_similarity = c(groups_similarity, x[3])
    groups_discard = c(groups_discard, x[3])
  }

  names_cells = names(cells)

  names(res) = names_cells
  names(groups) = names_cells
  #names(groups_similarity) = names_cells
  names(groups_discard) = names_cells

  #####Preparing output
  dt = c()
  for (i in 1:length(res)) {
    dt = c(dt, res[[i]])
  }
  dt = data.frame(dt)
  rownames(dt) = rownames(deconvolution.mat)

  #####Create and export table with subgroups

  #Count number of subgroups - Linear-based
  idx = c()
  for (i in 1:length(groups)){
    if(length(groups[[i]])>0){
      for (j in 1:length(groups[[i]])){
        idx = c(idx, names(groups[[i]])[[j]])
      }
    }
  }
  data.groups = data.frame(matrix(nrow = length(idx), ncol = 2)) #Create table
  colnames(data.groups) = c("Cell_subgroups", "Methods-signatures")
  data.groups$Cell_subgroups = idx #Assign subgroups

  #Save methods corresponding to each subgroup
  contador = 1
  for (i in 1:length(groups)){
    if(length(groups[[i]])>0){
      for (j in 1:length(groups[[i]])){
        data.groups[contador,2] = paste(groups[[i]][[j]], collapse ="\n")
        contador = contador + 1
      }
    }
  }


  #Count number of subgroups - Proportionality-based
  # idy = c()
  # for (i in 1:length(groups_similarity)){
  #   if(length(groups_similarity[[i]])>0){
  #     for (j in 1:length(groups_similarity[[i]])){
  #       idy = c(idy, names(groups_similarity[[i]])[[j]])
  #     }
  #   }
  # }
  # data.groups.similarity = data.frame(matrix(nrow = length(idy), ncol = 2)) #Create table
  # colnames(data.groups.similarity) = c("Cell_subgroups", "Methods-signatures")
  # data.groups.similarity$Cell_subgroups = idy #Assign subgroups
  #
  # #Save methods corresponding to each subgroup
  # contador = 1
  # for (i in 1:length(groups_similarity)){
  #   if(length(groups_similarity[[i]])>0){
  #     for (j in 1:length(groups_similarity[[i]])){
  #       data.groups.similarity[contador,2] = paste(groups_similarity[[i]][[j]], collapse ="\n")
  #       contador = contador + 1
  #     }
  #   }
  # }
  #
  #Save data to export
  if(return == TRUE){
    data.output = data.groups
    utils::write.csv(dt, paste0('Results/Deconvolution_after_subgrouping_', file_name,'.csv'))
    utils::write.csv(data.output, paste0('Results/Cell_subgroups_', file_name,'.csv'), row.names = F)
  }

  if(verbose){
    message("Deconvolution features subgroupped")
  }

  results = list(dt, res, groups, groups_discard, zero_features, low_variance_features, cells_discarded, features_high_corr)
  names(results) = c("Deconvolution matrix", "Deconvolution subgroups per cell types", "Deconvolution subgroups composition",
                     "Discarded groups with equal method", "Discarded features with high number of zeros", "Discarded features with low variance", "Discarded cell types",
                     "High correlated deconvolution groups (>0.9) per cell type")
  return(results)

}


#' Computes QuanTIseq
#'
#' @param TPM_matrix A matrix with TPM normalized counts (genes symbols as rows and samples as columns).
#' @param name_signature Name used to tag output columns with the signature source.
#'
#' @return A matrix with cell abundance deconvolve with QuanTIseq
#'
computeQuantiseq <- function(TPM_matrix, name_signature = "TIL10") {
  TPM_matrix = TPM_matrix[rownames(TPM_matrix)%in%rownames(immunedeconv::dataset_racle$expr_mat),] #To avoid problems regarding gene names (quantiseq error)

  quantiseq = immunedeconv::deconvolute(TPM_matrix, "quantiseq", tumor = T) %>%
    tibble::column_to_rownames("cell_type") %>%
    t()

  colnames(quantiseq) = paste0("Quantiseq_", name_signature, "_", colnames(quantiseq))
  colnames(quantiseq) <- colnames(quantiseq) %>%
    stringr::str_replace_all(., " ", "_")

  return(quantiseq)
}

#' Computes MCPcounter
#'
#' @param TPM_matrix A matrix with TPM normalized counts (genes symbols as rows and samples as columns).
#' @param genes_path Path containing the MCP genes
#
#'
#' @return A matrix with cell enrichment scores from MCP
#'
computeMCP <- function(TPM_matrix, genes_path) {
  genes <- utils::read.table(paste0(genes_path, "/MCPcounter/MCPcounter-genes.txt"), sep = "\t", stringsAsFactors = FALSE, header = TRUE, colClasses = "character", check.names = FALSE)
  mcp <- MCPcounter::MCPcounter.estimate(TPM_matrix, genes = genes, featuresType = "HUGO_symbols", probesets = NULL) %>%
    t()

  colnames(mcp) = paste0("MCP_", colnames(mcp))
  colnames(mcp) <- colnames(mcp) %>%
    stringr::str_replace_all(., " ", "_")

  return(mcp)
}

#' Computes XCell
#'
#' @param TPM_matrix A matrix with TPM normalized counts (genes symbols as rows and samples as columns).
#'
#' @return A matrix with cell enrichment scores from XCell.
#'
computeXCell <- function(TPM_matrix) {
  #t(xCell::xCellAnalysis(counts))  # try this: more cells
  xcell = immunedeconv::deconvolute(TPM_matrix, "xcell") %>%
    tibble::column_to_rownames("cell_type") %>%
    t()

  colnames(xcell) = paste0("XCell_", colnames(xcell))
  colnames(xcell) <- colnames(xcell) %>%
    stringr::str_replace_all(., " ", "_")

  return(xcell)
}

#' Compute CIBERSORTx (CBSX) in parallel across multiple signatures
#'
#' @param TPM_matrix A matrix with TPM normalized counts (genes symbols as rows and samples as columns).
#' @param signatures Path where signatures files are located
#' @param name Credential email for running CIBERSORTx.
#' @param password Credential token for running CIBERSORTx.
#' @param workers Number of processes available to run on parallel.
#'
#' @return A matrix with cell abundance deconvolve with CBSX
#'
computeCBSX_parallel = function(TPM_matrix, signatures, name, password, workers){
  cl = parallel::makeCluster(workers)
  doParallel::registerDoParallel(cl)

  cbsx = foreach::foreach (i=1:length(signatures), .combine=cbind, .packages = "multideconv") %dopar% {
    signature <- utils::read.delim(signatures[[i]], row.names=1)
    signature_name = stringr::str_split(basename(signatures[[i]]), "\\.")[[1]][1]
    computeCBSX(TPM_matrix, signature, name, password, signature_name)
  }

  parallel::stopCluster(cl)
  unregister_dopar()

  return(cbsx)
}

#' Computes CIBERSORTx (CBSX) using one signature
#'
#' @param TPM_matrix A matrix with TPM normalized counts (genes symbols as rows and samples as columns).
#' @param signature_file The signature file to use.
#' @param name Credential email for running CIBERSORTx.
#' @param password Credential token for running CIBERSORTx.
#' @param name_signature Signature name to set for the deconvolution results.
#'
#' @return A matrix with cell abundance deconvolve with CBSX
#'
computeCBSX = function(TPM_matrix, signature_file, name, password, name_signature){
  omnideconv::set_cibersortx_credentials(name, password)
  cbsx = omnideconv::deconvolute_cibersortx(TPM_matrix, signature_file)

  colnames(cbsx) = paste0("CBSX_", name_signature, "_", colnames(cbsx))
  colnames(cbsx) <- colnames(cbsx) %>%
    stringr::str_replace_all(., " ", "_")

  return(cbsx)
}

#' Compute DWLS in parallel across multiple signatures
#'
#' @param TPM_matrix A matrix with TPM normalized counts (genes symbols as rows and samples as columns).
#' @param signatures Path where signatures files are located
#' @param workers Number of processes available to run on parallel.
#'
#' @return A matrix with cell abundance deconvolve with DWLS
#'
computeDWLS_parallel = function(TPM_matrix, signatures, workers){
  cl = parallel::makeCluster(workers)
  doParallel::registerDoParallel(cl)

  dwls = foreach::foreach (i=1:length(signatures), .combine=cbind, .packages = "multideconv") %dopar% {
    signature <- utils::read.delim(signatures[[i]], row.names=1)
    signature_name = stringr::str_split(basename(signatures[[i]]), "\\.")[[1]][1]
    computeDWLS(TPM_matrix, signature, signature_name)
  }

  parallel::stopCluster(cl)
  unregister_dopar()

  return(dwls)
}

#' Computes DWLS
#'
#' @param TPM_matrix A matrix with TPM normalized counts (genes symbols as rows and samples as columns).
#' @param signature_file The signature file to use.
#' @param name_signature Signature name to set for the deconvolution results.
#'
#' @return A matrix with cell abundance deconvolve with DWLS
#'
computeDWLS = function(TPM_matrix, signature_file, name_signature){
  genes = rownames(signature_file)

  signature_file <- signature_file %>%
    apply(., 2, as.numeric) %>%
    data.frame() %>%
    dplyr::mutate("Genes" = genes) %>%
    tibble::column_to_rownames("Genes") %>%
    as.matrix()

  dwls = omnideconv::deconvolute_dwls(TPM_matrix, signature_file, dwls_submethod = "SVR", verbose = T)

  colnames(dwls) = paste0("DWLS_", name_signature, "_", colnames(dwls))
  colnames(dwls) <- colnames(dwls) %>%
    stringr::str_replace_all(., " ", "_")

  return(dwls)
}

#' Computes MOMF
#'
#' @param TPM_matrix A matrix with TPM normalized counts (genes symbols as rows and samples as columns).
#' @param sc_object A matrix with the counts from scRNAseq object (genes as rows and cells as columns)
#' @param signature_file The signature file to use.
#' @param name_signature Signature name to set for the deconvolution results.
#'
#' @return A matrix with cell abundance deconvolve with MOMF
#'
computeMOMF = function(TPM_matrix, sc_object, signature_file, name_signature){

  genes = rownames(signature_file)

  signature_file <- signature_file %>%
    apply(., 2, as.numeric) %>% #rownames are removed here
    data.frame() %>%
    dplyr::mutate("Genes" = genes) %>% #set original rownames
    tibble::column_to_rownames("Genes") %>%
    as.matrix()

  momf = omnideconv::deconvolute_momf(bulk_gene_expression = TPM_matrix, single_cell_object = as.matrix(sc_object),
                                      signature = signature_file, method = "KL", verbose = T)$cell.prop

  colnames(momf) = paste0("MOMF_", name_signature, "_", colnames(momf))
  colnames(momf) <- colnames(momf) %>%
    stringr::str_replace_all(., " ", "_")

  return(momf)
}

#' Compute MOMF in parallel across multiple signatures
#'
#' @param TPM_matrix A matrix with TPM normalized counts (genes symbols as rows and samples as columns).
#' @param sc_object A matrix with the counts from scRNAseq object (genes as rows and cells as columns)
#' @param signatures Path where signatures files are located
#' @param workers Number of processes available to run on parallel.
#'
#' @return A matrix with cell abundance deconvolve with MOMF
#'
computeMOMF_parallel = function(TPM_matrix, sc_object, signatures, workers){
  cl = parallel::makeCluster(workers)
  doParallel::registerDoParallel(cl)

  momf = foreach::foreach (i=1:length(signatures), .combine=cbind, .packages = "multideconv") %dopar% {
    signature <- utils::read.delim(signatures[[i]], row.names=1)
    signature_name = stringr::str_split(basename(signatures[[i]]), "\\.")[[1]][1]
    computeMOMF(TPM_matrix, sc_object, signature, signature_name)
  }

  parallel::stopCluster(cl)
  unregister_dopar()

  return(momf)
}

#' Computes EpiDISH
#'
#' @param TPM_matrix A matrix with TPM normalized counts (genes symbols as rows and samples as columns).
#' @param signature_file The signature file to use.
#' @param name_signature Signature name to set for the deconvolution results.
#'
#' @return A matrix with cell abundance deconvolve with EpiDISH
#'
computeEpiDISH = function(TPM_matrix, signature_file, name_signature){
  epi <- EpiDISH::epidish(TPM_matrix, as.matrix(signature_file), method = "RPC", maxit = 500)
  epidish = epi$estF

  colnames(epidish) = paste0("Epidish_", name_signature, "_", colnames(epidish))
  colnames(epidish) <- colnames(epidish) %>%
    stringr::str_replace_all(., " ", "_")

  return(epidish)
}

#' Computes DeconRNASeq
#'
#' @param TPM_matrix A matrix with TPM normalized counts (genes symbols as rows and samples as columns).
#' @param signature_file The signature file to use.
#' @param name_signature Signature name to set for the deconvolution results.
#'
#' @return A matrix with cell abundance deconvolve with DeconRNASeq
#'
#' @import pcaMethods
computeDeconRNASeq = function(TPM_matrix, signature_file, name_signature){
  if (!requireNamespace("DeconRNASeq", quietly = TRUE)) {
    stop("Package 'DeconRNASeq' is required for computeDeconRNASeq(). ",
         "Install it from Bioconductor with: BiocManager::install('DeconRNASeq')")
  }

  if (!requireNamespace("pcaMethods", quietly = TRUE)) {
    stop("Package 'pcaMethods' is required for computeDeconRNASeq()")
  }

  decon <- DeconRNASeq::DeconRNASeq(TPM_matrix, data.frame(signature_file))
  deconRNAseq = decon$out.all
  rownames(deconRNAseq) = colnames(TPM_matrix)

  colnames(deconRNAseq) = paste0("DeconRNASeq_", name_signature, "_", colnames(deconRNAseq))
  colnames(deconRNAseq) <- colnames(deconRNAseq) %>%
    stringr::str_replace_all(., " ", "_")

  return(deconRNAseq)
}

#' Compute deconvolution methods with variable signatures
#'
#' @param TPM_matrix A matrix with TPM normalized counts (samples as columns and genes symbols as rows)
#' @param signatures A path with a directory where signatures are located
#' @param algos A character vector with the methods to compute (Default methods are CBSX, Epidish, DeconRNASeq and DWLS)
#' @param exclude (Optional) A character vector with the signature to exclude
#' @param cbsx.name CIBERSORTx credential mail if CBSX will be run
#' @param cbsx.token CIBERSORTx credential token if CBSX will be run
#' @param doParallel Boolean value to specify if DWLS and CBSX should run in parallel (default is False)
#' @param workers Number of worker process to run during parallelization (default is NULL)
#' @param sc_obj A matrix with the counts from scRNAseq object (genes as rows and cells as columns) to run MOMF method. If NULL, MOMF is ignored.
#'
#' @return A matrix with the deconvolution features corresponding to all combinations of methods-signatures specified
#' @references
#'
#' Sturm, G., Finotello, F., Petitprez, F., Zhang, J. D., Baumbach, J., Fridman, W. H., ..., List, M., Aneichyk, T. (2019). Comprehensive evaluation of transcriptome-based cell-type quantification methods for immuno-oncology.
#' Bioinformatics, 35(14), i436-i445. https://doi.org/10.1093/bioinformatics/btz363
#'
#' Benchmarking second-generation methods for cell-type deconvolution of transcriptomic data. Dietrich, Alexander and Merotto, Lorenzo and Pelz, Konstantin and Eder, Bernhard and Zackl, Constantin and Reinisch, Katharina and
#' Edenhofer, Frank and Marini, Federico and Sturm, Gregor and List, Markus and Finotello, Francesca. (2024) https://doi.org/10.1101/2024.06.10.598226
#'
compute_methods_variable_signature = function(TPM_matrix, signatures, algos = c("CBSX", "Epidish", "DeconRNASeq", "DWLS", "MOMF"), exclude = NULL, cbsx.name, cbsx.token, doParallel = FALSE, workers = NULL, sc_obj = NULL){

  signature_dir = "Results/custom_signatures"
  default_sig = list.files(signatures, full.names = T, pattern = "\\.txt$")
  user_files = list.files(signature_dir, full.names = TRUE, pattern = "\\.txt$")

  db <- c(default_sig, user_files)

  name_exclude = c()
  if(is.null(algos)==F){
    cat("\nThe following method-signature combinations are going to be calculated...............................................................\n")

    cat("\nMethods\n")
    for (deconv_method in algos) {
      cat("* ", deconv_method, "\n", sep = "")
    }
    cat("\nSignatures\n")
    for (i in 1:length(db)) {
      name = stringr::str_split(basename(db[[i]]), "\\.")[[1]][1]
      cat("* ", name, "\n", sep = "")
      if(is.null(exclude)==F && name %in% exclude){
        name_exclude = c(name_exclude, name)
      }
    }

    if(length(name_exclude)>0){
      cat("\nExcluding signatures: ", paste0(name_exclude, collapse = ", "), "\n")
    }

    deconvolution = list()

    if("CBSX" %in% algos){
      if(is.null(cbsx.name)==T || is.null(cbsx.token)==T){
        cat("\nYou select to run CBSX but no credentials were found")
        cat("\nPlease set your credentials in the function for running CIBERSORTx")
        stop()
      }
    }

    for (i in 1:length(db)) {
      signature <- utils::read.delim(db[[i]], row.names=1)
      signature_name = stringr::str_split(basename(db[[i]]), "\\.")[[1]][1]

      ###Check whether common genes between counts and signature have values different than 0 to avoid NAs
      # common.data <- rownames(TPM_matrix) %in% rownames(signature)
      # data.check <- TPM_matrix[common.data,]
      # zero = any(rowSums(data.check != 0) == 0)
      # if(zero){
      #   exclude = c(exclude, signature_name)
      #   warning("Common genes between count matrix and signature ", signature_name, " are all zero values")
      # }

      if(!is.null(exclude) && signature_name %in% exclude) {
        next
      }else{
        if("DeconRNASeq"%in%algos){
          cat("\nRunning DeconRNASeq...............................................................\n\n")
          deconrnaseq <- computeDeconRNASeq(TPM_matrix, signature, signature_name)}
        if("Epidish"%in%algos){
          cat("\nRunning Epidish...............................................................\n\n")
          epidish_res <- computeEpiDISH(TPM_matrix, signature, signature_name)}
        if("DWLS"%in%algos){
          if(doParallel == F){
            cat("\nRunning DWLS...............................................................\n\n")
            dwls <- computeDWLS(TPM_matrix, signature, signature_name)}}
        if("CBSX"%in%algos){
          if(doParallel == F){
            cat("\nRunning CBSX...............................................................\n\n")
            cbsx <- computeCBSX(TPM_matrix, signature, cbsx.name, cbsx.token, signature_name)}}
        if("MOMF"%in%algos & is.null(sc_obj) == F){
          if(doParallel == F){
            cat("\nRunning MOMF...............................................................\n\n")
            momf <- computeMOMF(TPM_matrix, sc_obj, signature, signature_name)}}
        combined_data <- NULL
        if (exists("deconrnaseq")) {
          combined_data <- deconrnaseq
        }
        if (exists("epidish_res")) {
          if (is.null(combined_data)) {
            combined_data <- epidish_res
          } else {
            combined_data <- cbind(combined_data, epidish_res)
          }
        }
        if (exists("cbsx")) {
          if (is.null(combined_data)) {
            combined_data <- cbsx
          } else {
            combined_data <- cbind(combined_data, cbsx)
          }
        }
        if (exists("dwls")) {
          if (is.null(combined_data)) {
            combined_data <- dwls
          } else {
            combined_data <- cbind(combined_data, dwls)
          }
        }
        if (exists("momf")) {
          if (is.null(combined_data)) {
            combined_data <- momf
          } else {
            combined_data <- cbind(combined_data, momf)
          }
        }
        deconvolution[[i]] <- combined_data
      }
    }

    deconv = do.call(cbind, deconvolution)

    if("DWLS"%in%algos && doParallel == T){
      cat("\nRunning DWLS in parallel using", workers,"workers...............................................................\n\n")
      dwls <- computeDWLS_parallel(TPM_matrix, db, workers)
      deconv = cbind(deconv, dwls)
    }

    if("CBSX"%in%algos && doParallel == T){
      cat("\nRunning CBSX in parallel using", workers,"workers...............................................................\n\n")
      cbsx <- computeCBSX_parallel(TPM_matrix, db, cbsx.name, cbsx.token, workers)
      deconv = cbind(deconv, cbsx)
    }

    if("MOMF"%in%algos && doParallel == T && is.null(sc_obj) == F){
      cat("\nRunning MOMF in parallel using", workers,"workers...............................................................\n\n")
      momf <- computeMOMF_parallel(TPM_matrix, sc_obj, db, workers)
      deconv = cbind(deconv, momf)
    }

    return(deconv)
  }else{
    cat("\nNo methods to be calculated using variable signatures.")
    return(NULL)
  }

}

#' Compute deconvolution
#'
#'The function calculates cell abundance based on cell type signatures using different methods and signatures. Methods available are Quantiseq, MCP, XCell, CIBERSORTx, EpiDISH, DWLS and DeconRNASeq. Provided signatures included signatures based on bulk and methylation data (7 methods and 10 signature in total). Signatures are present in the src/signatures directory, user can add its own signatures by adding the .txt files in this same folder. Second generation methods to perform deconvolution based on single cell data are also available if scRNAseq object is provided.
#'
#' @param raw.counts A matrix with the raw counts (samples as columns and genes symbols as rows)
#' @param methods A character vector with the deconvolution methods to run. Default are "Quantiseq", "MCP", "xCell", "CBSX", "Epidish", "DeconRNASeq", "DWLS"
#' @param signatures_exclude A character vector with the signatures to exclude from the src/signatures folder.
#' @param normalized If raw.counts are not available, user can input its normalized counts. In that case this argument need to be set to False.
#' @param doParallel Whether to do or not parallelization. Only CBSX and DWLS methods will run in parallel.
#' @param workers Number of processes available to run on parallel. If no number is set, this will correspond to detectCores() - 1
#' @param return Whether to save or not the csv file with the deconvolution features
#' @param create_signature Whether to create or not the signatures using the methods MOMF, CBSX, DWLS and BSeq-SC. If TRUE, sc_matrix shuld be provide.
#' @param credentials.mail (Optional) Credential email for running CIBERSORTx. If not provided, CIBERSORTx method will not be run.
#' @param credentials.token (Optional) Credential token for running CIBERSORTx. If not provided, CIBERSORTx method will not be run.
#' @param sc_deconv Whether to run or not deconvolution methods based on single cell.
#' @param sc_matrix If sc_deconv = T, the matrix of counts across cells from the scRNAseq object is provided.
#' @param sc_metadata Dataframe with metadata from the single cell object. The matrix should include the columns cell_label and sample_label.
#' @param methods_sc A character vector with the sc-deconvolution methods to run. Default are "Autogenes", "BayesPrism", "Bisque", "CPM", "MuSic", "SCDC"
#' @param cell_label If sc_deconv = T, a character vector indicating the cell labels (same order as the count matrix)
#' @param sample_label If sc_deconv = T, a character vector indicating the cell samples IDs (same order as the count matrix)
#' @param cell_markers Named list with the genes markers names as Symbol per cell types to be used to create the signature using the BSeq-SC method. If NULL, the method will be ignored during the signature creation.
#' @param methods_sig A character vector specifying which methods to run. Options are "DWLS", "CIBERSORTx", "MOMF", and "BSeqsc". Default runs all available methods.
#' @param name_sc_signature If sc_deconv = T, the name you want to give to the signature generated
#' @param file_name File name for the csv files and plots saved in the Results/ directory
#'
#' @return
#'
#' A matrix of cell type deconvolution features across samples
#'
#' @export
#'
#' @examples
#'
#' data("raw_counts")
#' data("cell_labels")
#' data("sample_labels")
#' data("metacells_data")
#' data("metacells_metadata")
#' data("pseudobulk")
#'
#' deconv = compute.deconvolution(raw_counts, normalized = TRUE,
#'                                methods = c("Epidish"), return = FALSE)
#'
#'
#' @references
#'
#' Sturm, G., Finotello, F., Petitprez, F., Zhang, J. D., Baumbach, J., Fridman, W. H., ..., List, M., Aneichyk, T. (2019). Comprehensive evaluation of transcriptome-based cell-type quantification methods for immuno-oncology.
#' Bioinformatics, 35(14), i436-i445. https://doi.org/10.1093/bioinformatics/btz363
#'
#' Benchmarking second-generation methods for cell-type deconvolution of transcriptomic data. Dietrich, Alexander and Merotto, Lorenzo and Pelz, Konstantin and Eder, Bernhard and Zackl, Constantin and Reinisch, Katharina and
#' Edenhofer, Frank and Marini, Federico and Sturm, Gregor and List, Markus and Finotello, Francesca. (2024) https://doi.org/10.1101/2024.06.10.598226
#'
compute.deconvolution <- function(raw.counts, methods = c("Quantiseq", "CBSX", "Epidish", "DeconRNASeq", "DWLS"), signatures_exclude = NULL, normalized = TRUE, doParallel = FALSE, workers = NULL, return = TRUE, create_signature = FALSE,
                                  credentials.mail = NULL, credentials.token = NULL, sc_deconv = FALSE, sc_matrix = NULL, sc_metadata = NULL, methods_sc = c("Autogenes", "BayesPrism", "Bisque", "CPM", "MuSic", "SCDC"), cell_label = NULL,
                                  sample_label = NULL, cell_markers = NULL, methods_sig = c("DWLS", "CIBERSORTx", "MOMF", "BSeqsc"), name_sc_signature = NULL, file_name = NULL){

  path_signatures = system.file("signatures", package = "multideconv")

  if(normalized == T){
    cat("Performing TPM normalization ................................................................................\n\n")
    TPM_matrix = data.frame(ADImpute::NormalizeTPM(raw.counts))
  }else{ #If no raw counts are available
    TPM_matrix = data.frame(raw.counts)
  }

  cat("Running deconvolution using the following methods...............................................................\n\n")
  for (method in methods) {
    cat("* ", method, "\n", sep = "")
  }

  if("Quantiseq" %in% methods){
    cat("\nRunning Quantiseq...............................................................\n")
    quantiseq = computeQuantiseq(TPM_matrix)}
  # if("MCP" %in% methods){
  #   cat("\nRunning MCPCounter...............................................................\n")
  #   mcp = computeMCP(TPM_matrix, path_signatures)}
  # if("xCell" %in% methods){
  #   xcell = computeXCell(TPM_matrix)
  #   cat("\nRunning XCell...............................................................\n")}
  #
  default_sig = "Quantiseq" #This was including MCP and XCell before
  methods = methods[!(methods %in% default_sig)]
  if(length(methods) == 0){
    methods = NULL
  }

  if(create_signature == T){
    message("\nCreating static signatures...............................................................\n")
    if(is.null(sc_matrix)==T || is.null(sc_metadata) == T){
      stop("No single cell object or metadata has been provided for creating signature.")
    }else{
      signatures = create_sc_signatures(sc_matrix, sc_metadata, cell_label, sample_label, credentials.mail = credentials.mail, credentials.token = credentials.token,
                                        bulk_rna = raw.counts, cell_markers, name_signature = name_sc_signature, methods_sig = methods_sig)
    }
  }

  deconv_sig = compute_methods_variable_signature(TPM_matrix, signatures = path_signatures, algos = methods, exclude = signatures_exclude, cbsx.name = credentials.mail, cbsx.token = credentials.token, doParallel, workers, sc_matrix)

  deconv_default <- NULL
  if (exists("quantiseq")) {
    deconv_default <- quantiseq
  }
  if (exists("mcp")) {
    if (is.null(deconv_default)) {
      deconv_default <- mcp
    } else {
      deconv_default <- cbind(deconv_default, mcp)
    }
  }
  if (exists("xcell")) {
    if (is.null(deconv_default)) {
      deconv_default <- xcell
    } else {
      deconv_default <- cbind(deconv_default, xcell)
    }
  }

  if(is.null(deconv_sig)){
    all_deconvolution_table = deconv_default
  }else{
    all_deconvolution_table = cbind(deconv_default, deconv_sig)
  }

  if(sc_deconv){
    message("Running second generation cell-type deconvolution methods using scRNAseq\n")
    if(is.null(sc_matrix)==T){
      stop("No single cell object has been provided for deconvolution.")
    }else{
      deconv_sc = compute_sc_deconvolution_methods(raw.counts, normalized = normalized, methods_sc = methods_sc, sc_matrix,
                                                   sc_metadata, cell_label, sample_label, name_sc_signature, n_cores = workers)
      all_deconvolution_table = cbind(data.frame(all_deconvolution_table), deconv_sc)
    }
  }

  deconvolution = compute.deconvolution.preprocessing(data.frame(all_deconvolution_table))

  if(return == TRUE){
    utils::write.csv(deconvolution, paste0("Results/Deconvolution_", file_name, ".csv"))
  }

  return(deconvolution)

}

#' Compute second-generation deconvolution methods
#'
#' @param raw_counts A matrix with raw counts (samples as columns and genes symbols as rows)
#' @param normalized Boolean value to specify if raw_counts need to be normalized (If no raw_counts are available and argument corresponds to already normalized counts this arguments needs to be set to False)
#' @param methods_sc A character vector with the sc-deconvolution methods to run. Default are "Autogenes", "BayesPrism", "Bisque", "CPM", "MuSic", "SCDC"
#' @param sc_object A matrix with the counts from scRNAseq object (genes as rows and cells as columns)
#' @param sc_metadata Dataframe with metadata from the single cell object. The matrix should include the columns cell_label and sample_label.
#' @param cell_annotations A string with the column name with the cell labels (column should be of the same order as in the sc_object)
#' @param samples_ids A string with the column name with the samples labels (column should be of the same order as in the sc_object)
#' @param name_object Signature name to use in the generated single cell signature for deconvolving the bulk RNAseq data
#' @param n_cores Number of cores to use for paralellization. If no number is set, detectCores() - 1 will be set as the number.
#' @param return Whether to save or not the csv file with the deconvolution features.
#' @param file_name File name for the .csv file to save with the deconvolution results.
#'
#' @return A matrix of deconvolution features across samples from your bulk counts based on the second generation methods.
#' @references
#' Sturm, G., Finotello, F., Petitprez, F., Zhang, J. D., Baumbach, J., Fridman, W. H., ..., List, M., Aneichyk, T. (2019). Comprehensive evaluation of transcriptome-based cell-type quantification methods for immuno-oncology.
#' Bioinformatics, 35(14), i436-i445. https://doi.org/10.1093/bioinformatics/btz363
#'
#' Benchmarking second-generation methods for cell-type deconvolution of transcriptomic data. Dietrich, Alexander and Merotto, Lorenzo and Pelz, Konstantin and Eder, Bernhard and Zackl, Constantin and Reinisch, Katharina and
#' Edenhofer, Frank and Marini, Federico and Sturm, Gregor and List, Markus and Finotello, Francesca. (2024) https://doi.org/10.1101/2024.06.10.598226
#'
compute_sc_deconvolution_methods = function(raw_counts, normalized = TRUE, methods_sc = c("Autogenes", "BayesPrism", "Bisque", "CPM", "MuSic", "SCDC"), sc_object, sc_metadata, cell_annotations, samples_ids, name_object, n_cores = NULL, return = FALSE, file_name = NULL){
  if(normalized){
    bulk_counts = ADImpute::NormalizeTPM(raw_counts)
  } else {
    bulk_counts = raw_counts
  }

  if(is.null(n_cores)){
    n_cores = parallel::detectCores() - 1
    message("\nUsing ", n_cores, " cores available for running...\n")
  }

  results = list()

  if("Autogenes" %in% methods_sc){
    message("\nRunning AutogeneS...\n")
    autogenes = omnideconv::deconvolute_autogenes(
      bulk_gene_expression = bulk_counts,
      single_cell_object = as.matrix(sc_object),
      cell_type_annotations = as.character(sc_metadata[,cell_annotations]),
      verbose = TRUE
    )$proportions
    results$AutogeneS = autogenes
  }

  if("BayesPrism" %in% methods_sc){
    message("\nRunning BayesPrism...\n")
    bayesprism = omnideconv::deconvolute_bayesprism(
      bulk_gene_expression = raw_counts,
      single_cell_object = as.matrix(sc_object),
      cell_type_annotations = as.character(sc_metadata[,cell_annotations]),
      n_cores = n_cores
    )$theta
    results$BayesPrism = bayesprism
  }

  if("Bisque" %in% methods_sc){
    message("\nRunning Bisque...\n")
    bisque = omnideconv::deconvolute_bisque(
      bulk_gene_expression = as.matrix(raw_counts),
      single_cell_object = as.matrix(sc_object),
      cell_type_annotations = as.character(sc_metadata[,cell_annotations]),
      batch_ids = as.character(sc_metadata[,samples_ids]),
      verbose = TRUE
    )$bulk_props
    results$Bisque = bisque
  }

  if("CPM" %in% methods_sc){
    message("\nRunning CPM...\n")
    sampled_SCData <- stratified_sample_cells(as.matrix(sc_object), sc_metadata, cell_annotations, n_cells_per_type = 500) #Sample cells to a max of 500 per cell type
    set.seed(123) #Stochastic method (CPM is not deterministic)
    cpm = omnideconv::deconvolute_cpm(
      bulk_gene_expression = data.frame(raw_counts),
      single_cell_object = as.matrix(sampled_SCData$Counts),
      no_cores = n_cores,
      cell_type_annotations = as.character(sampled_SCData$Metadata[, cell_annotations]),
      verbose = TRUE
    )$cellTypePredictions
    results$CPM = cpm
  }

  if("MuSic" %in% methods_sc){
    message("\nRunning MuSiC...\n")
    music = omnideconv::deconvolute_music(
      bulk_gene_expression = as.matrix(bulk_counts),
      single_cell_object = as.matrix(sc_object),
      cell_type_annotations = as.character(sc_metadata[,cell_annotations]),
      batch_ids = as.character(sc_metadata[,samples_ids]),
      verbose = TRUE
    )$Est.prop.weighted
    results$MuSic = music
  }

  if("SCDC" %in% methods_sc){
    message("\nRunning SCDC...\n")
    scdc = omnideconv::deconvolute_scdc(
      bulk_gene_expression = as.matrix(bulk_counts),
      single_cell_object = as.matrix(sc_object),
      cell_type_annotations = as.character(sc_metadata[,cell_annotations]),
      batch_ids = as.character(sc_metadata[,samples_ids]),
      verbose = TRUE
    )$prop.est.mvw
    results$SCDC = scdc
  }

  # Format and combine results
  results <- lapply(names(results), function(method) {
    deconv_method <- results[[method]]
    colnames(deconv_method) <- paste0(method, "_", name_object, "_", colnames(deconv_method))
    colnames(deconv_method) <- stringr::str_replace_all(colnames(deconv_method), " ", "_")
    return(deconv_method)
  })

  results = do.call(cbind, results)

  if(return == TRUE){
    utils::write.csv(results, paste0("Results/Deconvolution_sc_", file_name, ".csv"))
  }

  return(results)

  ### METHODS NOT YET IMPLEMENTED

  # 1. BSeq-sc: Need CIBERSORT source code
  # message("\nRunning BSeq-sc...............................................................\n")
  # bseqsc = omnideconv::deconvolute_bseqsc(bulk_gene_expression = as.matrix(bulk_counts), signature = signatures[["BSeqsc"]], verbose = T)

  # 2. CDSeq: Crash machine
  # message("\nRunning CDSeq...............................................................\n")
  # cdseq = omnideconv::deconvolute_cdseq(bulk_gene_expression = raw_counts, single_cell_object = as.matrix(sc_object), no_cores = n_cores,
  #                     cell_type_annotations = as.character(sc_metadata[,cell_annotations]), batch_ids = as.character(sc_metadata[,samples_ids]), verbose = T)

  # 3. SCADEN: Takes a lot of time
  # message("\nRunning Scaden...............................................................\n")
  # model_scaden <- omnideconv::build_model(bulk_gene_expression = bulk.data, counts.matrix, as.character(cell_annotations),
  #                                         batch_ids = samples_ids, method = "scaden")
  # scaden = deconvolute_scaden(bulk_gene_expression = bulk_counts,
  #                             signature = model_scaden, verbose = T)

}


#' Create meta-cells from a single cell object using the KNN algorithm. This function is adapted from the R package hdWGCNA (Morabito et al., 2023)
#'
#' @param sc_object A matrix with the counts from scRNAseq object (genes as rows and cells as columns)
#' @param labels_column A character vector with the cell labels (need to be of the same order as in the sc_object)
#' @param samples_column A character vector with the samples labels (need to be of the same order as in the sc_object)
#' @param exclude_cells Cell types to discard from metacell algorithm.
#' @param min_cells The minimum number of cells in a particular grouping to construct metacells.
#' @param k Number of nearest neighbors to aggregate for KNN algorithm.
#' @param max_shared The maximum number of cells to be shared across two metacells.
#' @param n_workers Number of cores to use for paralellization.
#' @param min_meta Minimum number of metacells allowed. Below this number, metacells of this cell type will be discarded.
#'
#' @return A list with two elements:
#' - The metacell count matrix (genes as rownames and cells as columns)
#' - The metadata matrix corresponding to the metacell object
#'
#' @export
#'
#' @references
#'
#' Langfelder, P., Horvath, S. WGCNA: an R package for weighted correlation network analysis. BMC Bioinformatics 9, 559 (2008). https://doi.org/10.1186/1471-2105-9-559
#'
#' Morabito, S., Reese, F., Rahimzadeh, N., Miyoshi, E., & Swarup, V. (2023). hdWGCNA identifies co-expression networks in high-dimensional transcriptomics data. Cell Reports Methods, 3(6), 100498. https://doi.org/10.1016/j.crmeth.2023.100498
#'
#'
create_metacells = function(sc_object, labels_column, samples_column, exclude_cells = NULL, min_cells = 50, k = 15, max_shared = 15, n_workers = 4, min_meta = 10){

  message("\nCreating metacells...............................................................\n")
  ## Setup sc object
  data <- hdWGCNA::SetupForWGCNA(
    sc_object,
    gene_select = "fraction", # the gene selection approach
    fraction = 0.05, # fraction of cells that a gene needs to be expressed in order to be included
    wgcna_name = "MetaCells" # the name of the hdWGCNA experiment
  )

  rm(sc_object)
  gc()

  ### Parallelize work
  data@meta.data$cells_labels = data@meta.data[,labels_column]
  data@meta.data$samples_ids = data@meta.data[,samples_column]
  Seurat::Idents(data) = data@meta.data$cells_labels
  subset_data = list()
  contador = 1
  cells_ids = unique(data@meta.data$cells_labels)
  cells = cells_ids[!cells_ids %in% exclude_cells]
  for (cell_type in cells) {
    for (patient in unique(data@meta.data$samples_ids)) {
      x = subset(x = data, subset = samples_ids == patient, idents = cell_type, return.null = T)
      if(is.null(x) == F){
        subset_data[[contador]] <- x
        contador = contador + 1
      }
    }
  }

  # Set up parallelization using the future package
  future::plan(future::multisession, workers = n_workers) # Adjust the number of workers based on your system
  # Run the function in parallel
  results <- future.apply::future_lapply(subset_data, FUN = process_group, min_cells, k, max_shared, labels_column, samples_column, future.seed = TRUE)
  results <- results[!sapply(results, is.null)]

  #Stop parallelization from running in the background
  future::plan(future::sequential)

  rm(data, subset_data)
  gc()

  message("\nMetacells done!...............................................................\n")

  # Combine results into a single Seurat object (if needed)
  counts_sc = do.call(cbind, lapply(results, '[[', 1))
  metadata = do.call(rbind, lapply(results, '[[', 2))

  rm(results)
  gc()

  n_cells = table(metadata[,labels_column])
  low_count_cells <- n_cells[n_cells < min_meta]

  cat("\nNumber of metacells per cell type\n")
  print(n_cells)

  cat("\nRemoving metacells with less than", min_meta, "...............................................................\n")
  print(names(low_count_cells))

  metadata = metadata %>%
    dplyr::filter(!.data[[labels_column]] %in% names(low_count_cells))
  counts_sc = counts_sc[,colnames(counts_sc) %in% rownames(metadata)]

  return(list(Counts = counts_sc, Metadata = metadata))

}

#' Replicate deconvolution subgroups in a new dataset
#'
#' Reconstructs and applies deconvolution subgroup signatures based on a previous decomposition.
#'
#' @param deconv_res A list containing results from the deconvolution process, including:
#'   \itemize{
#'     \item{\code{Deconvolution subgroups composition}: a list of subgroup feature names per iteration}
#'     \item{\code{Deconvolution matrix}: the original deconvolution result used to determine relevant features}
#'   }
#' @param deconvolution_test A data.frame or matrix of deconvolution results (e.g., from another cohort)
#'
#' @return A data.frame with the projected subgroup features proportions
#' @export
#'
replicate_deconvolution_subgroups = function(deconv_res, deconvolution_test){

  #deconv_subgroups <- mapply(c, deconv_res[[3]], deconv_res[[4]], SIMPLIFY = FALSE) #Join cell groups
  deconv_subgroups = deconv_res[["Deconvolution subgroups composition"]]
  iterations = find.maximum.iteration(deconv_subgroups)

  ## Extract the deconv feature without the cluster type
  features_with_clusters <- colnames(deconv_res[["Deconvolution matrix"]])
  has_clusters <- grepl("_.*(mixed|immunosuppressive|immunoactive)$", features_with_clusters)

  if(any(has_clusters)){

    # Base name = everything before final cluster label
    base_names <- sub("_(mixed|immunosuppressive|immunoactive)$",
                      "",
                      features_with_clusters)

    # Cluster suffix = cluster type
    cluster_suffixes <- sub(".*_(mixed|immunosuppressive|immunoactive)$",
                            "\\1",
                            features_with_clusters)

    map <- data.frame(base = base_names,
                      suffix = cluster_suffixes,
                      stringsAsFactors = FALSE)
  }

  if (is.infinite(iterations) && iterations < 0) {
    warning("No subgroups to replicate")
    ## Paste the corresponding clusters to the deconvolution features
    if(any(has_clusters)){
      colnames(deconvolution_test) <- paste0(colnames(deconvolution_test), map$suffix[match(colnames(deconvolution_test), map$base)])
    }

    deconvolution_test = deconvolution_test[,colnames(deconvolution_test)%in%colnames(deconv_res[["Deconvolution matrix"]])] # Filter for features not found in the deconv_res (low variance, zeros, etc)
    return(data.frame(deconvolution_test))
  }

  # Create same groups composition
  for (m in 1:iterations) {
    base_groups = list()
    for (i in 1:length(deconv_subgroups)){
      if(length(deconv_subgroups[[i]])!=0){
        idy = grep(paste0("Iteration.",m), names(deconv_subgroups[[i]]))
        if(length(idy)!=0){
          base_groups = append(base_groups, deconv_subgroups[[i]][idy])
        }
      }
    }

    deconv_subgroups_values = c()
    for (i in 1:length(base_groups)) {
      x = as.matrix(deconvolution_test[, colnames(deconvolution_test) %in% base_groups[[i]], drop = FALSE])

      if(ncol(x) == 0){
        med = rep(0, nrow(deconvolution_test))
      } else {
        med = matrixStats::rowMedians(x)
      }

      deconv_subgroups_values = cbind(deconv_subgroups_values, med) #Compute median using base groups
    }
    colnames(deconv_subgroups_values) = names(base_groups)
    deconvolution_test = cbind(deconv_subgroups_values, deconvolution_test) # Join cell subgroups and deconv features

  }

  ## Paste the corresponding clusters to the deconvolution features
  if(any(has_clusters)){
    colnames(deconvolution_test) <- paste0(colnames(deconvolution_test), "_", map$suffix[match(colnames(deconvolution_test), map$base)])
  }

  deconvolution_test = deconvolution_test[,colnames(deconvolution_test)%in%colnames(deconv_res[["Deconvolution matrix"]])]

  return(data.frame(deconvolution_test))
}

#' Find maximum iteration from subgroups
#'
#' @param cells.groups Cell groups corresponding to a specific cell type.
#'
#' @return Maximum subgroupping iteration
#'
#' @keywords internal
find.maximum.iteration = function(cells.groups){
  max_iteration = c()
  for (i in 1:length(cells.groups)){
    if(is.null(names(cells.groups[[i]]))==F){
      iterations <- sapply(names(cells.groups[[i]]), function(x) {
        as.numeric(sub(".*\\.Iteration\\.(\\d+)", "\\1", x))
      })
      local_max = max(unlist(iterations))
      max_iteration = c(max_iteration, local_max)
    }
  }

  return(max(max_iteration))
}

#' Compute deconvolution benchmark
#'
#' @param deconvolution The deconvolution matrix output from compute.deconvolution()
#' @param groundtruth A matrix with the cell type proportions (samples as rows and cell types as columns). Cell types names should correspond to the ones on the deconvolution matrix.
#' @param cells_extra A string specifying the cells names to consider and that are not including in the nomenclature of multideconv (see Readme)
#' @param corr_type Secifies the type of correlations to compute ('spearman' or 'pearson').
#' @param scatter Boolean value to specify if scatter plots should be returned.
#' @param pval A numeric value with the pvalue to use for selecting significant features.
#' @param plot Boolean value to whether save or not the plot of the benchmark in the Results/ directory.
#' @param file_name A string specifying the name of the plot saved in Results/
#' @param width A numeric value with the width for the returned plot.
#' @param height A numeric value with the height for the returned plot.
#'
#' @return A correlation matrix between the cell type deconvolution combinations and the real cell proportions.
#' @export
#'
#' @examples
#'
#' data("deconvolution")
#' data("cells_groundtruth")
#'
#' corr_matrix = compute.benchmark(deconvolution, cells_groundtruth, cells_extra = "Myeloid.cells",
#'                                 corr_type = "spearman", scatter = FALSE)
#'
compute.benchmark = function(deconvolution, groundtruth, cells_extra = NULL, corr_type = "spearman", scatter = TRUE, plot = FALSE, pval = 0.05, file_name = NULL, width = 16, height = 8){

  groundtruth = groundtruth[rownames(deconvolution),] #Order samples to match both features

  cell_types = c("B.cells", "B.naive.cells", "B.memory.cells", "Macrophages.cells", "Macrophages.M0", "Macrophages.M1", "Macrophages.M2", "Monocytes", "Neutrophils", "NK.cells", "NK.activated", "NK.resting", "NKT.cells", "CD4.cells", "CD4.memory.activated",
                 "CD4.memory.resting", "CD4.naive", "CD8.cells", "CD4.regulatory", "CD4.non.regulatory","T.cells.helper", "T.cells.gamma.delta", "Dendritic.cells", "Dendritic.activated.cells", "Dendritic.resting.cells", "Cancer", "Endothelial",
                 "Eosinophils", "Plasma", "Myocytes", "Fibroblast", "Mast.cells", "Mast.activated.cells", "Mast.resting.cells", "CAF")

  cell_types = c(cell_types, cells_extra)

  pattern <- paste0("(_", gsub("\\.", "\\\\.", cell_types), ")$", collapse = "|")
  deconvolution_combinations <- unique(gsub(pattern, "", colnames(deconvolution)))

  deconvolution_combinations = gsub("(BPRNACan3DProMetNew|BPRNACanProMetNew|BPRNACan3DMetNew|BPRNACan3DProMet|BPRNACanProMet|BPRNACan)", "\\1_", deconvolution_combinations)

  ###Correlation function
  corr_bench <- function(data, corr, pval = 0.05) {
    M <- Hmisc::rcorr(as.matrix(data), type = corr)

    # Only keep the three matrix elements: r, P, n
    Mdf <- purrr::map(M[c("r", "P", "n")], ~data.frame(.x))

    corr_df <- Mdf %>%
      purrr::map(~tibble::rownames_to_column(.x, var = "measure1")) %>%
      purrr::map(~tidyr::pivot_longer(.x, -measure1, names_to = "measure2")) %>%
      dplyr::bind_rows(.id = "id") %>%
      tidyr::pivot_wider(names_from = id, values_from = value) %>%
      dplyr::mutate(
        r = as.numeric(r),
        P = as.numeric(P),
        sig_p = ifelse(P < pval, TRUE, FALSE),
        p_if_sig = ifelse(sig_p, P, NA),
        r_if_sig = ifelse(sig_p, r, NA)
      )

    return(corr_df)
  }

  #####Scatter plot function
  scatter_plots = function(deconv, ground, corr_method){
    for (i in 1:ncol(deconv)) {
      data = cbind(deconv[,i], ground)
      colnames(data) = c("x", "y")
      cor_test <- stats::cor.test(data$x, data$y, method = corr_method)
      cor_value <- cor_test$estimate  # Correlation coefficient
      p_value <- cor_test$p.value    # p-value

      p <- ggplot2::ggplot(data, ggplot2::aes(x = x, y = y)) +
        ggplot2::geom_point(color = "blue", size = 0.1, alpha = 0.7) +  # Customize the points
        ggplot2::geom_smooth(method = "lm", se = T, color = "red") +  # Add regression line
        ggplot2::theme_minimal() +  # Apply a minimal theme
        ggplot2::labs(
          x = colnames(ground),
          #title = paste0("Linear correlation - ", colnames(ground)),  # Set the title
          y = colnames(deconv)[i],                 # Set the x-axis label
        ) +
        ggplot2::theme(
          axis.title.x = ggplot2::element_text(size = 5),
          axis.text.x = ggplot2::element_text(size = 5),
          axis.text.y = ggplot2::element_text(size = 5),
          axis.title.y = ggplot2::element_text(size = 5)  # Adjust title font size and position
        ) +
        ggplot2::geom_text(
          ggplot2::aes(x = mean(data$x), y = max(data$y), label = paste("r =", round(cor_value, 2), ", pval = ", round(p_value, 2))),  # Add the correlation text
          size = 2,  # Adjust the font size of the correlation coefficient text
          hjust = 0.5,  # Adjust the horizontal alignment of the text
          vjust = -1     # Adjust the vertical position of the text
        )

      print(p)
    }
  }

  cell_clusters = colnames(groundtruth)

  ###Correlation matrix
  corr_matrix = data.frame(matrix(ncol = length(deconvolution_combinations), nrow = length(cell_clusters)))
  pval_matrix = data.frame(matrix(ncol = length(deconvolution_combinations), nrow = length(cell_clusters)))
  rownames(corr_matrix) = cell_clusters
  colnames(corr_matrix) = deconvolution_combinations
  rownames(pval_matrix) = cell_clusters
  colnames(pval_matrix) = deconvolution_combinations
  cells_discard = c()
  plots_all = list()

  ###Correlation computation
  for (i in 1:length(cell_clusters)) {
    idx = grep(paste0("_", cell_clusters[i], "$"), colnames(deconvolution))
    if(length(idx)==0){
      cells_discard = c(cells_discard, cell_clusters[i])
    }

    deconv = deconvolution[,idx, drop = F]

    ground = groundtruth[,cell_clusters[i],drop=F]

    ###Scatter plots
    if(scatter == T){
      if(ncol(deconv)!=0){
        pdf(paste0("Scatter_plots_", colnames(ground), "_", file_name))
        scatter_plots(deconv, ground, corr_type)
        dev.off()
      }
    }

    x = corr_bench(cbind(deconv, ground), corr_type, pval)
    x = x[which(x$measure1==colnames(ground)),] #only taking corr against ground truth

    for (j in 1:ncol(corr_matrix)) {
      idx = grep(colnames(corr_matrix)[j], x$measure2)
      if(length(idx) == 0){
        corr_matrix[i,j] = NA
      }else{
        corr_matrix[i,j] = x$r[idx]
      }
    }

    for (j in 1:ncol(pval_matrix)) {
      idx = grep(colnames(pval_matrix)[j], x$measure2)
      if(length(idx) == 0){
        pval_matrix[i,j] = NaN
      }else{
        pval_matrix[i,j] = x$P[idx]
      }
    }
  }


  ###Benchmarking plot
  if(length(cells_discard)>0){
    corr_matrix = corr_matrix[-which(rownames(corr_matrix)%in%cells_discard),]
    pval_matrix = pval_matrix[-which(rownames(pval_matrix)%in%cells_discard),]
  }

  ## remove NA columns
  corr_matrix = corr_matrix %>%
    dplyr::select(dplyr::where(~ !all(is.na(.))))

  pval_matrix = pval_matrix %>%
    dplyr::select(dplyr::where(~ !all(is.na(.))))

  corr_matrix[nrow(corr_matrix)+1,] = colMeans(corr_matrix, na.rm = T)
  rownames(corr_matrix)[nrow(corr_matrix)] = "average"

  pval_matrix[nrow(pval_matrix)+1,] = 0
  rownames(pval_matrix)[nrow(pval_matrix)] = "average"

  ##Order methods
  corr_matrix = t(corr_matrix) %>%
    data.frame() %>%
    dplyr::arrange(average) %>%
    t() %>%
    data.frame()

  corr_df <- reshape2::melt(corr_matrix)
  pval_df = reshape2::melt(pval_matrix[,colnames(corr_matrix)]) #Take the same order as corr_matrix

  corr_df = corr_df %>%
    dplyr::mutate(Cells = rep(rownames(corr_matrix), ncol(corr_matrix)),
                  pval_value = pval_df$value)

  g <- corr_df %>%
    ggplot2::ggplot(ggplot2::aes(Cells, variable, fill=value, label=round(value,2))) +
    ggplot2::geom_tile() +
    ggplot2::labs(x = NULL, y = NULL, fill = paste0(corr_type, "'s\nCorrelation"), title=file_name, subtitle = paste0("Only showing significant correlations (<", pval, ")")) +
    ggplot2::scale_fill_gradient2(mid="#FBFEF9",low="#0C6291",high="#A63446", limits=c(-1,1)) +
    ggplot2::geom_text(data = subset(corr_df, pval_value <= pval)) +
    ggplot2::theme_classic() +
    ggplot2::scale_x_discrete(expand=c(0,0)) +
    ggplot2::scale_y_discrete(expand=c(0,0)) +
    ggpubr::rotate_x_text(angle = 45) + ggplot2::theme(axis.text.x=ggtext::element_markdown()) + ggplot2::theme(axis.text.y=ggtext::element_markdown())

  if(plot){
    grDevices::pdf(paste0("Results/Benchmark_plot_", file_name,".pdf"), width = width, height = height)
    plot(g)
    grDevices::dev.off()
  }

  return(corr_matrix)

}

#' Create pseudo bulk from single cell object
#'
#' @param sc_obj A Seurat single cell object
#' @param cells_labels A character vector with the cell labels (need to be of the same order as in the sc_obj)
#' @param sample_labels A character vector with the samples labels (need to be of the same order as in the sc_obj)
#' @param normalized Whether pseudobulk should be or not TPM normalized
#' @param file_name A string specifying the name of the .csv pseudobulk saved in Results/
#'
#' @return A gene count matrix (genes as rows and samples as columns)
#' @export
#'
create_sc_pseudobulk = function(sc_obj, cells_labels, sample_labels, normalized = TRUE, file_name){

  #Convert to SingleCell
  sc_obj@meta.data$Patient = as.factor(sc_obj@meta.data[,sample_labels])
  sc_obj@meta.data$new_annotation = as.factor(sc_obj@meta.data[,cells_labels])
  sce = Seurat::as.SingleCellExperiment(sc_obj)

  ##Aggregating counts
  aggr_counts <- glmGamPoi::pseudobulk(sce, group_by = glmGamPoi::vars(Patient), aggregation_functions = list(counts = "rowMeans2", .default = "rowMeans2"))
  pseudo_counts = data.frame(aggr_counts@assays@data$counts)

  if(normalized == TRUE){
    pseudo_counts = ADImpute::NormalizeTPM(pseudo_counts, log=F) %>%
      data.frame()
  }

  #Save pseudobulk matrix
  utils::write.table(pseudo_counts, file = paste0("Results/", file_name, ".csv"), quote = F, sep = "\t", row.names = T)

  return(pseudo_counts)

}


#' Create cell type signatures from scRNAseq
#'
#'
#' @param sc_obj A matrix with the counts from scRNAseq object (genes as rows and cells as columns)
#' @param sc_metadata Dataframe with metadata from the single cell object. The matrix should include the columns cell_label and sample_label.
#' @param cells_labels A character vector with the cell labels (need to be of the same order as in the sc_object)
#' @param sample_labels A character vector with the samples labels (need to be of the same order as in the sc_object)
#' @param credentials.mail (Optional) Credential email for running CIBERSORTx If not provided, CIBERSORTx method will not be run.
#' @param credentials.token (Optional) Credential token for running CIBERSORTx. If not provided, CIBERSORTx method will not be run.
#' @param bulk_rna A matrix of bulk data. Rows are genes, columns are samples. This is needed for MOMF method, if not given the method will not be run.
#' @param cell_markers Named list with the genes markers names as Symbol per cell types to be used to create the signature using the BSeq-SC method. If NULL, the method will be ignored during the signature creation.
#' @param name_signature A string indicating the signature name. This will be added as a suffix in each method (e.g. CBSX_name_signature, DWLS_name_signature)
#' @param methods_sig A character vector specifying which methods to run. Options are "DWLS", "CIBERSORTx", "MOMF", and "BSeqsc". Default runs all available methods.
#'
#' @return A list containing the cell signatures per method. Signatures are directly saved in Results/custom_signatures folder, these will be used to run deconvolution.
#' @export
#'
#' @references
#' Sturm, G., Finotello, F., Petitprez, F., Zhang, J. D., Baumbach, J., Fridman, W. H., ..., List, M., Aneichyk, T. (2019). Comprehensive evaluation of transcriptome-based cell-type quantification methods for immuno-oncology.
#' Bioinformatics, 35(14), i436-i445. https://doi.org/10.1093/bioinformatics/btz363
#'
#' Benchmarking second-generation methods for cell-type deconvolution of transcriptomic data. Dietrich, Alexander and Merotto, Lorenzo and Pelz, Konstantin and Eder, Bernhard and Zackl, Constantin and Reinisch, Katharina and
#' Edenhofer, Frank and Marini, Federico and Sturm, Gregor and List, Markus and Finotello, Francesca. (2024) https://doi.org/10.1101/2024.06.10.598226
#'
create_sc_signatures = function(sc_obj,
                                sc_metadata,
                                cells_labels,
                                sample_labels,
                                credentials.mail = NULL,
                                credentials.token = NULL,
                                bulk_rna = NULL,
                                cell_markers = NULL,
                                name_signature = NULL,
                                methods_sig = c("DWLS", "CIBERSORTx", "MOMF", "BSeqsc")) {

  signature_dir = "Results/custom_signatures/"
  dir.create(signature_dir, showWarnings = FALSE, recursive = TRUE)

  sc_obj = as.matrix(sc_obj)
  signatures = list()

  # DWLS
  if ("DWLS" %in% methods_sig) {
    cat("\nRunning DWLS...............................................................\n")
    model_dwls <- omnideconv::build_model_dwls(
      sc_obj, as.character(sc_metadata[,cells_labels]),
      dwls_method = "mast_optimized", ncores = 1
    ) %>%
      data.frame() %>%
      tibble::rownames_to_column("NAME")

    utils::write.table(model_dwls, paste0(signature_dir, "DWLS-", name_signature,"-scRNAseq.txt"), row.names = FALSE, quote = FALSE, sep = "\t")
    signatures[["DWLS"]] = model_dwls
  }

  # CIBERSORTx
  if ("CIBERSORTx" %in% methods_sig) {
    cat("\nRunning CIBERSORTx...............................................................\n")

    if (is.null(credentials.mail) || is.null(credentials.token)) {
      warning("Skipping CIBERSORTx: Credentials not provided.")
      cat("Please provide credentials.mail and credentials.token to run CIBERSORTx.\n")
    } else {
      omnideconv::set_cibersortx_credentials(credentials.mail, credentials.token)
      model_cbsx <- omnideconv::build_model(
        sc_obj, as.character(sc_metadata[,cells_labels]),
        batch_ids = as.character(sc_metadata[,sample_labels]),
        method = "cibersortx"
      ) %>%
        data.frame() %>%
        tibble::rownames_to_column("NAME")

      utils::write.table(model_cbsx, paste0(signature_dir, "CBSX-", name_signature,"-scRNAseq.txt"), row.names = FALSE, quote = FALSE, sep = "\t")
      signatures[["CBSX"]] = model_cbsx
    }
  }

  # MOMF
  if ("MOMF" %in% methods_sig) {
    if (is.null(bulk_rna)) {
      warning("Skipping MOMF: bulk_rna not provided.")
    } else {
      cat("\nRunning MOMF...............................................................\n")
      model_momf <- omnideconv::build_model_momf(
        sc_obj, as.character(sc_metadata[,cells_labels]),
        bulk_gene_expression = bulk_rna
      ) %>%
        data.frame() %>%
        tibble::rownames_to_column("NAME")

      utils::write.table(model_momf, paste0(signature_dir, "MOMF-", name_signature,"-scRNAseq.txt"), row.names = FALSE, quote = FALSE, sep = "\t")
      signatures[["MOMF"]] = model_momf
    }
  }

  # BSeqsc
  if ("BSeqsc" %in% methods_sig) {
    if (is.null(cell_markers)) {
      warning("Skipping BSeqsc: cell_markers not provided.")
    } else {
      cat("\nRunning BSeq-sc...............................................................\n")
      model_bseq <- omnideconv::build_model_bseqsc(
        sc_obj, as.character(sc_metadata[,cells_labels]),
        markers = cell_markers,
        batch_ids = as.character(sc_metadata[,sample_labels])
      ) %>%
        data.frame() %>%
        tibble::rownames_to_column("NAME")

      utils::write.table(model_bseq, paste0(signature_dir, "BSeqSC-", name_signature,"-scRNAseq.txt"), row.names = FALSE, quote = FALSE, sep = "\t")
      signatures[["BSeqsc"]] = model_bseq
    }
  }

  return(signatures)
}

unregister_dopar <- function() {
  if (!is.null(foreach::getDoParRegistered())) {
    # switch back to sequential backend
    foreach::registerDoSEQ()
    gc()
  }
}

# Function to process each group in metacells
process_group <- function(data, min_cells = 50, k = 15, max_shared = 15, labels_column, samples_column) {

  if (ncol(data) < min_cells) {
    cat("Skipping group: Less than", min_cells, "cells in this subset\n")
    return(NULL) # Return NULL for groups with insufficient cells
  }

  #Create Metacells by Groups celltype_patient
  seurat_obj = hdWGCNA::MetacellsByGroups(seurat_obj = data,
                                          min_cells = min_cells,
                                          group.by = c(labels_column, samples_column),
                                          reduction = 'pca',
                                          k = k,
                                          max_shared = max_shared,
                                          ident.group = labels_column)

  meta = hdWGCNA::GetMetacellObject(seurat_obj)

  counts = as.matrix(SeuratObject::GetAssayData(meta, assay = "RNA", slot = "counts"))

  result <- list(
    counts = counts,
    metadata = meta@meta.data
  )

  # Clean memory inside worker
  rm(data, seurat_obj, meta)
  gc()

  return(result)

}

stratified_sample_cells <- function(SCData, SCData_metadata, cell_label, n_cells_per_type = 500, seed = 123) {
  set.seed(seed)

  # Add cell name as a column for tracking
  SCData_metadata <- SCData_metadata %>%
    tibble::rownames_to_column("cell_name")

  # Split by cell type
  sampled_cells_df <- SCData_metadata %>%
    dplyr::group_split(.data[[cell_label]]) %>%
    purrr::map_dfr(~ {
      n_sample <- min(n_cells_per_type, nrow(.x))
      .x %>% dplyr::slice_sample(n = n_sample)
    })

  # Extract sampled cell names
  sampled_cell_names <- sampled_cells_df$cell_name

  # Subset counts and metadata
  metadata <- sampled_cells_df %>%
    tibble::column_to_rownames("cell_name")

  counts <- SCData[, sampled_cell_names]

  return(list(Counts = counts, Metadata = metadata))
}

#' Prepare folds for multideconv cross-validation with processed training and test data
#'
#' This function processes a dataset for k-fold cross-validation using the multideconv framework.
#' For each fold, it generates training and test datasets by computing deconvolution subgroups features from the deconvolution matrix.
#' It also processes the entire dataset once to provide a final processed training set.
#'
#' @param data A matrix or data frame of deconvolution features (samples x features) and a column named `target` indicating class labels.
#' @param folds A list of integer vectors indicating row indices for the training set in each fold. The test set is implicitly defined as the complement.
#' @param bestune Optional tuning object; when provided, folds are skipped and full-data processing is returned.
#' @param ncores Number of CPU cores for parallel fold processing.
#' @param time_var Optional survival time vector used when target labels are not provided.
#' @param event_var Optional survival event vector used when target labels are not provided.
#' @param trait.positive Label in `event_var` that defines event = 1.
#' @param cells_extra Optional character vector of additional cell labels to include.
#'
#' @return A list of two elements:
#' \itemize{
#'   \item \code{processed_folds}: A list of folds, where each fold contains:
#'     \itemize{
#'       \item \code{train_data}: Processed training data with cell group features and `target` column.
#'       \item \code{test_data}: Test data projected into the learned cell group feature space.
#'       \item \code{obs_test}: True class labels for the test set.
#'       \item \code{rowIndex}: Row indices corresponding to the test set.
#'       \item \code{fold_name}: Optional fold name if provided in the `folds` list.
#'     }
#'   \item \code{train_cell_data_final}: Final cell group feature matrix for the full dataset, including the `target` column.
#' }
#'
#' @details The function runs the `compute.deconvolution.analysis()` function on each fold's training set and uses the trained projection
#' to compute the test set representation. It also runs multideconv on the full dataset to return the complete processed training set.
#'
#' @importFrom dplyr mutate
#' @importFrom stats setNames
#' @export
#'
prepare_multideconv_folds <- function(
    data,
    folds = NULL,
    bestune = NULL,
    ncores = NULL,
    time_var = NULL,
    event_var = NULL,
    trait.positive = NULL,
    cells_extra = NULL
) {

  # -----------------------------
  # CASE 1: bestune provided → compute full training once
  # -----------------------------
  if (!is.null(bestune)) {

    # Determine target / survival info
    if ("target" %in% colnames(data)) {
      obs_train <- data$target
      data$target <- NULL
    } else if (!is.null(time_var) && !is.null(event_var)) {
      obs_train <- list(
        time  = time_var,
        event = as.numeric(event_var == trait.positive)
      )
    } else {
      stop("Data must contain 'target' column or both time_var and event_var")
    }

    # Compute deconvolution on full dataset
    deconv_subgroups_final <- compute.deconvolution.analysis(
      deconvolution = data,
      corr = 0.7,
      seed = 123,
      cells_extra = cells_extra,
      return = FALSE
    )

    train_cell_data_final <- deconv_subgroups_final[[1]] %>%
      dplyr::mutate(target = if (is.list(obs_train)) NA else obs_train)

    # For survival info
    if (is.list(obs_train)) {
      train_cell_data_final <- train_cell_data_final %>%
        dplyr::mutate(time = obs_train$time, event = obs_train$event)
    }

    custom_output <- deconv_subgroups_final

    return(list(train_cell_data_final, custom_output, bestune))
  }

  # -----------------------------
  # CASE 2: bestune NOT provided → compute folds
  # -----------------------------
  if (is.null(ncores)) ncores <- parallel::detectCores() - 2
  cl <- parallel::makeCluster(ncores)
  doParallel::registerDoParallel(cl)

  processed_folds <- foreach::foreach(
    i = seq_along(folds),
    .packages = c("dplyr", "multideconv")
  ) %dopar% {
    cat("Starting fold", names(folds)[i], "\n")

    train_idx <- folds[[i]]
    test_idx  <- setdiff(seq_len(nrow(data)), train_idx)

    # TRAIN
    train_data <- data[train_idx, , drop = FALSE]

    if ("target" %in% colnames(train_data)) {
      obs_train <- train_data$target
      train_data$target <- NULL
    } else if (!is.null(time_var) && !is.null(event_var)) {
      obs_train <- list(
        time  = time_var[train_idx],
        event = as.numeric(event_var[train_idx] == trait.positive)
      )
    } else {
      stop("Data must contain 'target' column or both time_var and event_var")
    }

    deconv_subgroups <- compute.deconvolution.analysis(
      deconvolution = train_data,
      corr = 0.7,
      seed = 123,
      cells_extra = cells_extra,
      return = FALSE
    )

    train_cell_data <- deconv_subgroups[[1]] %>%
      dplyr::mutate(target = if (is.list(obs_train)) NA else obs_train)

    if (is.list(obs_train)) {
      train_cell_data <- train_cell_data %>%
        dplyr::mutate(time = obs_train$time, event = obs_train$event)
    }

    # TEST
    test_data_raw <- data[test_idx, , drop = FALSE]
    obs_test <- if ("target" %in% colnames(data)) data$target[test_idx] else list(
      time  = time_var[test_idx],
      event = as.numeric(event_var[test_idx] == trait.positive)
    )
    test_data_raw$target <- NULL

    test_data <- replicate_deconvolution_subgroups(deconv_subgroups, test_data_raw)

    list(
      train_data = train_cell_data,
      test_data  = test_data,
      obs_test   = obs_test,
      rowIndex   = test_idx,
      fold_name  = names(folds)[i]
    )
  }

  parallel::stopCluster(cl)
  unregister_dopar()

  # Save each fold
  for (i in seq_along(processed_folds)) {
    saveRDS(processed_folds[[i]], file = file.path("Results", paste0("fold_", names(folds)[i], ".rds")))
  }
}


#' Build a Deconvolution–Pathway Relationship Dictionary
#'
#' @description
#' The `deconvolution_dictionary()` function integrates cell-type–specific
#' deconvolution features with a pathway activity matrix. It identifies globally
#' consistent pathway clusters and reannotates each deconvolution feature
#' according to its association with those pathway clusters.
#'
#' The function first computes a global correlation matrix between the full
#' deconvolution matrix and the provided pathway activity matrix, performs
#' hierarchical clustering on the pathways, and automatically determines the
#' optimal number of pathway clusters using the silhouette method. Each
#' deconvolution feature within each cell type is then correlated with the
#' pathways, scored against the global clusters, and classified into the cluster
#' with which it is most strongly associated.
#'
#' @param deconv_subgroups Output of `compute.deconvolution.analysis()`
#'
#' @param pathway_matrix A numeric matrix or data frame of pathway activities
#'   (rows = samples, columns = pathways), with the same row names as the
#'   deconvolution matrices. Can be any pathway or feature activity matrix.
#' @param batch_id Optional batch covariate used when computing module relationships.
#'
#' @return
#' An updated version of \code{deconv_subgroups} containing:
#' \describe{
#'   \item{\code{Deconvolution matrix}}{A rebuilt deconvolution matrix obtained by
#'     column-binding all cell-type–specific subgroups after relabeling features
#'     with their corresponding pathway cluster.}
#'   \item{\code{Deconvolution subgroups per cell types}}{The list of cell-type–
#'     specific matrices, each with feature names updated to reflect their
#'     cluster classification (e.g., \code{"FeatureA_Cluster_1"}).}
#'   \item{\code{Clusters}}{A list of globally defined pathway clusters (e.g.,
#'     \code{$Cluster_1}, \code{$Cluster_2}, ...), where each element contains the
#'     pathways belonging to that cluster.}
#' }
#'
#' @details
#' - The optimal number of pathway clusters (\eqn{k}) is determined automatically
#'   using the silhouette width criterion via \code{factoextra::fviz_nbclust()}.
#' - The clustering is performed globally across all pathways, ensuring consistent
#'   interpretation of clusters across all cell types.
#' - Each deconvolution feature is assigned to the pathway cluster with the
#'   highest eigenvector score.
#'
#' @seealso
#' \code{\link[CellTFusion]{compute.modules.relationship}},
#' \code{\link[factoextra]{fviz_nbclust}},
#' \code{\link[stats]{hclust}},
#' \code{\link[stats]{cutree}}
#'
#' @importFrom purrr list_flatten
#' @importFrom dplyr bind_cols
#' @importFrom stats dist hclust cutree
#' @importFrom factoextra fviz_nbclust hcut
#'
deconvolution_dictionary = function(deconv_subgroups, pathway_matrix, batch_id = NULL){
  if (!requireNamespace("CellTFusion", quietly = TRUE)) {
    stop("Package 'CellTFusion' is required for deconvolution_dictionary(). ",
         "Install it with: pak::pkg_install('VeraPancaldiLab/CellTFusion')")
  }

  pathway_matrix = pathway_matrix[,!colnames(pathway_matrix)%in%c("Androgen", "Estrogen")]
  cell_subgroups = deconv_subgroups[["Deconvolution subgroups per cell types"]]
  cell_clusters = list()
  i = 1

  # Compute global module correlation using the full deconvolution matrix
  global_x = CellTFusion::compute.modules.relationship(
    deconv_subgroups[["Deconvolution matrix"]],
    pathway_matrix,
    return = TRUE,
    batch = batch_id,
    plot = FALSE
  )

  #Create distance matrix and hierarchical clustering for the PROGENy pathways (global)
  d_global <- stats::dist(t(global_x[[1]]))
  dendrogram_global <- stats::hclust(d_global)

  #Identify the two global pathway clusters
  clusters_global <- stats::cutree(dendrogram_global, k = 2)
  clusters_global <- split(names(clusters_global), clusters_global)

  # Automatic TME annotation based on pathway composition
  tme_annotation <- c(
    "Androgen" = "mixed",
    "JAK.STAT" = "immunoactive",
    "NFkB" = "immunosuppressive",
    "Trail" = "immunoactive",
    "WNT" = "immunosuppressive",
    "p53" = "mixed",
    "EGFR" = "immunosuppressive",
    "Estrogen" = "mixed",
    "Hypoxia" = "immunosuppressive",
    "MAPK" = "mixed",
    "PI3K" = "immunosuppressive",
    "TGFb" = "immunosuppressive",
    "TNFa" = "immunoactive",
    "VEGF" = "immunosuppressive"
  )

  cluster_tme <- sapply(clusters_global, function(paths) {
    effects <- tme_annotation[paths]
    n_immunoactive <- sum(effects == "immunoactive")
    n_suppressive <- sum(effects == "immunosuppressive")

    if (n_immunoactive > n_suppressive) {
      return("immunoactive")
    } else if (n_suppressive > n_immunoactive) {
      return("immunosuppressive")
    } else {
      return("mixed")
    }
  })

  # Rename clusters BEFORE computing scores
  names(clusters_global) <- cluster_tme

  # Calculate eigenvector-based score (PC1) for each cluster
  corr_matrix_global <- data.frame(global_x[[1]])
  for (k in seq_along(clusters_global)) {
    cluster_name <- names(clusters_global)[k]
    sub_mat <- corr_matrix_global[, clusters_global[[k]], drop = FALSE]

    # Compute eigenvector (PC1) direction per feature (deconv row)
    pca_res <- stats::prcomp(sub_mat, center = TRUE, scale. = TRUE)
    pc1_scores <- pca_res$x[, 1]  # first principal component
    corr_matrix_global[[paste0(cluster_name, "_Score")]] <- pc1_scores
  }

  # Classify features based on the highest mean correlation across all clusters
  cluster_scores <- corr_matrix_global[, grepl("_Score$", colnames(corr_matrix_global)), drop = F]
  corr_matrix_global$Classification <- apply(cluster_scores, 1, function(row) {
    cluster_name <- names(which.max(row))
    gsub("_Score", "", cluster_name)
  })

  #Compute correlation within each cell type to see the cluster classification in its own cell-type context (avoid domination of strong correlations from abundant or variable cell types)
  for (cell in names(cell_subgroups)) {
    if (ncol(cell_subgroups[[cell]]) >= 2) {
      rownames(cell_subgroups[[cell]]) <- rownames(deconv_subgroups[["Deconvolution matrix"]])

      #Compute module correlation between cell deconvolution features and PROGENy pathways
      x <- CellTFusion::compute.modules.relationship(cell_subgroups[[cell]], pathway_matrix, return = TRUE, batch = batch_id, plot = FALSE)
      corr_matrix <- data.frame(x[[1]])

      for (k in seq_along(clusters_global)) {
        cluster_name <- names(clusters_global)[k]
        sub_mat <- corr_matrix[, clusters_global[[k]], drop = FALSE]

        # Compute eigenvector-based (PC1) score per cluster
        pca_res <- stats::prcomp(sub_mat, center = TRUE, scale. = TRUE)
        pc1_scores <- pca_res$x[, 1]
        corr_matrix[[paste0(cluster_name, "_Score")]] <- pc1_scores
      }

      #Identify which cluster each feature belongs to based on the highest mean score
      cluster_scores <- corr_matrix[, grepl("_Score$", colnames(corr_matrix)), drop = F]
      corr_matrix$Classification <- apply(cluster_scores, 1, function(row) {
        cluster_name <- names(which.max(row))
        gsub("_Score", "", cluster_name)
      })

      #Rename deconvolution features with cluster information
      deconv_names <- paste0(rownames(corr_matrix), "_", corr_matrix$Classification)
      colnames(cell_subgroups[[cell]]) <- deconv_names

    }else if (ncol(cell_subgroups[[cell]]) > 0) { # Subgroup has <2 features → assign cluster based on global classification
      feature_names <- colnames(cell_subgroups[[cell]])
      # Use global classification computed earlier
      global_feature_class <- corr_matrix_global$Classification
      names(global_feature_class) <- rownames(corr_matrix_global)
      # Assign the cluster to the feature (if feature exists in global_x)
      feature_class <- ifelse(feature_names %in% names(global_feature_class),
                              global_feature_class[feature_names],
                              "Unclassified")

      # Rename the feature with the assigned cluster
      colnames(cell_subgroups[[cell]]) <- paste0(feature_names, "_", feature_class)
    }
  }

  ### Flat list to replace main deconvolution element
  flat_list <- purrr::list_flatten(cell_subgroups)
  deconv_subgroups[["Deconvolution matrix"]] = bind_cols(flat_list)
  deconv_subgroups[["Deconvolution subgroups per cell types"]] = cell_subgroups
  deconv_subgroups[["States"]] = clusters_global

  return(deconv_subgroups)
}

aggregate_genes <- function(subgroup, default_quantiseq = "TIL10") {

  ct <- sub(".*_", "", subgroup[1]) # Extract cell type from subgroup name
  sigs <- unique(na.omit(sapply(subgroup, function(x) { # Iterate over subgroup names to extract signature names
    p <- strsplit(x, "_")[[1]] # Extract signature name from subgroup name
    if(grepl("^Quantiseq$", p[1], ignore.case = TRUE)){
      default_quantiseq # If Quantiseq, use default signature name TIL10
    }else if (length(p) >= 2){
      p[2] # If signature name is present, use it
    } 
  })))

  sigs <- gsub("\\.", "-", sigs)  # all signature coming from "." separated files should be converted to "-" to match the file names in the directory

  sigdir = system.file("signatures", package = "multideconv")
  signature_dir = "Results/custom_signatures"
  default_sig = list.files(sigdir, full.names = T, pattern = "\\.txt$")
  user_files = list.files(signature_dir, full.names = TRUE, pattern = "\\.txt$")
  files = c(default_sig, user_files) # Combine default and user signature files

  sel <- files[sapply(files, function(f) stringr::str_split(basename(f), "\\.")[[1]][1] %in% sigs)] # Select files that match the signature names

  scores <- numeric()
  for (f in sel) {
    df <- utils::read.delim(f, row.names = 1) # Read the signature file
    df <- standardize_celltype_colnames(df) # Standardize column names to match cell types
    cols <- grep(ct, colnames(df), ignore.case = TRUE) # Extract columns that match the cell type
    if (!length(cols)) next # If no columns match, skip to the next file
    s <- df[, cols, drop = FALSE] # Subset the data frame to keep only the relevant columns
    for (g in rownames(s)) { # Fill the scores vector with the gene scores, summing if the gene is already present
      if(is.na(scores[g])){
        scores[g] <- s[rownames(s)==g, ]}
      else{
        scores[g] <- scores[g] + s[rownames(s)==g, ]}
    }
  }
  res <- data.frame(gene = names(scores), score = as.numeric(scores), row.names = NULL)

  return(res)
}

#' Rank Genes by Correlation With a Deconvolution Subgroup
#'
#' Computes a data-driven gene ranking by correlating expression values with a
#' selected deconvolution subgroup across matched samples.
#'
#' @param res Data frame containing at least a `gene` column with genes to evaluate.
#' @param expr Gene expression matrix with genes in rows and samples in columns.
#' @param deconv Deconvolution matrix with samples in rows and features/subgroups in columns.
#' @param subgroup Character scalar indicating the subgroup/feature column in `deconv`.
#' @param method Correlation method passed to [stats::cor()], typically `"spearman"` or `"pearson"`.
#'
#' @return A data frame sorted in descending correlation, with one column named `correlation`
#' and row names corresponding to genes.
compute_data_driven_rank <- function(res,
                                     expr,        # genes x samples
                                     deconv,      # samples x methods
                                     subgroup,    # column names in deconv
                                     method = "spearman") {
  
  # -----------------------------
  # 1. Match samples
  # -----------------------------
  if(!all.equal(colnames(expr), rownames(deconv))){
    stop("Sample names in expr and deconv do not match")
  }
    
  # -----------------------------
  # 2. Subset deconv to subgroup
  # -----------------------------
  sub_est <- deconv[, subgroup, drop = FALSE]

  # -----------------------------
  # 3. Filter genes
  # -----------------------------
  genes_use <- intersect(res$gene, rownames(expr))
  expr_sub <- expr[genes_use, , drop = FALSE]
  
  # -----------------------------
  # 4. Correlation
  # -----------------------------
  cors <- apply(expr_sub, 1, function(g) {
    stats::cor(g, sub_est, method = method, use = "pairwise.complete.obs")
  })
  
  # -----------------------------
  # 5. Output ranked list
  # -----------------------------
  ranked <- data.frame(
    gene = names(cors),
    correlation = as.numeric(cors),
    stringsAsFactors = FALSE
  )
  rownames(ranked) <- ranked$gene
  ranked <- ranked[order(ranked$correlation, decreasing = TRUE), , drop = FALSE]
  ranked$gene <- NULL
    
  return(ranked)
}

#' Build a GSEA-Derived Signature Label for a Cell Subgroup
#'
#' Runs fgsea on ranked genes and creates a subgroup signature name based on the
#' top positively enriched pathway.
#'
#' @param gene_scores Data frame of ranked scores (as produced by [compute_data_driven_rank()]).
#' @param cell_type Character label used as prefix in the generated signature name.
#' @param pathways Optional named list of pathways (`pathway -> genes`). If `NULL`,
#' Hallmark pathways from `msigdbr` are used.
#' @param plot Logical; if `TRUE`, save a top-20 fgsea dot plot in `Results/`.
#'
#' @return A list with two elements:
#' `[[1]]` generated signature name, `[[2]]` a named list of enriched pathways.
create_gsea_signature <- function(gene_scores,
                                  cell_type,
                                  pathways = NULL,
                                  plot = FALSE) {

  stats <- gene_scores[[1]]
  names(stats) <- rownames(gene_scores)   # attach gene names
  stats <- stats[!is.na(stats)]           # drop NA scores
  ranks <- sort(stats, decreasing = TRUE, na.last = NA)  # sort in decreasing order for fgsea

  # load pathways if not provided
  if (is.null(pathways)) {
    msig <- msigdbr::msigdbr(species = "Homo sapiens", category = "H")
    pathways <- split(msig$gene_symbol, msig$gs_name)
  }

  # run fgsea 
  fg <- fgsea::fgseaMultilevel(pathways = pathways, stats = ranks, scoreType = "pos", nproc = 4) %>%
    dplyr::tibble() %>%
    dplyr::arrange(padj)

  # keep positive NES
  pos <- fg %>% 
    dplyr::filter(!is.na(NES) & NES > 0) %>%  # Keep positive NES
    dplyr::arrange(dplyr::desc(NES)) # Arrange by descending NES

  fg_top <- fg %>%
   dplyr::filter(!is.na(NES)) %>%
   dplyr::arrange(dplyr::desc(abs(NES))) %>%
   dplyr::slice_head(n = 20) %>%
   dplyr::mutate(pathway = factor(pathway, levels = rev(pathway)),
                 sig = -log10(padj + 1e-300))

  if(plot){
    grDevices::pdf(paste0("Results/",cell_type, "_FGSEA_top20.pdf"))
    print(ggplot2::ggplot(fg_top, ggplot2::aes(x = NES, y = pathway, size = size, color = sig)) +
      ggplot2::geom_point() +
      ggplot2::scale_color_viridis_c(name = "-log10(padj)") +
      ggplot2::scale_size_continuous(name = "pathway size") +
      ggplot2::labs(title = paste0(cell_type, " FGSEA top 20 pathways"), x = "NES", y = NULL) +
      ggplot2::theme_minimal(base_size = 12))
    grDevices::dev.off()
  }
  
  if (nrow(pos) == 0) {
    message("No pathways with NES > 0 found for ", cell_type, "; keeping original subgroup label.")
    return(NULL)
  }
  first_pathway <- as.character(pos$pathway[1]) 
  suffix <- stringr::str_replace_all(first_pathway, "[^A-Za-z0-9]+", "_") # Replace non-alphanumeric characters with underscores
  signature_name <- paste0(cell_type, "_", suffix) 
  signature_list <- setNames(list(as.character(pos$pathway)), cell_type)

  return(list(signature_name, signature_list))
}

expand_subgroup_members <- function(subgroup, subgroup_map) {
  prev_len <- -1
  cur <- subgroup
  while (any(cur %in% names(subgroup_map))) {
    cur <- unname(unlist(lapply(cur, function(x) {
      if (x %in% names(subgroup_map)) subgroup_map[[x]] else x
    }), use.names = FALSE))
  }

  return(cur)
}


#' Compute a Deconvolution Dictionary From Subgroup Gene Programs
#'
#' For each subgroup, this function aggregates signature genes, ranks genes by
#' correlation with subgroup abundance, performs GSEA, and renames subgroup
#' labels using the top enriched pathway.
#'
#' @param subgroups Output list from [compute.deconvolution.analysis()].
#' @param expr Gene expression matrix with genes in rows and samples in columns.
#' @param pathways Optional named list of pathways (`pathway -> genes`) used by fgsea.
#' If `NULL`, Hallmark pathways are used.
#' @param plot Logical; if `TRUE`, save GSEA summary plots in `Results/`.
#'
#' @return Updated `subgroups` list with renamed subgroup labels in
#' `"Deconvolution matrix"` and `"Deconvolution subgroups composition"`.
#' @export
compute_deconvolution_dictionary <- function(subgroups, expr, pathways = NULL, plot = FALSE) {

  subgroup_map <- subgroups[["Deconvolution subgroups composition"]]
  deconv_mat = subgroups[["Deconvolution matrix"]]
  comp = subgroups[["Deconvolution subgroups per cell types"]]

  for (cell_type in names(comp)) { # Iterate over cell types
    grp_list <- colnames(comp[[cell_type]]) # Extract cell type specific subgroup list
    subgroup_map_ct = subgroup_map[[cell_type]] # Extract cell type specific subgroup map
    for (sub_name in grp_list) { # Iterate over subgroups
      if(!sub_name %in% colnames(deconv_mat)) next # If subgroup not in deconv matrix, skip to next subgroup (e.g. subgroups included within another subgroup)
      subgroup_vec <- subgroup_map_ct[[sub_name]] # vector of method_signature entries
      if (is.null(subgroup_vec)) subgroup_vec <- sub_name # If no subgroup vector, use subgroup name as is (e.g. for subgroups that are not themselves subgroups of other subgroups)
      subgroup_vec = expand_subgroup_members(subgroup_vec, subgroup_map_ct) # expand subgroup members if they are themselves subgroups
      res <- aggregate_genes(subgroup_vec)    # aggregate gene scores for the subgroup
      ranked = compute_data_driven_rank(res = res,
                                         expr = expr,
                                         deconv = deconv_mat,
                                         subgroup = sub_name) # Compute correlation rankings for the subgroup

      sig_out <- create_gsea_signature(ranked, sub_name, pathways, plot = plot) # create pathwyas signature
      if (is.null(sig_out)) next # No enrichment found, skip to next subgroup
      new_label <- sig_out[[1]]
      idx <- which(colnames(deconv_mat) == sub_name) # replace column name in deconv_mat if present
      if (length(idx)) colnames(deconv_mat)[idx] <- new_label

      # rename subgroup entry in composition 
      subgroup_map[[cell_type]][[new_label]] <- subgroup_map[[cell_type]][[sub_name]]
      subgroup_map[[cell_type]][[sub_name]] <- NULL # Remove old subgroup entry
      colnames(comp[[cell_type]])[colnames(comp[[cell_type]]) == sub_name] <- new_label # rename subgroup entry in composition
    }
  }

  subgroups[["Deconvolution subgroups composition"]] <- comp
  subgroups[["Deconvolution matrix"]] <- deconv_mat

  return(subgroups)
}

#' Relate Deconvolution Subgroups to PROGENy Pathways
#'
#' Computes PROGENy pathway activity from normalized counts and evaluates module
#' relationships between subgroup profiles and pathway activity profiles.
#'
#' @param subgroups Output list from [compute.deconvolution.analysis()].
#' @param counts_norm Normalized expression matrix with genes in rows and samples in columns.
#' @param file_name Prefix used to save output files.
#' @param height Plot height in inches.
#' @param width Plot width in inches.
#' @param par_mar Numeric vector passed to plot margins.
#' @param pval P-value threshold used in module relationship plots.
#'
#' @return Invisibly returns `NULL`; side effects are generated output files.
#' @export
compute_subgroups_pathways <- function(subgroups,
                                       counts_norm,
                                       file_name = "Test",
                                       height = 6,
                                       width = 12,
                                       par_mar = c(4, 25, 5, 3),
                                       pval = 0.05) {
  if (!requireNamespace("CellTFusion", quietly = TRUE)) {
    stop("Package 'CellTFusion' is required for compute_subgroups_pathways(). ",
         "Install it with: pak::pkg_install('VeraPancaldiLab/CellTFusion')")
  }

  subgroups_cells = subgroups[["Deconvolution subgroups per cell types"]]

  # build PROGENy consensus matrix
  universe <- decoupleR::get_progeny()
  universe2 <- universe %>% dplyr::rename(mor = weight)
  sample_acts <- decoupleR::decouple(counts_norm,
                                     network = universe2,
                                     .source = "source",
                                     .target = "target",
                                     minsize = 0)
  mat_consensus <- sample_acts %>%
    dplyr::filter(statistic == "consensus") %>%
    decoupleR::pivot_wider_profile(id_cols = source,
                                   names_from = condition,
                                   values_from = score) %>%
    as.data.frame()

  for(celltype in names(subgroups_cells)) {
    cells = subgroups_cells[[celltype]]
    if(ncol(cells) < 2) next 
    CellTFusion::compute.modules.relationship(cells,
                                             data.frame(t(mat_consensus)),
                                             file_name = paste0(file_name, "_", celltype),
                                             height = height,
                                             width = width,
                                             par_mar = par_mar,
                                             pval = pval)
  }
  
}

#' Estimate Cell-Type-Specific Expression Profiles from Bulk Data
#'
#' Uses non-negative least squares (NNLS) to decompose bulk gene expression
#' into cell-type-specific expression estimates, given known cell-type fractions.
#'
#' @param bulk_expr A numeric matrix of bulk gene expression with genes as rows
#'   and samples as columns.
#' @param cell_fracs A numeric matrix of cell-type fractions with samples as rows
#'   and cell types as columns. Row names must match column names of `bulk_expr`.
#'
#' @return A named list of matrices, one per cell type. Each matrix has samples
#'   as rows and genes as columns, containing the estimated expression
#'   contribution of that cell type.
#'
#' @importFrom nnls nnls
#' @export
estimate_expression_profiles <- function(bulk_expr, cell_fracs) {
  if (!requireNamespace("nnls", quietly = TRUE)) {
    stop("Package 'nnls' is required for estimate_expression_profiles()")
  }
  genes <- rownames(bulk_expr)
  samples <- colnames(bulk_expr)
  cell_types <- colnames(cell_fracs)
  
  # Initialize a list of matrices, one per cell type
  expr_by_celltype <- lapply(cell_types, function(ct) {
    matrix(0, nrow = length(samples), ncol = length(genes),
           dimnames = list(samples, genes))
  })
  names(expr_by_celltype) <- cell_types
  
  # Iterate over each sample
  for (s in seq_along(samples)) {
    sample_name <- samples[s] # sample
    p <- cell_fracs[s, ]  # deconvolution in sample
    
    # Iterate over each gene
    for (g in seq_along(genes)) {
      gene_name <- genes[g] # gene
      y <- bulk_expr[g, s] # extract expression per gene and sample
      X <- diag(p) # create a diagonal matrix with the proportions (to give the shape)
      fit <- nnls::nnls(X, rep(y, length(p))) # compute non negative linear least squares (avoid negatives) to fit the model. Solve for X*beta = y
      est_expr <- stats::coef(fit) # extract the beta coefficient 
      
      # Store result per cell type
      for (c in seq_along(cell_types)) {
        expr_by_celltype[[c]][s, g] <- t(est_expr[c])
      }
    }
  }
  
  return(expr_by_celltype)  # one matrix per cell type
}