# load packages
suppressMessages(library(dplyr))
library(hflights)

# explore data
data(hflights)
head(hflights)

# convert to local data frame
# printing only shows 10 rows and as many columns as can fit on your screen
flights <- hflights
## Source: local data frame [227,496 x 21]

# convert to a normal data frame to see all of the columns
data.frame(head(flights))

# base R approach to view all flights on January 1
flights[flights$Month==1 & flights$DayofMonth==1, ]

# dplyr approach
# note: you can use comma or ampersand to represent AND condition
filter(flights, Month==1, DayofMonth==1)
## Source: local data frame [552 x 21]

# use pipe for OR condition
filter(flights, UniqueCarrier=="AA" | UniqueCarrier=="UA")

# you can also use %in% operator
filter(flights, UniqueCarrier %in% c("AA", "UA"))

# select: Pick columns by name
# base R approach to select DepTime, ArrTime, and FlightNum columns
flights[, c("DepTime", "ArrTime", "FlightNum")]

# dplyr approach
select(flights, DepTime, ArrTime, FlightNum)
## Source: local data frame [227,496 x 3]

# “Chaining” or “Pipelining”
# Usual way to perform multiple operations in one line is by nesting
# nesting method to select UniqueCarrier and DepDelay columns and filter for delays over 60 minutes
filter(select(flights, UniqueCarrier, DepDelay), DepDelay > 60)
# chaining method
flights %>%
    select(UniqueCarrier, DepDelay) %>%
    filter(DepDelay > 60)
## Source: local data frame [10,242 x 2]

# summarise_each allows you to apply the same summary function to multiple columns at once
# Note: mutate_each is also available
# for each carrier, calculate the percentage of flights cancelled or diverted
flights %>%
    group_by(UniqueCarrier) %>%
    summarise_each(funs(mean), Cancelled, Diverted)

## Source: local data frame [15 x 3]
## 

# for each carrier, calculate the minimum and maximum arrival and departure delays
flights %>%
    group_by(UniqueCarrier) %>%
    summarise_each(funs(min(., na.rm=TRUE), max(., na.rm=TRUE)), matches("Delay"))

## Source: local data frame [15 x 5]


# for each destination, count the total number of flights and the number of distinct planes that flew there
flights %>%
    group_by(Dest) %>%
    summarise(flight_count = n(), plane_count = n_distinct(TailNum))
## Source: local data frame [116 x 3]
