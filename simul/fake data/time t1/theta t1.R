rm(list=ls())
library(ggplot2)

#coordinates
x=seq(from=-50,to=50,by=2)
y=x
combo=expand.grid(x=x,y=y)
dim(combo)

#create topography
combo$topo=500000*dnorm(combo$x,mean=0,sd=20)*dnorm(combo$y,mean=0,sd=25)
round(range(combo$topo),3)

#create flat top
qtt=quantile(combo$topo,0.90)
cond=combo$topo>qtt; combo$topo[cond]=qtt
#----------------------------------------------
#create 5 communities
range(combo$topo)

y1=dnorm(combo$topo,mean=0,sd=10)
y2=dnorm(combo$topo,mean=qtt*2/4,sd=10)
y3=dnorm(combo$topo,mean=3*qtt/4,sd=10)
y4=dnorm(combo$topo,mean=3.5*qtt/4,sd=10)
y5=dnorm(combo$topo,mean=4*qtt/4,sd=2)
tmp=cbind(y1,y2,y3,y4,y5)
theta=tmp/apply(tmp,1,sum)
combo$y1=theta[,1]
combo$y2=theta[,2]
combo$y3=theta[,3]
combo$y4=theta[,4]
combo$y5=theta[,5]

#do I cover a good range?
nomes=c('y1','y2','y3','y4','y5')
round(apply(combo[,nomes],2,range),2)
boxplot(combo[,nomes])

ggplot(data=combo,aes(x=x,y=y)) +
  geom_tile(alpha = combo$y1, fill='green') +
  geom_tile(alpha = combo$y2, fill='red') +
  geom_tile(alpha = combo$y3, fill='cyan') +
  geom_tile(alpha = combo$y4, fill='blue') +
  geom_tile(alpha = combo$y5, fill='orange') +
  geom_contour(aes(x=combo$x, y=combo$y, z = combo$topo))

setwd('U:\\independent studies\\LIDAR Tanguro\\LidarLDA_MS\\simul\\fake data\\time t1')
write.csv(combo,'theta t1.csv',row.names=F)

