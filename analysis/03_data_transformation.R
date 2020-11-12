#summarize sales yearly by store by products

names(store_sales)
yearly_sales<-store_sales%>%select(-Day,-Month)%>%
  group_by(Store,Year)%>%summarize_all(list(sum))

yearly_sales$Total<-rowSums(yearly_sales[,c(3:11)])

var<-names(yearly_sales[c(3:11)])
var


