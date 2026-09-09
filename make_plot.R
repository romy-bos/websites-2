library(tidyverse)

top_songs <- read_rds("clean_data.rds")

billboard_plot <- top_songs |>
  ggplot(aes(x = week, y = rank, group = track, color = best_rank)) +
  geom_line(linewidth = 1.2, alpha = 0.85) +
  geom_point(size = 1.8, alpha = 0.9) +
  facet_wrap(~ fct_reorder(track, best_rank), ncol = 2) +
  scale_y_reverse(breaks = c(1, 25, 50, 75, 100)) +
  scale_color_viridis_c(option = "magma", direction = -1) +
  labs(
    title = "The climb to number one",
    subtitle = "Weekly Billboard rank for eight enduring hits in 2000",
    x = "Week on the chart",
    y = "Billboard rank",
    color = "Best rank"
  ) +
  theme_minimal(base_size = 12) +
  theme(
    plot.title = element_text(face = "bold", size = 20),
    plot.subtitle = element_text(color = "grey40"),
    strip.text = element_text(face = "bold"),
    panel.grid.minor = element_blank(),
    legend.position = "bottom"
  )

ggsave(
  "billboard.png",
  plot = billboard_plot,
  width = 10,
  height = 8,
  dpi = 300
)
