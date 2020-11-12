#Check the dimesnions of the data sets
dim(store_demo)
dim(store_sales)
dim(store_loc)
#quick check for missing values
anyNA(store_demo)
anyNA((store_sales))
anyNA(store_loc)
#See the structure of the data
glimpse(store_sales)  # may require some date conversions

glimpse(store_demo)# looks ok mostly percentages and population
glimpse(store_loc)
