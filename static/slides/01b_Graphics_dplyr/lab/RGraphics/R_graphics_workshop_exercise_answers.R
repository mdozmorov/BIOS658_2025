# R Graphics workshop answers to exercises

# 1. Load the Cars93 dataset. It's in the MASS library. How many observations and variables does it have?
library(MASS)
data(Cars93)
str(Cars93)

# 2. Create two boxplots: MPG city versus Origin and MPG highway versus Origin. 
#    Put them side-by-side in the same graphing window and make sure you can identify each.
#    Also, identify any outliers.

par(mfrow=c(1,2))

boxplot(MPG.city ~ Origin, data=Cars93, main="MPG.city ~ Origin")
hmpg <- identify(Cars93$Origin, Cars93$MPG.city)
Cars93[hmpg,c("Model","MPG.city","Origin")]

boxplot(MPG.highway ~ Origin, data=Cars93, main="MPG.highway ~ Origin")
hmpg <- identify(Cars93$Origin, Cars93$MPG.highway)
Cars93[hmpg,c("Model","MPG.highway","Origin")]

# 3. Create two scatterplots: MPG city (y axis) versus Weight (x axis)
#    Put them side-by-side in the same graphing window and make sure you can identify each.

plot(MPG.city ~ Weight, data=Cars93, main="MPG.city ~ Weight")
plot(MPG.highway ~ Weight, data=Cars93, main="MPG.highway ~ Weight")

# 4. create a scatterplot using ggplot2 with MPG city on the y axis, weight on the x axis, and the 
#    dots colored by Origin

library(ggplot2)
sp1 <- ggplot(Cars93, aes(x=Weight,y=MPG.city,color=Origin)) 
sp1 + geom_point() 

# 5. repeat #4, but this time include a smooth trend line through the points 
#    without a shaded confidence interval

sp1 + geom_point() + geom_smooth(se=FALSE)

# 6. create a boxplot using ggplot2 for Price versus Cylinders

sp2 <- ggplot(Cars93, aes(x=Cylinders, y=Price))
sp2 + geom_boxplot()

# 7. add the title "Price vs. Cylinders" to the graph created in #6

sp2 + geom_boxplot() + ggtitle("Price vs. Cylinders")

# 8. create a scatterplot of MPG highway (y-axis) versus weight (x-axis), 
#    fit a linear model where MPG is regressed on Weight,
#    and then add the fitted line to the plot.

par(mfrow=c(1,1))
plot(MPG.highway~Weight, data=Cars93)
mod1 <- lm(MPG.highway~Weight, data=Cars93)
abline(mod1)

# 9. In #8 it appears a curved line may provide a better fit to the data.
#    Fit the same model again but with the extra predictor I(Weight^2).
#    (The I() function means treat Weight^2 "as is". That is, actually square it.
#    Then add the fitted line to the plot from #8 so you can see both lines. 
#    Make the new line blue.

mod2 <- lm(MPG.highway~Weight+I(Weight^2), data=Cars93)
# predict values; sort the predictors to help us draw the line
yhat <- predict(mod2, newdata = data.frame(Weight = sort(Cars93$Weight)))
lines(sort(Cars93$Weight), yhat, col="blue")

# test if extra predictor is significant; Null: both models the same
anova(mod1, mod2) 
# low p-value suggests we keep the extra predictor in the model


