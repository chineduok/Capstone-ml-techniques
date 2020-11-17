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


### Data wit 53 variables

## Perform cluster analysis

# calulate the distances
distance1 <- get_dist(pct_demo_sales15)

#visualize distances
fviz_dist(distance1, gradient = list(low = "#00AFBB", mid = "white", high = "#FC4E07"))

# determining the optimal number of clusters
fviz_nbclust(pct_demo_sales15, kmeans, method = "wss")

#seems as if the optimal cluster is between 3 & 5 but will include 6 for more comparison


#Executing for k = 3:6
k3a<-kmeans(pct_demo_sales15, centers =3,nstart = 10,iter.max = 10)
k4a<-kmeans(pct_demo_sales15, centers =4,nstart = 10,iter.max = 10)
k5a<-kmeans(pct_demo_sales15, centers =5,nstart = 10,iter.max = 10)
k6a<-kmeans(pct_demo_sales15, centers =6,nstart = 10,iter.max = 10)



## Plotting for k =3:6
plt1a<-fviz_cluster(k3a, geom="point", data = pct_demo_sales15) +ggtitle('3 Clusters')
plt2a<-fviz_cluster(k4a, geom="point", data = pct_demo_sales15) +ggtitle('4 Clusters')
plt3a<-fviz_cluster(k5a, geom="point", data = pct_demo_sales15) +ggtitle('5 Clusters')
plt4a<-fviz_cluster(k6a, geom="point", data = pct_demo_sales15) +ggtitle('6 Clusters')


grid.arrange(plt1a, plt2a,plt3a,plt4a)

#including the demographics info gave 3 as the optimal number of clusters 
k3a  #K-means clustering with 3 clusters of sizes 38, 9, 38
     #Within cluster sum of squares by cluster:
     #[1] 1725.483  347.650 1086.127
     #(between_SS / total_SS =  29.0 %)

k3   #K-means clustering with 3 clusters of sizes 35, 33, 17
    #Within cluster sum of squares by cluster:
    #[1] 203.89372 217.39606  85.42453
    #(between_SS / total_SS =  33.0 %)

grid.arrange(plt1, plt1a)

#K3 minimizes the wss with optimal number of clusters 3