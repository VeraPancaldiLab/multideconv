library(ggplot2)
library(hexSticker)
library(showtext)
library(sysfonts)

# Add a clean Google Font
font_add_google("Roboto Condensed", "roboto")
showtext_auto()

# --- Immune cell themed logo with funnel preprocessing concept ---
# Top: mixed immune cells (various shapes/colors) entering a funnel
# Bottom: clean separated cell types coming out

set.seed(42)

# Immune cell colors
col_tcell   <- "#276DC3"  # R blue - T cells
col_bcell   <- "#2CA02C"  # green - B cells
col_macro   <- "#D62728"  # red - Macrophages
col_nk      <- "#17BECF"  # teal - NK cells
col_dc      <- "#9467BD"  # purple - Dendritic cells
col_mono    <- "#FF7F0E"  # orange - Monocytes
col_funnel  <- "#8CBFEF"  # light blue funnel

# --- Top: scattered mixed immune cells (noisy, overlapping) ---
n_top <- 18
set.seed(123)
top_cells <- data.frame(
  x = runif(n_top, 0.15, 1.85),
  y = runif(n_top, 0.72, 0.95),
  size = runif(n_top, 2.5, 5),
  type = sample(c("T", "B", "Mac", "NK", "DC", "Mono"), n_top, replace = TRUE)
)

# Some cells have a "nucleus" dot to look cell-like
nucleus <- top_cells[sample(1:n_top, 8), ]
nucleus$size <- nucleus$size * 0.35

# --- Funnel shape (trapezoid made of polygon) ---
funnel <- data.frame(
  x = c(0.1, 1.9, 1.3, 0.7, 0.1),
  y = c(0.72, 0.72, 0.42, 0.42, 0.72)
)

# Funnel spout
spout <- data.frame(
  x = c(0.7, 1.3, 1.15, 0.85, 0.7),
  y = c(0.42, 0.42, 0.22, 0.22, 0.42)
)

# --- Bottom: clean separated immune cell types in a row ---
output_cells <- data.frame(
  x = c(0.35, 0.65, 1.0, 1.35, 1.65),
  y = c(0.1, 0.1, 0.1, 0.1, 0.1),
  size = c(4.5, 4.5, 4.5, 4.5, 4.5),
  type = c("T", "B", "Mac", "NK", "DC")
)

# Output nuclei
out_nucleus <- output_cells
out_nucleus$size <- out_nucleus$size * 0.35

cell_colors <- c(
  "T"    = col_tcell,
  "B"    = col_bcell,
  "Mac"  = col_macro,
  "NK"   = col_nk,
  "DC"   = col_dc,
  "Mono" = col_mono
)

# Small downward arrows between funnel exit and output
arrows_df <- data.frame(
  x = 1.0, xend = 1.0,
  y = 0.20, yend = 0.15
)

p <- ggplot() +
  # Funnel body
  geom_polygon(data = funnel, aes(x = x, y = y),
               fill = col_funnel, alpha = 0.2, color = col_funnel, linewidth = 0.8) +
  # Funnel spout
  geom_polygon(data = spout, aes(x = x, y = y),
               fill = col_funnel, alpha = 0.25, color = col_funnel, linewidth = 0.8) +
  # Top mixed cells (messy, overlapping)
  geom_point(data = top_cells, aes(x = x, y = y, color = type),
             size = top_cells$size, alpha = 0.55, show.legend = FALSE) +
  # Nuclei in top cells
  geom_point(data = nucleus, aes(x = x, y = y, color = type),
             size = nucleus$size, alpha = 0.9, show.legend = FALSE) +
  # Output clean cells
  geom_point(data = output_cells, aes(x = x, y = y, color = type),
             size = output_cells$size, alpha = 0.9, show.legend = FALSE) +
  # Output nuclei
  geom_point(data = out_nucleus, aes(x = x, y = y),
             size = out_nucleus$size, color = "white", alpha = 0.5, show.legend = FALSE) +
  # Small arrow
  geom_segment(data = arrows_df, aes(x = x, xend = xend, y = y, yend = yend),
               arrow = arrow(length = unit(0.08, "inches"), type = "closed"),
               linewidth = 0.8, color = "#BBDDFF") +
  scale_color_manual(values = cell_colors) +
  xlim(-0.05, 2.05) +
  ylim(0.0, 1.0) +
  theme_void() +
  theme(
    plot.background = element_rect(fill = "transparent", color = NA),
    panel.background = element_rect(fill = "transparent", color = NA)
  )

# Create hex sticker
sticker(
  subplot = p,
  package = "multideconv",
  # Package name settings
  p_size = 17,
  p_y = 1.52,
  p_color = "#FFFFFF",
  p_family = "roboto",
  p_fontface = "bold",
  # Subplot settings
  s_x = 1.0,
  s_y = 0.82,
  s_width = 1.7,
  s_height = 1.05,
  # Hex settings
  h_fill = "#1B3A5C",
  h_color = "#276DC3",
  h_size = 1.8,
  # No subtitle
  url = "",
  u_size = 0,
  u_color = "#8CBFEF",
  # Output
  filename = "man/figures/logo.png",
  dpi = 300
)

cat("Logo saved to man/figures/logo.png\n")
