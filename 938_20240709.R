library(ggplot2)
data(iris)

ggplot(data = iris, aes(x = Sepal.Length)) +
  geom_histogram(aes(y = ..density..), binwidth = 0.25, fill = "turquoise", color = "black") +
  geom_density(color = "red", size = 1) +
  labs(title = "Histogram of Sepal Length with Density Curve",
       x = "Sepal Length",
       y = "Density") +
  theme_minimal()

ggplot(data = iris, aes(x = Sepal.Length, y = Sepal.Width)) + 
  geom_point() +
  labs(title = "Scatter Plot of Sepal Length vs Sepal Width",
       x = "Sepal Length",
       y = "Sepal Width")


ggplot(data = iris, aes(x = Sepal.Length, y = Sepal.Width)) + 
  geom_point() +                               
  geom_smooth(method = "lm", col = "turquoise") +   
  labs(title = "Scatter Plot with Regression Line",
       x = "Sepal Length",
       y = "Sepal Width") +
  theme_minimal()    


iris_setosa <- subset(iris, Species == "setosa")
# Data frame for plotting
iris_setosa_long <- data.frame(
  Feature = rep(c("Sepal.Length", "Sepal.Width", "Petal.Length", "Petal.Width"), 
                each = nrow(iris_setosa)),
  Value = c(iris_setosa$Sepal.Length, iris_setosa$Sepal.Width, 
            iris_setosa$Petal.Length, iris_setosa$Petal.Width)
)

ggplot(data = iris_setosa_long, aes(x = Feature, y = Value)) +
  geom_boxplot(fill = "turquoise", color = "black") +
  labs(title = "Boxplots of Features for Setosa Species",
       x = "Feature",
       y = "Value") +
  theme_minimal()




