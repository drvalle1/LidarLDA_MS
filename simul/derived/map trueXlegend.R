rm(list=ls())
library(ggplot2)

setwd('U:\\independent studies\\LIDAR Tanguro\\LidarLDA_MS\\simul\\fake data')
combo3=read.csv('theta3.csv')
tmp=sample(1:3,size=nrow(combo3),replace=T)
combo3$Cluster=as.factor(tmp)

combo5=read.csv('theta5.csv')
tmp=sample(1:5,size=nrow(combo5),replace=T)
combo5$Cluster=as.factor(tmp)

#get legends
cores=c('green','red','cyan')
res3=ggplot(data=combo3,aes(x=x,y=y,fill=Cluster))+
     geom_tile() +
     scale_fill_manual(values = cores)
res3

cores=c('green','red','cyan','blue','orange')
res5=ggplot(data=combo5,aes(x=x,y=y,fill=Cluster))+
  geom_tile() +
  scale_fill_manual(values = cores)
res5

#export results
setwd('U:\\independent studies\\LIDAR Tanguro\\LidarLDA_MS\\simul\\derived')
ggsave(file=paste('map true',3,'legend.jpeg',sep=''), res3,width=7,height=7)
ggsave(file=paste('map true',5,'legend.jpeg',sep=''), res5,width=7,height=7)
