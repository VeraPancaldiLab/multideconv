options(stringsAsFactors = FALSE)

`%||%` <- function(x, y) if (is.null(x)) y else x

load_multideconv <- function() {
  if (requireNamespace("multideconv", quietly = TRUE)) {
    return(invisible(TRUE))
  }

  if (!requireNamespace("pkgload", quietly = TRUE)) {
    stop(
      "The package 'multideconv' is not installed and 'pkgload' is unavailable. ",
      "Install multideconv or install pkgload to run from source.",
      call. = FALSE
    )
  }

  app_dir <- dirname(normalizePath(sys.frame(1)$ofile %||% "inst/shiny/app.R", winslash = "/", mustWork = FALSE))
  repo_root <- normalizePath(file.path(app_dir, "..", ".."), winslash = "/", mustWork = TRUE)
  pkgload::load_all(repo_root, export_all = FALSE, quiet = TRUE)
  invisible(TRUE)
}

load_multideconv()

library(shiny)

read_expression_table <- function(path) {
  ext <- tolower(tools::file_ext(path))
  if (ext %in% c("tsv", "txt")) {
    df <- utils::read.delim(path, check.names = FALSE, row.names = 1)
  } else {
    df <- utils::read.csv(path, check.names = FALSE, row.names = 1)
  }
  as.matrix(df)
}

parse_extra_cells <- function(x) {
  if (is.null(x) || !nzchar(trimws(x))) {
    return(NULL)
  }
  vals <- unlist(strsplit(x, ","))
  vals <- trimws(vals)
  vals <- vals[nzchar(vals)]
  if (!length(vals)) NULL else vals
}

safe_workers <- function(x) {
  if (is.null(x) || is.na(x) || x < 1) {
    return(NULL)
  }
  as.integer(x)
}

ui <- fluidPage(
  tags$head(
    tags$style(HTML("\n      :root {\n        --bg-1: #f4f8fb;\n        --bg-2: #e6f0f5;\n        --ink: #17324a;\n        --brand: #0d6e8a;\n        --brand-dark: #0a5469;\n        --accent: #f3b562;\n        --panel: #ffffff;\n        --soft-border: #d7e4ec;\n      }\n\n      body {\n        background: linear-gradient(145deg, var(--bg-1), var(--bg-2));\n        color: var(--ink);\n      }\n\n      .container-fluid {\n        max-width: 1320px;\n      }\n\n      .main-title {\n        background: linear-gradient(120deg, #0d6e8a, #1f8fae);\n        color: #ffffff;\n        border-radius: 14px;\n        padding: 18px 22px;\n        margin-bottom: 14px;\n        box-shadow: 0 12px 30px rgba(13, 110, 138, 0.22);\n      }\n\n      .main-title h2 {\n        margin: 0;\n        font-weight: 700;\n      }\n\n      .main-title p {\n        margin: 8px 0 0 0;\n        opacity: 0.95;\n      }\n\n      .hero-card, .info-card, .well, .tab-content {\n        background: var(--panel);\n        border: 1px solid var(--soft-border);\n        border-radius: 12px;\n        box-shadow: 0 8px 24px rgba(21, 58, 79, 0.08);\n      }\n\n      .hero-card {\n        padding: 18px;\n        margin-top: 8px;\n      }\n\n      .hero-logo {\n        display: block;\n        max-width: 340px;\n        width: 100%;\n        margin: 0 auto 10px auto;\n      }\n\n      .info-card {\n        padding: 14px 16px;\n        margin-top: 14px;\n      }\n\n      .tabbable > .nav > li > a {\n        font-weight: 600;\n        color: var(--brand-dark);\n      }\n\n      .tabbable > .nav > li.active > a,\n      .tabbable > .nav > li.active > a:focus,\n      .tabbable > .nav > li.active > a:hover {\n        color: #ffffff;\n        background-color: var(--brand);\n        border-color: var(--brand-dark);\n      }\n\n      .btn-primary {\n        background-color: var(--brand);\n        border-color: var(--brand-dark);\n        font-weight: 600;\n      }\n\n      .btn-primary:hover, .btn-primary:focus {\n        background-color: var(--brand-dark);\n        border-color: var(--brand-dark);\n      }\n\n      .btn-default {\n        border-color: #c7d6df;\n      }\n\n      h3, h4 {\n        color: #10324b;\n      }\n\n      .lead-note {\n        font-size: 1.05em;\n        line-height: 1.6;\n      }\n    "))
  ),
  div(
    class = "main-title",
    h2(HTML("<strong>multideconv</strong>")),
    p("Integrative deconvolution from bulk RNA-seq with user-friendly analysis and benchmarking")
  ),
  tabsetPanel(
    tabPanel(
      "Welcome",
      fluidRow(
        column(
          12,
          div(
            class = "hero-card",
            fluidRow(
              column(
                8,
                p(
                  class = "lead-note",
                  style = "text-align: justify;",
                  tags$strong("multideconv"),
                  " is an integrative pipeline that combines multiple deconvolution approaches to estimate cell populations from bulk RNA-seq data. It helps reduce redundancy between methods and signatures, then summarizes robust cell signals you can interpret and compare across patients."
                )
              ),
              column(
                4,
                tags$img(
                  src = "logo.png",
                  alt = "multideconv logo",
                  style = "display:block; width:140px; max-width:100%; margin:6px 0 6px auto;"
                )
              )
            )
          ),
          div(
            class = "info-card",
            h3("What you can do here"),
            tags$ol(
              tags$li("Estimate cell composition from your bulk RNA-seq matrix in the Deconvolution tab."),
              tags$li("Refine noisy and redundant outputs into robust subgroups in Analysis."),
              tags$li("Compare deconvolution estimates against known cell proportions in Benchmark.")
            )
          ),
          div(
            class = "info-card",
            h3("Before you start"),
            tags$ul(
              tags$li("Use genes in rows and samples in columns for expression inputs."),
              tags$li("If your matrix is already normalized, disable TPM normalization in the Deconvolution tab."),
              tags$li("CIBERSORTx is optional and needs credentials/token if selected."),
              tags$li("You can test the whole workflow using built-in example datasets first.")
            )
          ),
          div(
            class = "info-card",
            h3("Citation"),
            p(
              style = "text-align: justify; color: #000000;",
              "If you use ", tags$strong("multideconv"), " in your work, please cite:", tags$br(), tags$br(),
              "Hurtado, M., Essabbar, A., Khajavi, L., & Pancaldi, V. (2025). ",
              tags$strong("multideconv"),
              " – Integrative pipeline for cell type deconvolution from bulk RNAseq using first and second generation methods. bioRxiv. https://doi.org/10.1101/2025.04.29.651220"
            )
          ),
          div(
            class = "info-card",
            h3("Authors"),
            tags$ul(
              tags$li("Authors: Marcelo Hurtado (marcelo.hurtado@inserm.fr), Vera Pancaldi (vera.pancaldi@inserm.fr)"),
              tags$li("Maintainer: Marcelo Hurtado (marcelo.hurtado@inserm.fr)")
            )
          ),
          p(
            style = "text-align: center; font-style: italic; font-size: 1.2em; margin-top: 26px;",
            "This app is designed for researchers and clinicians who want practical results without needing to write code."
          )
        )
      )
    ),
    tabPanel(
      "Deconvolution",
      sidebarLayout(
        sidebarPanel(
          selectInput(
            "counts_source",
            "Counts source",
            choices = c("Example raw_counts", "Upload file")
          ),
          fileInput("counts_file", "Upload counts (CSV/TSV, genes in rows)"),
          checkboxInput("counts_normalized", "Input is raw counts (apply TPM normalization)", value = TRUE),
          checkboxGroupInput(
            "methods",
            "Methods",
            choices = c("Quantiseq", "CBSX", "Epidish", "DeconRNASeq", "DWLS"),
            selected = c("Quantiseq", "Epidish", "DeconRNASeq")
          ),
          checkboxInput("do_parallel", "Parallelize supported methods", value = FALSE),
          numericInput("workers", "Workers", value = 2, min = 1, step = 1),
          textInput("credentials_mail", "CIBERSORTx mail (optional)", value = ""),
          passwordInput("credentials_token", "CIBERSORTx token (optional)", value = ""),
          textInput("deconv_file_name", "Output file name", value = "ShinyRun"),
          checkboxInput("save_deconv_csv", "Save Results/Deconvolution_<file>.csv", value = FALSE),
          actionButton("run_deconv", "Run compute.deconvolution", class = "btn-primary")
        ),
        mainPanel(
          h4("Input preview"),
          tableOutput("counts_preview"),
          h4("Deconvolution status"),
          verbatimTextOutput("deconv_status"),
          downloadButton("download_deconv_csv", "Download deconvolution CSV"),
          h4("Deconvolution matrix preview"),
          tableOutput("deconv_preview")
        )
      )
    ),
    tabPanel(
      "Analysis",
      sidebarLayout(
        sidebarPanel(
          selectInput(
            "deconv_source",
            "Deconvolution input",
            choices = c("From previous tab", "Example deconv_bulk", "Example deconvolution", "Upload file")
          ),
          fileInput("deconv_file", "Upload deconvolution matrix (CSV/TSV, samples in rows)"),
          sliderInput("analysis_corr", "Correlation threshold", min = 0.5, max = 0.95, value = 0.7, step = 0.05),
          selectInput("analysis_corr_type", "Correlation type", choices = c("spearman", "pearson"), selected = "spearman"),
          numericInput("analysis_seed", "Seed", value = 123, min = 1, step = 1),
          textInput("cells_extra", "Extra cell types (comma-separated)", value = ""),
          textInput("analysis_file_name", "Output file name", value = "ShinySubgroups"),
          checkboxInput("save_analysis_outputs", "Save subgroup outputs in Results/", value = FALSE),
          actionButton("run_analysis", "Run compute.deconvolution.analysis", class = "btn-primary")
        ),
        mainPanel(
          h4("Analysis status"),
          verbatimTextOutput("analysis_status"),
          downloadButton("download_analysis_csv", "Download processed matrix CSV"),
          downloadButton("download_subgroups_csv", "Download subgroup composition CSV"),
          h4("Processed deconvolution preview"),
          tableOutput("analysis_preview"),
          h4("Subgroup composition preview"),
          tableOutput("subgroup_preview")
        )
      )
    ),
    tabPanel(
      "Benchmark",
      sidebarLayout(
        sidebarPanel(
          selectInput(
            "benchmark_deconv_source",
            "Deconvolution matrix",
            choices = c("Processed (from previous tab)", "Raw deconvolution (from previous tab)", "Example deconv_bulk", "Upload file")
          ),
          fileInput("benchmark_deconv_file", "Upload deconvolution for benchmark (CSV/TSV)"),
          selectInput(
            "groundtruth_source",
            "Ground truth matrix",
            choices = c("Example cells_groundtruth", "Upload file")
          ),
          fileInput("groundtruth_file", "Upload ground truth (CSV/TSV)"),
          selectInput("benchmark_corr_type", "Correlation type", choices = c("spearman", "pearson"), selected = "spearman"),
          numericInput("benchmark_pval", "P-value threshold", value = 0.05, min = 0.0001, max = 1, step = 0.01),
          textInput("benchmark_cells_extra", "Extra cell types (comma-separated)", value = ""),
          checkboxInput("save_benchmark_plot", "Save benchmark PDF in Results/", value = FALSE),
          textInput("benchmark_file_name", "Output file name", value = "ShinyBenchmark"),
          actionButton("run_benchmark", "Run compute.benchmark", class = "btn-primary")
        ),
        mainPanel(
          h4("Benchmark status"),
          verbatimTextOutput("benchmark_status"),
          downloadButton("download_benchmark_csv", "Download benchmark matrix CSV"),
          h4("Benchmark correlation matrix preview"),
          tableOutput("benchmark_preview"),
          h4("Heatmap"),
          plotOutput("benchmark_plot", height = "550px")
        )
      )
    )
  )
)

server <- function(input, output, session) {
  state <- reactiveValues(
    counts = NULL,
    deconv = NULL,
    analysis = NULL,
    benchmark = NULL,
    deconv_msg = "No run yet.",
    analysis_msg = "No run yet.",
    benchmark_msg = "No run yet."
  )

  current_counts <- reactive({
    if (identical(input$counts_source, "Example raw_counts")) {
      return(multideconv::raw_counts)
    }

    req(input$counts_file)
    read_expression_table(input$counts_file$datapath)
  })

  output$counts_preview <- renderTable({
    mat <- current_counts()
    if (is.null(mat)) {
      return(NULL)
    }
    head(as.data.frame(mat[, seq_len(min(6, ncol(mat))), drop = FALSE]), 8)
  }, rownames = TRUE)

  observeEvent(input$run_deconv, {
    methods <- input$methods
    if (!length(methods)) {
      showNotification("Select at least one method.", type = "error")
      return()
    }

    counts <- current_counts()
    workers <- safe_workers(input$workers)

    state$deconv_msg <- "Running compute.deconvolution..."

    res <- tryCatch({
      multideconv::compute.deconvolution(
        raw.counts = counts,
        methods = methods,
        normalized = isTRUE(input$counts_normalized),
        doParallel = isTRUE(input$do_parallel),
        workers = workers,
        return = isTRUE(input$save_deconv_csv),
        credentials.mail = if (nzchar(trimws(input$credentials_mail))) input$credentials_mail else NULL,
        credentials.token = if (nzchar(trimws(input$credentials_token))) input$credentials_token else NULL,
        file_name = input$deconv_file_name
      )
    }, error = function(e) e)

    if (inherits(res, "error")) {
      state$deconv_msg <- paste("Error:", conditionMessage(res))
      showNotification(state$deconv_msg, type = "error", duration = 8)
      return()
    }

    state$deconv <- as.data.frame(res)
    state$deconv_msg <- paste(
      "Done.",
      "Samples:", nrow(state$deconv),
      "Features:", ncol(state$deconv)
    )
    showNotification("Deconvolution completed.", type = "message")
  })

  output$deconv_status <- renderText(state$deconv_msg)

  output$deconv_preview <- renderTable({
    req(state$deconv)
    head(state$deconv[, seq_len(min(8, ncol(state$deconv))), drop = FALSE], 10)
  }, rownames = TRUE)

  output$download_deconv_csv <- downloadHandler(
    filename = function() {
      paste0("deconvolution_", format(Sys.time(), "%Y%m%d_%H%M%S"), ".csv")
    },
    content = function(file) {
      req(state$deconv)
      utils::write.csv(state$deconv, file = file, row.names = TRUE)
    }
  )

  current_deconv_for_analysis <- reactive({
    src <- input$deconv_source

    if (identical(src, "From previous tab")) {
      req(state$deconv)
      return(as.data.frame(state$deconv))
    }

    if (identical(src, "Example deconv_bulk")) {
      return(as.data.frame(multideconv::deconv_bulk))
    }

    if (identical(src, "Example deconvolution")) {
      return(as.data.frame(multideconv::deconvolution))
    }

    req(input$deconv_file)
    as.data.frame(read_expression_table(input$deconv_file$datapath))
  })

  observeEvent(input$run_analysis, {
    deconv_mat <- current_deconv_for_analysis()
    cells_extra <- parse_extra_cells(input$cells_extra)

    state$analysis_msg <- "Running compute.deconvolution.analysis..."

    res <- tryCatch({
      multideconv::compute.deconvolution.analysis(
        deconvolution = deconv_mat,
        corr = input$analysis_corr,
        corr_type = input$analysis_corr_type,
        seed = as.integer(input$analysis_seed),
        cells_extra = cells_extra,
        file_name = input$analysis_file_name,
        return = isTRUE(input$save_analysis_outputs),
        verbose = TRUE
      )
    }, error = function(e) e)

    if (inherits(res, "error")) {
      state$analysis_msg <- paste("Error:", conditionMessage(res))
      showNotification(state$analysis_msg, type = "error", duration = 8)
      return()
    }

    state$analysis <- res
    mat <- res[["Deconvolution matrix"]]
    state$analysis_msg <- paste(
      "Done.",
      "Processed samples:", nrow(mat),
      "Processed features:", ncol(mat)
    )
    showNotification("Deconvolution analysis completed.", type = "message")
  })

  output$analysis_status <- renderText(state$analysis_msg)

  output$analysis_preview <- renderTable({
    req(state$analysis)
    mat <- as.data.frame(state$analysis[["Deconvolution matrix"]])
    head(mat[, seq_len(min(8, ncol(mat))), drop = FALSE], 10)
  }, rownames = TRUE)

  subgroup_preview_df <- reactive({
    req(state$analysis)
    groups <- state$analysis[["Deconvolution subgroups composition"]]

    rows <- list()
    for (cell in names(groups)) {
      g <- groups[[cell]]
      if (!length(g)) {
        next
      }
      for (sub_name in names(g)) {
        rows[[length(rows) + 1]] <- data.frame(
          CellType = cell,
          Subgroup = sub_name,
          Members = paste(g[[sub_name]], collapse = " | "),
          stringsAsFactors = FALSE
        )
      }
    }

    if (!length(rows)) {
      return(data.frame(Message = "No subgroup composition available."))
    }

    do.call(rbind, rows)
  })

  output$subgroup_preview <- renderTable({
    head(subgroup_preview_df(), 15)
  }, rownames = FALSE)

  output$download_analysis_csv <- downloadHandler(
    filename = function() {
      paste0("processed_deconvolution_", format(Sys.time(), "%Y%m%d_%H%M%S"), ".csv")
    },
    content = function(file) {
      req(state$analysis)
      utils::write.csv(state$analysis[["Deconvolution matrix"]], file = file, row.names = TRUE)
    }
  )

  output$download_subgroups_csv <- downloadHandler(
    filename = function() {
      paste0("subgroup_composition_", format(Sys.time(), "%Y%m%d_%H%M%S"), ".csv")
    },
    content = function(file) {
      out <- subgroup_preview_df()
      utils::write.csv(out, file = file, row.names = FALSE)
    }
  )

  current_deconv_for_benchmark <- reactive({
    src <- input$benchmark_deconv_source

    if (identical(src, "Processed (from previous tab)")) {
      req(state$analysis)
      return(as.data.frame(state$analysis[["Deconvolution matrix"]]))
    }

    if (identical(src, "Raw deconvolution (from previous tab)")) {
      req(state$deconv)
      return(as.data.frame(state$deconv))
    }

    if (identical(src, "Example deconv_bulk")) {
      return(as.data.frame(multideconv::deconv_bulk))
    }

    req(input$benchmark_deconv_file)
    as.data.frame(read_expression_table(input$benchmark_deconv_file$datapath))
  })

  current_groundtruth <- reactive({
    if (identical(input$groundtruth_source, "Example cells_groundtruth")) {
      return(as.data.frame(multideconv::cells_groundtruth))
    }

    req(input$groundtruth_file)
    as.data.frame(read_expression_table(input$groundtruth_file$datapath))
  })

  observeEvent(input$run_benchmark, {
    deconv_mat <- current_deconv_for_benchmark()
    gt <- current_groundtruth()
    cells_extra <- parse_extra_cells(input$benchmark_cells_extra)

    state$benchmark_msg <- "Running compute.benchmark..."

    res <- tryCatch({
      multideconv::compute.benchmark(
        deconvolution = deconv_mat,
        groundtruth = gt,
        cells_extra = cells_extra,
        corr_type = input$benchmark_corr_type,
        scatter = FALSE,
        plot = isTRUE(input$save_benchmark_plot),
        pval = input$benchmark_pval,
        file_name = input$benchmark_file_name
      )
    }, error = function(e) e)

    if (inherits(res, "error")) {
      state$benchmark_msg <- paste("Error:", conditionMessage(res))
      showNotification(state$benchmark_msg, type = "error", duration = 8)
      return()
    }

    state$benchmark <- as.data.frame(res)
    state$benchmark_msg <- paste(
      "Done.",
      "Rows:", nrow(state$benchmark),
      "Columns:", ncol(state$benchmark)
    )
    showNotification("Benchmark completed.", type = "message")
  })

  output$benchmark_status <- renderText(state$benchmark_msg)

  output$benchmark_preview <- renderTable({
    req(state$benchmark)
    head(state$benchmark, 12)
  }, rownames = TRUE)

  output$download_benchmark_csv <- downloadHandler(
    filename = function() {
      paste0("benchmark_matrix_", format(Sys.time(), "%Y%m%d_%H%M%S"), ".csv")
    },
    content = function(file) {
      req(state$benchmark)
      utils::write.csv(state$benchmark, file = file, row.names = TRUE)
    }
  )

  output$benchmark_plot <- renderPlot({
    req(state$benchmark)

    bm <- state$benchmark
    bm$CellType <- rownames(bm)
    long <- reshape2::melt(bm, id.vars = "CellType", variable.name = "Combination", value.name = "Correlation")
    long$Correlation <- as.numeric(long$Correlation)

    ggplot2::ggplot(long, ggplot2::aes(x = CellType, y = Combination, fill = Correlation)) +
      ggplot2::geom_tile() +
      ggplot2::scale_fill_gradient2(low = "#2166AC", mid = "#F7F7F7", high = "#B2182B", midpoint = 0, limits = c(-1, 1)) +
      ggplot2::theme_minimal(base_size = 12) +
      ggplot2::theme(
        axis.text.x = ggplot2::element_text(angle = 50, hjust = 1),
        panel.grid = ggplot2::element_blank()
      ) +
      ggplot2::labs(x = NULL, y = NULL, fill = "Correlation")
  })
}

shinyApp(ui, server)
