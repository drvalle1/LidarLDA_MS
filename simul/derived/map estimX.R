rm(list=ls(all=TRUE))
library(ggplot2)   #ggplot2_3.3.3

#root path
setwd('U:\\independent studies\\LIDAR Tanguro\\LidarLDA_MS')

#get coordinates 
combo3=read.csv('simul\\fake data\\theta3.csv')
combo5=read.csv('simul\\fake data\\theta5.csv')

#get estimated parameter values
theta3=read.csv('simul\\results\\theta3.csv'); boxplot(theta3)
theta5=read.csv('simul\\results\\theta5.csv'); boxplot(theta5)

#label these groups
theta3a=theta3[,1:3]; colnames(theta3a)=c('gr1','gr2','gr3')
theta5a=theta5[,1:5]; colnames(theta5a)=paste0('gr',1:5)

#combine with coordinates
theta3b=cbind(combo3[,c('x','y','topo')],theta3a)
theta5b=cbind(combo5[,c('x','y','topo')],theta5a)

#make figures
res3=ggplot(data=theta3b,aes(x=x,y=y)) + 
  geom_tile(alpha = theta3b$gr1, fill='green') +
  geom_tile(alpha = theta3b$gr2, fill='red') +
  geom_tile(alpha = theta3b$gr3, fill='cyan') +
  geom_contour(aes(x=x, y=y, z = topo))+
  theme(axis.title.x=element_blank(),
        axis.text.x=element_blank(),
        axis.ticks.x=element_blank(),
        axis.title.y=element_blank(),
        axis.text.y=element_blank(),
        axis.ticks.y=element_blank()) +
  xlab('')+ylab('')

res5=ggplot(data=theta5b,aes(x=x,y=y)) + 
  geom_tile(alpha = theta5b$gr1, fill='red') +
  geom_tile(alpha = theta5b$gr2, fill='green') +
  geom_tile(alpha = theta5b$gr3, fill='cyan') +
  geom_tile(alpha = theta5b$gr4, fill='orange') +
  geom_tile(alpha = theta5b$gr5, fill='blue') +
  geom_contour(aes(x=x, y=y, z = topo))+
  theme(axis.title.x=element_blank(),
        axis.text.x=element_blank(),
        axis.ticks.x=element_blank(),
        axis.title.y=element_blank(),
        axis.text.y=element_blank(),
        axis.ticks.y=element_blank()) +
  xlab('')+ylab('')

ggsave(file=paste('simul\\derived\\map estim',3,'.jpeg',sep=''), res3,width=7,height=7)
ggsave(file=paste('simul\\derived\\map estim',5,'.jpeg',sep=''), res5,width=7,height=7)  