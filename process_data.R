library(tidyverse)

chart_data <- billboard |>
	pivot_longer(
		cols = starts_with("wk"),
		names_to = "week",
		values_to = "rank"
	) |>
	mutate(week = readr::parse_number(week))

top_tracks <- chart_data |>
	group_by(track, artist) |>
	summarise(
		best_rank = min(rank, na.rm = TRUE),
		weeks_on_chart = sum(!is.na(rank)),
		.groups = "drop"
	) |>
	filter(weeks_on_chart >= 20) |>
	slice_min(best_rank, n = 8, with_ties = FALSE)

top_songs <- chart_data |>
	inner_join(top_tracks, by = c("track", "artist"))

write_rds(top_songs, file = "clean_data.rds")
