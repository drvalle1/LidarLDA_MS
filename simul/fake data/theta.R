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
ggplot(data=combo, aes(x, y, z = topo)) + 
  geom_contour()

#----------------------------------------------
#create 3 communities
range(combo$topo)

y1=dnorm(combo$topo,mean=0,sd=20)
y2=dnorm(combo$topo,mean=qtt/2,sd=20)
y3=dnorm(combo$topo,mean=qtt,sd=20)

tmp=cbind(y1,y2,y3)
theta=tmp/apply(tmp,1,sum)
combo$y1=theta[,1]
combo$y2=theta[,2]
combo$y3=theta[,3]

#do I cover a good range?
round(apply(combo[,c('y1','y2','y3')],2,range),2)

par(mfrow=c(1,1))
boxplot(combo[,c('y1','y2','y3')],ylim=c(0,1))

ggplot(data=combo,aes(x=x,y=y)) + 
  geom_tile(alpha = combo$y1, fill='green') +
  geom_tile(alpha = combo$y2, fill='red') +
  geom_tile(alpha = combo$y3, fill='cyan') +
  geom_contour(aes(x=combo$x, y=combo$y, z = combo$topo))

#export true parameters
setwd('U:\\independent studies\\LIDAR Tanguro\\LidarLDA_MS\\simul\\fake data')
write.csv(combo,'theta3.csv',row.names=F)
#----------------------------------------------
#create 5 communities
range(combo$topo)

y1=dnorm(combo$topo,mean=0,sd=10)
y2=dnorm(combo$topo,mean=qtt/4,sd=10)
y3=dnorm(combo$topo,mean=2*qtt/4,sd=10)
y4=dnorm(combo$topo,mean=3*qtt/4,sd=10)
y5=dnorm(combo$topo,mean=qtt,sd=10)
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
  geom_tile(alpha = combo$y5, fill='grey') +
  geom_contour(aes(x=combo$x, y=combo$y, z = combo$topo))

#export true parameters
setwd('U:\\independent studies\\LIDAR Tanguro\\LidarLDA_MS\\simul\\fake data')
write.csv(combo,'theta5.csv',row.names=F)

