#-------------------------------------------------------------------------
# This R script analyzes the car data "mtcars" available as R data frame via data(mtcars).
#
#-------------------------------------------------------------------------
# Necessary library calls in R:
library(plyr)
library(dplyr)
library(Hmisc)
library(reshape2)
library(ggplot2)
library(knitr)
#
#-------------------------------------------------------------------------
data(mtcars)
dim(mtcars)
head(mtcars, 10)
#
#-------------------------------------------------------------------------
#
mtcars_melt <- melt(mtcars, id.vars = "am", measure.vars = "mpg", na.rm = TRUE)
mtcars_melt
mtcars_select <- group_by(mtcars_melt, am, variable)
mtcars_select
mtcars_mean <- ddply(mtcars_select, c("am"), summarise, mean = mean(value, na.rm = TRUE))
mtcars_median <- ddply(mtcars_select, c("am"), summarise, median = median(value, na.rm = TRUE))
mtcars_sd <- ddply(mtcars_select, c("am"), summarise, sd = sd(value, na.rm = TRUE))
mtcars_min <- ddply(mtcars_select, c("am"), summarise, min = min(value, na.rm = TRUE))
mtcars_max <- ddply(mtcars_select, c("am"), summarise, max = max(value, na.rm = TRUE))
mtcars_mean
mtcars_stat <- mtcars_mean
mtcars_stat$median <- mtcars_median$median
mtcars_stat$sd <- mtcars_sd$sd 
mtcars_stat$min <- mtcars_min$min 
mtcars_stat$max <- mtcars_max$max
#
head(mtcars_stat)
