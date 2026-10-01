

utils::globalVariables(c("i", ".", "samples_ids", "multisession", ".data", "Patient", "var", "id", "P", "sig_p", "r", "y", "p", "average", "Cells", "variable", "value", "pval_value", "gene", "weight", "statistic", "condition", "score", "padj", "NES", "pathway", "size", "sig", "source"))

#' Canonical cell type nomenclature used by multideconv
#'
#' Returns the vector of cell type names recognized by multideconv's deconvolution
#' output column naming (e.g. "B.cells", "CD4.regulatory", "Plasma"). 
#'
#' @param cells_extra Optional character vector of additional cell type names to append
#'   (e.g. names from a custom signature not included by default).
#'
#' @returns A character vector of cell type names.
#' @examples
#' get_cell_type_nomenclature()
#' get_cell_type_nomenclature(cells_extra = "mesenchymal")
#' @export
get_cell_type_nomenclature <- function(cells_extra = NULL) {
  cell_types <- c("B.cells", "B.naive.cells", "B.memory.cells", "Macrophages.cells", "Macrophages.M0", "Macrophages.M1", "Macrophages.M2", "Monocytes", "Neutrophils", "NK.cells", "NK.activated", "NK.resting", "NKT.cells", "CD4.cells", "CD4.memory.activated",
                  "CD4.memory.resting", "CD4.naive", "CD8.cells", "CD4.regulatory", "CD4.non.regulatory", "T.cells.helper", "T.cells.gamma.delta", "Dendritic.cells", "Dendritic.activated.cells", "Dendritic.resting.cells", "Cancer", "Endothelial",
                  "Eosinophils", "Plasma", "Myocytes", "Fibroblasts", "Mast.cells", "Mast.activated.cells", "Mast.resting.cells", "CAF",
                  "Dendritic.plasmacytoid.cells", "Myeloid.cells", "Basophils", "Epithelial", "Pericytes", "Mural.cells", "T.cells.proliferative", "uncharacterized_cell")
  unique(c(cell_types, cells_extra))
}

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
#' @export
#' 
standardize_celltype_colnames <- function(mat) {
  if (is.null(rownames(mat))) rownames(mat) <- seq_len(nrow(mat))
  # Normalize spaces to dots so patterns using [._-] match space-separated names
  colnames(mat) <- gsub(" ", ".", colnames(mat))
  empty <- mat[, FALSE, drop = FALSE]
  # initialize blocks as a named list of empty matrices
  names_order <- c(setdiff(get_cell_type_nomenclature(), "uncharacterized_cell"), "extra")

  blocks <- setNames(rep(list(empty), length(names_order)), names_order)

  # Helper: grep columns
  cols <- function(pat, x = mat, ignore.case = TRUE, value = FALSE) {
    grep(pat, colnames(x), ignore.case = ignore.case, value = value)
  }

  # Helper: rename only the cell type suffix (after the last underscore).
  # This makes patterns universal regardless of separator used in original names.
  # pattern/replacement are applied case-insensitively via gsub(perl=TRUE).
  rn <- function(cn, pattern, replacement) {
    has_us <- grepl("_", cn)
    result  <- cn
    if (any(has_us)) {
      pre  <- sub("_[^_]*$", "_", cn[has_us])
      suf  <- sub("^.*_",   "",  cn[has_us])
      result[has_us] <- paste0(pre, gsub(pattern, replacement, suf,
                                         perl = TRUE, ignore.case = TRUE))
    }
    if (any(!has_us)) {
      result[!has_us] <- gsub(pattern, replacement, cn[!has_us],
                              perl = TRUE, ignore.case = TRUE)
    }
    result
  }

  ## Macrophages and subtypes
  blocks$Macrophages.cells <- mat[, cols("acrophage|^Macro$"), drop = FALSE]
  blocks$Macrophages.M0 <- mat[, cols("M0"), drop = FALSE]
  blocks$Macrophages.M1 <- mat[, cols("M1"), drop = FALSE]
  blocks$Macrophages.M2 <- mat[, cols("M2"), drop = FALSE]
  if (length(cols("LM22", blocks$Macrophages.M2)) > 0) blocks$Macrophages.M2 <- blocks$Macrophages.M2[, -cols("LM22", blocks$Macrophages.M2), drop = FALSE]
  test <- mat[, cols("LM22"), drop = FALSE]
  if (ncol(test)) test <- test[, cols("Macrophages.M2", test), drop = FALSE]
  if (ncol(test)) blocks$Macrophages.M2 <- cbind(blocks$Macrophages.M2, test)

  idx <- which(colnames(blocks$Macrophages.cells) %in% c(colnames(blocks$Macrophages.M0), colnames(blocks$Macrophages.M1), colnames(blocks$Macrophages.M2)))
  if (length(idx)) blocks$Macrophages.cells <- blocks$Macrophages.cells[, -idx, drop = FALSE]
  if (ncol(blocks$Macrophages.cells)) {
    mat <- mat[, !colnames(mat) %in% colnames(blocks$Macrophages.cells), drop = FALSE]
    colnames(blocks$Macrophages.cells) <- rn(colnames(blocks$Macrophages.cells),
      "^macrophages?([._-]cells?)?$|^macro$", "Macrophages.cells")
  }

  if (ncol(blocks$Macrophages.M0)) {
    mat <- mat[, !colnames(mat) %in% colnames(blocks$Macrophages.M0), drop = FALSE]
    colnames(blocks$Macrophages.M0) <- rn(colnames(blocks$Macrophages.M0),
      "^macrophages?[._-]?m0$|^m0$", "Macrophages.M0")
  }

  if (ncol(blocks$Macrophages.M1)) {
    mat <- mat[, !colnames(mat) %in% colnames(blocks$Macrophages.M1), drop = FALSE]
    colnames(blocks$Macrophages.M1) <- rn(colnames(blocks$Macrophages.M1),
      "^macrophages?[._-]?m1$|^m1$", "Macrophages.M1")
  }

  if (ncol(blocks$Macrophages.M2)) {
    mat <- mat[, !colnames(mat) %in% colnames(blocks$Macrophages.M2), drop = FALSE]
    colnames(blocks$Macrophages.M2) <- rn(colnames(blocks$Macrophages.M2),
      "^macrophages?[._-]?m2$|^m2$", "Macrophages.M2")
  }

  ## Monocytes
  blocks$Monocytes <- mat[, cols("Mono|mono|^Mon$"), drop = FALSE]
  if (ncol(blocks$Monocytes)) {
    mat <- mat[, !colnames(mat) %in% colnames(blocks$Monocytes), drop = FALSE]
    colnames(blocks$Monocytes) <- rn(colnames(blocks$Monocytes),
      "^mono(cytes?|cytic[._-]lineage)?([._-]cells?)?$|^mon$", "Monocytes")
  }

  ## Neutrophils
  blocks$Neutrophils <- mat[, cols("Neu"), drop = FALSE]
  if (ncol(blocks$Neutrophils)) {
    mat <- mat[, !colnames(mat) %in% colnames(blocks$Neutrophils), drop = FALSE]
    colnames(blocks$Neutrophils) <- rn(colnames(blocks$Neutrophils),
      "^neutrophils?([._-]cells?)?$|^neu$|^neutro$", "Neutrophils")
  }

  ## NK and subtypes
  blocks$NK.cells <- mat[, cols("NK"), drop = FALSE]
  blocks$NKT.cells <- if (ncol(blocks$NK.cells)) blocks$NK.cells[, cols("NKT", blocks$NK.cells), drop = FALSE] else empty
  blocks$NK.activated <- if (ncol(blocks$NK.cells)) blocks$NK.cells[, cols("activated", blocks$NK.cells, value = TRUE), drop = FALSE] else empty
  blocks$NK.resting <- if (ncol(blocks$NK.cells)) blocks$NK.cells[, cols("resting", blocks$NK.cells, value = TRUE), drop = FALSE] else empty
  idx <- which(colnames(blocks$NK.cells) %in% c(colnames(blocks$NK.activated), colnames(blocks$NK.resting), colnames(blocks$NKT.cells)))
  if (length(idx)) blocks$NK.cells <- blocks$NK.cells[, -idx, drop = FALSE]
  if (ncol(blocks$NK.cells)) {
    mat <- mat[, !colnames(mat) %in% colnames(blocks$NK.cells), drop = FALSE]
    colnames(blocks$NK.cells) <- rn(colnames(blocks$NK.cells),
      "^nk[._-]?cells?$|^nk$", "NK.cells")
  }
  if (ncol(blocks$NKT.cells)) {
    mat <- mat[, !colnames(mat) %in% colnames(blocks$NKT.cells), drop = FALSE]
    colnames(blocks$NKT.cells) <- rn(colnames(blocks$NKT.cells),
      "^nkt[._-]?cells?$|^nkt$", "NKT.cells")
  }
  if (ncol(blocks$NK.activated)) {
    mat <- mat[, !colnames(mat) %in% colnames(blocks$NK.activated), drop = FALSE]
    colnames(blocks$NK.activated) <- rn(colnames(blocks$NK.activated),
      "^nk[._-]?cells?[._-]activated$|^nk[._-]activated([._-]cells?)?$", "NK.activated")
  }
  if (ncol(blocks$NK.resting)) {
    mat <- mat[, !colnames(mat) %in% colnames(blocks$NK.resting), drop = FALSE]
    colnames(blocks$NK.resting) <- rn(colnames(blocks$NK.resting),
      "^nk[._-]?cells?[._-]resting$|^nk[._-]resting([._-]cells?)?$", "NK.resting")
  }

  ## CD4 and subtypes
  lower <- stringr::str_to_lower(colnames(mat))
  is_cd4 <- grepl("\\bcd4\\b|cd4t|(^|[_.])cd4($|[_.])|\\breg\\b|regulatory|treg", lower)
  is_tcell_variant <- grepl("(^|[^a-z0-9])(t|tcell|t\\.cells|t_cells|t cells)([^a-z0-9]|$)", lower, perl = TRUE)
  is_memory <- grepl("memory", lower)
  cd4_idx <- which(is_cd4 | (is_tcell_variant & is_memory))
  blocks$CD4.cells <- mat[, cd4_idx, drop = FALSE]

  blocks$CD4.memory.activated <- if (ncol(blocks$CD4.cells)) blocks$CD4.cells[, cols("activated", blocks$CD4.cells), drop = FALSE] else empty
  blocks$CD4.memory.resting <- if (ncol(blocks$CD4.cells)) blocks$CD4.cells[, cols("resting", blocks$CD4.cells), drop = FALSE] else empty
  blocks$CD4.naive <- if (ncol(blocks$CD4.cells)) blocks$CD4.cells[, cols("naive", blocks$CD4.cells), drop = FALSE] else empty
  if (ncol(blocks$CD4.cells)) {
    cn <- colnames(blocks$CD4.cells)
    canon <- stringr::str_to_lower(stringr::str_replace_all(cn, "[ _\\-]+", "."))
    non_reg_idx <- grep("(^|\\.)non[._-]?regulatory(\\.|$)", canon, perl = TRUE)
    reg_idx <- grep("(^|\\.)((tregs?)|tregulatory|t\\.cells\\.regulatory)(\\.|$)", canon, perl = TRUE)

    blocks$CD4.non.regulatory <- if(length(non_reg_idx) > 0) blocks$CD4.cells[, non_reg_idx, drop = FALSE] else empty
    blocks$CD4.regulatory <- if(length(reg_idx) > 0) blocks$CD4.cells[, reg_idx, drop = FALSE] else empty
  }

  idx <- which(colnames(blocks$CD4.cells) %in% c(colnames(blocks$CD4.memory.activated), colnames(blocks$CD4.memory.resting), colnames(blocks$CD4.naive), colnames(blocks$CD4.non.regulatory), colnames(blocks$CD4.regulatory)))
  if (length(idx)) blocks$CD4.cells <- blocks$CD4.cells[, -idx, drop = FALSE]
  if (ncol(blocks$CD4.cells)) {
    mat <- mat[, !colnames(mat) %in% colnames(blocks$CD4.cells), drop = FALSE]
    colnames(blocks$CD4.cells) <- rn(colnames(blocks$CD4.cells),
      "^(t[._-]?cells?[._-]?)?cd4([._-]?t[._-]?cells?|[._-]?cells?|[._-]?)?$|^cd4t$", "CD4.cells")
  }
  if (ncol(blocks$CD4.memory.activated)) {
    mat <- mat[, !colnames(mat) %in% colnames(blocks$CD4.memory.activated), drop = FALSE]
    colnames(blocks$CD4.memory.activated) <- rn(colnames(blocks$CD4.memory.activated),
      "^(t[._-]?cells?[._-]?)?cd4[._-]?memory[._-]?activated$", "CD4.memory.activated")
  }
  if (ncol(blocks$CD4.memory.resting)) {
    mat <- mat[, !colnames(mat) %in% colnames(blocks$CD4.memory.resting), drop = FALSE]
    colnames(blocks$CD4.memory.resting) <- rn(colnames(blocks$CD4.memory.resting),
      "^(t[._-]?cells?[._-]?)?cd4[._-]?memory[._-]?resting$", "CD4.memory.resting")
  }
  if (ncol(blocks$CD4.naive)) {
    mat <- mat[, !colnames(mat) %in% colnames(blocks$CD4.naive), drop = FALSE]
    colnames(blocks$CD4.naive) <- rn(colnames(blocks$CD4.naive),
      "^(t[._-]?cells?[._-]?)?cd4[._-]?naive$", "CD4.naive")
  }
  if (ncol(blocks$CD4.non.regulatory)) {
    mat <- mat[, !colnames(mat) %in% colnames(blocks$CD4.non.regulatory), drop = FALSE]
    # Use gsub on full colname (not rn) because cell type suffix may span multiple underscores
    # e.g. "Quantiseq_TIL10_T_cells_non_regulatory" where rn() would only see suffix "regulatory"
    colnames(blocks$CD4.non.regulatory) <- gsub(
      "(t[._-]?cells?[._-]?(cd4[._-]?)?)?non[._-]?regulatory.*$|cd4[._-]?non[._-]?regulatory.*$",
      "CD4.non.regulatory",
      colnames(blocks$CD4.non.regulatory),
      perl = TRUE, ignore.case = TRUE)
  }
  if (ncol(blocks$CD4.regulatory)) {
    mat <- mat[, !colnames(mat) %in% colnames(blocks$CD4.regulatory), drop = FALSE]
    colnames(blocks$CD4.regulatory) <- rn(colnames(blocks$CD4.regulatory),
      "^(t[._-]?cells?[._-]?)?regulatory.*$|^tregs?[._-]?.*$|^t[._-]cells[._-]regulatory.*$|^tregulatory.*$", "CD4.regulatory")
  }

  ## CD8
  blocks$CD8.cells <- mat[, cols("CD8"), drop = FALSE]
  if (ncol(blocks$CD8.cells)) {
    mat <- mat[, !colnames(mat) %in% colnames(blocks$CD8.cells), drop = FALSE]
    colnames(blocks$CD8.cells) <- rn(colnames(blocks$CD8.cells),
      "^(t[._-]?cells?[._-]?)?cd8([._-]?t[._-]?cells?|[._-]?cells?|[._-]?)?$|^cd8t$", "CD8.cells")
  }

  ## Thelper
  blocks$T.cells.helper <- mat[, cols("helper"), drop = FALSE]
  if (ncol(blocks$T.cells.helper)) {
    mat <- mat[, !colnames(mat) %in% colnames(blocks$T.cells.helper), drop = FALSE]
    colnames(blocks$T.cells.helper) <- rn(colnames(blocks$T.cells.helper),
      "^t[._-]?cells?[._-]?(follicular[._-])?helper$", "T.cells.helper")
  }

  ## Tgamma
  blocks$T.cells.gamma.delta <- mat[, cols("gamma"), drop = FALSE]
  if (ncol(blocks$T.cells.gamma.delta)) {
    mat <- mat[, !colnames(mat) %in% colnames(blocks$T.cells.gamma.delta), drop = FALSE]
    colnames(blocks$T.cells.gamma.delta) <- rn(colnames(blocks$T.cells.gamma.delta),
      "^t[._-]?cells?[._-]?gamma[._-]?delta$", "T.cells.gamma.delta")
  }

  ## Dendritic and subtypes
  blocks$Dendritic.cells <- mat[, cols("endritic"), drop = FALSE]
  blocks$Dendritic.activated.cells <- if (ncol(blocks$Dendritic.cells)) blocks$Dendritic.cells[, cols("activated", blocks$Dendritic.cells), drop = FALSE] else empty
  blocks$Dendritic.resting.cells <- if (ncol(blocks$Dendritic.cells)) blocks$Dendritic.cells[, cols("resting", blocks$Dendritic.cells), drop = FALSE] else empty
  blocks$Dendritic.plasmacytoid.cells <- if (ncol(blocks$Dendritic.cells)) blocks$Dendritic.cells[, cols("plasmacytoid", blocks$Dendritic.cells), drop = FALSE] else empty
  idx <- which(colnames(blocks$Dendritic.cells) %in% c(colnames(blocks$Dendritic.activated.cells), colnames(blocks$Dendritic.resting.cells), colnames(blocks$Dendritic.plasmacytoid.cells)))
  if (length(idx)) blocks$Dendritic.cells <- blocks$Dendritic.cells[, -idx, drop = FALSE]
  if (ncol(blocks$Dendritic.cells)) {
    mat <- mat[, !colnames(mat) %in% colnames(blocks$Dendritic.cells), drop = FALSE]
    colnames(blocks$Dendritic.cells) <- rn(colnames(blocks$Dendritic.cells),
      "^(myeloid[._-])?dendritic[._-]?cells?$|^dendritic$", "Dendritic.cells")
  }
  if (ncol(blocks$Dendritic.activated.cells)) {
    mat <- mat[, !colnames(mat) %in% colnames(blocks$Dendritic.activated.cells), drop = FALSE]
    colnames(blocks$Dendritic.activated.cells) <- rn(colnames(blocks$Dendritic.activated.cells),
      "^(myeloid[._-])?dendritic[._-]?cells?[._-]activated$|^dendritic[._-]activated[._-]?cells?$", "Dendritic.activated.cells")
  }
  if (ncol(blocks$Dendritic.resting.cells)) {
    mat <- mat[, !colnames(mat) %in% colnames(blocks$Dendritic.resting.cells), drop = FALSE]
    colnames(blocks$Dendritic.resting.cells) <- rn(colnames(blocks$Dendritic.resting.cells),
      "^(myeloid[._-])?dendritic[._-]?cells?[._-]resting$|^dendritic[._-]resting[._-]?cells?$", "Dendritic.resting.cells")
  }
  if (ncol(blocks$Dendritic.plasmacytoid.cells)) {
    mat <- mat[, !colnames(mat) %in% colnames(blocks$Dendritic.plasmacytoid.cells), drop = FALSE]
    colnames(blocks$Dendritic.plasmacytoid.cells) <- rn(colnames(blocks$Dendritic.plasmacytoid.cells),
      "^plasmacytoid[._-]dendritic([._-]cells?)?$|^dendritic[._-]cells?[._-]plasmacytoid$", "Dendritic.plasmacytoid.cells")
  }

  ## CAF
  blocks$CAF <- mat[, cols("CAF|Cancer_associated_fibroblast"), drop = FALSE]
  if (ncol(blocks$CAF)) {
    mat <- mat[, !colnames(mat) %in% colnames(blocks$CAF), drop = FALSE]
    colnames(blocks$CAF) <- rn(colnames(blocks$CAF),
      "^cancer[._-]associated[._-]fibroblasts?$|^cafs?$", "CAF")
  }

  ## Cancer / malignant
  blocks$Cancer <- mat[, cols("ancer"), drop = FALSE]
  if (ncol(blocks$Cancer)) {
    mat <- mat[, !colnames(mat) %in% colnames(blocks$Cancer), drop = FALSE]
    colnames(blocks$Cancer) <- rn(colnames(blocks$Cancer),
      "^cancer([._-]cells?)?$", "Cancer")
  }
  blocks$malignant <- mat[, cols("alignant"), drop = FALSE]
  if (ncol(blocks$malignant)) {
    mat <- mat[, !colnames(mat) %in% colnames(blocks$malignant), drop = FALSE]
    colnames(blocks$malignant) <- rn(colnames(blocks$malignant),
      "^malignant([._-]cells?)?$", "Cancer")
    if (ncol(blocks$Cancer)) blocks$Cancer <- cbind(blocks$Cancer, blocks$malignant) else blocks$Cancer <- blocks$malignant
  }

  ## Endothelial
  blocks$Endothelial <- mat[, cols("dothelial"), drop = FALSE]
  if (ncol(blocks$Endothelial)) {
    mat <- mat[, !colnames(mat) %in% colnames(blocks$Endothelial), drop = FALSE]
    colnames(blocks$Endothelial) <- rn(colnames(blocks$Endothelial),
      "^endothelial([._-]cells?)?$", "Endothelial")
  }

  ## Eosinophils
  blocks$Eosinophils <- mat[, cols("osino|^Eos$"), drop = FALSE]
  if (ncol(blocks$Eosinophils)) {
    mat <- mat[, !colnames(mat) %in% colnames(blocks$Eosinophils), drop = FALSE]
    colnames(blocks$Eosinophils) <- rn(colnames(blocks$Eosinophils),
      "^eosinophils?$|^eosino$|^eos$", "Eosinophils")
  }

  ## Plasma
  blocks$Plasma <- mat[, cols("lasma"), drop = FALSE]
  if (ncol(blocks$Plasma)) {
    mat <- mat[, !colnames(mat) %in% colnames(blocks$Plasma), drop = FALSE]
    colnames(blocks$Plasma) <- rn(colnames(blocks$Plasma),
      "^plasma([._-]cells?)?$", "Plasma")
  }

  ## Myocytes / Fibroblasts
  blocks$Myocytes <- mat[, cols("yocyte"), drop = FALSE]
  if (ncol(blocks$Myocytes)) {
    mat <- mat[, !colnames(mat) %in% colnames(blocks$Myocytes), drop = FALSE]
    colnames(blocks$Myocytes) <- rn(colnames(blocks$Myocytes), "^myocytes?$", "Myocytes")
  }
  blocks$Fibroblasts <- mat[, cols("ibroblast"), drop = FALSE]
  if (ncol(blocks$Fibroblasts)) {
    mat <- mat[, !colnames(mat) %in% colnames(blocks$Fibroblasts), drop = FALSE]
    colnames(blocks$Fibroblasts) <- rn(colnames(blocks$Fibroblasts), "^fibroblasts?$", "Fibroblasts")
  }

  ## Mast and subtypes
  blocks$Mast.cells <- mat[, cols("Mast"), drop = FALSE]
  blocks$Mast.activated.cells <- if (ncol(blocks$Mast.cells)) blocks$Mast.cells[, cols("activated", blocks$Mast.cells), drop = FALSE] else empty
  blocks$Mast.resting.cells <- if (ncol(blocks$Mast.cells)) blocks$Mast.cells[, cols("resting", blocks$Mast.cells), drop = FALSE] else empty
  idx <- which(colnames(blocks$Mast.cells) %in% c(colnames(blocks$Mast.activated.cells), colnames(blocks$Mast.resting.cells)))
  if (length(idx)) blocks$Mast.cells <- blocks$Mast.cells[, -idx, drop = FALSE]
  if (ncol(blocks$Mast.cells)) {
    mat <- mat[, !colnames(mat) %in% colnames(blocks$Mast.cells), drop = FALSE]
    colnames(blocks$Mast.cells) <- rn(colnames(blocks$Mast.cells),
      "^mast[._-]?cells?$|^mast$", "Mast.cells")
  }
  if (ncol(blocks$Mast.activated.cells)) {
    mat <- mat[, !colnames(mat) %in% colnames(blocks$Mast.activated.cells), drop = FALSE]
    colnames(blocks$Mast.activated.cells) <- rn(colnames(blocks$Mast.activated.cells),
      "^mast[._-]?cells?[._-]activated$|^mast[._-]activated([._-]cells?)?$", "Mast.activated.cells")
  }
  if (ncol(blocks$Mast.resting.cells)) {
    mat <- mat[, !colnames(mat) %in% colnames(blocks$Mast.resting.cells), drop = FALSE]
    colnames(blocks$Mast.resting.cells) <- rn(colnames(blocks$Mast.resting.cells),
      "^mast[._-]?cells?[._-]resting$|^mast[._-]resting([._-]cells?)?$", "Mast.resting.cells")
  }

  ## Other cell types: one block each (search pattern, rename pattern, standard name)
  other <- list(
    list("yeloid",     "^myeloid([._-]cells?)?$",                                   "Myeloid.cells"),
    list("asophil",    "^basophils?$",                                              "Basophils"),
    list("pithelial",  "^epithelial([._-]cells?)?$",                                "Epithelial"),
    list("ericyte",    "^pericytes?$",                                              "Pericytes"),
    list("mural",      "^mural([._-]cells?)?$",                                     "Mural.cells"),
    list("proliferat", "^t[._-]?cells?[._-]?proliferat(ive|ing)$",                  "T.cells.proliferative")
  )
  for (o in other) {
    blocks[[o[[3]]]] <- mat[, cols(o[[1]]), drop = FALSE]
    if (ncol(blocks[[o[[3]]]])) {
      mat <- mat[, !colnames(mat) %in% colnames(blocks[[o[[3]]]]), drop = FALSE]
      colnames(blocks[[o[[3]]]]) <- rn(colnames(blocks[[o[[3]]]]), o[[2]], o[[3]])
    }
  }

  ## B cells (naive / memory) and final B
  blocks$B.naive.cells <- mat[, cols("naive"), drop = FALSE]
  if (ncol(blocks$B.naive.cells)) {
    mat <- mat[, !colnames(mat) %in% colnames(blocks$B.naive.cells), drop = FALSE]
    colnames(blocks$B.naive.cells) <- rn(colnames(blocks$B.naive.cells),
      "^b[._-]?cells?[._-]naive$|^b[._-]naive([._-]cells?)?$", "B.naive.cells")
  }

  blocks$B.memory.cells <- mat[, cols("memory"), drop = FALSE]
  if (ncol(blocks$B.memory.cells)) {
    mat <- mat[, !colnames(mat) %in% colnames(blocks$B.memory.cells), drop = FALSE]
    colnames(blocks$B.memory.cells) <- rn(colnames(blocks$B.memory.cells),
      "^b[._-]?cells?[._-]memory$|^b[._-]memory([._-]cells?)?$", "B.memory.cells")
  }

  idx <- which(colnames(mat) %in% c(colnames(blocks$B.naive.cells), colnames(blocks$B.memory.cells)))
  if (length(idx)) mat <- mat[, -idx, drop = FALSE]

  if (ncol(mat)) {
    colnames(mat) <- rn(colnames(mat),
      "^b[._-]?cells?$|^b[._-]?cell$|^bcell$|^b[._-]lineage$|^b$", "B.cells")
    blocks$B.cells <- mat[, cols("B.cells"), drop = FALSE]
    if (ncol(blocks$B.cells)) mat <- mat[, !colnames(mat) %in% colnames(blocks$B.cells), drop = FALSE]
  }

  ## remaining are extra
  blocks$extra <- mat

  # assemble in fixed order (blocks created on the fly, like malignant, are already merged)
  existing <- intersect(names_order, names(blocks))
  cell_types <- do.call(cbind, unname(blocks[existing]))

  return(cell_types)
}

#' Compute deconvolution preprocessing
#'
#' Give consistent names and patterns following the method_signature_cell structure to the deconvolution features
#'
#' @param deconv A dataframe with the unprocessed deconvolution features
#' @param cells_extra A character vector of non-standard cell type names to retain.
#'
#' @return A matrix of the preprocessed deconvolution features with fixed and consistent names across the different methods and signatures following the nomenclature specified in multideconv (see Readme)
#' @examples
#'
#' data("deconvolution")
#'
#' deconvolution = multideconv:::compute.deconvolution.preprocessing(deconvolution)
#'
#' @keywords internal
compute.deconvolution.preprocessing = function(deconv, cells_extra = NULL){
  cat("Preprocessing deconvolution features...............................................................\n\n")

  #Remove NA (this need to be check -- not possible to have NAs values in deconv)
  deconv <- deconv %>%
    data.frame() %>%
    dplyr::mutate(dplyr::across(dplyr::everything(), ~ tidyr::replace_na(.x, 0)))

  ##### Edit cell names for consistency across features

  deconv_standarized = standardize_celltype_colnames(deconv)

  cat("Checking consistency in deconvolution cell fractions across patients...............................................................\n\n")

  cell_types = get_cell_type_nomenclature()

  if(is.null(cells_extra)){
    cat("No extra cell types provided. Only the following cell types will be considered:\n", paste0(cell_types, collapse = "\n"), "\n\n")
    cat("If you want to consider other cell types (e.g. from a custom signature) which are not included in the package by default (see README), please provide them in the cells_extra argument.\n")
  }

  cell_types = c(cell_types, cells_extra)

  pattern <- paste0("(_", gsub("\\.", "\\\\.", cell_types), ")$", collapse = "|")
  combinations <- unique(gsub(pattern, "", colnames(deconv_standarized)))

  error = F
  for(i in combinations){
    idx <- which(startsWith(colnames(deconv_standarized), paste0(i, "_")))
    if(length(idx)>0){
      mat = deconv_standarized[,idx, drop = FALSE] #A matrix of samples as rows and features only with combination[i] as columns
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

  return(deconv_standarized)
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
#' @keywords internal
compute.cell.types = function(data, cells_extra = NULL){
  # One element per cell type of the package vocabulary (same names and order as before)
  cell_names = setdiff(get_cell_type_nomenclature(), "uncharacterized_cell")
  cell_types = lapply(cell_names, function(cell) data[, grep(cell, colnames(data)), drop = FALSE])
  names(cell_types) = cell_names
  cell_types_matrix = do.call(cbind, unname(cell_types))

  ####Add extra cells (if exist), skipping those already in the vocabulary
  cells_extra = setdiff(cells_extra, cell_names)
  if(length(cells_extra) > 0){
    extra = list()
    for (i in 1:length(cells_extra)){
      pat = paste0("_", gsub("\\.", "\\\\.", cells_extra[i]), "$")
      extra[[i]] = grep(pat, colnames(data))
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

#' Compute deconvolution subgroups
#'
#' Groups the features of one cell type by complete-linkage hierarchical clustering on their correlations:
#' features end up in the same subgroup only if every pair of them correlates at least `thres_corr`
#' (non-significant correlations, p >= 0.05, count as 0). Each subgroup is replaced by the row median of
#' its members. The result does not depend on the column order.
#'
#' @param deconvolution A matrix with the deconvolution features of one cell type (samples as rows)
#' @param thres_corr A numeric value with the minimum correlation allowed to group cell deconvolution features
#' @param corr_type Correlation type whether "spearman" or "pearson".
#' @param file_name Cell type name, used as prefix of the subgroup names (`<file_name>_Subgroup.<i>`)
#' @param batch Optional batch labels, one per sample in the same order as the rows. A factor or character
#'   is treated as categorical: correlations become partial correlations controlling for one indicator column
#'   per batch. A numeric vector is used as a single linear covariate.
#'
#' @return A list containing
#'
#' - A data frame with the final features: the subgroup medians plus the features that were not grouped
#' - The subgroups composition: a named list with the members of every subgroup
#'
#' @keywords internal
compute_subgroups = function(deconvolution, thres_corr, corr_type, file_name, batch = NULL){
  data = data.frame(deconvolution, check.names = FALSE)

  cell_subgroups = list()
  if (ncol(data) < 2) {
    return(list(data, cell_subgroups))
  }else{

    #################### Complete-linkage grouping
    # Correlation matrix of all features (non-significant or missing correlations count as 0)
    corr_df <- corr_subgroups(data, corr_type = corr_type, batch = batch)
    corr_mat = matrix(0, ncol(data), ncol(data), dimnames = list(colnames(data), colnames(data)))
    corr_mat[cbind(corr_df$measure1, corr_df$measure2)] = corr_df$r
    corr_mat[cbind(corr_df$measure2, corr_df$measure1)] = corr_df$r
    diag(corr_mat) = 1
    corr_mat = corr_mat[order(colnames(corr_mat)), order(colnames(corr_mat))] #Fixed order: ties are broken the same way whatever the column order
    # Two groups join only if every pair of features across them correlates >= thres_corr
    clusters = stats::cutree(stats::hclust(stats::as.dist(1 - corr_mat), method = "complete"), h = 1 - thres_corr)
    subgroup = unname(split(names(clusters), clusters))
    subgroup = subgroup[lengths(subgroup) > 1] #Features without partners are kept as they are
    data_sub = c()

    if(length(subgroup)!=0){
      for (i in 1:length(subgroup)){ #Name subgroups
        names(subgroup)[i] = paste0(file_name, "_Subgroup.", i)
      }
      #Take median expression of subgroups
      for(i in 1:length(subgroup)){ #Create data frame with features subgroupped
        sub = data.frame(data[,colnames(data)%in%subgroup[[i]]], check.names = FALSE) #Map features that are inside each subgroup from input (deconvolution)
        sub$median = matrixStats::rowMedians(as.matrix(sub), useNames = FALSE) #Compute median of subgroup across patients
        data_sub = data.frame(cbind(data_sub, sub$median), check.names = FALSE) #Save median in a new data frame
        colnames(data_sub)[i] = names(subgroup)[i]
        name = colnames(data)[which(!(colnames(data)%in%subgroup[[i]]))]
        data = data.frame(data[,-which(colnames(data)%in%subgroup[[i]]), drop = FALSE], check.names = FALSE) #Remove from deconvolution features that are subgrouped
        if(ncol(data.frame(data))==1){
          data = as.data.frame(data)
          colnames(data)[1] = name
        }
      }

      rownames(data_sub) = rownames(data) #List of patients
      cell_subgroups = subgroup

      if(ncol(data)!=0){
        data = cbind(data, data_sub)
      }else{
        data = data_sub #data will be 0 if all deconvolution features have been subgroupped
      }
    }

    data = data[, !duplicated(t(data)), drop = FALSE] # Drop features with identical values

    return(list(data, cell_subgroups))
  }

}

#' Perform pairwise correlation across all features
#'
#' @param data Matrix with features to correlate
#' @param corr_type Correlation type whether "spearman" or "pearson".
#' @param batch Optional batch labels, one per sample in the same order as the rows. A factor or character
#'   is treated as categorical: correlations become partial correlations controlling for one indicator column
#'   per batch. A numeric vector is used as a single linear covariate.
#'
#' @return Dataframe containing all significant correlations (pvalue < 0.05)
#'
#' @keywords internal
corr_subgroups <- function(data, corr_type = "spearman", batch = NULL) {
  if (!is.null(batch)) {
    # Categorical batch: one indicator column per batch (first batch = reference), so each batch's own shift is removed
    if(is.factor(batch) || is.character(batch)){
      batch <- stats::model.matrix(~ factor(batch))[, -1, drop = FALSE]
    }

    # Compute all pairwise partial correlations controlling for batch
    vec <- colnames(data)
    corr_df <- data.frame(measure1 = character(0), measure2 = character(0),
                          r = numeric(0), p = numeric(0))
    for(i in 1:(length(vec)-1)){
      for(j in (i+1):length(vec)){
        pc <- ppcor::pcor.test(data[, vec[i]], data[, vec[j]], batch, method = corr_type)
        corr_df <- rbind(corr_df, data.frame(measure1 = vec[i],
                                             measure2 = vec[j],
                                             r = pc$estimate,
                                             p = pc$p.value))
      }
    }
    corr_df <- corr_df[which(!is.na(corr_df$r) & corr_df$p < 0.05), ] # Keep significant, non-NA correlations (as without batch)
  } else {
    # Original correlation using Hmisc::rcorr
    M <- Hmisc::rcorr(data.matrix(data), type = corr_type)
    Mdf <- purrr::map(M[c("r", "P", "n")], ~data.frame(.x, check.names = FALSE))
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
#' Removes features that barely vary across samples: features whose coefficient of variation
#' (CV = standard deviation / mean) is below `cv_thr`. Each feature is judged on its own, so features
#' of rare cell types (small values) are kept as long as they vary relative to their size.
#'
#' @param data Deconvolution features
#' @param cv_thr Minimum coefficient of variation; features below it are discarded.
#'
#' @return A list containing
#'
#' - Deconvolution matrix after removal of low variance.
#' - Discarded low variance features.
#'
#' @keywords internal
remove_low_variance <- function(data, cv_thr = 0.1) {
  cv <- apply(data, 2, stats::sd) / abs(colMeans(data))
  low_variance <- which(cv < cv_thr | is.nan(cv)) # NaN: constant all-zero feature

  data_filt = if (length(low_variance) == 0) data else data[, -low_variance, drop = FALSE]
  low_var_features = data[, low_variance, drop = FALSE]

  res = list(data_filt, low_var_features)
  return(res)
}

#' Compute cell type processing
#'
#' @param deconvolution Deconvolution output of compute.deconvolution() with features as columns and samples as rows
#' @param corr Minimum correlation threshold for subgroupping the deconvolution features
#' @param corr_type Correlation type for computing the cell subgroups, whether "spearman" or "pearson".
#' @param zero_thr Maximum fraction of zeros allowed per feature before it is discarded.
#' @param cv_thr Minimum coefficient of variation (standard deviation / mean) across samples; features below it are removed.
#' @param batch Optional batch labels, one per sample in the same order as the rows. A factor or character
#'   is treated as categorical: correlations become partial correlations controlling for one indicator column
#'   per batch. A numeric vector is used as a single linear covariate. With only one batch, ordinary
#'   correlations are used.
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
#' - The discarded features because they contain a high number of zeros across samples (> 90%)
#' - Discarded features due to low variance across samples
#' - Discarded cell types because they are not supported in the pipeline
#'
#' @export
#'
#' @examples
#'
#' data("deconvolution")
#'
#' processed_deconvolution = compute.deconvolution.analysis(deconvolution, corr = 0.7)
#'
#' processed_deconvolution = compute.deconvolution.analysis(deconvolution, cells_extra = "mesenchymal")
#'
compute.deconvolution.analysis <- function(deconvolution, corr = 0.7, corr_type = "spearman", zero_thr = 0.9, cv_thr = 0.1, batch = NULL, cells_extra = NULL, file_name = NULL, return = FALSE, verbose = FALSE){
  deconvolution.mat = deconvolution

  if(!is.null(batch) && length(unique(batch)) < 2){
    batch = NULL
  }

  # #####Unsupervised filtering
  #
  #Remove high zero number features
  if(verbose){
    cat(paste0("Removing features with high zero number 90%...............................................................\n\n"))
  }

  deconvolution.mat = deconvolution.mat[, colSums(deconvolution.mat == 0, na.rm=TRUE) < round(zero_thr*nrow(deconvolution.mat)) , drop=FALSE]
  diff_colnames <- setdiff(colnames(deconvolution), colnames(deconvolution.mat))
  zero_features <- deconvolution[, diff_colnames, drop = FALSE]

  #Remove low_variance features
  if(verbose){
    cat(paste0("Removing low variance features...............................................................\n\n"))
  }

  variance = remove_low_variance(deconvolution.mat, cv_thr = cv_thr)
  deconvolution.mat = variance[[1]]
  low_variance_features = variance[[2]]

  #####Cell types split
  if(verbose){
    cat("Splitting deconvolution features per cell type...............................................................\n\n")
  }

  cells_types = compute.cell.types(deconvolution.mat, cells_extra)
  cells = cells_types[[1]]
  cells_discarded = cells_types[[2]]

  #####Subgrouping of deconvolution features
  res = list()
  groups = list()
  for (i in 1:length(cells)) {
    x = compute_subgroups(cells[[i]], file_name = names(cells)[i], thres_corr = corr, corr_type = corr_type, batch = batch)
    res = c(res, x[1])
    groups = c(groups, x[2])
  }

  names_cells = names(cells)

  names(res) = names_cells
  names(groups) = names_cells

  #####Preparing output
  dt = c()
  for (i in 1:length(res)) {
    dt = c(dt, as.data.frame(res[[i]]))
  }
  dt = data.frame(dt, check.names = FALSE)
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

  #Save data to export
  if(return == TRUE){
    ensure_results_dir()
    data.output = data.groups
    utils::write.csv(dt, paste0('Results/Deconvolution_after_subgrouping_', file_name,'.csv'))
    utils::write.csv(data.output, paste0('Results/Cell_subgroups_', file_name,'.csv'), row.names = F)
  }

  if(verbose){
    message("Deconvolution features subgroupped")
  }

  results = list(dt, res, groups, zero_features, low_variance_features, cells_discarded)
  names(results) = c("Deconvolution matrix", "Deconvolution subgroups per cell types", "Deconvolution subgroups composition",
                     "Discarded features with high number of zeros", "Discarded features with low variance", "Discarded cell types")
  return(results)

}


#' Computes QuanTIseq
#'
#' @param TPM_matrix A matrix with TPM normalized counts (genes symbols as rows and samples as columns).
#' @param name_signature Name used to tag output columns with the signature source.
#'
#' @return A matrix with cell abundance deconvolve with QuanTIseq
#'
#' @keywords internal
computeQuantiseq <- function(TPM_matrix, name_signature = "TIL10") {
  TPM_matrix = TPM_matrix[rownames(TPM_matrix)%in%rownames(immunedeconv::dataset_racle$expr_mat),] #To avoid problems regarding gene names (quantiseq error)
  
  quantiseq = immunedeconv::deconvolute(TPM_matrix, "quantiseq", tumor = T) %>%
    tibble::column_to_rownames("cell_type") %>%
    t() %>%
    data.frame() %>%
    dplyr::mutate(Tregs = .data[["T.cell.regulatory..Tregs."]], 
                  T_cells_non_regulatory = .data[["T.cell.CD4...non.regulatory."]]) %>%
    dplyr::select(-"T.cell.regulatory..Tregs.", -"T.cell.CD4...non.regulatory.") 

  colnames(quantiseq) = paste0("Quantiseq_", name_signature, "_", colnames(quantiseq))
  colnames(quantiseq) <- colnames(quantiseq) %>%
    stringr::str_replace_all(., " ", "_")

  return(quantiseq)
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
#' @keywords internal
computeCBSX_parallel = function(TPM_matrix, signatures, name, password, workers){
  cl = parallel::makeCluster(workers)
  doParallel::registerDoParallel(cl)

  cbsx = foreach::foreach (i=1:length(signatures), .combine=cbind, .packages = c("multideconv", "dplyr"), .export = "computeCBSX") %dopar% { # internal function: exported to the workers explicitly
    signature <- utils::read.delim(signatures[[i]], row.names=1)
    signature_name = tools::file_path_sans_ext(basename(signatures[[i]]))
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
#' @keywords internal
computeCBSX = function(TPM_matrix, signature_file, name, password, name_signature){
  omnideconv::set_cibersortx_credentials(name, password)
  cbsx = tryCatch(
    omnideconv::deconvolute_cibersortx(TPM_matrix, signature_file),
    error = function(e){
      # On some machines the CIBERSORTx container fails (error code 139) when using R's temporary
      # directory and the "..._Results.txt" output is never written. Retry once with fixed folders
      # in the home directory; any other error is re-raised unchanged.
      if (!grepl("does not exist", conditionMessage(e), fixed = TRUE)) stop(e)
      input_dir = path.expand("~/user_projects/cibersort/input")
      output_dir = path.expand("~/user_projects/cibersort/output")
      dir.create(input_dir, recursive = TRUE, showWarnings = FALSE)
      dir.create(output_dir, recursive = TRUE, showWarnings = FALSE)
      message("\nCIBERSORTx failed using the temporary directory. Retrying with input_dir = ", input_dir, " and output_dir = ", output_dir, "\n")
      omnideconv::deconvolute_cibersortx(TPM_matrix, signature_file, input_dir = input_dir, output_dir = output_dir)
    }
  )

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
#' @keywords internal
computeDWLS_parallel = function(TPM_matrix, signatures, workers){
  cl = parallel::makeCluster(workers)
  doParallel::registerDoParallel(cl)

  dwls = foreach::foreach (i=1:length(signatures), .combine=cbind, .packages = c("multideconv", "dplyr"), .export = "computeDWLS") %dopar% { # internal function: exported to the workers explicitly
    signature <- utils::read.delim(signatures[[i]], row.names=1)
    signature_name = tools::file_path_sans_ext(basename(signatures[[i]]))
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
#' @keywords internal
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
#' @keywords internal
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
#' @keywords internal
computeMOMF_parallel = function(TPM_matrix, sc_object, signatures, workers){
  cl = parallel::makeCluster(workers)
  doParallel::registerDoParallel(cl)

  momf = foreach::foreach (i=1:length(signatures), .combine=cbind, .packages = c("multideconv", "dplyr"), .export = "computeMOMF") %dopar% { # internal function: exported to the workers explicitly
    signature <- utils::read.delim(signatures[[i]], row.names=1)
    signature_name = tools::file_path_sans_ext(basename(signatures[[i]]))
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
#' @keywords internal
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
#' @keywords internal
computeDeconRNASeq = function(TPM_matrix, signature_file, name_signature){
  .pkg <- "DeconRNASeq"
  if (!requireNamespace(.pkg, quietly = TRUE)) {
    stop("Package 'DeconRNASeq' is required for computeDeconRNASeq(). ",
         "Install it with: BiocManager::install('DeconRNASeq')",
         call. = FALSE)
  }

  if (!requireNamespace("pcaMethods", quietly = TRUE)) {
    stop("Package 'pcaMethods' is required for computeDeconRNASeq()")
  }

  # DeconRNASeq lists pcaMethods under Depends (not Imports), so its own internal code
  # calls prep() unqualified, expecting library(DeconRNASeq) to have auto-attached
  # pcaMethods to the search path. Loading DeconRNASeq via requireNamespace()/
  # asNamespace() below (deliberately, to avoid attaching DeconRNASeq itself) skips that
  # auto-attach, so prep() must be attached explicitly here or DeconRNASeq::DeconRNASeq()
  # fails with "could not find function \"prep\"" partway through.
  if (!"package:pcaMethods" %in% search()) {
    attachNamespace("pcaMethods")
  }

  ns   <- asNamespace(.pkg)
  decon <- tryCatch(
    ns$DeconRNASeq(TPM_matrix, data.frame(signature_file)),
    error = function(e) {
      if (grepl('could not find function "prep"', conditionMessage(e), fixed = TRUE)) {
        message("\nDeconRNASeq failed with \"could not find function \\\"prep\\\"\". ",
                "This happens when pcaMethods hasn't been attached to the search path in your R session. ",
                "Fix: add library(DeconRNASeq) at the top of your script (before calling compute.deconvolution()) and re-run.\n")
      }
      stop(e)
    }
  )
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
#' @param signatures_select (Optional) A character vector with the signature names to run. If NULL (default), all available signatures are used (package + custom).
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
#' @keywords internal
compute_methods_variable_signature = function(TPM_matrix, signatures, algos = c("CBSX", "Epidish", "DeconRNASeq", "DWLS", "MOMF"), signatures_select = NULL, cbsx.name, cbsx.token, doParallel = FALSE, workers = NULL, sc_obj = NULL){

  created_results_dir <- !dir.exists("Results")
  cache_dir <- ensure_results_dir()
  # Fingerprint of the input data, so cached results are only reused for the same TPM matrix
  fp_file <- tempfile(); saveRDS(TPM_matrix, fp_file, compress = FALSE)
  data_id <- substr(unname(tools::md5sum(fp_file)), 1, 8); unlink(fp_file)
  cache_file <- function(method, sig_name) file.path(cache_dir, paste0("deconv_", method, "_", sig_name, "_", data_id, ".rds"))
  load_cache <- function(method, sig_name) {
    f <- cache_file(method, sig_name)
    if (file.exists(f)) {
      message("\nFound cached result for ", method, " (", sig_name, ") - skipping run.\n")
      return(readRDS(f))
    }
    NULL
  }
  save_cache <- function(method, sig_name, result) saveRDS(result, cache_file(method, sig_name))

  signature_dir = "Results/custom_signatures"
  default_sig = list.files(signatures, full.names = T, pattern = "\\.txt$")
  user_files = list.files(signature_dir, full.names = TRUE, pattern = "\\.txt$")

  db <- c(default_sig, user_files)

  if(is.null(algos)==F){

    if (length(db) == 0) {
      stop("No signature files (.txt) found in '", signatures, "' or '", signature_dir, "'.")
    }

    # Filter signatures: if signatures_select is provided, keep only those
    if (!is.null(signatures_select)) {
      db <- db[tools::file_path_sans_ext(basename(db)) %in% signatures_select]
      if (length(db) == 0) {
        warning("None of the requested signatures were found: ",
                paste(signatures_select, collapse = ", "))
        return(NULL)
      }
    }

    cat("\nThe following method-signature combinations are going to be calculated...............................................................\n")

    cat("\nMethods\n")
    for (deconv_method in algos) {
      cat("* ", deconv_method, "\n", sep = "")
    }
    cat("\nSignatures\n")
    for (i in 1:length(db)) {
      name = tools::file_path_sans_ext(basename(db[[i]]))
      cat("* ", name, "\n", sep = "")
    }

    deconvolution = list()

    if("CBSX" %in% algos){
      if(is.null(cbsx.name)==T || is.null(cbsx.token)==T){
        warning("CBSX was selected but no CIBERSORTx credentials were provided (credentials.mail/credentials.token). Skipping CBSX.", call. = FALSE)
        algos = setdiff(algos, "CBSX")
        if(length(algos) == 0){
          return(NULL)
        }
      }
    }

    if(doParallel == T && is.null(workers)){
      workers = max(1, parallel::detectCores() - 1)
    }

    # Per-signature results; reset for every signature and never looked up outside this function
    deconrnaseq = epidish_res = cbsx = dwls = momf = NULL

    for (i in 1:length(db)) {

      signature <- utils::read.delim(db[[i]], row.names=1)
      signature_name = tools::file_path_sans_ext(basename(db[[i]]))

      if("DeconRNASeq"%in%algos){
        cached <- load_cache("DeconRNASeq", signature_name)
        if(!is.null(cached)){ deconrnaseq <- cached } else {
          cat("\nRunning DeconRNASeq...............................................................\n\n")
          deconrnaseq <- computeDeconRNASeq(TPM_matrix, signature, signature_name)
          save_cache("DeconRNASeq", signature_name, deconrnaseq)}}
      if("Epidish"%in%algos){
        cached <- load_cache("Epidish", signature_name)
        if(!is.null(cached)){ epidish_res <- cached } else {
          cat("\nRunning Epidish...............................................................\n\n")
          epidish_res <- computeEpiDISH(TPM_matrix, signature, signature_name)
          save_cache("Epidish", signature_name, epidish_res)}}
      if("DWLS"%in%algos){
        if(doParallel == F){
          cached <- load_cache("DWLS", signature_name)
          if(!is.null(cached)){ dwls <- cached } else {
            cat("\nRunning DWLS...............................................................\n\n")
            dwls <- computeDWLS(TPM_matrix, signature, signature_name)
            save_cache("DWLS", signature_name, dwls)}}}
      if("CBSX"%in%algos){
        if(doParallel == F){
          cached <- load_cache("CBSX", signature_name)
          if(!is.null(cached)){ cbsx <- cached } else {
            cat("\nRunning CBSX...............................................................\n\n")
            cbsx <- computeCBSX(TPM_matrix, signature, cbsx.name, cbsx.token, signature_name)
            save_cache("CBSX", signature_name, cbsx)}}}
      if("MOMF"%in%algos & is.null(sc_obj) == F){
        if(doParallel == F){
          cached <- load_cache("MOMF", signature_name)
          if(!is.null(cached)){ momf <- cached } else {
            cat("\nRunning MOMF...............................................................\n\n")
            momf <- computeMOMF(TPM_matrix, sc_obj, signature, signature_name)
            save_cache("MOMF", signature_name, momf)}}}
      combined_data <- do.call(cbind, Filter(Negate(is.null), list(deconrnaseq, epidish_res, cbsx, dwls, momf)))
      deconvolution[[i]] <- combined_data
    }


    deconv = do.call(cbind, deconvolution)

    # Clean up per-method-signature cache files now that the full matrix is combined
    all_sig_names <- tools::file_path_sans_ext(basename(db))
    cache_methods_used <- algos[algos %in% c("DeconRNASeq", "Epidish", "DWLS", "CBSX", "MOMF")]
    for (sig_name in all_sig_names) {
      for (m in cache_methods_used) {
        f <- cache_file(m, sig_name)
        if (file.exists(f)) file.remove(f)
      }
    }
    message("\nDeconvolution cache files removed.\n")
    # Don't leave an empty Results/ behind if it only existed for the cache
    if (created_results_dir && length(list.files("Results", all.files = TRUE, no.. = TRUE)) == 0) {
      unlink("Results", recursive = TRUE)
    }

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
#'The function calculates cell abundance based on cell type signatures using different methods and signatures. Methods available are Quantiseq, CIBERSORTx, EpiDISH, DWLS and DeconRNASeq. Provided signatures included signatures based on bulk and methylation data. Signatures are present in the src/signatures directory, user can add its own signatures by adding the .txt files in this same folder. Second generation methods to perform deconvolution based on single cell data are also available if scRNAseq object is provided.
#'
#' @param raw.counts A matrix with the raw counts (samples as columns and genes symbols as rows)
#' @param methods A character vector with the deconvolution methods to run. Default are "Quantiseq", "CBSX", "Epidish", "DeconRNASeq", "DWLS"
#' @param signatures_select A character vector with the signature names to run. If NULL (default), all available signatures are used (package signatures + custom signatures from Results/custom_signatures/).
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
#' @param cells_extra A character vector of non-standard cell type names to retain during analysis.
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
compute.deconvolution <- function(raw.counts, methods = c("Quantiseq", "CBSX", "Epidish", "DeconRNASeq", "DWLS"), signatures_select = NULL, normalized = TRUE, doParallel = FALSE, workers = NULL, return = TRUE, create_signature = FALSE,
                                  credentials.mail = NULL, credentials.token = NULL, sc_deconv = FALSE, sc_matrix = NULL, sc_metadata = NULL, methods_sc = c("Autogenes", "BayesPrism", "Bisque", "CPM", "MuSic", "SCDC"), cell_label = NULL,
                                  sample_label = NULL, cell_markers = NULL, methods_sig = c("DWLS", "CIBERSORTx", "MOMF", "BSeqsc"), name_sc_signature = NULL, file_name = NULL, cells_extra = NULL){

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

  quantiseq = NULL
  if("Quantiseq" %in% methods){
    cat("\nRunning Quantiseq...............................................................\n")
    quantiseq = computeQuantiseq(TPM_matrix)}
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

  deconv_sig = compute_methods_variable_signature(TPM_matrix, signatures = path_signatures, algos = methods, signatures_select = signatures_select, cbsx.name = credentials.mail, cbsx.token = credentials.token, doParallel, workers, sc_matrix)

  deconv_default <- quantiseq

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

  if(is.null(all_deconvolution_table) || ncol(data.frame(all_deconvolution_table)) == 0){
    stop("No deconvolution results were produced. Check the selected methods (e.g. CBSX needs credentials.mail and credentials.token).")
  }

  deconvolution = compute.deconvolution.preprocessing(all_deconvolution_table, cells_extra = cells_extra)

  if(return == TRUE){
    ensure_results_dir()
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
#' @keywords internal
compute_sc_deconvolution_methods = function(raw_counts, normalized = TRUE, methods_sc = c("Autogenes", "BayesPrism", "Bisque", "CPM", "MuSic", "SCDC"), sc_object, sc_metadata, cell_annotations, samples_ids, name_object, n_cores = NULL, return = FALSE, file_name = NULL){
  if(normalized){
    bulk_counts = ADImpute::NormalizeTPM(raw_counts)
  } else {
    bulk_counts = raw_counts
  }

  if(is.null(name_object)) name_object = "scRNAseq" # Avoid "Method__cell" names that break method_signature_cell parsing

  # Method names are matched ignoring case (e.g. "MuSiC" = "MuSic"); unknown names are reported
  valid_sc = c("Autogenes", "BayesPrism", "Bisque", "CPM", "MuSic", "SCDC")
  matched_sc = valid_sc[match(tolower(methods_sc), tolower(valid_sc))]
  if(anyNA(matched_sc)){
    warning("Unknown single-cell methods ignored: ", paste(methods_sc[is.na(matched_sc)], collapse = ", "),
            ". Available: ", paste(valid_sc, collapse = ", "), call. = FALSE)
  }
  methods_sc = matched_sc[!is.na(matched_sc)]

  sc_object = as.matrix(sc_object) # Convert once (each conversion of a large reference costs a lot of memory)

  if(is.null(n_cores)){
    n_cores = parallel::detectCores() - 1
    message("\nUsing ", n_cores, " cores available for running...\n")
  }

  # Set up per-method caching to survive crashes
  created_results_dir <- !dir.exists("Results")
  cache_dir <- ensure_results_dir()
  # Fingerprint of the inputs (bulk and single-cell reference), so cached results are only reused for the same data
  fp_file <- tempfile()
  saveRDS(list(raw_counts, dim(sc_object), dimnames(sc_object), sum(sc_object),
               if (!is.null(sc_metadata)) sc_metadata[, c(cell_annotations, samples_ids), drop = FALSE]), fp_file, compress = FALSE)
  data_id <- substr(unname(tools::md5sum(fp_file)), 1, 8); unlink(fp_file)
  cache_file <- function(method) file.path(cache_dir, paste0("sc_deconv_", method, "_", name_object, "_", data_id, ".rds"))
  load_cache <- function(method){
    f <- cache_file(method)
    if(file.exists(f)){
      message("\nFound cached result for ", method, " - skipping run.\n")
      return(readRDS(f))
    }
    NULL
  }
  save_cache <- function(method, result) saveRDS(result, cache_file(method))

  results = list()

  if("Autogenes" %in% methods_sc){
    cached <- load_cache("AutogeneS")
    if(!is.null(cached)){
      results$AutogeneS = cached
    } else {
      message("\nRunning AutogeneS...\n")
      autogenes = omnideconv::deconvolute_autogenes(
        bulk_gene_expression = bulk_counts,
        single_cell_object = sc_object,
        cell_type_annotations = as.character(sc_metadata[,cell_annotations]),
        verbose = TRUE
      )$proportions
      save_cache("AutogeneS", autogenes)
      results$AutogeneS = autogenes
    }
  }

  if("BayesPrism" %in% methods_sc){
    cached <- load_cache("BayesPrism")
    if(!is.null(cached)){
      results$BayesPrism = cached
    } else {
      message("\nRunning BayesPrism...\n")
      bayesprism = omnideconv::deconvolute_bayesprism(
        bulk_gene_expression = raw_counts,
        single_cell_object = sc_object,
        cell_type_annotations = as.character(sc_metadata[,cell_annotations]),
        n_cores = n_cores
      )$theta
      save_cache("BayesPrism", bayesprism)
      results$BayesPrism = bayesprism
    }
  }

  if("Bisque" %in% methods_sc){
    cached <- load_cache("Bisque")
    if(!is.null(cached)){
      results$Bisque = cached
    } else {
      message("\nRunning Bisque...\n")
      bisque = omnideconv::deconvolute_bisque(
        bulk_gene_expression = as.matrix(raw_counts),
        single_cell_object = sc_object,
        cell_type_annotations = as.character(sc_metadata[,cell_annotations]),
        batch_ids = as.character(sc_metadata[,samples_ids]),
        verbose = TRUE
      )$bulk.props %>% t() # BisqueRNA returns cell types x samples
      save_cache("Bisque", bisque)
      results$Bisque = bisque
    }
  }

  if("CPM" %in% methods_sc){
    cached <- load_cache("CPM")
    if(!is.null(cached)){
      results$CPM = cached
    } else {
      message("\nRunning CPM...\n")
      sampled_SCData <- stratified_sample_cells(sc_object, sc_metadata, cell_annotations, n_cells_per_type = 500) #Sample cells to a max of 500 per cell type
      set.seed(123) #Stochastic method (CPM is not deterministic)
      cpm = omnideconv::deconvolute_cpm(
        bulk_gene_expression = data.frame(raw_counts),
        single_cell_object = as.matrix(sampled_SCData$Counts),
        no_cores = n_cores,
        cell_type_annotations = as.character(sampled_SCData$Metadata[, cell_annotations]),
        verbose = TRUE
      )$cellTypePredictions
      save_cache("CPM", cpm)
      results$CPM = cpm
    }
  }

  if("MuSic" %in% methods_sc){
    cached <- load_cache("MuSic")
    if(!is.null(cached)){
      results$MuSic = cached
    } else {
      message("\nRunning MuSiC...\n")
      ct_annotations <- as.character(sc_metadata[, cell_annotations])
      sample_ids     <- as.character(sc_metadata[, samples_ids])
      n_subjects_per_ct <- tapply(sample_ids, ct_annotations, function(x) length(unique(x)))
      keep_ct <- names(n_subjects_per_ct)[n_subjects_per_ct > 1]
      keep_cells <- ct_annotations %in% keep_ct
      dropped_ct <- setdiff(unique(ct_annotations), keep_ct)
      if(length(dropped_ct) > 0){
        message("MuSiC needs each cell type in at least 2 samples; not estimated: ", paste(dropped_ct, collapse = ", "))
      }
      music = omnideconv::deconvolute_music(
        bulk_gene_expression = as.matrix(bulk_counts),
        single_cell_object = sc_object[, keep_cells],
        cell_type_annotations = ct_annotations[keep_cells],
        batch_ids = sample_ids[keep_cells],
        verbose = TRUE
      )$Est.prop.weighted
      save_cache("MuSic", music)
      results$MuSic = music
    }
  }

  if("SCDC" %in% methods_sc){
    cached <- load_cache("SCDC")
    if(!is.null(cached)){
      results$SCDC = cached
    } else {
      message("\nRunning SCDC...\n")
      scdc = omnideconv::deconvolute_scdc(
        bulk_gene_expression = as.matrix(bulk_counts),
        single_cell_object = sc_object,
        cell_type_annotations = as.character(sc_metadata[,cell_annotations]),
        batch_ids = as.character(sc_metadata[,samples_ids]),
        verbose = TRUE
      )$prop.est.mvw
      save_cache("SCDC", scdc)
      results$SCDC = scdc
    }
  }

  # Format and combine results
  results <- lapply(names(results), function(method) {
    deconv_method <- results[[method]]
    colnames(deconv_method) <- paste0(method, "_", name_object, "_", colnames(deconv_method))
    colnames(deconv_method) <- stringr::str_replace_all(colnames(deconv_method), " ", "_")
    return(deconv_method)
  })

  results = do.call(cbind, results)

  # Clean up per-method cache files now that all methods completed successfully
  {
    cache_methods <- c("AutogeneS", "BayesPrism", "Bisque", "CPM", "MuSic", "SCDC")
    for(m in cache_methods){
      f <- cache_file(m)
      if(file.exists(f)) file.remove(f)
    }
    message("\nSc-deconvolution cache files removed.\n")
    # Don't leave an empty Results/ behind if it only existed for the cache
    if (created_results_dir && length(list.files("Results", all.files = TRUE, no.. = TRUE)) == 0) {
      unlink("Results", recursive = TRUE)
    }
  }

  if(return == TRUE){
    ensure_results_dir()
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
#' @param sc_object A Seurat object with raw counts and a PCA already computed (`RunPCA()`), used to find each cell's nearest neighbours.
#' @param labels_column Name of the metadata column with the cell type labels.
#' @param samples_column Name of the metadata column with the sample labels.
#' @param exclude_cells Cell types to discard from metacell algorithm.
#' @param min_cells The minimum number of cells in a particular grouping to construct metacells.
#' @param k Number of nearest neighbors to aggregate for KNN algorithm.
#' @param max_shared The maximum number of cells to be shared across two metacells (keep it below `k`, otherwise metacells can overlap completely).
#' @param n_workers Number of cores to use for paralellization.
#' @param min_meta Minimum number of metacells allowed. Below this number, metacells of this cell type will be discarded.
#'
#' @return A list with two elements:
#' - The metacell count matrix (genes as rownames and metacells as columns): each metacell is the sum of the counts of its `k` cells
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
create_metacells = function(sc_object, labels_column, samples_column, exclude_cells = NULL, min_cells = 50, k = 15, max_shared = 10, n_workers = 4, min_meta = 10){

  .pkg <- "hdWGCNA"
  if (!requireNamespace(.pkg, quietly = TRUE))
    stop("Package 'hdWGCNA' is required for create_metacells(). ",
         "Install with: pak::pkg_install('smorabit/hdWGCNA')")
  .hd <- asNamespace(.pkg)
  if (!requireNamespace("Seurat", quietly = TRUE))
    stop("Package 'Seurat' is required for create_metacells().")

  message("\nCreating metacells...............................................................\n")
  ## Setup sc object
  data <- .hd$SetupForWGCNA(
    sc_object,
    gene_select = "fraction",
    fraction = 0.05,
    wgcna_name = "MetaCells"
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
      # Pick cells from the metadata and subset by cell name: in subset(subset = ...) a metadata
      # column named e.g. "patient" would shadow the loop variable and return empty groups
      cells_use <- colnames(data)[which(data@meta.data$samples_ids == patient &
                                          data@meta.data$cells_labels == cell_type)]
      if (length(cells_use) > 0) {
        subset_data[[contador]] <- subset(data, cells = cells_use)
        contador = contador + 1
      }
    }
  }

  # Set up parallelization using the future package
  old_plan <- future::plan(future::multisession, workers = n_workers) # Adjust the number of workers based on your system
  on.exit(future::plan(old_plan), add = TRUE) # Restore the user's plan, also on error
  # Run the function in parallel
  results <- future.apply::future_lapply(subset_data, FUN = process_group, min_cells, k, max_shared, labels_column, samples_column, future.seed = TRUE)
  results <- results[!sapply(results, is.null)]


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
  counts_sc = counts_sc[,colnames(counts_sc) %in% rownames(metadata), drop = FALSE]

  return(list(Counts = counts_sc, Metadata = metadata))

}

#' Replicate deconvolution subgroups in a new dataset
#'
#' Reconstructs and applies deconvolution subgroup signatures based on a previous decomposition.
#'
#' @param deconv_res A list containing results from the deconvolution process, including:
#'   \itemize{
#'     \item{\code{Deconvolution subgroups composition}: the member features of each subgroup, per cell type}
#'     \item{\code{Deconvolution matrix}: the original deconvolution result used to determine relevant features}
#'   }
#' @param deconvolution_test A data.frame or matrix of deconvolution results (e.g., from another cohort)
#'
#' @return A data.frame with the projected subgroup features proportions: the same features, in the same order, as
#'   the "Deconvolution matrix" of `deconv_res`. Each subgroup is the median of its member features. Subgroups with
#'   no member in `deconvolution_test`, and training features missing from it, are set to `NA` with a warning; a
#'   warning also lists subgroups computed from only part of their members.
#' @export
#'
replicate_deconvolution_subgroups = function(deconv_res, deconvolution_test){

  # All subgroups of all cell types, in the order they were created
  deconv_subgroups = unlist(unname(deconv_res[["Deconvolution subgroups composition"]]), recursive = FALSE)

  if (length(deconv_subgroups) == 0) {
    warning("No subgroups to replicate")
  }

  # Create same groups composition (one subgroup at a time, so a subgroup can also use earlier subgroups)
  deconvolution_test = data.frame(deconvolution_test, check.names = FALSE)
  partial = c()
  absent = c()
  for (sub_name in names(deconv_subgroups)) {
    members = deconv_subgroups[[sub_name]]
    x = as.matrix(deconvolution_test[, colnames(deconvolution_test) %in% members, drop = FALSE])

    if(ncol(x) == 0){
      med = rep(NA_real_, nrow(deconvolution_test)) #No member available: unknown (not 0)
      absent = c(absent, sub_name)
    } else {
      med = matrixStats::rowMedians(x)
      if(ncol(x) < length(members)) partial = c(partial, sub_name)
    }

    deconvolution_test[[sub_name]] = med #Compute median using the subgroup members
  }

  # Same features, in the same order, as the training "Deconvolution matrix" (missing ones as NA)
  train_features = colnames(deconv_res[["Deconvolution matrix"]])
  missing_features = setdiff(train_features, colnames(deconvolution_test))
  if(length(missing_features) > 0) deconvolution_test[missing_features] = NA_real_
  deconvolution_test = deconvolution_test[, train_features, drop = FALSE]

  show = function(x) paste0(paste(utils::head(x, 10), collapse = ", "), if (length(x) > 10) paste0(", ... (", length(x), " in total)"))
  if(length(partial) > 0) warning("Subgroups computed from only part of their members (others missing in deconvolution_test): ", show(partial), call. = FALSE)
  if(length(absent) > 0) warning("Subgroups with no member in deconvolution_test, set to NA: ", show(absent), call. = FALSE)
  if(length(missing_features) > 0) warning("Features of the training matrix missing in deconvolution_test, set to NA: ", show(setdiff(missing_features, absent)), call. = FALSE)

  return(data.frame(deconvolution_test, check.names = FALSE))
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
#' @return A correlation matrix between the cell type deconvolution combinations and the real cell proportions, with an
#'   "average" row (mean over cell types) used to order the combinations. When `deconvolution` contains subgroups
#'   (e.g. `B.cells_Subgroup.1`), columns are `Subgroup.1`, `Subgroup.2`, ... (the i-th subgroup of each cell type) and
#'   no average is computed, because a column then holds unrelated features.
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

  missing_samples = setdiff(rownames(deconvolution), rownames(groundtruth))
  if(length(missing_samples) == length(rownames(deconvolution))){
    stop("No sample names (rownames) are shared between 'deconvolution' and 'groundtruth'.")
  }
  if(length(missing_samples) > 0){
    warning(length(missing_samples), " samples in 'deconvolution' are missing from 'groundtruth' and will be ignored.")
    deconvolution = deconvolution[!rownames(deconvolution) %in% missing_samples, , drop = FALSE]
  }
  groundtruth = groundtruth[rownames(deconvolution), , drop = FALSE] #Order samples to match both features

  # Subgroup columns are named CellType_SubgroupID (e.g. B.cells_Subgroup.1).
  # Swap to SubgroupID_CellType so the standard _CellType$ matching logic works.
  subgroup_idx <- grepl("_Subgroup\\.", colnames(deconvolution))
  if (any(subgroup_idx)) {
    colnames(deconvolution)[subgroup_idx] <- sub(
      "^(.+?)_(Subgroup\\..+)$", "\\2_\\1",
      colnames(deconvolution)[subgroup_idx]
    )
  }

  cell_types = get_cell_type_nomenclature(cells_extra = cells_extra)

  pattern <- paste0("(_", gsub("\\.", "\\\\.", cell_types), ")$", collapse = "|")
  deconvolution_combinations <- unique(gsub(pattern, "", colnames(deconvolution)))

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

  #####Global scatter plot function (all cell types per method_signature)
  global_scatter <- function(deconvolution, groundtruth, cell_clusters, deconv_combinations, corr_method) {
    plot_list <- list()
    for (combo in deconv_combinations) {
      rows_list <- list()
      for (ct in cell_clusters) {
        col_name <- paste0(combo, "_", ct)
        if (!col_name %in% colnames(deconvolution)) next
        rows_list[[length(rows_list) + 1]] <- data.frame(
          estimate   = deconvolution[, col_name],
          ground     = groundtruth[, ct],
          cell_type  = ct,
          stringsAsFactors = FALSE
        )
      }
      if (length(rows_list) == 0) next
      plot_df <- do.call(rbind, rows_list)
      plot_df <- plot_df[stats::complete.cases(plot_df), ]
      if (nrow(plot_df) < 3) next

      # One correlation per cell type: pooling cell types mostly reflects their different abundances
      p_text <- function(p) ifelse(p < 0.001, "p < 0.001", ifelse(p < 0.01, "p < 0.01", ifelse(p < 0.05, "p < 0.05", paste0("p = ", formatC(p, format = "f", digits = 3)))))
      ct_stats <- sapply(split(plot_df, plot_df$cell_type), function(d) {
        if (nrow(d) < 3 || stats::sd(d$estimate) == 0 || stats::sd(d$ground) == 0) return(paste0(d$cell_type[1], ": r = NA"))
        ct_test <- suppressWarnings(stats::cor.test(d$estimate, d$ground, method = corr_method))
        paste0(d$cell_type[1], ": r = ", formatC(ct_test$estimate, format = "f", digits = 2), ", ", p_text(ct_test$p.value))
      })
      plot_df$cell_type <- factor(plot_df$cell_type, levels = names(ct_stats), labels = ct_stats)

      p <- ggplot2::ggplot(plot_df, ggplot2::aes(x = .data$ground, y = .data$estimate, colour = .data$cell_type)) +
        ggplot2::geom_point(size = 2.5, alpha = 0.85) +
        ggplot2::geom_smooth(method = "lm", se = FALSE, linewidth = 0.7) + # one line per cell type
        ggplot2::scale_colour_brewer(palette = "Dark2", name = NULL) +
        ggplot2::labs(
          title = gsub("_", " ", combo),
          x     = "Ground truth (cell fractions)",
          y     = "Estimated cell fractions"
        ) +
        ggplot2::theme_classic(base_size = 11) +
        ggplot2::theme(legend.position = "right")

      plot_list[[combo]] <- p
    }
    return(plot_list)
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

  ###Global scatter plots (all cell types per method_signature)
  if (scatter == TRUE) {
    scatter_list <- global_scatter(deconvolution, groundtruth, cell_clusters,
                                  deconvolution_combinations, corr_type)
    if (length(scatter_list) > 0) ensure_results_dir()
    for (combo_name in names(scatter_list)) {
      grDevices::pdf(paste0("Results/Scatter_global_", combo_name, "_", file_name, ".pdf"),
                     width = 6, height = 5)
      print(scatter_list[[combo_name]])
      grDevices::dev.off()
    }
  }

  ###Correlation computation
  for (i in 1:length(cell_clusters)) {
    idx = grep(paste0("_", cell_clusters[i], "$"), colnames(deconvolution))
    if(length(idx)==0){
      cells_discard = c(cells_discard, cell_clusters[i])
    }

    deconv = deconvolution[,idx, drop = F]

    ground = groundtruth[,cell_clusters[i],drop=F]

    x = corr_bench(cbind(deconv, ground), corr_type, pval)
    x = x[which(x$measure1==colnames(ground)),] #only taking corr against ground truth

    for (j in 1:ncol(corr_matrix)) {
      idx <- grep(paste0("^", colnames(corr_matrix)[j], "_"), x$measure2)
      if(length(idx) == 0){
        corr_matrix[i,j] = NA
      }else{
        corr_matrix[i,j] = x$r[idx]
      }
    }

    for (j in 1:ncol(pval_matrix)) {
      idx <- grep(paste0("^", colnames(pval_matrix)[j], "_"), x$measure2)
      if(length(idx) == 0){
        pval_matrix[i,j] = NaN
      }else{
        pval_matrix[i,j] = x$P[idx]
      }
    }
  }


  ###Benchmarking plot
  if(length(cells_discard)>0){
    corr_matrix = corr_matrix[!rownames(corr_matrix)%in%cells_discard, , drop = FALSE]
    pval_matrix = pval_matrix[!rownames(pval_matrix)%in%cells_discard, , drop = FALSE]
  }

  ## remove NA columns
  corr_matrix = corr_matrix %>%
    dplyr::select(dplyr::where(~ !all(is.na(.))))

  pval_matrix = pval_matrix %>%
    dplyr::select(dplyr::where(~ !all(is.na(.))))

  n_cell_types = colSums(!is.na(corr_matrix)) #Number of cell types each average is based on

  # With subgroups, a column (e.g. Subgroup.1) holds the first subgroup of every cell type: these are
  # unrelated features, so no average is computed and the columns are not ordered by it
  if(!any(subgroup_idx)){
    corr_matrix[nrow(corr_matrix)+1,] = colMeans(corr_matrix, na.rm = T)
    rownames(corr_matrix)[nrow(corr_matrix)] = "average"

    pval_matrix[nrow(pval_matrix)+1,] = 0
    rownames(pval_matrix)[nrow(pval_matrix)] = "average"

    ##Order methods
    corr_matrix = t(corr_matrix) %>%
      data.frame(check.names = FALSE) %>%
      dplyr::arrange(average) %>%
      t() %>%
      data.frame(check.names = FALSE)
  }

  corr_df <- reshape2::melt(corr_matrix)
  pval_df = reshape2::melt(pval_matrix[,colnames(corr_matrix), drop = FALSE]) #Take the same order as corr_matrix

  corr_df = corr_df %>%
    dplyr::mutate(Cells = rep(rownames(corr_matrix), ncol(corr_matrix)),
                  pval_value = pval_df$value)
  levels(corr_df$variable) = paste0(levels(corr_df$variable), " (n = ", n_cell_types[levels(corr_df$variable)], ")") #Show how many cell types each average uses

  g <- corr_df %>%
    ggplot2::ggplot(ggplot2::aes(Cells, variable, fill=value, label=round(value,2))) +
    ggplot2::geom_tile() +
    ggplot2::labs(x = NULL, y = NULL, fill = paste0(corr_type, "'s\nCorrelation"), title=file_name, subtitle = paste0("Showing correlations (pval<", pval, ")")) +
    ggplot2::scale_fill_gradient2(mid="#FBFEF9",low="#0C6291",high="#A63446", limits=c(-1,1)) +
    ggplot2::geom_text(data = subset(corr_df, pval_value <= pval)) +
    ggplot2::theme_classic() +
    ggplot2::scale_x_discrete(expand=c(0,0)) +
    ggplot2::scale_y_discrete(expand=c(0,0)) +
    ggpubr::rotate_x_text(angle = 45) + ggplot2::theme(axis.text.x=ggtext::element_markdown()) + ggplot2::theme(axis.text.y=ggtext::element_markdown())

  if(plot){
    ensure_results_dir()
    grDevices::pdf(paste0("Results/Benchmark_plot_", file_name,".pdf"), width = width, height = height)
    plot(g)
    grDevices::dev.off()
  }

  return(corr_matrix)

}

#' Create pseudo bulk from single cell object
#'
#' Sums the counts of all the cells of each sample, producing one bulk-like expression profile per sample.
#'
#' @param sc_obj A Seurat single cell object
#' @param cells_labels Not used (kept so existing calls keep working). The pseudobulk is aggregated per sample only.
#' @param sample_labels Name of the metadata column with the sample labels.
#' @param normalized Whether pseudobulk should be or not TPM normalized
#' @param file_name A string specifying the name of the .csv pseudobulk saved in Results/
#' @param return Whether to save or not the csv file with the pseudobulk in Results/
#'
#' @return A gene count matrix (genes as rows and samples as columns)
#' @export
#'
create_sc_pseudobulk = function(sc_obj, cells_labels = NULL, sample_labels, normalized = TRUE, file_name = "Pseudobulk", return = TRUE){
  if (!requireNamespace("Seurat", quietly = TRUE))
    stop("Package 'Seurat' is required for create_sc_pseudobulk().")

  #Convert to SingleCell
  sc_obj@meta.data$Patient = as.factor(sc_obj@meta.data[,sample_labels])
  sce = Seurat::as.SingleCellExperiment(sc_obj)

  ##Aggregating counts (sum of the counts of the cells of each sample)
  aggr_counts <- glmGamPoi::pseudobulk(sce, group_by = glmGamPoi::vars(Patient), aggregation_functions = list(counts = "rowSums2", .default = "rowMeans2"))
  pseudo_counts = data.frame(SummarizedExperiment::assay(aggr_counts, "counts"), check.names = FALSE)

  if(normalized == TRUE){
    pseudo_counts = ADImpute::NormalizeTPM(pseudo_counts, log=F) %>%
      data.frame(check.names = FALSE)
  }

  #Save pseudobulk matrix
  if(return == TRUE){
    ensure_results_dir()
    utils::write.csv(pseudo_counts, paste0("Results/", file_name, ".csv"))
  }

  return(pseudo_counts)

}


#' Create cell type signatures from scRNAseq
#'
#'
#' @param sc_obj A matrix with the counts from scRNAseq object (genes as rows and cells as columns)
#' @param sc_metadata Dataframe with metadata from the single cell object. The matrix should include the columns cell_label and sample_label.
#' @param cells_labels Name of the `sc_metadata` column with the cell type labels. The labels become the cell type names of the
#'   signatures, so they must follow the multideconv nomenclature (see [get_cell_type_nomenclature()] and the README);
#'   otherwise those cell types are discarded later by [compute.deconvolution.analysis()].
#' @param sample_labels Name of the `sc_metadata` column with the sample labels.
#' @param credentials.mail (Optional) Credential email for running CIBERSORTx If not provided, CIBERSORTx method will not be run.
#' @param credentials.token (Optional) Credential token for running CIBERSORTx. If not provided, CIBERSORTx method will not be run.
#' @param bulk_rna A matrix of bulk data. Rows are genes, columns are samples. This is needed for MOMF method, if not given the method will not be run.
#' @param cell_markers Named list with the genes markers names as Symbol per cell types to be used to create the signature using the BSeq-SC method. If NULL, the method will be ignored during the signature creation.
#' @param name_signature A string indicating the signature name, used in the file names (e.g. `DWLS-<name_signature>-scRNAseq.txt`).
#'   It must not contain `_` (replaced by `-`), which separates method, signature and cell type in the deconvolution column names.
#' @param methods_sig A character vector specifying which methods to run. Options are "DWLS", "CIBERSORTx" (or "CBSX"), "MOMF", and "BSeqsc". Default runs all available methods.
#'
#' @return A list containing the cell signatures per method. Signatures are directly saved in Results/custom_signatures folder
#'   (an existing file with the same name is overwritten), these will be used to run deconvolution.
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
  if(is.null(name_signature)) name_signature = "custom" # Avoid "DWLS--scRNAseq.txt" file names
  if(grepl("_", name_signature)){
    message("'_' in name_signature replaced by '-' ('_' separates method, signature and cell type in the column names).")
    name_signature = gsub("_", "-", name_signature)
  }

  # Method names are matched ignoring case ("CBSX" = "CIBERSORTx"); unknown names are reported
  valid_sig = c("DWLS", "CIBERSORTx", "MOMF", "BSeqsc")
  methods_sig[toupper(methods_sig) == "CBSX"] = "CIBERSORTx"
  matched_sig = valid_sig[match(tolower(methods_sig), tolower(valid_sig))]
  if(anyNA(matched_sig)){
    warning("Unknown signature methods ignored: ", paste(methods_sig[is.na(matched_sig)], collapse = ", "),
            ". Available: ", paste(valid_sig, collapse = ", "), call. = FALSE)
  }
  methods_sig = matched_sig[!is.na(matched_sig)]

  save_signature = function(model, prefix){
    sig_file = paste0(signature_dir, prefix, "-", name_signature, "-scRNAseq.txt")
    if(file.exists(sig_file)) message("Overwriting existing signature file: ", sig_file)
    utils::write.table(model, sig_file, row.names = FALSE, quote = FALSE, sep = "\t")
  }

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

    save_signature(model_dwls, "DWLS")
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

      save_signature(model_cbsx, "CBSX")
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

      save_signature(model_momf, "MOMF")
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

      save_signature(model_bseq, "BSeqSC")
      signatures[["BSeqsc"]] = model_bseq
    }
  }

  return(signatures)
}

#' Reset the foreach backend to sequential
#'
#' Registers the sequential `foreach` backend after a parallel cluster has been stopped, so later
#' parallel `foreach` calls do not try to use the closed cluster.
#'
#' @return Called for its side effect; the return value is not used.
#' @keywords internal
unregister_dopar <- function() {
  if (!is.null(foreach::getDoParRegistered())) {
    # switch back to sequential backend
    foreach::registerDoSEQ()
    gc()
  }
}

#' Build metacells for one cell type and sample group
#'
#' Worker function of [create_metacells()]: runs hdWGCNA's `MetacellsByGroups()` on the cells of one
#' cell type from one sample and returns the metacell counts and metadata.
#'
#' @param data A Seurat object with the cells of one cell type from one sample (must contain a `pca` reduction).
#' @param min_cells Minimum number of cells required to build metacells; smaller groups are skipped.
#' @param k Number of nearest neighbours aggregated into each metacell.
#' @param max_shared Maximum number of cells shared between two metacells.
#' @param labels_column Name of the metadata column with the cell type labels.
#' @param samples_column Name of the metadata column with the sample labels.
#'
#' @return A list with `counts` (genes x metacells matrix of summed counts) and `metadata` (metacell metadata), or `NULL`
#'   if the group has fewer than `min_cells` cells.
#' @keywords internal
process_group <- function(data, min_cells = 50, k = 15, max_shared = 10, labels_column, samples_column) {

  .pkg <- "hdWGCNA"
  if (!requireNamespace(.pkg, quietly = TRUE))
    stop("Package 'hdWGCNA' is required. Install with: pak::pkg_install('smorabit/hdWGCNA')")
  .hd <- asNamespace(.pkg)

  if (ncol(data) < min_cells) {
    cat("Skipping group: Less than", min_cells, "cells in this subset\n")
    return(NULL)
  }

  seurat_obj = .hd$MetacellsByGroups(seurat_obj = data,
                                     min_cells = min_cells,
                                     group.by = c(labels_column, samples_column),
                                     reduction = 'pca',
                                     k = k,
                                     max_shared = max_shared,
                                     mode = "sum", # metacell counts = sum of its cells' counts (integers)
                                     ident.group = labels_column)

  meta = .hd$GetMetacellObject(seurat_obj)

  # Use the metacell object's own assay (hdWGCNA keeps the input's default assay, e.g. "SCT")
  # and the counts accessor matching the installed SeuratObject (the `slot` argument is defunct in v5)
  assay = SeuratObject::DefaultAssay(meta)
  if (utils::packageVersion("SeuratObject") >= "5.0.0") {
    counts = SeuratObject::LayerData(meta, assay = assay, layer = "counts")
  } else {
    counts = SeuratObject::GetAssayData(meta, assay = assay, slot = "counts")
  }
  counts = as.matrix(counts)

  result <- list(
    counts = counts,
    metadata = meta@meta.data
  )

  # Clean memory inside worker
  rm(data, seurat_obj, meta)
  gc()

  return(result)

}

#' Subsample cells per cell type
#'
#' Randomly keeps at most `n_cells_per_type` cells of each cell type. Used to limit the size of the
#' single-cell reference for CPM in [compute_sc_deconvolution_methods()].
#'
#' @param SCData A count matrix (genes x cells); its column names must match the row names of `SCData_metadata`.
#' @param SCData_metadata A data frame with one row per cell (row names = cell names).
#' @param cell_label Name of the metadata column with the cell type labels.
#' @param n_cells_per_type Maximum number of cells kept per cell type.
#' @param seed Random seed for the sampling.
#'
#' @return A list with `Counts` (subsampled count matrix) and `Metadata` (matching metadata).
#' @keywords internal
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
#' @param data A data frame of deconvolution features (samples x features) plus the outcome, as given by pipeML:
#'   a `target` column (classification) or `time` and `event` columns (survival). The outcome columns are not used
#'   to compute the subgroups; they are added back to the returned data.
#' @param folds A list of integer vectors indicating row indices for the training set in each fold. The test set is implicitly defined as the complement.
#' @param bestune Optional tuning object; when provided, folds are skipped and full-data processing is returned.
#' @param ncores Number of CPU cores for parallel fold processing.
#' @param cells_extra Optional character vector of additional cell labels to include.
#' @param corr Minimum correlation threshold passed to [compute.deconvolution.analysis()].
#' @param corr_type Correlation type passed to [compute.deconvolution.analysis()].
#' @param zero_thr Maximum zero fraction passed to [compute.deconvolution.analysis()].
#' @param cv_thr Minimum coefficient of variation passed to [compute.deconvolution.analysis()].
#' @param batch Optional batch covariate passed to [compute.deconvolution.analysis()].
#'
#' @return
#' - When `bestune` is `NULL` (fold mode): invisibly, a named list of processed folds, each also saved to
#'   `Results/fold_<fold name>.rds`. Each fold contains:
#'     \itemize{
#'       \item \code{train_data}: Processed training data with cell group features and the outcome columns.
#'       \item \code{test_data}: Test data projected into the learned cell group feature space (plus `time` and
#'         `event` for survival).
#'       \item \code{obs_test}: True class labels (or survival time/event) for the test set.
#'       \item \code{rowIndex}: Row indices corresponding to the test set.
#'       \item \code{fold_name}: Fold name if provided in the `folds` list.
#'     }
#' - When `bestune` is provided: a list with the processed feature matrix for the full dataset (including
#'   the outcome columns), the full [compute.deconvolution.analysis()] output, and `bestune`.
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
    cells_extra = NULL,
    corr = 0.7,
    corr_type = "spearman",
    zero_thr = 0.9,
    cv_thr = 0.1,
    batch = NULL
) {

  # Outcome columns given by pipeML in data: "target" (classification) or "time" + "event" (survival).
  # They are removed before computing the deconvolution subgroups and added back to the returned data
  if ("target" %in% colnames(data)) {
    outcome_cols <- "target"
  } else if (all(c("time", "event") %in% colnames(data))) {
    outcome_cols <- c("time", "event")
  } else {
    stop("data must contain a 'target' column (classification) or 'time' and 'event' columns (survival)")
  }
  survival <- !identical(outcome_cols, "target")
  outcome <- data[, outcome_cols, drop = FALSE]
  data <- data[, setdiff(colnames(data), outcome_cols), drop = FALSE]

  # -----------------------------
  # CASE 1: bestune provided - compute full training once
  # -----------------------------
  if (!is.null(bestune)) {

    # Compute deconvolution on full dataset
    deconv_subgroups_final <- compute.deconvolution.analysis(
      deconvolution = data,
      corr = corr,
      corr_type = corr_type,
      zero_thr = zero_thr,
      cv_thr = cv_thr,
      batch = batch,
      cells_extra = cells_extra,
      return = FALSE,
      verbose = FALSE
    )

    train_cell_data_final <- cbind(deconv_subgroups_final[[1]], outcome)

    custom_output <- deconv_subgroups_final

    return(list(train_cell_data_final, custom_output, bestune))
  }

  # -----------------------------
  # CASE 2: bestune NOT provided - compute folds
  # -----------------------------
  if (is.null(folds)) stop("Provide 'folds' (a list of training row indices) or 'bestune'.")
  if (is.null(ncores)) ncores <- max(1, parallel::detectCores() - 2)
  cl <- parallel::makeCluster(ncores)
  doParallel::registerDoParallel(cl)

  processed_folds <- foreach::foreach(
    i = seq_along(folds),
    .packages = c("dplyr", "multideconv")
  ) %dopar% {
    cat("Starting fold", names(folds)[i], "\n")

    train_idx <- folds[[i]]
    test_idx  <- setdiff(seq_len(nrow(data)), train_idx)

    # TRAIN: subgroups learned on the training samples of the fold
    deconv_subgroups <- compute.deconvolution.analysis(
      deconvolution = data[train_idx, , drop = FALSE],
      corr = corr,
      corr_type = corr_type,
      zero_thr = zero_thr,
      cv_thr = cv_thr,
      batch = if (!is.null(batch)) batch[train_idx] else NULL,
      cells_extra = cells_extra,
      return = FALSE
    )

    train_cell_data <- cbind(deconv_subgroups[[1]], outcome[train_idx, , drop = FALSE])

    # TEST: test samples projected onto the subgroups learned on the training samples
    test_data <- replicate_deconvolution_subgroups(deconv_subgroups, data[test_idx, , drop = FALSE])
    if (survival) test_data <- cbind(test_data, outcome[test_idx, , drop = FALSE])  # pipeML evaluates each fold with them

    list(
      train_data = train_cell_data,
      test_data  = test_data,
      obs_test   = if (survival) outcome[test_idx, , drop = FALSE] else outcome$target[test_idx],
      rowIndex   = test_idx,
      fold_name  = names(folds)[i]
    )
  }

  parallel::stopCluster(cl)
  unregister_dopar()

  # Save each fold (pipeML reads back every Results/fold_*.rds, so drop stale files from earlier runs first)
  ensure_results_dir()
  file.remove(list.files("Results", pattern = "^fold_.*\\.rds$", full.names = TRUE))
  fold_names <- if (is.null(names(folds))) paste0("Fold", seq_along(folds)) else names(folds)
  names(processed_folds) <- fold_names
  for (i in seq_along(processed_folds)) {
    saveRDS(processed_folds[[i]], file = file.path("Results", paste0("fold_", fold_names[i], ".rds")))
  }

  invisible(processed_folds)
}

#' Relate Deconvolution Subgroups to Pathway Activities
#'
#' Correlates deconvolution subgroup profiles with a pre-computed pathway
#' activity matrix, saves one heatmap per cell type to `Results/` and returns
#' the correlations and p-values.
#'
#' @param subgroups Output list from [compute.deconvolution.analysis()].
#' @param pathways A numeric matrix or data frame with samples as rows and
#'   pathway activities as columns. Row names must match sample identifiers in
#'   `subgroups`.
#' @param file_name Character prefix used when naming output PDF files.
#' @param height,width Plot height and width in inches (passed to [ggplot2::ggsave()]). If `NULL` (default), the
#'   size is chosen from the number of subgroups and pathways.
#' @param par_mar Ignored; kept for backwards compatibility.
#' @param pval P-value threshold; correlations above this are not starred.
#' @param corr_type Correlation type, "pearson" (default) or "spearman".
#'
#' @return Invisibly, a list with one element per cell type, each holding `correlations` and `pvalues`
#'   (subgroups as rows, pathways as columns). One PDF heatmap per cell type is also saved in `Results/`.
#'
#' @importFrom ggplot2 ggplot aes geom_tile geom_text scale_fill_gradientn
#'   scale_x_discrete guide_colorbar labs theme_minimal theme element_text
#'   element_blank margin ggsave
#' @importFrom stats quantile
#' @export
compute.subgroup.pathways <- function(subgroups,
                                      pathways  = NULL,
                                      file_name = "Test",
                                      height    = NULL,
                                      width     = NULL,
                                      par_mar   = c(4, 25, 5, 3),
                                      pval      = 0.05,
                                      corr_type = "pearson") {
  if (!requireNamespace("WGCNA", quietly = TRUE))
    stop("Package 'WGCNA' is required for compute.subgroup.pathways()")

  if (is.null(pathways))
    stop("Supply a pre-computed 'pathways' matrix (samples x pathways). ")

  sig_label <- function(p) ifelse(p < 0.001, "***", ifelse(p < 0.01, "**", ifelse(p < 0.05, "*", "")))

  subgroups_per_ct <- subgroups$`Deconvolution subgroups per cell types`

  common_all <- intersect(rownames(subgroups[["Deconvolution matrix"]]), rownames(pathways))
  if (length(common_all) < 5)
    stop("Fewer than 5 samples in common between 'subgroups' and 'pathways' (", length(common_all),
         "). Row names of 'pathways' must be the sample names used in the deconvolution.")

  results <- list()

  multi_subgroup_cts <- Filter(function(ct) {
    m <- subgroups_per_ct[[ct]]
    !is.null(m) && (is.data.frame(m) || is.matrix(m)) && ncol(m) > 1
  }, names(subgroups_per_ct))

  if (length(multi_subgroup_cts) == 0)
    message("No cell type has more than one feature: nothing to compare.")

  for (ct in multi_subgroup_cts) {

    cells <- data.frame(subgroups_per_ct[[ct]], check.names = FALSE)
    path  <- data.frame(pathways, check.names = FALSE)

    common_samples <- intersect(rownames(cells), rownames(path))
    if (length(common_samples) < 5) next
    cells <- cells[common_samples, , drop = FALSE]
    path  <- path[common_samples,  , drop = FALSE]

    cells <- cells[, apply(cells, 2, var, na.rm = TRUE) > 0, drop = FALSE]
    path  <- path[,  apply(path,  2, var, na.rm = TRUE) > 0, drop = FALSE]
    if (ncol(cells) == 0 || ncol(path) == 0) next

    cor_mat  <- WGCNA::cor(cells, path, method = corr_type)
    pval_mat <- WGCNA::corPvalueStudent(cor_mat, nrow(cells))
    results[[ct]] <- list(correlations = cor_mat, pvalues = pval_mat)

    clean_ct   <- gsub("\\.", " ", ct)
    clean_cols <- gsub(paste0("^", gsub("\\.", "\\\\.", ct), "_"), "", colnames(cells))

    cor_df <- as.data.frame(cor_mat) %>%
      tibble::rownames_to_column("Subgroup") %>%
      tidyr::pivot_longer(-Subgroup, names_to = "Pathway", values_to = "Correlation")

    pval_df <- as.data.frame(pval_mat) %>%
      tibble::rownames_to_column("Subgroup") %>%
      tidyr::pivot_longer(-Subgroup, names_to = "Pathway", values_to = "Pvalue")

    plot_df <- dplyr::left_join(cor_df, pval_df, by = c("Subgroup", "Pathway")) %>%
      dplyr::mutate(
        Label    = sig_label(Pvalue),
        Label    = ifelse(Pvalue <= pval, Label, ""),
        Subgroup = factor(Subgroup, levels = rev(colnames(cells))),
        Pathway  = factor(Pathway,  levels = colnames(path))
      )

    levels(plot_df$Subgroup) <- rev(clean_cols)

    n_sub  <- length(levels(plot_df$Subgroup))
    n_path <- length(levels(plot_df$Pathway))
    plot_w <- if (is.null(width))  max(8, n_path * 0.55 + 3) else width
    plot_h <- if (is.null(height)) max(4, n_sub  * 0.7  + 3) else height

    p <- ggplot(plot_df, aes(x = Pathway, y = Subgroup, fill = Correlation)) +
      geom_tile(color = "white", linewidth = 0.4) +
      geom_text(aes(label = Label), size = 3.5, vjust = 0.75, color = "black") +
      scale_fill_gradientn(
        colors  = c("#2166AC", "#4393C3", "#92C5DE", "#FFFFFF", "#F4A582", "#D6604D", "#B2182B"),
        limits  = c(-1, 1),
        name    = paste0(tools::toTitleCase(corr_type), " r"),
        guide   = guide_colorbar(barwidth = 0.8, barheight = 6, ticks = FALSE)
      ) +
      scale_x_discrete(position = "bottom") +
      labs(
        title   = clean_ct,
        caption = "* p<0.05   ** p<0.01   *** p<0.001",
        x       = NULL,
        y       = NULL
      ) +
      theme_minimal(base_size = 11) +
      theme(
        plot.title    = element_text(face = "bold", size = 13, hjust = 0),
        plot.caption  = element_text(size = 8, color = "grey40", hjust = 0),
        axis.text.x   = element_text(angle = 45, hjust = 1, size = 9),
        axis.text.y   = element_text(size = 10),
        panel.grid    = element_blank(),
        legend.position = "right",
        plot.margin   = margin(6, 10, 4, 6)
      )

    if (interactive()) print(p) # Printing in a script would leave a stray Rplots.pdf

    safe_name <- gsub("[^A-Za-z0-9_]", "_", ct)
    ensure_results_dir()
    ggsave(
      filename = file.path("Results", paste0(file_name, "_", safe_name, ".pdf")),
      plot     = p,
      width    = plot_w,
      height   = plot_h,
      device   = "pdf"
    )
  }
  invisible(results)
}
