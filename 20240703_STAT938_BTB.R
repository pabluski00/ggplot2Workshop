library(ggplot2)
library(HSAUR)
library(tidyr)
library(dplyr)
install.packages("patchwork")
library(patchwork)

# Load the BtheB dataset
data("BtheB", package = "HSAUR")

BtheB <- na.omit(BtheB)

BtheB <- BtheB %>%
  mutate(id = row_number())



# Reshape to long format and clean up time variable
BtheB_long <- BtheB %>%
  pivot_longer(cols = starts_with("bdi"), 
               names_to = "time",
               values_to = "bdi_value") %>%
  mutate(time = gsub("bdi.", "", time))  # Clean up time variable


BtheB_long <- BtheB_long %>%
  mutate(id = as.numeric(as.character(id)))

# Now filter based on numeric conditions
BtheB_TAU<- BtheB_long %>%
  filter(treatment == "TAU")

BtheB_long_TAU <- BtheB_TAU %>%
  mutate(id = factor(id))

# Plotting spaghetti plot with ggplot2
plot1 <- ggplot(BtheB_long_TAU, aes(x = time, y = bdi_value, group = id, color = id)) +
  geom_line() +
  labs(title = "Spaghetti Plot of BDI Scores Over Time (TAU)",
       x = "Time (months)",
       y = "BDI Score",
       color = "Patient ID") +
  theme_minimal()




# Now filter based on numeric conditions
BtheB_notTAU<- BtheB_long %>%
  filter(treatment != "TAU")

BtheB_long_notTAU <- BtheB_notTAU %>%
  mutate(id = factor(id))

# Plotting spaghetti plot with ggplot2
plot2 <- ggplot(BtheB_long_notTAU, aes(x = time, y = bdi_value, group = id, color = id)) +
  geom_line() +
  labs(title = "Spaghetti Plot of BDI Scores Over Time (BtheB)",
       x = "Time (months)",
       y = "BDI Score",
       color = "Patient ID") +
  theme_minimal()

combined_plot <- plot1 + plot2

# Display the combined plot
combined_plot
