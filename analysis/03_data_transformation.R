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

### include demographics 

pct_demo_sales15 <-left_join(per_yr_sales15,store_demo,by= 'Store')
pct_demo_sales15 <-pct_demo_sales15%>%select(-Year, -Total)



## Scale data
per_yr_sales15 [,3:11]<-scale(per_yr_sales15[,3:11])
per_yr_sales15 <-per_yr_sales15%>%select(-Year,-Total)
per_yr_sales15 %>% 
  filter_all(any_vars(is.infinite(.))) 

###Scale data with demographics

pct_demo_sales15[,2:54]<- scale(pct_demo_sales15[,2:54])

### convert storenames to rownames to avoid NAs
per_yr_sales15 <-as.data.frame(per_yr_sales15)
rownames(per_yr_sales15)<-per_yr_sales15[,1]
per_yr_sales15$Store<-NULL


### convert storenames to rwonames to avoid NAs
pct_demo_sales15 <- as.data.frame(pct_demo_sales15)
rownames(pct_demo_sales15)<- pct_demo_sales15[,1]
pct_demo_sales15$Store <-NULL
