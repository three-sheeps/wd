# get cleaned data
source("lib/get_clean_data.R")
mammal <- get_clean_data()

str(mammal)

# correlation between body mass and field metabolic rate dependend on whether
# the mammal eats other mammals

library(data.table)
mammalt <- as.data.table(mammal)
mammalt[,
        cor(BMR, Mass.BMR, use = "com"),
        by = MammalEater]


# change analysis and use dplyr package
