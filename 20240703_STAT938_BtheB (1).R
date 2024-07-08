library(HSAUR)
library(tidyverse) # For combining plots

data("BtheB", package = "HSAUR")

str(BtheB)

BtheB <- BtheB %>%
  mutate(row_id = row_number())

BtheB <- na.omit(BtheB)



# Reshape the data into long format using pivot_longer
BtheB_long <- BtheB %>%
  pivot_longer(cols = starts_with("bdi"), names_to = "time", values_to = "bdi")

BtheB_long$time <- c(rep(1:5,52))

BtheB_subset_TAU <- BtheB_long %>%
  filter(treatment == "TAU") %>%
  slice_head(n = 16*5)


BtheB_subset_notTAU <- BtheB_long %>%
  filter(treatment != "TAU") %>%
  slice_head(n = 16*5)

plot1 <- ggplot(BtheB_subset_TAU, aes(x = time, y = bdi)) +
  geom_line() + 
  ylim(0, 50) + 
  facet_wrap(~ row_id, scales = "fixed") +  # Facet by subject in a 4x4 grid with fixed scales
  labs(title = "Lattice Plot of BtheB Dataset (TAU Treatment)",
       x = "Time",
       y = "Measurement",
       subtitle = "First 16 TAU Treatment Subjects") +
  theme_minimal()

plot2 <- ggplot(BtheB_subset_notTAU, aes(x = time, y = bdi)) +
  geom_line() + 
  ylim(0, 50) + 
  facet_wrap(~ row_id, scales = "fixed") +  # Facet by subject in a 4x4 grid with fixed scales
  labs(title = "Lattice Plot of BtheB Dataset (BtheB Treatment)",
       x = "Time",
       y = "Measurement",
       subtitle = "First 16 BtheB Treatment Subjects") +
  theme_minimal()

# Combine plots using patchwork
combined_plot <- plot1 + plot2

# Display the combined plot
combined_plot
