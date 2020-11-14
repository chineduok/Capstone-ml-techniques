#summarize sales yearly by store by products

names(store_sales)
# create a column for total sales per store
store_sales.1<-store_sales %>% mutate(Total = rowSums(across(Dry_Grocery:General_Merchandise)))


# summarize by year per store
yearly_sales<-store_sales.1%>%select(-Day,-Month)%>%
  group_by(Store,Year)%>%summarize_all(list(sum))

# calculate the  % contribution by product to Total yearly sale
per_yr_sales<- yearly_sales%>%mutate(across(Dry_Grocery:General_Merchandise, ~ . / Total*100))

#filter year 2015
per_yr_sales15<-per_yr_sales%>%filter(Year==2015)


## Scale data
per_yr_sales15 [,3:11]<-scale(per_yr_sales15[,3:11])
per_yr_sales15 <-per_yr_sales15%>%select(-Year,-Total)
per_yr_sales15 %>% 
  filter_all(any_vars(is.infinite(.))) 


### convert storenames to rownames to avoid NAs
anyNA(distance)
per_yr_sales15 <-as.data.frame(per_yr_sales15)
rownames(per_yr_sales15)<-per_yr_sales15[,1]
per_yr_sales15$Store<-NULL




