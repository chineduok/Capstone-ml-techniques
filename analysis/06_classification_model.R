
# Join the dataframe with the cluster

df <- full_join(store_demo,k3_cluster, by = 'Store')
df$Cluster <-factor(df$Cluster)

df_score<-subset(df, is.na(df$Cluster))
df_train<- subset(df, !is.na(df$Cluster))

# we will build the model using - Tree, Forest, and Boosted tree models

set.seed(123)


## Setting the tuning parameters
fitControl <- trainControl(## 10-fold CV
  method = "repeatedcv",
  number = 10,
  #classProbs = T,
  ## repeated ten times
  repeats = 10)


##Data split 80-20%
train_index <- createDataPartition(df_train$Cluster,times = 1, p = 0.8, list = F)
training<- df_train[train_index,]
training <-training[,-1]
testing <- df_train[-train_index,]
anyNA(training)

tree.model <- train(Cluster ~. ,
                    method = "rpart",
                    trControl = fitControl,
                    tuneGrid = data.frame(cp = seq(0.0, 0.1, len = 25)),
                    data = training)

tree.model$finalModel
tree.model
tree.model$bestTune
plot(tree.model)
plot(varImp(tree.model))


rfFit<- train(Cluster ~.,
              method = 'rf',
              importance =T,
              trControl = fitControl,
              tuneLength = 10,
              data = training)

summary(rfFit)
rfFit$finalModel
rfFit
plot(rfFit)
plot(varImp(rfFit,10))


# Boosted Tree

gbmFit.a<- train(Cluster ~., 
               method = 'gbm',
               trControl = fitControl,
               verbose = FALSE,
               data = training)
gbmFit.a


tune.Grid <-  expand.grid(interaction.depth = c(2, 3, 5), 
                          n.trees = (100:300) ,
                          shrinkage = 0.1,
                          n.minobsinnode = 15)
gbmFit<- train(Cluster ~., 
               method = 'gbm',
               trControl = fitControl,
               tuneGrid = tune.Grid,
               family ="multinomial",
               verbose = FALSE,
               data = training)

summary(gbmFit)
gbmFit$bestTune
plot(gbmFit)
gbmFit
plot(varImp(gbmFit,10))


