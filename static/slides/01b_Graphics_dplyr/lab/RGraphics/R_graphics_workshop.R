# Getting Started with R Graphics
# Amanda Gentry and Mikhail Dozmorov, Ph.D.
# With materials borrowed from Clay Ford, StatLab@UVa Library

# In Review:
# Helpful R Studio commands -----------------------------------------------

# Description       Windows & Linux       Mac 
# ----------------------------------------------------------------
# Run current line  Ctrl+Enter            Command+Enter
# Previous plot 	  Ctrl+Shift+PageUp     Command+Shift+PageUp 
# Next plot 	      Ctrl+Shift+PageDown 	Command+Shift+PageDown 


# Packages ----------------------------------------------------------------

# we'll use the following packages today.
# only submit these lines if you don't already have them installed. 
install.packages("ggplot2")
install.packages("RColorBrewer")
install.packages("googleVis")
install.packages("likert")
# load the libraries
library(ggplot2)
library(RColorBrewer)
library(googleVis)
library(likert)

# R Graphics Framework ----------------------------------------------------

# Today we'll use data that come with R (see datasets package); 
# airquality data:
# Daily air quality measurements in New York, May to September 1973.
head(airquality)

# three types of plotting functions:

# (1) High-level plotting - create the graphic
# create a scatterplot (High-level plot)
plot(x=airquality$Temp, y=airquality$Ozone)

# (2) Low-level plotting - add extra information to the current plot
points(x=mean(airquality$Temp,na.rm=T),
       y=mean(airquality$Ozone,na.rm=T),
       pch=19,col="red")

# (3) interactive plotting - add/extract information
# label point(s) you click (default is row number)
identify(x=airquality$Temp,y=airquality$Ozone) 
# This enters interactive mode - no other code may be run until you
# exit interactive mode with the Esc key. After you exit, the points
# you clicked will be labeled on the plot and will appear in the console

# show one single coordinate of where I click (extract information)
locator(1) 
# add a point or line (add and extract information)
locator(1, type="p")
locator(3, type="o")

# Play around with these commands to see what happens!
# To "reset" your plot, run (1) and (2) again, from above
# to create a fresh plot

# Using Graphics Parameters
# Use the par() function to access and modify the list of graphics parameters
# for the current graphics device.
# The "graphics device" is usually the window your graphic appears in.

par() # see all graphics parameters
help(par) # see what the parameters mean

# common graphics parameter to set: mfrow (multi-frame row);
# allows you to plot more than one graph in window;
# set this OUTSIDE of plotting functions;
par("mfrow") # see current setting; 1 x 1 plotting area
par(mfrow = c(1, 2)) # set to 1 row x 2 columns (ie, 2 graphs side-by-side)

# plot histograms of Temp and Ozone (high-level plots)
hist(airquality$Temp)
hist(airquality$Ozone)

# now go up and re-do the scatter plot and see what happens.
# notice the mfrow setting persists;
# need to reset it.
par(mfrow = c(1, 1)) # set to 1 x 1 (ie, the default)
# Or just close the graphics device; that restores all par() defaults;
# "clear all" button in R Studio

# some par() settings can be set INSIDE plotting functions
hist(airquality$Temp)
# change the size of the title; 
# cex.main is a graphics parameter, not an argument for hist()
hist(airquality$Temp, cex.main=1.5) # active during the execution of the function only
par("cex.main") # see current setting; still set to 1.2

# R Graphics parameters...
# some parameters can only be set by a call to par() (example: mfrow)
# others can be set as arguments to high-level plotting functions (example: cex.main)

### Remember, if there's something specific you want to do with your graph,
# Google it and you will usually find lots of help!
# stackoverflow.com is a coding and developers forum, often, you will find
# that someone has asked your same question and coding gurus will offer a
# variety of solutions


# Common graphs in R ------------------------------------------------------


# --- SCATTER PLOT --- # 
# use data that comes with R 
# iris: measurements of sepal length and width and petal length and width
# from each of 3 species of iris

head(iris)
str(iris)

# basic scatter plot
plot(iris$Petal.Width, iris$Petal.Length)

# typing name of data before each variable gets tedious;
# can use "formula" notation with plot (y ~ x)
plot(Petal.Length ~ Petal.Width, data=iris)

# let's customize the plot using arguments
# with title and labels and blue dots
plot(Petal.Length ~ Petal.Width, data=iris,
     main="Petal Length vs. Petal Width\nIris Dataset",
     xlab="Petal Length", ylab="Petal Width",
     pch=20, col="blue",
     ylim=c(0,7), xlim=c(0,2.5))

# pch = plotting character; to see what first 25 look like
plot(1:25, pch=1:25)
# 26:31 - unused (and ignored).
# 32:127 - ASCII characters.

# scatter plot by Species
# col = Species
plot(Petal.Length ~ Petal.Width, data=iris, 
     main="Petal Length vs. Petal Width\nIris Dataset",
     xlab="Petal Length", ylab="Petal Width", 
     pch=20, col=Species,
     ylim=c(0,7), xlim=c(0,2.5))

# color codes mapped to palette
palette()

# see available colors (657!)
colors() 
# View this helpful visual that shows each color available in R with its
# corresponding name and number
# http://research.stowers.org/mcm/efg/R/Color/Chart/ColorChart.pdf

# The name of a color can be found by referencing it's number
colors()[555]
# And the number of a color may be found by referencing its name
which(colors() == "red3")

# See the default palette that R will use
palette()
# customze your palette
palette(c("gray20","gray40","gray60"))
palette()

# scatter plot by Species - grayscale
plot(Petal.Length ~ Petal.Width, data=iris, 
     main="Petal Length vs. Petal Width\nIris Dataset",
     xlab="Petal Length", ylab="Petal Width", 
     pch=20, col=Species,
     ylim=c(0,7), xlim=c(0,2.5))

# add legend with a low-level legend() function
legend(x="topleft",legend=levels(iris$Species), pch=20,
       col=1:3)

# In legend can also set x = bottomright", "bottom", "bottomleft", 
# "left", "top", "topright", "right", "center".

palette("default") # restore color palette to default

# For more helpful information about colors and palettes, see
# http://data.library.virginia.edu/setting-up-color-palettes-in-r/

# --- HISTOGRAM/DENSITY PLOT --- #

# visualize distribution of continuous data

# use faithful data set; Waiting time between eruptions and the duration of the
# eruption for the Old Faithful geyser in Yellowstone National Park.
hist(faithful$eruptions) # length of eruptions in mins
hist(faithful$eruptions, breaks=20)

# add a rug (low-level function)
# draw data on x axis as small vertical lines
rug(faithful$eruptions)

# add points to identify mean and median
# cex=2 means 2 times bigger than the default
points(x = mean(faithful$eruptions), y = 0,
       pch=19, col="blue", cex=2) 
points(x = median(faithful$eruptions), y = 0,
       pch=19, col="red", cex=2)

# save hist() output values; add counts to histogram
sh <- hist(faithful$eruptions, breaks=20, main="Distribution of Old Faithful Eruptions")
sh
# the text function adds text to a graph
# the labels argument specifies the text
text(x=sh$mids, y=sh$counts+1, labels=sh$counts, col = "blue3")


# plot proportions (ie, a true histogram) with freq=FALSE
hist(faithful$eruptions, breaks=20, freq=FALSE, 
     main="Distribution of Old Faithful Eruptions", 
     xlab="Eruption time in mins")
# add kernel density estimate (ie, smooth line)
lines(density(faithful$eruptions))
# adjust the bandwidth if you want
lines(density(faithful$eruptions, adjust = 0.5), col="red") # more wiggly
lines(density(faithful$eruptions, adjust = 0.25), col="blue") # even more wiggly
lines(density(faithful$eruptions, adjust = 1.25), col="orange") # less wiggly
# add a legend
legend(x = 2.5, y=0.7,legend = c(0.25, 0.5, 1, 1.25), 
       col = c("blue", "red", "black", "orange"), lty=1, 
       title = "bandwidth", cex=0.8)

# --- BOX PLOT --- #

# distribution of numeric values by groups

boxplot(Sepal.Length ~ Species, data=iris) 

# with a "notch" and y label
boxplot(Sepal.Length ~ Species, data=iris, ylab="Petal Width (cm)",
        notch = TRUE)
# if notch is TRUE, a notch is drawn in each side of the boxes. 
# If the notches of two plots do not overlap this is 'strong evidence' 
# that the two medians differ

# an extended graphics example...
# make boxes narrower, add scale for inches on right, and add point for mean;

# first set margins using par(); need more space on right side;
# mar = number of lines of margin to be specified (bot, left, top, right);
# simulateously set new, and save old, par settings
par("mar")
op <- par(mar=c(5.1, 4.1, 4.1, 5.1))
op # old settings saved as "op"
par("mar") # current settings
boxplot(Sepal.Length ~ Species, data=iris, ylab="Sepal Length (cm)", 
        xlab="Species",
        main="Sepal Length by Species",
        boxwex = 0.25, # make boxes thinner
        col="gray")

# add axis for inches using low-level axis() function
# first create "pretty breakpoints"
# multiply by 0.393701 to convert cm to inches 
wdInches <- pretty(range(iris$Sepal.Length*0.393701))
wdInches
# now add axis: 4=right side, at=where to place tick marks,
# lab=what to put on the axis
axis(side=4, at=wdInches/0.393701, lab=wdInches) 

# finally add axis label using low-level mtext() function
mtext("Sepal Length (in)", side=4, line=3)

# add means to box plot using low-level points() function
meanWidth <- aggregate(Sepal.Length ~ Species, data=iris, mean)
meanWidth
points(1:3, meanWidth[,2], pch=18)

# to restore to original settings, call par on "op" object we created earlier:
par(op)
# verify settings restored
par("mar")



# -- STRIPCHART --- #

# one dimensional scatter plots; good alternative to boxplots when data is small
# Data: experiment to measure effectiveness of feed supplements on growth rate
# of chickens
head(chickwts)
stripchart(weight ~ feed, data=chickwts)

# add jitter (a small amount of "noise")
stripchart(weight ~ feed, data=chickwts, method="jitter")

# rotate and change dots
stripchart(weight ~ feed, data=chickwts, method="jitter", 
           vertical=TRUE, pch=1, col="grey60", 
           main="Chick Weight by Feed")

# add mean with standard error bars
# calculate mean for each group
# tapply: (1) the measure (2) the grouping variable (3) the statistic
meanWeight <- tapply(chickwts$weight, chickwts$feed, mean) 
# calculate SE for each grpup
seWeight <- tapply(chickwts$weight, chickwts$feed, 
                   function(x)sd(x)/sqrt(length(x))) 

# add mean to graph with low-level points() function
points(1:6,meanWeight,pch=16)
# add 2x SE bars to graph with low-level segments() function;
# draws line from (x0,y0) to (x1,y1)
segments(x0=1:6, y0=meanWeight-2*seWeight,
         x1=1:6, y1=meanWeight+2*seWeight)


# --- BAR CHART/BAR GRAPH --- #

# often used for graphing counts

library(MASS) # has a dataset I want to use
head(Cars93) # Data from 93 Cars on Sale in the USA in 1993

# bar graph of counts of Car Type
Cars93$Type
table(Cars93$Type)

# barplot()
# first argument: vector or matrix of values
barplot(table(Cars93$Type)) 

# save table
types <- table(Cars93$Type)

# change y axis limits
barplot(types, ylim=c(0,25)) 
# draw a box around the plot and add title
box(which="plot")
title("Counts of Car Type")

# let's include Origin in our graph
table(Cars93$Origin, Cars93$Type)
types2 <- table(Cars93$Origin, Cars93$Type)

barplot(types2, beside=TRUE) # adjacent

# barplot has built-in legend argument
# add legend, make y axis go to 20, set colors
barplot(types2, beside = TRUE, 
        legend=levels(Cars93$Origin),
        ylim=c(0,20), xlab="number of cars",
        main="Counts of Car Type by Origin", col=c(4,8))


# --- DOT CHART --- #

# aka, Cleveland's dot chart
# some people prefer these to bar charts

# first argument: either a vector or matrix of numeric values
# again we'll use the Cars93 dataset
summary(Cars93$Type)
# dotchart doesn't work on tables 
dotchart(summary(Cars93$Type)) 
# add labels and sort by count
dotchart(sort(summary(Cars93$Type)),
         pch=16, main="Counts of  Car Type",
         xlim=c(0,25))


# --- PIE CHARTS --- #

help(pie)
# from the help file: 
# "Pie charts are a very bad way of displaying information. 
# The eye is good at judging linear measures and bad at judging relative areas. 
# A bar chart or dot chart is a preferable way of displaying this type of data."


# --- TIME SERIES PLOT --- #

# back to airquality data
head(airquality)
# need to wrangle month and day columns into a single vector of dates;
# life is easier in R if date is formatted as YYYY-MM-DD
date <- paste("1973", airquality$Month, airquality$Day, sep="-")
head(date)
# convert date to Date object and add to airquality data frame
airquality$date  <- as.Date(date)
head(airquality)
str(airquality)
# basic time series plot
plot(Temp ~ date, data=airquality, type="l")
plot(Temp ~ date, data=airquality, type="b")
plot(Temp ~ date, data=airquality, type="b", pch=20)
plot(Temp ~ date, data=airquality, type="o", pch=20)



# --- LINE GRAPH --- #

# Pharmacokinetics of Indomethacin (6 subjects)
# time: a numeric vector of times at which blood samples were drawn (hr).
# conc: a numeric vector of plasma concentrations of indomethacin (mcg/ml).
head(Indometh, n=12)

# plot conc over time by subject
# type="l" means plot a line
plot(conc ~ time, data=Indometh, type="l") # not what we want!

# let's subset for subject 1
plot(conc ~ time, data=Indometh, subset= Subject==1, type="l")
# and now add other subjects...
# ALERT! Notice the the lines exceed the y axis!
lines(conc ~ time, data=Indometh, subset= Subject==2, type="l", col=2)
lines(conc ~ time, data=Indometh, subset= Subject==3, type="l", col=3)
lines(conc ~ time, data=Indometh, subset= Subject==4, type="l", col=4)
lines(conc ~ time, data=Indometh, subset= Subject==5, type="l", col=5)
lines(conc ~ time, data=Indometh, subset= Subject==6, type="l", col=6)


# let's fix the y axis and work smarter, not harder
plot(conc ~ time, data=Indometh, subset= Subject==1, type="l", 
     ylim=range(conc), main="Concentrations over Time by Subject")
for(i in 2:6){
  lines(conc ~ time, data=Indometh, subset= Subject==i, type="l", col=i)
}

# add a legend
legend("topright",legend=unique(Indometh$Subject),lty=1, 
       col=1:6, title="Subjects")
# Notice that the legend location may be specified using keywords
# or (x,y) coordinates

# we can work even smarter using ggplot! (coming up shortly)



# Saving R graphics -------------------------------------------------------

# R graphs can be saved multiple ways.
# In R Studio: Export...Save as Image...
# In R GUI: File...Save as...
# Available formats include PNG, TIF, JPG, PDF, BMP, EPS

# can also use code to save graphic files; 
# useful for automating creation of lots of graphs

# first issue the command; "opens" a graphing device; nothing visible happens
# file will be saved in working directory
# functions include png(), jpeg(), bmp(), tiff()
png(file = "iris1.png")
# then issue plotting commands; notice it doesn't appear in R Studio window
stripchart(Petal.Width ~ Species, data=iris, method="jitter")
# then 
dev.off()

# Example: create and save stripcharts of all iris measurements in your working
# directory
for(i in 1:4){
  png(file = paste0("sc",names(iris)[i],".png"))
  stripchart(iris[,i] ~ Species, data=iris, method="jitter", main=names(iris)[i])
  dev.off()
}

# clean up workspace
rm(list = ls())

# ggplot2 -----------------------------------------------------------------

# install.packages("ggplot2") # if you don't aready have
library(ggplot2)

# --- SCATTER PLOT --- #
ggplot(iris, aes(x = Petal.Width, y = Petal.Length)) + 
  geom_point() 

# scatter plot by group
# add color=Species to aes()
ggplot(iris, aes(x = Petal.Width, y = Petal.Length, color=Species)) + 
  geom_point() 

# add shape=Species to aes()
ggplot(iris, aes(x = Petal.Width, y = Petal.Length, shape=Species)) + 
  geom_point() 

# shape and color
ggplot(iris, aes(x = Petal.Width, y = Petal.Length, 
                 shape=Species, color=Species)) + 
  geom_point() 

# mapping species to color and shape and making points bigger and jittered
ggplot(iris, aes(x = Petal.Width, y = Petal.Length, 
                 color=Species, shape=Species)) + 
  geom_point(size=3, position = "jitter") 

# mapping species to color and Sepal.Length to size
# balloon scatter plot
ggplot(iris, aes(x = Petal.Width, y = Petal.Length, 
                 color=Species, size=Sepal.Length)) + 
  geom_point(position = "jitter") 

# fix the labels and add a title
ggplot(iris, aes(x = Petal.Width, y = Petal.Length, 
                 color=Species, size=Sepal.Length)) + 
  geom_point(position = "jitter") +
  labs(y="Petal Length (cm)", x= "Petal Width (cm)", 
       size="Sepal Length", title="Iris Balloon Plot")

# adding fitted regression lines with CI and save
p <- ggplot(iris, aes(x = Petal.Width, y = Petal.Length, color=Species)) + 
  geom_point() +
  geom_smooth(method="lm") + 
  ggtitle("Petals of the Iris data set") 
p  

# "zoom in" on plot with coord_cartesian()
# This is especially useful when you need to use one scale to show the
# comparison between groups but would like to also zoom in on a particular
# region of interest
p + coord_cartesian(xlim=c(0,0.75), ylim = c(0, 2))


# --- BOX PLOT --- #
ggplot(iris, aes(x=Species, y=Petal.Width)) +
  geom_boxplot()

# skinnier box plot with mean included
ggplot(iris, aes(x=Species, y=Petal.Width)) +
  geom_boxplot(width=0.5) +
  stat_summary(fun.y = mean, geom="point", color="red")


# --- STRIP CHART --- #

ggplot(chickwts, aes(x=feed, y=weight)) + 
  geom_point()

# add the jitter so that the points are distinguishable from one another
ggplot(chickwts, aes(x=feed, y=weight)) + 
  geom_point(position = position_jitter(w = 0.1, h = 0))

# with confidence limits
# first need to calculate means and standard errors
fMean <- tapply(chickwts$weight, chickwts$feed, mean)
fSE <- tapply(chickwts$weight, chickwts$feed, function(x) sd(x)/sqrt(length(x)))
# now create data frame; recall that ggplot requires data frame
chick2 <- data.frame(feed=names(fMean), fMean, fSE)

# now plot strip chart and error bars
# notice we call two data frames
ggplot(chickwts, aes(x=feed, y=weight)) + 
  geom_point(position = position_jitter(w = 0.1, h = 0)) +
  geom_point(aes(x=feed, y=fMean), data=chick2, color="red", size=3) +
  geom_errorbar(aes(x=feed, y=fMean, ymin=fMean - 2*fSE, ymax=fMean + 2*fSE), 
                data=chick2, width=0.1)


# --- DOT PLOT --- #
# cleveland dot plot
# use state.x77 data; it's a matrix, so need to convert to data frame
state.x77
class(state.x77)
states <- data.frame(state=rownames(state.x77),state.x77, row.names = NULL)
head(states)

# population dot plot
ggplot(states, aes(x=Population, y=state)) +
  geom_point()

# in order of population
ggplot(states, aes(x=Population, y=reorder(state, Population))) +
  geom_point(size=3) +
  ylab("State") +
  ggtitle("Population of US States in 1975")

# area dot plot
ggplot(states, aes(x=Area, y=reorder(state, Area))) +
  geom_point() +
  ylab("State") +
  ggtitle("Land Area of US States") 

# fix the x-axis tick marks
library(scales) # for comma() function
ggplot(states, aes(x=Area, y=reorder(state, Area))) +
  geom_point() +
  scale_x_continuous(breaks=pretty(range(states$Area)), 
                     labels=comma(pretty(range(states$Area)))) +
  ylab("State") +
  xlab("Area (sq miles)") + 
  ggtitle("Land Area of US States") 


# --- HISTOGRAM --- #
ggplot(faithful, aes(x=eruptions)) +
  geom_histogram()
# note the warnings; developer firmly believes you should not accept default
# binwidth. use the binwdith argument to change

# with different color bars
ggplot(faithful, aes(x=eruptions)) +
  geom_histogram(fill="white", color="black", binwidth=0.1) 

# "true" histogram - density instead of counts
# ..density.. refers to a variable generated by geom_histogram
ggplot(faithful, aes(x=eruptions, y = ..density..)) +
  geom_histogram()

# with a density curve
ggplot(faithful, aes(x=eruptions, y = ..density..)) +
  geom_histogram(fill="white", color="black", binwidth=0.1) +
  geom_density(adjust=0.5)

# mapping bin counts to color of histogram
# ..count.. refers to a variable generated by geom_histogram
ggplot(faithful, aes(x=eruptions, fill = ..count..)) +
  geom_histogram(binwidth=0.2)

# back to iris data
# in groups (vertical facet)
ggplot(iris, aes(x=Petal.Length)) +
  geom_histogram(binwidth=0.2) +
  facet_grid(Species ~ .) # vertical ~ horizontal

# in groups (horizontal facet)
ggplot(iris, aes(x=Petal.Length)) +
  geom_histogram(binwidth=0.2) +
  facet_grid(. ~ Species) 

# overlayed histograms with transparency
ggplot(iris, aes(x=Petal.Length, fill=Species)) +
  geom_histogram(position="identity", alpha=0.4, binwidth=.1) 
# position="identity" needed for overlapping; without they get stacked;
# alpha = transparency setting

# --- VIOLIN PLOT --- # 
# compare multiple data distributions
ggplot(iris, aes(x=Species, y=Petal.Length)) + 
  geom_violin()

# violin plot with boxplot
ggplot(iris, aes(x=Species, y=Petal.Length)) + 
  geom_violin() +
  geom_boxplot(width=0.1)


# --- LINE GRAPH --- # 
names(Indometh)
# recall how we did this above with a loop
ggplot(Indometh, aes(x=time,y=conc, group=Subject)) +
  geom_line()

# with color
ggplot(Indometh, aes(x=time,y=conc,group=Subject, color=Subject)) +
  geom_line()

# put legend in numeric order
ggplot(Indometh, aes(x=time,y=conc,group=Subject, color=Subject)) +
  geom_line() +
  scale_color_discrete(limits=1:6)

# single line graph of means at each time point with SE bars
# first calculate means and SEs
tMean <- tapply(Indometh$conc, Indometh$time, mean)
tSE <- tapply(Indometh$conc, Indometh$time, function(x)sd(x)/sqrt(length(x)))

# ggplot requires data in data frame
Indo2 <- data.frame(time=unique(Indometh$time), tMean, tSE)

# now ready to create plot
ggplot(Indo2, aes(x=time,y=tMean)) +
  geom_line() +
  geom_point(size=2) +
  geom_errorbar(aes(ymin=tMean-2*tSE, ymax=tMean+2*tSE), width=0.2)


# --- BAR GRAPH --- # 
ggplot(mtcars, aes(x=factor(cyl))) + 
  geom_bar()

# by group Transmission - stacked  (0 = automatic, 1 = manual)
ggplot(mtcars, aes(x=factor(cyl), fill=factor(am))) + 
  geom_bar()

# by group (transmission) - dodged (side-by-side)
ggplot(mtcars, aes(x=factor(cyl), fill=factor(am))) + 
  geom_bar(position="dodge", alpha=0.5) +
  scale_fill_discrete(labels=c("automatic", "manual")) +
  labs(fill="Transmission") +
  xlab("Cylinder")

# by group (transmission) - dodged, with different color
# and fix the y axis so it only displays whole numbers
ggplot(mtcars, aes(x=factor(cyl), fill=factor(am))) + 
  geom_bar(position="dodge") +
  scale_y_discrete(breaks=seq(0,14,2)) +
  scale_fill_brewer(palette="Paired", labels=c("automatic", "manual")) +
  labs(fill="Transmission") +
  xlab("Cylinder")


# help(RColorBrewer) for different palettes 

# others to try: 
# SEQUENTIAL PALETTES (suited to ordered data that progress from low to high): 
# Blues BuGn BuPu GnBu Greens Greys Oranges OrRd PuBu PuBuGn PuRd Purples RdPu
# Reds YlGn YlGnBu YlOrBr YlOrRd

# DIVERGING PALETTES (equal emphasis on mid-range critical values and extremes):
# BrBG PiYG PRGn PuOr RdBu RdGy RdYlBu RdYlGn Spectral

# QUALITATIVE PALETTES (used to create the primary visual differences between classes):
# Accent Dark2 Paired Pastel1 Pastel2 Set1 Set2 Set3

# See the online help for ggplot2; full of examples
# Electronic version of R Graphics Cookbook available from UVa Library

# tidy up before moving on
rm(list=ls())



# Plotting functions in packages ------------------------------------------

# many R packages include special plotting functions.
# these are usually functions that do much of the plotting customization for you.

# Example: the likert package
# Functions to analyze and visualize likert type items

# install.packages("likert") # if you don't aready have 
library(likert)

# let's use data that comes with the likert package:
# North American (i.e. Canada, Mexico, and United States) results from the 
# 2009 Programme of International Student Assessment 
data(pisaitems) # load data into workspace
names(pisaitems)
head(pisaitems)
str(pisaitems) # all factors

# grab a subset of data: all questions that contain "ST25Q"
read <- subset(pisaitems, select = substr(names(pisaitems), 1,5) == 'ST25Q')

head(read); dim(read)
names(read) <- c("Magazines", "Comic books", "Fiction",
                    "Non-fiction books", "Newspapers")
head(read)
lread <- likert(read) # provides various statistics about a set of likert items
lread # percents sum to 100 for each row
class(lread) # "likert" object
plot(lread)
plot(lread, type="density")
plot(lread, type="heat")

# see plot methods for R objects; notice plot.likert
methods(plot) # notice plot.likert
help(plot.likert)

# Example: googleVis package 
# allows users to create web pages with interactive charts based on R data frames

# install.packages("googleVis")
library(googleVis)
# map of hurrican sandy
# data source: http://www.wunderground.com/hurricane/atlantic/2012/Post-Tropical-Cyclone-Sandy
# copied and pasted table into Excel, saved as CSV
sandy <- read.csv(file="http://static.lib.virginia.edu/statlab/materials/workshops/R_Graphics/sandy.csv", 
                  header=T)
sandy$LatLong <- paste(sandy$Lat,sandy$Lon,sep=":")
sandy$Tip <- paste(sandy$Date,sandy$Storm.Type)
head(sandy)
sandyMap <- gvisMap(sandy, locationvar="LatLong" , tipvar="Tip",
                    options=list(showTip=TRUE, showLine=TRUE, enableScrollWheel=TRUE,
                           mapType='hybrid', useMapTypeControl=TRUE,
                           width=800,height=400))
plot(sandyMap)


# BEGIN TIME-PERMITTING BONUS MATERIAL!


# dynamite plunger plots (or detonator plots) -----------------------------

# comparing means with SE bars
# some people frown on these; does not convey distribution of data
# generate some data
set.seed(5)
a <- rchisq(100,df=2)
b <- rnorm(100,mean=2)
# create a bar plot of the means
bplt <- barplot(c(mean(a),mean(b)), ylim=c(0,3),names.arg=c("a","b"))
bplt
# calculate standard errors of a and b
se.a <- sd(a)/sqrt(100)
se.b <- sd(b)/sqrt(100)
# add standard error bars to barplot
# draw lines from (xo,y0) to (x1,y1)
arrows(x0=bplt,y0=c(mean(a),mean(b))-2*c(se.a,se.b),
       y1=c(mean(a),mean(b))+2*c(se.a,se.b),
       code=3,angle=90)
# compare a and b with boxplots
par(mfrow=c(1,2))
boxplot(a,xlab="a",ylim=c(min(a,b),max(a,b)))
boxplot(b,xlab="b",ylim=c(min(a,b),max(a,b)))


# polygon function --------------------------------------------------------


# draws a shape; the first two arguments are the x and y coordinates of a closed
# figure. It is assumed that the polygon is to be closed by joining the last
# point to the first point.

# create a blank plotting window
plot(x=c(1,10), y=c(1,10), type="n", xlab="", ylab="", axes = FALSE)
ticks  <- 1:10 # define tick marks
axis(side = 1, at = ticks) # plot tick marks on x axis (bottom)
axis(side = 2, at = ticks) # plot tick marks on y axis (left)
box(which="plot") # draw a box around the plot

# now draw a box in the plotting area
# points at (2,2), (3,2), (3,3), (2,3) 
polygon(x=c(2,3,3,2),y=c(2,2,3,3),col="grey")
points(x=c(2,3,3,2),y=c(2,2,3,3), pch=16)

# can be used for shading areas under a curve
# plot a standard normal curve
x <- seq(-3,3,by=0.01)
y <- dnorm(x)
plot(x,y, type="l")
# shade bottom 5% of curve, i.e., P(Z < -1.64)
bot <- seq(-3,qnorm(0.05),length=30) # x values for polygon
top <- dnorm(bot) # y values for polygon
# recall: polygon() joins last point to the first point;
# need to add two extra points that sit on the x axis
polygon(x=c(-3,bot,qnorm(0.05)), y=c(0,top,0),col="red")
text(0,0.1,"P(Z < -1.64) = 0.05")



# 3D plots ----------------------------------------------------------------

# try the scatterplot3d package

# base R 3D graphing functions
# create some data
x <- seq(-3,3, length=50)
y <- x
z <- outer(x, y, function(x,y)(y^2 - x^2)) # returns a 50 x 50 matrix

# saddle
contour(x, y, z) # contour plotd
contour(x, y, z, nlevels=30) # contour plot
filled.contour(x, y, z, nlevels = 30)
persp(x, y, z) # 3d plot
# 3d plot rotated 30 degrees "to the left" with color and shading
persp(x, y, z, theta=30, col = "lightblue", shade = 0.75) 
image(x, y, z) # heat map




# Anscombe's Quartet ------------------------------------------------------

# We need tools to easily visualize data in R, especially before analysis.
# The following will help demonstrate why.
# load the anscombe dataset that comes with R
data(anscombe)
names(anscombe)
# x1 goes with y1, x2 goes with y2, etc.
# x1-x4 are "predictors"
# y1-y4 are "responses"

options(digits=4) # limit display of digits to 4

# let's statistically investigate 
sapply(anscombe[,1:4], mean) # mean of x's
sapply(anscombe[,1:4], sd) # sd of x's
sapply(anscombe[,5:8], mean) # mean of y's
sapply(anscombe[,5:8], sd) # sd of y's
cor(anscombe[,1],anscombe[,5]) # correlation of x1 and y1
cor(anscombe[,2],anscombe[,6]) # correlation of x2 and y2
cor(anscombe[,3],anscombe[,7]) # correlation of x3 and y3
cor(anscombe[,4],anscombe[,8]) # correlation of x4 and y4
# they're all almost identical.

# regress y1 on x1, y2 on x2, etc.
m <- list()
for(i in 1:4){
  m[[i]] <- lm(anscombe[,i+4] ~ anscombe[,i], data=anscombe)
}
m
# all coefficients are identical

# let's graphically investigate
par(mfrow=c(2,2)) # 2 x 2 plotting area

# this loop will plot y1 vs x1, y2 vs x2, etc.
for(i in 1:4){
  
  # create blank plot: type="n" (high-level function)
  plot(x=c(0,20), y=c(0,20), type="n", 
       xlab=paste("x",i,sep=""), ylab=paste("y",i,sep=""), axes = FALSE)
  
  # add custom axis (low-level functions)
  ticks  <- 0:20 # define tick marks
  axis(side = 1, at = ticks) # plot tick marks on x axis
  axis(side = 2, at = ticks) # plot tick marks on y axis
  box(which="plot") # draw a box around the plot
  
  # plot x1 vs y1, x2 vs y2, etc, with linear regression line
  points(anscombe[,i],anscombe[,i+4])
  abline(m[[i]])
}

# RESULT: four very different plots with almost identical statistics.
# Always a good idea to graph your data before analyzing it.
# see http://en.wikipedia.org/wiki/Anscombe%27s_quartet
# see also the R help file:  help(anscombe)


# Interactive 3D ----------------------------------------------------------


# Spinning 3D scatterplot
# Install and load the "rgl" package ("3D visualization 
# device system (OpenGL)")
# NOTE: This will cause RStudio to crash when graphics 
# window is closed. Instead, run this in the standard, 
# console version of R.
install.packages("rgl")
require("rgl")
require("RColorBrewer")
plot3d(iris$Petal.Length,  # x variable
       iris$Petal.Width,   # y variable
       iris$Sepal.Length,  # z variable
       xlab = "Petal.Length",
       ylab = "Petal.Width",
       zlab = "Sepal.Length",
       col = brewer.pal(3, "Dark2")[unclass(iris$Species)],
       size = 8)



# conditioning plots ------------------------------------------------------


# multiple plots with different subsets of data
# mtcars: Motor Trend Car Road Tests
# plot mpg versus horsepower conditional on cylinders
coplot(mpg ~ hp | factor(cyl), data=mtcars, rows=1) 


# more information on colors ----------------------------------------------


# see what numbers refer to which color
palette()
# you can change the palette
palette(rainbow(6)) # set palette to 6 rainbow colors
palette()

# define a new palette using the R ColorBrewer package
install.packages("RColorBrewer")
library(RColorBrewer)
help(RColorBrewer)
# brewer.pal() makes the color palettes from ColorBrewer available as R palettes.
palette(brewer.pal(7, "Blues")) # load 7 colors from the RColorBrewer "Blues" palette
palette()
barplot(1:7,col=palette()) # trick to see colors

palette("default") # return to default

