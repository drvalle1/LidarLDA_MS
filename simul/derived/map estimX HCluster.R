rm(list=ls(all=TRUE))
library(ggplot2)

#root path
setwd('U:\\independent studies\\LIDAR Tanguro\\LidarLDA_MS')

#get true parameter values
combo3=read.csv('simul\\fake data\\theta3.csv')
combo5=read.csv('simul\\fake data\\theta5.csv')

#get estimated values based on hard clustering
theta3=read.csv('simul\\derived\\cluster analysis 3.csv'); 
theta5=read.csv('simul\\derived\\cluster analysis 5.csv'); 

#do we get the same results?
mean(theta3$hclust1!=theta3$agnes5) #no
mean(theta5$hclust1!=theta5$agnes5) #yes

#convert to factor
theta3$Cluster=as.factor(theta3$agnes5)
theta5$Cluster=as.factor(theta5$agnes5)
theta3b=cbind(combo3[,c('x','y','topo')],theta3)
theta5b=cbind(combo5[,c('x','y','topo')],theta5)

#make figures
colors=c('green','yellow','red','grey','cyan')
res3=ggplot(data=theta3b,aes(x=x,y=y,fill=Cluster)) + 
  geom_tile() +
  scale_fill_manual(values=colors) +
  geom_contour(aes(x=x, y=y, z = topo))+
  theme(axis.title.x=element_blank(),
        axis.text.x=element_blank(),
        axis.ticks.x=element_blank(),
        axis.title.y=element_blank(),
        axis.text.y=element_blank(),
        axis.ticks.y=element_blank(),
        legend.position = "none") +
  xlab('')+ylab('')
res3.leg=ggplot(data=theta3b,aes(x=x,y=y,fill=Cluster)) + 
  geom_tile() +
  scale_fill_manual(values=colors) +
  xlab('')+ylab('')

colors=c('green','red','cyan','blue','orange')
res5=ggplot(data=theta5b,aes(x=x,y=y,fill=Cluster)) + 
  geom_tile() +
  scale_fill_manual(values=colors) +
  geom_contour(aes(x=x, y=y, z = topo))+
  theme(axis.title.x=element_blank(),
        axis.text.x=element_blank(),
        axis.ticks.x=element_blank(),
        axis.title.y=element_blank(),
        axis.text.y=element_blank(),
        axis.ticks.y=element_blank(),
        legend.position = "none") +
  xlab('')+ylab('')
res5.leg=ggplot(data=theta5b,aes(x=x,y=y,fill=Cluster)) + 
  geom_tile() +
  scale_fill_manual(values=colors) +
  xlab('')+ylab('')

ggsave(file='simul\\derived\\map estim3 XCluster.jpeg', res3,width=7,height=7)
ggsave(file='simul\\derived\\map estim5 XCluster.jpeg', res5,width=7,height=7)  
ggsave(file='simul\\derived\\map estim3 XCluster leg.jpeg', res3.leg,width=7,height=7)
ggsave(file='simul\\derived\\map estim5 XCluster leg.jpeg', res5.leg,width=7,height=7)  