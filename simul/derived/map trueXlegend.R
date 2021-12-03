rm(list=ls())
library(ggplot2)   #ggplot2_3.3.3

#root path
setwd('U:\\independent studies\\LIDAR Tanguro\\LidarLDA_MS')

#get structure of original table
combo3=read.csv('simul\\fake data\\theta3.csv')
tmp=sample(1:3,size=nrow(combo3),replace=T)
combo3$Cluster=as.factor(tmp)

combo5=read.csv('simul\\fake data\\theta5.csv')
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
ggsave(file='simul\\derived\\map true3legend.jpeg', res3,width=7,height=7)
ggsave(file='simul\\derived\\map true5legend.jpeg', res5,width=7,height=7)
