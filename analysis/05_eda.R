#Exploratory Data Analysis

#Set the cluster column to a dataframe for joining for EDA
k3$cluster
k3_cluster <-as.data.frame(k3$cluster)

#set back the rownames to store
k3_cluster<- rownames_to_column(k3_cluster,var='Store')

# rename to Cluster
names(k3_cluster)[2]<-"Cluster"

## join the cluster column back to the store_sales data for analysis
st_sales_cl<- left_join(store_sales,k3_cluster, by= "Store")
# create a column for total sales per store
st_sales_cl.1<-st_sales_cl %>% mutate(Total = rowSums(across(Dry_Grocery:General_Merchandise)))


# summarize by month per store
mth_sales<-st_sales_cl.1%>%select(-Day)%>%
  group_by(Store,Month,Year,Cluster)%>%summarize_all(list(sum))

mth_sales<-arrange(mth_sales,Store,Year, Month)

yr_sales <-st_sales_cl.1%>%select(-Day,-Month)%>%
  group_by(Store,Year,Cluster)%>%summarize_all(list(sum))


# Join cluster data with location data
store_Clusters <-left_join(yr_sales,store_loc, by = "Store") 
store_Clusters <-store_Clusters%>% select(-Address,-Type)




mth_sales$Cluster <- factor(mth_sales$Cluster)




####Plots for clusters

# 1) line plot of average monthly sales by cluster by year

##make month double digit
mth_sales$Month<-sprintf("%02d",mth_sales$Month)

# unite year and month as Date

mth_sales.1<- unite(mth_sales,Year:Month,col = "Date", sep = "-")
library(zoo)
mth_sales.1$Date <-as.yearmon(mth_sales.1$Date)

  # group by month, year and compute average monthly category sales by cluster

clust_sales<-mth_sales.1[,-1]
monthly_savg <- clust_sales%>%select(-Cluster)%>%
  group_by(Date)%>%summarise(avg_sales = mean(Total))
clust_avg_sales<- clust_sales%>%
  group_by(Cluster, Date)%>%summarize(Cluster_Avg_sales= mean(Total))
clust_avg_sales<-left_join(clust_avg_sales,monthly_savg,by = 'Date')
clust_tot_sales <- clust_sales%>%
  group_by(Cluster, Date)%>%summarize(Cluster_sums= sum(Total))

pl1<-clust_avg_sales%>%group_by(Cluster)%>%
  ggplot(aes(x= Date)) +
  geom_line(aes(y = Cluster_Avg_sales,color = Cluster))+
  geom_line(aes(y =avg_sales), linetype=2) +
  ggtitle('Cluster Average Sales Trend') + xlab('Time')+
  ylab('Average Monthly Sales') 


pl2<-clust_tot_sales%>%group_by(Cluster)%>%
  ggplot(aes(Date, Cluster_sums,color = Cluster)) +
  geom_line()+
  ggtitle('Cluster Total Sales Trend') + xlab('Time')+
  ylab('Total Monthly Sales') 

grid.arrange(pl1,pl2)
### Cluster 3 performed below average consistently .Why?

# 2) Column chart with percentage contribution per cluster grid.arrange by year
pct.clust.sales<-clust_sales%>%group_by(Cluster,Date)%>%
  mutate(across(Dry_Grocery:General_Merchandise, ~ . / Total*100))

pct.clust.sales%>%group_by(Cluster)%>%
  ggplot()

# 3) California cluster map with total sales by zip codes or towns

