rm(list=ls())
library(ggplot2)    #ggplot2_3.3.3

#root path
setwd('U:\\independent studies\\LIDAR Tanguro\\LidarLDA_MS')

#get true parameter values
combo3=read.csv('simul\\fake data\\theta3.csv')
combo5=read.csv('simul\\fake data\\theta5.csv')

#plot spatial distribution
res3=ggplot(data=combo3,aes(x=x,y=y)) + 
  geom_tile(alpha = combo3$y1, fill='green') +
  geom_tile(alpha = combo3$y2, fill='red') +
  geom_tile(alpha = combo3$y3, fill='cyan') +
  geom_contour(aes(x=x, y=y, z = topo))+
  theme(axis.title.x=element_blank(),
        axis.text.x=element_blank(),
        axis.ticks.x=element_blank(),
        axis.title.y=element_blank(),
        axis.text.y=element_blank(),
        axis.ticks.y=element_blank()) +
  xlab('')+ylab('')

res5=ggplot(data=combo5,aes(x=x,y=y)) + 
  geom_tile(alpha = combo5$y1, fill='green') +
  geom_tile(alpha = combo5$y2, fill='red') +
  geom_tile(alpha = combo5$y3, fill='cyan') +
  geom_tile(alpha = combo5$y4, fill='blue') +
  geom_tile(alpha = combo5$y5, fill='orange') +
  geom_contour(aes(x=x, y=y, z = topo))+
  theme(axis.title.x=element_blank(),
        axis.text.x=element_blank(),
        axis.ticks.x=element_blank(),
        axis.title.y=element_blank(),
        axis.text.y=element_blank(),
        axis.ticks.y=element_blank()) +
  xlab('')+ylab('')

#export plots
ggsave(file='simul\\derived\\map true3.jpeg',res3,width=7,height=7)
ggsave(file='simul\\derived\\map true5.jpeg',res5,width=7,height=7)