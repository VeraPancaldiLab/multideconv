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

# Ensure critical dependencies are loaded for deconvolution backends
library(shiny)
library(pcaMethods, quietly = TRUE)
library(immunedeconv, quietly = TRUE)

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

escape_regex <- function(x) {
  gsub("([][{}()+*^$|\\?.])", "\\\\\\1", x)
}

discover_dictionary_plot_files <- function(results_dir, file_name = "", previous_files = character()) {
  if (!dir.exists(results_dir)) {
    return(character(0))
  }

  all_files <- list.files(results_dir, full.names = TRUE)
  all_files <- all_files[file.info(all_files)$isdir %in% FALSE]
  if (!length(all_files)) {
    return(character(0))
  }

  new_files <- setdiff(all_files, previous_files)
  fgsea_files <- all_files[grepl("_FGSEA_top20\\.(pdf|png|jpg|jpeg)$", all_files, ignore.case = TRUE)]

  pathway_files <- character(0)
  if (nzchar(trimws(file_name))) {
    prefix <- paste0("^", escape_regex(trimws(file_name)), ".*\\.(pdf|png|jpg|jpeg)$")
    pathway_files <- all_files[grepl(prefix, basename(all_files), ignore.case = TRUE)]
  }

  keep <- unique(c(new_files, fgsea_files, pathway_files))
  if (!length(keep)) {
    return(character(0))
  }

  keep[order(file.info(keep)$mtime, decreasing = TRUE)]
}

# ── CSS ───────────────────────────────────────────────────────────────────────
app_css <- "
:root {
  --brand:       #0a7490;
  --brand-dark:  #065f76;
  --brand-light: #e2f0f4;
  --accent:      #f0a500;
  --text:        #1a2e3a;
  --muted:       #5f7d8a;
  --bg:          #edf3f7;
  --panel:       #ffffff;
  --border:      #cee0e8;
  --radius:      10px;
  --shadow:      0 3px 14px rgba(10,116,144,.09);
  --shadow-lg:   0 8px 26px rgba(10,116,144,.17);
}

/* ── Body ── */
body {
  font-family: 'Segoe UI', system-ui, -apple-system, 'Helvetica Neue', Arial, sans-serif;
  background: var(--bg);
  color: var(--text);
  font-size: 14.5px;
}

/* ── Navbar ── */
.navbar.navbar-default {
  background: linear-gradient(135deg,#054e62 0%,#0a7490 100%) !important;
  border: none !important;
  border-radius: 0 !important;
  box-shadow: 0 2px 10px rgba(5,78,98,.35) !important;
  min-height: 56px;
}
.navbar-brand {
  color: #fff !important;
  font-size: 1.22em !important;
  font-weight: 700 !important;
  padding: 10px 18px !important;
  line-height: 36px !important;
}
.navbar-brand img {
  display: inline-block;
  vertical-align: middle;
  margin-right: 9px;
  margin-top: -2px;
  border-radius: 6px;
}
.navbar-nav > li > a {
  color: rgba(255,255,255,.82) !important;
  font-weight: 500;
  padding: 19px 15px !important;
  font-size: .91em;
  transition: background .15s;
}
.navbar-nav > li > a:hover {
  color: #fff !important;
  background: rgba(255,255,255,.12) !important;
}
.navbar-nav > li.active > a,
.navbar-nav > li.active > a:focus,
.navbar-nav > li.active > a:hover {
  color: #fff !important;
  background: rgba(255,255,255,.18) !important;
  border-bottom: 3px solid #f0a500 !important;
}
.navbar-toggle { border-color: rgba(255,255,255,.3) !important; }
.navbar-toggle .icon-bar { background: rgba(255,255,255,.85) !important; }

/* ── Layout ── */
.container-fluid { max-width: 1360px; padding: 20px 26px; }
.tab-content { padding-top: 4px; }

/* ── Generic card ── */
.md-card {
  background: var(--panel);
  border-radius: var(--radius);
  border: 1px solid var(--border);
  box-shadow: var(--shadow);
  padding: 22px 26px;
  margin-bottom: 18px;
}
.md-card-title {
  font-size: .97em;
  font-weight: 700;
  color: var(--brand-dark);
  margin: 0 0 14px 0;
  padding-bottom: 10px;
  border-bottom: 2px solid var(--brand-light);
}

/* ── Hero ── */
.hero {
  background: linear-gradient(135deg,#054e62 0%,#0a7490 60%,#0d96b5 100%);
  border-radius: var(--radius);
  padding: 36px 42px;
  color: #fff;
  margin-bottom: 22px;
  box-shadow: var(--shadow-lg);
  position: relative;
  overflow: hidden;
}
.hero::after {
  content: '';
  position: absolute; top: -70px; right: -70px;
  width: 280px; height: 280px;
  background: rgba(255,255,255,.05);
  border-radius: 50%;
  pointer-events: none;
}
.hero-title {
  font-size: 2.1em; font-weight: 700; margin: 0 0 6px 0; letter-spacing: -.02em;
}
.hero-ver {
  font-size: .75em; background: rgba(255,255,255,.22);
  border-radius: 20px; padding: 2px 10px;
  vertical-align: middle; margin-left: 8px; font-weight: 500;
}
.hero-sub {
  font-size: 1.03em; opacity: .88;
  max-width: 640px; line-height: 1.65; margin: 6px 0 18px 0;
}
.hero-logo {
  width: 108px; height: 108px;
  border-radius: 14px;
  box-shadow: 0 6px 22px rgba(0,0,0,.22);
}
.method-badge {
  display: inline-block; border-radius: 4px;
  padding: 3px 9px; font-size: .78em; font-weight: 600;
  margin: 2px 3px 2px 0; color: #fff;
}

/* ── Pipeline figure ── */
.fig-wrap {
  background: var(--panel);
  border-radius: var(--radius);
  border: 1px solid var(--border);
  box-shadow: var(--shadow);
  padding: 24px; margin-bottom: 18px; text-align: center;
}
.fig-wrap img {
  max-width: 100%; border-radius: 8px;
  box-shadow: 0 2px 10px rgba(10,116,144,.08);
}
.fig-caption {
  margin-top: 12px; font-size: .84em; color: var(--muted); font-style: italic;
}

/* ── Step cards ── */
.step-card {
  background: var(--panel);
  border-radius: var(--radius);
  border: 1px solid var(--border);
  box-shadow: var(--shadow);
  padding: 22px 20px; height: 100%;
  position: relative; overflow: hidden;
  transition: box-shadow .2s, transform .2s;
}
.step-card:hover { box-shadow: var(--shadow-lg); transform: translateY(-2px); }
.step-card::before {
  content: ''; position: absolute; top: 0; left: 0; right: 0; height: 4px;
}
.step-1::before { background: linear-gradient(90deg,#0a7490,#0d96b5); }
.step-2::before { background: linear-gradient(90deg,#2e9e6b,#3dc98a); }
.step-3::before { background: linear-gradient(90deg,#c0620a,#f0a500); }
.step-badge {
  display: inline-flex; align-items: center; justify-content: center;
  width: 34px; height: 34px; border-radius: 50%;
  color: #fff; font-weight: 700; font-size: 1em; margin-bottom: 12px;
}
.step-1 .step-badge { background: #0a7490; }
.step-2 .step-badge { background: #2e9e6b; }
.step-3 .step-badge { background: #c0620a; }
.step-title { font-weight: 700; font-size: 1em; color: var(--text); margin-bottom: 8px; }
.step-desc  { color: var(--muted); font-size: .9em; line-height: 1.55; margin: 0; }

/* ── Citation ── */
.citation-block {
  background: var(--brand-light);
  border-left: 4px solid var(--brand);
  border-radius: 0 8px 8px 0;
  padding: 14px 18px; font-size: .9em; line-height: 1.65; margin-top: 10px;
}

/* ── Sidebar ── */
.well {
  background: var(--panel) !important;
  border: 1px solid var(--border) !important;
  border-radius: var(--radius) !important;
  box-shadow: var(--shadow) !important;
  padding: 18px 18px 12px !important;
}
.sidebar-group {
  font-size: .76em; font-weight: 700; color: var(--brand);
  text-transform: uppercase; letter-spacing: .07em; margin: 14px 0 9px 0;
}
.sidebar-group:first-child { margin-top: 2px; }
.sidebar-hr { border: none; border-top: 1px solid var(--border); margin: 12px 0; }

/* ── Form controls ── */
select.form-control,
input.form-control,
input[type='text'].form-control,
input[type='password'].form-control,
input[type='number'].form-control {
  border-radius: 6px !important;
  border: 1px solid var(--border) !important;
  font-size: .9em !important; height: 34px !important;
}
textarea.form-control { border-radius: 6px !important; border: 1px solid var(--border) !important; font-size: .9em !important; }
.form-control:focus {
  border-color: var(--brand) !important;
  box-shadow: 0 0 0 2px rgba(10,116,144,.15) !important; outline: none !important;
}
.control-label { font-weight: 600; font-size: .87em; color: var(--text); }
.checkbox label, .radio label { font-size: .9em; }

/* ── Buttons ── */
.btn-primary {
  background: var(--brand) !important;
  border-color: var(--brand-dark) !important;
  border-radius: 7px !important; font-weight: 600 !important;
  padding: 9px 20px !important; width: 100%; font-size: .92em;
  letter-spacing: .02em; transition: all .18s ease !important;
  box-shadow: 0 2px 8px rgba(10,116,144,.22) !important;
  margin-top: 4px;
}
.btn-primary:hover, .btn-primary:focus {
  background: var(--brand-dark) !important; border-color: #044f63 !important;
  box-shadow: 0 5px 14px rgba(10,116,144,.3) !important;
}
.btn-default {
  border-radius: 7px !important; border-color: var(--border) !important;
  font-size: .88em; font-weight: 500 !important;
  color: var(--brand-dark) !important; background: var(--brand-light) !important;
}
.btn-default:hover { background: #cce4eb !important; border-color: var(--brand) !important; }

/* ── Output cards ── */
.out-card {
  background: var(--panel); border: 1px solid var(--border);
  border-radius: var(--radius); box-shadow: var(--shadow);
  padding: 20px 22px; margin-bottom: 16px;
}
.sec-head {
  font-size: .94em; font-weight: 700; color: var(--brand-dark);
  margin: 0 0 12px 0; padding-bottom: 8px;
  border-bottom: 2px solid var(--border);
}
.dl-row { display: flex; gap: 10px; flex-wrap: wrap; margin: 10px 0 2px; }
.dl-row .btn { flex: 1; min-width: 160px; width: auto !important; }

/* ── Status verbatim ── */
pre.shiny-text-output {
  background: #f5f9fb; border: 1px solid var(--border);
  border-radius: 6px; font-size: .84em; color: var(--muted);
  padding: 10px 14px; min-height: 36px;
}

/* ── Tables ── */
.table { font-size: .87em; }
.table > thead > tr > th {
  background: var(--brand-light); color: var(--brand-dark);
  font-weight: 700; border-bottom: 2px solid var(--border);
}

/* ── Footer ── */
.app-footer {
  text-align: center; padding: 20px 0;
  color: var(--muted); font-size: .82em;
  border-top: 1px solid var(--border); margin-top: 26px;
}

/* ── Responsive ── */
@media (max-width: 768px) {
  .hero-title { font-size: 1.5em; }
  .hero { padding: 22px 18px; }
  .hero-logo { width: 78px; height: 78px; }
  .container-fluid { padding: 12px 14px; }
}
"

# ── UI ────────────────────────────────────────────────────────────────────────
ui <- navbarPage(
  title = div(
    tags$img(src = "logo.png", height = "34px",
             style = "border-radius:6px; vertical-align:middle; margin-right:9px; margin-top:-2px;"),
    "multideconv"
  ),
  windowTitle = "multideconv \u00b7 Integrative Cell Deconvolution",
  id          = "main_nav",
  collapsible = TRUE,

  # ── Welcome ────────────────────────────────────────────────────────────────
  tabPanel(
    HTML('<span class="glyphicon glyphicon-home"></span>&nbsp; Welcome'),
    value = "welcome",

    tags$head(tags$style(HTML(app_css))),

    # Hero banner
    div(class = "hero",
      fluidRow(
        column(9,
          h1(class = "hero-title",
             HTML('multi<strong style="font-weight:800;">deconv</strong>'),
             tags$span(class = "hero-ver", "v0.0.1")),
          p(class = "hero-sub",
            "Integrative pipeline for cell type deconvolution from bulk RNA-seq \u2014 ",
            "combining first- and second-generation methods to identify robust, ",
            "cross-validated cell subgroups with minimal redundancy."),
          div(
            tags$span(class = "method-badge", style = "background:#0a7490;", "Quantiseq"),
            tags$span(class = "method-badge", style = "background:#2e9e6b;", "EpiDISH"),
            tags$span(class = "method-badge", style = "background:#1565c0;", "DeconRNASeq"),
            tags$span(class = "method-badge", style = "background:#7b4fa6;", "DWLS"),
            tags$span(class = "method-badge", style = "background:#c0620a;", "CIBERSORTx"),
            tags$span(class = "method-badge", style = "background:#37888c;", "MOMF"),
            tags$span(class = "method-badge", style = "background:#444;",    "& more\u2026")
          )
        ),
        column(3, style = "text-align:right; padding-top:8px;",
          tags$img(src = "logo.png", class = "hero-logo", alt = "multideconv logo")
        )
      )
    ),

    # Pipeline overview figure
    div(class = "fig-wrap",
      div(class = "md-card-title",
          HTML('<span class="glyphicon glyphicon-picture"></span>&nbsp; Pipeline Overview')),
      tags$img(src = "overview.png", alt = "multideconv pipeline overview",
               style = "max-width:960px; width:100%;"),
      p(class = "fig-caption",
        "multideconv orchestrates both first-generation (immunedeconv: Quantiseq, CIBERSORTx, EpiDISH, ",
        "DeconRNASeq) and second-generation (omnideconv: DWLS, MOMF, BayesPrism, MuSiC, Bisque\u2026) ",
        "deconvolution methods. Single-cell RNA-seq can be incorporated to build custom signatures.")
    ),

    # Three workflow steps
    fluidRow(style = "margin-bottom:18px;",
      column(4,
        div(class = "step-card step-1",
          div(class = "step-badge",
              HTML('<span class="glyphicon glyphicon-cog"></span>')),
          div(class = "step-title", "Step 1 \u00b7 Deconvolution"),
          p(class  = "step-desc",
            "Upload your bulk RNA-seq expression matrix and run multiple deconvolution ",
            "methods simultaneously. Parallel execution is supported to accelerate the run.")
        )
      ),
      column(4,
        div(class = "step-card step-2",
          div(class = "step-badge",
              HTML('<span class="glyphicon glyphicon-stats"></span>')),
          div(class = "step-title", "Step 2 \u00b7 Analysis"),
          p(class  = "step-desc",
            "Reduce cross-method redundancy via iterative correlation-based subgroup filtering. ",
            "Consolidates highly correlated estimates into robust, interpretable cell signals.")
        )
      ),
      column(4,
        div(class = "step-card step-3",
          div(class = "step-badge",
              HTML('<span class="glyphicon glyphicon-ok-sign"></span>')),
          div(class = "step-title", "Step 3 \u00b7 Benchmark"),
          p(class  = "step-desc",
            "Validate deconvolution outputs against known ground truth proportions. ",
            "Correlation heatmaps reveal accuracy per cell type across all methods and signatures.")
        )
      )
    ),

    # Tips + Authors (two columns)
    fluidRow(
      column(6,
        div(class = "md-card",
          div(class = "md-card-title",
              HTML('<span class="glyphicon glyphicon-info-sign"></span>&nbsp; Before You Start')),
          tags$ul(style = "padding-left:18px; margin:0;",
            tags$li(style = "margin-bottom:6px;",
                    "Expression matrix: genes in rows, samples in columns."),
            tags$li(style = "margin-bottom:6px;",
                    "If already normalized, uncheck raw counts in the Deconvolution tab."),
            tags$li(style = "margin-bottom:6px;",
                    "CIBERSORTx requires valid credentials (email + token)."),
            tags$li("Test with built-in example datasets before uploading your own data.")
          )
        )
      ),
      column(6,
        div(class = "md-card",
          div(class = "md-card-title",
              HTML('<span class="glyphicon glyphicon-user"></span>&nbsp; Authors')),
          p(style = "margin-bottom:8px;",
            tags$strong("Marcelo Hurtado"),
            tags$small(style = "display:block; color:#5f7d8a;",
                       tags$a(href = "mailto:marcelo.hurtado@inserm.fr",
                              "marcelo.hurtado@inserm.fr")),
            tags$small(style = "color:#5f7d8a;", "Author \u00b7 Maintainer")),
          tags$hr(style = "margin:8px 0;"),
          p(style = "margin:0;",
            tags$strong("Vera Pancaldi"),
            tags$small(style = "display:block; color:#5f7d8a;",
                       tags$a(href = "mailto:vera.pancaldi@inserm.fr",
                              "vera.pancaldi@inserm.fr")),
            tags$small(style = "color:#5f7d8a;", "Author")),
          tags$hr(style = "margin:8px 0;"),
          p(style = "margin:0; font-size:.87em; color:#5f7d8a;",
            HTML('<span class="glyphicon glyphicon-map-marker"></span>'),
            HTML("&nbsp;INSERM &bull; Toulouse, France"))
        )
      )
    ),

    # Detailed algorithm flowchart
    div(class = "fig-wrap",
      div(class = "md-card-title",
          HTML('<span class="glyphicon glyphicon-random"></span>&nbsp; Analysis Algorithm Flowchart')),
      tags$img(src = "Deconvolution_pipeline.png", alt = "Analysis pipeline flowchart",
               style = "max-width:100%; width:100%;"),
      p(class = "fig-caption",
        "Detailed flowchart of the subgroup computation algorithm: deconvolution matrix preprocessing, ",
        "iterative pairwise correlation analysis, and cell subgroup identification.")
    ),

    # Citation
    div(class = "md-card",
      div(class = "md-card-title",
          HTML('<span class="glyphicon glyphicon-book"></span>&nbsp; Citation')),
      div(class = "citation-block",
        "Hurtado, M., Essabbar, A., Khajavi, L., & Pancaldi, V. (2025). ",
        tags$strong("multideconv"),
        HTML(" &ndash; Integrative pipeline for cell type deconvolution from bulk RNAseq "),
        "using first and second generation methods.",
        tags$em(" bioRxiv."), HTML("&nbsp;"),
        tags$a(href   = "https://doi.org/10.1101/2025.04.29.651220",
               target = "_blank",
               "https://doi.org/10.1101/2025.04.29.651220")
      )
    ),

    # Footer
    div(class = "app-footer",
        HTML("multideconv &bull; v0.0.1 &bull; INSERM &bull; ",
             "<a href='https://github.com/VeraPancaldiLab/multideconv' target='_blank'>",
             "<span class='glyphicon glyphicon-link'></span>&nbsp;GitHub</a>"))
  ),

  # ── Deconvolution ──────────────────────────────────────────────────────────
  tabPanel(
    HTML('<span class="glyphicon glyphicon-cog"></span>&nbsp; Deconvolution'),
    value = "deconvolution",
    sidebarLayout(
      sidebarPanel(
        width = 3,
        div(class = "sidebar-group",
            HTML('<span class="glyphicon glyphicon-folder-open"></span>&nbsp; Input')),
        selectInput("counts_source", "Counts source",
                    choices = c("Example raw_counts", "Upload file")),
        fileInput("counts_file", "Upload counts (CSV/TSV, genes in rows)"),
        checkboxInput("counts_normalized",
                      "Input is raw counts (apply TPM normalization)", value = TRUE),
        tags$hr(class = "sidebar-hr"),
        div(class = "sidebar-group",
            HTML('<span class="glyphicon glyphicon-list-alt"></span>&nbsp; Methods')),
        checkboxGroupInput(
          "methods", label = NULL,
          choices  = c("Quantiseq", "CBSX", "Epidish", "DeconRNASeq", "DWLS"),
          selected = c("Quantiseq", "Epidish", "DeconRNASeq")
        ),
        checkboxInput("do_parallel", "Parallelize supported methods", value = FALSE),
        numericInput("workers", "Workers", value = 2, min = 1, step = 1),
        tags$hr(class = "sidebar-hr"),
        div(class = "sidebar-group",
            HTML('<span class="glyphicon glyphicon-lock"></span>&nbsp; CIBERSORTx Credentials')),
        textInput("credentials_mail",  "Email", value = ""),
        passwordInput("credentials_token", "Token", value = ""),
        tags$hr(class = "sidebar-hr"),
        div(class = "sidebar-group",
            HTML('<span class="glyphicon glyphicon-floppy-disk"></span>&nbsp; Output')),
        textInput("deconv_file_name", "Output file name", value = "ShinyRun"),
        checkboxInput("save_deconv_csv",
                      "Save Results/Deconvolution_<file>.csv", value = FALSE),
        br(),
        actionButton("run_deconv",
                     HTML('<span class="glyphicon glyphicon-play"></span>&nbsp; Run Deconvolution'),
                     class = "btn-primary")
      ),
      mainPanel(
        width = 9,
        div(class = "out-card",
          div(class = "sec-head",
              HTML('<span class="glyphicon glyphicon-eye-open"></span>&nbsp; Input Preview')),
          div(style = "overflow-x:auto;", tableOutput("counts_preview"))
        ),
        div(class = "out-card",
          div(class = "sec-head",
              HTML('<span class="glyphicon glyphicon-info-sign"></span>&nbsp; Run Status')),
          verbatimTextOutput("deconv_status"),
          div(class = "dl-row",
              downloadButton("download_deconv_csv",
                             HTML('<span class="glyphicon glyphicon-download-alt"></span>&nbsp; Download CSV')))
        ),
        div(class = "out-card",
          div(class = "sec-head",
              HTML('<span class="glyphicon glyphicon-th"></span>&nbsp; Deconvolution Matrix Preview')),
          div(style = "overflow-x:auto;", tableOutput("deconv_preview"))
        )
      )
    )
  ),

  # ── Analysis ───────────────────────────────────────────────────────────────
  tabPanel(
    HTML('<span class="glyphicon glyphicon-stats"></span>&nbsp; Analysis'),
    value = "analysis",
    sidebarLayout(
      sidebarPanel(
        width = 3,
        div(class = "sidebar-group",
            HTML('<span class="glyphicon glyphicon-folder-open"></span>&nbsp; Input')),
        selectInput(
          "deconv_source", "Deconvolution input",
          choices = c("From previous tab", "Example deconv_bulk",
                      "Example deconvolution", "Upload file")
        ),
        fileInput("deconv_file", "Upload deconvolution matrix (CSV/TSV, samples in rows)"),
        tags$hr(class = "sidebar-hr"),
        div(class = "sidebar-group",
            HTML('<span class="glyphicon glyphicon-equalizer"></span>&nbsp; Parameters')),
        sliderInput("analysis_corr", "Correlation threshold",
                    min = 0.5, max = 0.95, value = 0.7, step = 0.05),
        selectInput("analysis_corr_type", "Correlation type",
                    choices = c("spearman", "pearson"), selected = "spearman"),
        numericInput("analysis_seed", "Seed", value = 123, min = 1, step = 1),
        textInput("cells_extra", "Extra cell types (comma-separated)", value = ""),
        tags$hr(class = "sidebar-hr"),
        div(class = "sidebar-group",
            HTML('<span class="glyphicon glyphicon-floppy-disk"></span>&nbsp; Output')),
        textInput("analysis_file_name", "Output file name", value = "ShinySubgroups"),
        checkboxInput("save_analysis_outputs",
                      "Save subgroup outputs in Results/", value = FALSE),
        br(),
        actionButton("run_analysis",
                     HTML('<span class="glyphicon glyphicon-play"></span>&nbsp; Run Analysis'),
                     class = "btn-primary")
      ),
      mainPanel(
        width = 9,
        div(class = "out-card",
          div(class = "sec-head",
              HTML('<span class="glyphicon glyphicon-info-sign"></span>&nbsp; Run Status')),
          verbatimTextOutput("analysis_status"),
          div(class = "dl-row",
              downloadButton("download_analysis_csv",
                             HTML('<span class="glyphicon glyphicon-download-alt"></span>&nbsp; Processed Matrix CSV')),
              downloadButton("download_subgroups_csv",
                             HTML('<span class="glyphicon glyphicon-download-alt"></span>&nbsp; Subgroup Composition CSV')))
        ),
        div(class = "out-card",
          div(class = "sec-head",
              HTML('<span class="glyphicon glyphicon-th"></span>&nbsp; Processed Deconvolution Preview')),
          div(style = "overflow-x:auto;", tableOutput("analysis_preview"))
        ),
        div(class = "out-card",
          div(class = "sec-head",
              HTML('<span class="glyphicon glyphicon-list"></span>&nbsp; Subgroup Composition Preview')),
          div(style = "overflow-x:auto;", tableOutput("subgroup_preview"))
        )
      )
    )
  ),

  # ── Dictionary & Pathways ──────────────────────────────────────────────────
  tabPanel(
    HTML('<span class="glyphicon glyphicon-book"></span>&nbsp; Dictionary & Pathways'),
    value = "dictionary",
    sidebarLayout(
      sidebarPanel(
        width = 3,
        div(class = "sidebar-group",
            HTML('<span class="glyphicon glyphicon-folder-open"></span>&nbsp; Input')),
        selectInput(
          "dict_deconv_source", "Deconvolution (subgroups)",
          choices = c("From Analysis tab", "Upload file")
        ),
        fileInput("dict_deconv_file", 
                  "Upload deconvolution subgroups (from Analysis step)"),
        selectInput(
          "dict_counts_source", "Expression counts",
          choices = c("Example raw_counts", "From Deconvolution tab", "Upload file")
        ),
        fileInput("dict_counts_file", "Upload normalized counts (genes in rows)"),
        checkboxInput("dict_normalize_tpm",
                      "Normalize to TPM (if raw counts)", value = TRUE),
        tags$hr(class = "sidebar-hr"),
        div(class = "sidebar-group",
            HTML('<span class="glyphicon glyphicon-equalizer"></span>&nbsp; Parameters')),
        checkboxInput("dict_plot_gsea",
                      "Generate GSEA plots", value = FALSE),
        tags$hr(class = "sidebar-hr"),
        div(class = "sidebar-group",
            HTML('<span class="glyphicon glyphicon-floppy-disk"></span>&nbsp; Output')),
        textInput("dict_file_name", "Output file name", value = "ShinyDictionary"),
        checkboxInput("dict_save_plots",
                      "Save plots in Results/", value = FALSE),
        br(),
        actionButton("run_dict",
                     HTML('<span class="glyphicon glyphicon-play"></span>&nbsp; Compute Dictionary'),
                     class = "btn-primary"),
        br(),
        checkboxInput("run_pathways",
                      "Also run pathway analysis", value = TRUE),
        numericInput("pathway_height", "Plot height (inches)", value = 6, min = 2, max = 20),
        numericInput("pathway_width", "Plot width (inches)", value = 12, min = 4, max = 30),
        numericInput("pathway_pval", "P-value threshold", value = 0.05, min = 0.001, max = 1, step = 0.01)
      ),
      mainPanel(
        width = 9,
        div(class = "out-card",
          div(class = "sec-head",
              HTML('<span class="glyphicon glyphicon-info-sign"></span>&nbsp; Run Status')),
          verbatimTextOutput("dict_status"),
          div(class = "dl-row",
              downloadButton("download_dict_matrix",
                             HTML('<span class="glyphicon glyphicon-download-alt"></span>&nbsp; Download Dictionary Matrix CSV')))
        ),
        div(class = "out-card",
          div(class = "sec-head",
              HTML('<span class="glyphicon glyphicon-th"></span>&nbsp; Dictionary Matrix Preview')),
          div(style = "overflow-x:auto;", tableOutput("dict_preview"))
        ),
        div(class = "out-card",
          div(class = "sec-head",
              HTML('<span class="glyphicon glyphicon-stats"></span>&nbsp; Dictionary States')),
          verbatimTextOutput("dict_states")
        ),
        div(class = "out-card",
          div(class = "sec-head",
              HTML('<span class="glyphicon glyphicon-picture"></span>&nbsp; Generated Plots (GSEA and Pathways)')),
          uiOutput("dict_plots_ui")
        )
      )
    )
  ),

  # ── Benchmark ──────────────────────────────────────────────────────────────
  tabPanel(
    HTML('<span class="glyphicon glyphicon-ok-sign"></span>&nbsp; Benchmark'),
    value = "benchmark",
    sidebarLayout(
      sidebarPanel(
        width = 3,
        div(class = "sidebar-group",
            HTML('<span class="glyphicon glyphicon-folder-open"></span>&nbsp; Deconvolution Input')),
        selectInput(
          "benchmark_deconv_source", "Deconvolution matrix",
          choices = c("Processed (from previous tab)",
                      "Raw deconvolution (from previous tab)",
                      "Example deconv_bulk", "Upload file")
        ),
        fileInput("benchmark_deconv_file",
                  "Upload deconvolution for benchmark (CSV/TSV)"),
        tags$hr(class = "sidebar-hr"),
        div(class = "sidebar-group",
            HTML('<span class="glyphicon glyphicon-check"></span>&nbsp; Ground Truth')),
        selectInput(
          "groundtruth_source", "Ground truth matrix",
          choices = c("Example cells_groundtruth", "Upload file")
        ),
        fileInput("groundtruth_file", "Upload ground truth (CSV/TSV)"),
        tags$hr(class = "sidebar-hr"),
        div(class = "sidebar-group",
            HTML('<span class="glyphicon glyphicon-equalizer"></span>&nbsp; Parameters')),
        selectInput("benchmark_corr_type", "Correlation type",
                    choices = c("spearman", "pearson"), selected = "spearman"),
        numericInput("benchmark_pval", "P-value threshold",
                     value = 0.05, min = 0.0001, max = 1, step = 0.01),
        textInput("benchmark_cells_extra",
                  "Extra cell types (comma-separated)", value = ""),
        tags$hr(class = "sidebar-hr"),
        div(class = "sidebar-group",
            HTML('<span class="glyphicon glyphicon-floppy-disk"></span>&nbsp; Output')),
        checkboxInput("save_benchmark_plot",
                      "Save benchmark PDF in Results/", value = FALSE),
        textInput("benchmark_file_name", "Output file name", value = "ShinyBenchmark"),
        br(),
        actionButton("run_benchmark",
                     HTML('<span class="glyphicon glyphicon-play"></span>&nbsp; Run Benchmark'),
                     class = "btn-primary")
      ),
      mainPanel(
        width = 9,
        div(class = "out-card",
          div(class = "sec-head",
              HTML('<span class="glyphicon glyphicon-info-sign"></span>&nbsp; Run Status')),
          verbatimTextOutput("benchmark_status"),
          div(class = "dl-row",
              downloadButton("download_benchmark_csv",
                             HTML('<span class="glyphicon glyphicon-download-alt"></span>&nbsp; Download Benchmark CSV')))
        ),
        div(class = "out-card",
          div(class = "sec-head",
              HTML('<span class="glyphicon glyphicon-th"></span>&nbsp; Benchmark Matrix Preview')),
          div(style = "overflow-x:auto;", tableOutput("benchmark_preview"))
        ),
        div(class = "out-card",
          div(class = "sec-head",
              HTML('<span class="glyphicon glyphicon-signal"></span>&nbsp; Benchmark Heatmap')),
          plotOutput("benchmark_plot", height = "550px")
        )
      )
    )
  )
)

# ── Server ────────────────────────────────────────────────────────────────────
server <- function(input, output, session) {
  state <- reactiveValues(
    counts    = NULL,
    deconv    = NULL,
    analysis  = NULL,
    benchmark = NULL,
    results_dir = normalizePath(file.path(getwd(), "Results"), winslash = "/", mustWork = FALSE),
    dictionary_plot_files = character(0),
    deconv_msg    = "No run yet.",
    analysis_msg  = "No run yet.",
    benchmark_msg = "No run yet."
  )

  if (!dir.exists(state$results_dir)) {
    dir.create(state$results_dir, recursive = TRUE, showWarnings = FALSE)
  }
  shiny::addResourcePath("results", state$results_dir)

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

    counts  <- current_counts()
    workers <- safe_workers(input$workers)

    state$deconv_msg <- "Running compute.deconvolution..."

    res <- tryCatch({
      multideconv::compute.deconvolution(
        raw.counts         = counts,
        methods            = methods,
        normalized         = isTRUE(input$counts_normalized),
        doParallel         = isTRUE(input$do_parallel),
        workers            = workers,
        return             = isTRUE(input$save_deconv_csv),
        credentials.mail   = if (nzchar(trimws(input$credentials_mail)))  input$credentials_mail  else NULL,
        credentials.token  = if (nzchar(trimws(input$credentials_token))) input$credentials_token else NULL,
        file_name          = input$deconv_file_name
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
    deconv_mat  <- current_deconv_for_analysis()
    cells_extra <- parse_extra_cells(input$cells_extra)

    state$analysis_msg <- "Running compute.deconvolution.analysis..."

    res <- tryCatch({
      multideconv::compute.deconvolution.analysis(
        deconvolution = deconv_mat,
        corr          = input$analysis_corr,
        corr_type     = input$analysis_corr_type,
        seed          = as.integer(input$analysis_seed),
        cells_extra   = cells_extra,
        file_name     = input$analysis_file_name,
        return        = isTRUE(input$save_analysis_outputs),
        verbose       = TRUE
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
          Members  = paste(g[[sub_name]], collapse = " | "),
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

  # ── Dictionary & Pathways ──────────────────────────────────────────────────
  state$dictionary_msg <- "No run yet."
  state$dictionary    <- NULL

  current_dict_deconv <- reactive({
    src <- input$dict_deconv_source

    if (identical(src, "From Analysis tab")) {
      req(state$analysis)
      return(state$analysis)
    }

    req(input$dict_deconv_file)
    # Try to read as RDS (from Analysis tab) or CSV (fallback)
    tryCatch({
      readRDS(input$dict_deconv_file$datapath)
    }, error = function(e) {
      # Fallback to CSV - user must have manually saved the data
      list(
        "Deconvolution matrix" = read_expression_table(input$dict_deconv_file$datapath),
        "Deconvolution subgroups per cell types" = list(),
        "Deconvolution subgroups composition" = list()
      )
    })
  })

  current_dict_counts <- reactive({
    src <- input$dict_counts_source

    if (identical(src, "Example raw_counts")) {
      counts <- multideconv::raw_counts
    } else if (identical(src, "From Deconvolution tab")) {
      req(state$counts)
      counts <- state$counts
    } else {
      req(input$dict_counts_file)
      counts <- read_expression_table(input$dict_counts_file$datapath)
    }

    if (isTRUE(input$dict_normalize_tpm)) {
      if (requireNamespace("ADImpute", quietly = TRUE)) {
        counts <- ADImpute::NormalizeTPM(counts, log = FALSE)
      } else {
        # Simple TPM normalization fallback
        counts <- sweep(counts, 2, colSums(counts), "/") * 1e6
      }
    }

    counts
  })

  observeEvent(input$run_dict, {
    subgroups <- current_dict_deconv()
    expr      <- current_dict_counts()
    prev_files <- if (dir.exists(state$results_dir)) {
      list.files(state$results_dir, full.names = TRUE)
    } else {
      character(0)
    }

    state$dictionary_plot_files <- character(0)

    state$dictionary_msg <- "Running compute_deconvolution_dictionary..."

    dict_res <- tryCatch({
      multideconv::compute_deconvolution_dictionary(
        subgroups = subgroups,
        expr      = expr,
        pathways  = NULL,
        plot      = isTRUE(input$dict_plot_gsea)
      )
    }, error = function(e) e)

    if (inherits(dict_res, "error")) {
      state$dictionary_msg <- paste("Dictionary Error:", conditionMessage(dict_res))
      showNotification(state$dictionary_msg, type = "error", duration = 8)
      return()
    }

    state$dictionary <- dict_res
    state$dictionary_msg <- paste(
      "Dictionary completed.",
      "Features:", ncol(dict_res[["Deconvolution matrix"]])
    )
    showNotification("Deconvolution dictionary computed.", type = "message")

    # Optional: Run pathway analysis
    if (isTRUE(input$run_pathways)) {
      state$dictionary_msg <- paste(state$dictionary_msg, "\nRunning pathway analysis...")

      path_res <- tryCatch({
        multideconv::compute_subgroups_pathways(
          subgroups   = dict_res,
          counts_norm = expr,
          file_name   = input$dict_file_name,
          height      = as.numeric(input$pathway_height),
          width       = as.numeric(input$pathway_width),
          pval        = as.numeric(input$pathway_pval)
        )
      }, error = function(e) e)

      if (inherits(path_res, "error")) {
        state$dictionary_msg <- paste(state$dictionary_msg,
                                      "\nPathway analysis error:", conditionMessage(path_res))
        showNotification(paste("Pathway error:", conditionMessage(path_res)),
                        type = "warning", duration = 8)
      } else {
        state$dictionary_msg <- paste(state$dictionary_msg, "Pathway plots generated.")
        showNotification("Pathway analysis completed.", type = "message")
      }
    }

    state$dictionary_plot_files <- discover_dictionary_plot_files(
      results_dir = state$results_dir,
      file_name = input$dict_file_name,
      previous_files = prev_files
    )

    if (length(state$dictionary_plot_files)) {
      state$dictionary_msg <- paste(
        state$dictionary_msg,
        "\nPlot files detected:",
        length(state$dictionary_plot_files)
      )
    }
  })

  output$dict_status <- renderText(state$dictionary_msg)

  output$dict_preview <- renderTable({
    req(state$dictionary)
    mat <- as.data.frame(state$dictionary[["Deconvolution matrix"]])
    head(mat[, seq_len(min(8, ncol(mat))), drop = FALSE], 10)
  }, rownames = TRUE)

  output$dict_states <- renderText({
    req(state$dictionary)
    states <- state$dictionary[["States"]]
    if (is.null(states)) {
      return("No pathway states available.")
    }
    paste(
      "Pathway states detected:",
      "\n",
      paste(names(states), ":", sapply(states, length), "pathways each", collapse = "\n")
    )
  })

  output$dict_plots_ui <- renderUI({
    files <- state$dictionary_plot_files
    if (!length(files)) {
      return(tags$p(
        style = "margin: 0; color: #5f7d8a;",
        "No generated plot files detected yet. Run Dictionary with GSEA plots and/or pathway analysis enabled."
      ))
    }

    blocks <- lapply(files, function(f) {
      fname <- basename(f)
      ext <- tolower(tools::file_ext(fname))
      src <- paste0("results/", utils::URLencode(fname, reserved = TRUE))

      viewer <- if (ext %in% c("pdf")) {
        tags$iframe(
          src = src,
          style = "width:100%; height:560px; border:1px solid #cee0e8; border-radius:8px; background:#fff;"
        )
      } else if (ext %in% c("png", "jpg", "jpeg")) {
        tags$img(
          src = src,
          style = "max-width:100%; border:1px solid #cee0e8; border-radius:8px; padding:4px; background:#fff;"
        )
      } else {
        tags$p(
          style = "margin:0; color:#5f7d8a;",
          paste("Preview not available for", ext, "files.")
        )
      }

      tags$div(
        style = "margin-bottom:18px;",
        tags$div(
          style = "font-weight:600; margin: 0 0 8px 0;",
          fname,
          tags$span(style = "font-weight:400; margin-left:8px;", format(file.info(f)$mtime, "%Y-%m-%d %H:%M:%S"))
        ),
        tags$div(style = "margin-bottom:8px;", tags$a(href = src, target = "_blank", "Open in new tab")),
        viewer
      )
    })

    do.call(tagList, blocks)
  })

  output$download_dict_matrix <- downloadHandler(
    filename = function() {
      paste0("dictionary_matrix_", format(Sys.time(), "%Y%m%d_%H%M%S"), ".csv")
    },
    content = function(file) {
      req(state$dictionary)
      utils::write.csv(state$dictionary[["Deconvolution matrix"]], file = file, row.names = TRUE)
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
    deconv_mat  <- current_deconv_for_benchmark()
    gt          <- current_groundtruth()
    cells_extra <- parse_extra_cells(input$benchmark_cells_extra)

    state$benchmark_msg <- "Running compute.benchmark..."

    res <- tryCatch({
      multideconv::compute.benchmark(
        deconvolution = deconv_mat,
        groundtruth   = gt,
        cells_extra   = cells_extra,
        corr_type     = input$benchmark_corr_type,
        scatter       = FALSE,
        plot          = isTRUE(input$save_benchmark_plot),
        pval          = input$benchmark_pval,
        file_name     = input$benchmark_file_name
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
    long <- reshape2::melt(bm, id.vars = "CellType",
                           variable.name = "Combination", value.name = "Correlation")
    long$Correlation <- as.numeric(long$Correlation)

    ggplot2::ggplot(long, ggplot2::aes(x = CellType, y = Combination, fill = Correlation)) +
      ggplot2::geom_tile(colour = "white", linewidth = .4) +
      ggplot2::scale_fill_gradient2(
        low = "#2166AC", mid = "#F7F7F7", high = "#B2182B",
        midpoint = 0, limits = c(-1, 1)
      ) +
      ggplot2::theme_minimal(base_size = 12) +
      ggplot2::theme(
        axis.text.x    = ggplot2::element_text(angle = 50, hjust = 1, size = 10),
        axis.text.y    = ggplot2::element_text(size = 10),
        panel.grid     = ggplot2::element_blank(),
        plot.background = ggplot2::element_rect(fill = "white", colour = NA),
        legend.position = "right"
      ) +
      ggplot2::labs(x = NULL, y = NULL, fill = "Correlation")
  })
}

shinyApp(ui, server)
