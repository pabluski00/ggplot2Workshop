# Install and load necessary packages
install.packages("survival")
install.packages("survminer")
install.packages("ggplot2")

library(survival)
library(survminer)
library(ggplot2)
library(patchwork)

# Fitting Kaplan-Meier survival curve
fit <- survfit(Surv(time, status) ~ 1, data = lung)

surv_df <- data.frame(time = fit$time, surv = fit$surv)

# Kaplan-Meier survival curve using ggplot2
km_plot <- ggplot(data = surv_df, aes(x = time, y = surv)) +
  geom_step() +
  labs(title = "Kaplan-Meier Survival Curve for Lung Cancer",
       x = "Time (days)", y = "Survival Probability") +
  theme_minimal()

print(km_plot)


fit2 <- survfit(Surv(time, status) ~ 1, data = lung)

# Kaplan-Meier survival curve using survminer adn ggsurvplot
km_plot2 <- ggsurvplot(fit2,                     # Survival object
                      data = lung,             # Data containing survival information
                      pval = TRUE,             # Show p-values
                      conf.int = TRUE,         # Show confidence intervals
                      risk.table = TRUE,       # Show risk table
                      risk.table.title = "Risk Table",  # Risk table title
                      xlab = "Time (days)",    # X-axis label
                      ylab = "Survival probability",  # Y-axis label
                      title = "Kaplan-Meier Survival Curve for Lung Cancer",  # Plot title
                      legend.labs = c("Overall"),  # Legend label
                      legend.title = "Group",  # Legend title
                      palette = c("#E7B800"),  # Color palette
                      tables.theme = theme_cleantable(),  # Theme for risk table
                      surv.median.line = "hv",  # Median survival line style
                      tables.height = 0.2      # Height of risk table
)

print(km_plot2)
