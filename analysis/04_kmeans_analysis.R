## Perform cluster analysis

# calulate the distances
distance <- get_dist(per_yr_sales15)

#visualize distances
fviz_dist(distance, gradient = list(low = "#00AFBB", mid = "white", high = "#FC4E07"))

# determining the optimal number of clusters
fviz_nbclust(per_yr_sales15, kmeans, method = "wss")

#seems as if the optimal cluster is between 3 & 5 but will include 6 for more comparison


#Executing for k = 3:6
k3<-kmeans(per_yr_sales15, centers =3,nstart = 10,iter.max = 10)
k4<-kmeans(per_yr_sales15, centers =4,nstart = 10,iter.max = 10)
k5<-kmeans(per_yr_sales15, centers =5,nstart = 10,iter.max = 10)
k6<-kmeans(per_yr_sales15, centers =6,nstart = 10,iter.max = 10)


## Plotting for k =3:6
plt1<-fviz_cluster(k3, geom="point", data = per_yr_sales15) +ggtitle('3 Clusters')
plt2<-fviz_cluster(k4, geom="point", data = per_yr_sales15) +ggtitle('4 Clusters')
plt3<-fviz_cluster(k5, geom="point", data = per_yr_sales15) +ggtitle('5 Clusters')
plt4<-fviz_cluster(k6, geom="point", data = per_yr_sales15) +ggtitle('6 Clusters')


grid.arrange(plt1, plt2,plt3,plt4)
## shows overlaps for increasing overlaps for k =4:6 so k= 3 is optimal!

#add cluster numbers to data frame
per_yr_sales15$Cluster <- k3$cluster
