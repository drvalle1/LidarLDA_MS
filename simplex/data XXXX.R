rm(list=ls(all=TRUE))

#get data
# setwd('U:\\independent studies\\LIDAR Tanguro\\LidarLDA_MS\\edited data\\2014')
setwd('U:\\independent studies\\LIDAR Tanguro\\LidarLDA_MS\\edited data\\2018')
dat=read.csv('y1.csv',as.is=T)
ind=which(colnames(dat)%in%c('X','Y'))
coord=dat[,ind]

#get parameter estimates
# setwd('U:\\independent studies\\LIDAR Tanguro\\LidarLDA_MS\\results 2014')
setwd('U:\\independent studies\\LIDAR Tanguro\\LidarLDA_MS\\results 2018')
theta.m=read.csv('theta.m.csv',as.is=T)
order1=c(3,2,4,1)
theta.m=theta.m[,order1]
nomes=paste0('comm',1:4)
colnames(theta.m)=nomes
theta=cbind(coord,theta.m)

#get coordinates to retain
setwd('U:\\independent studies\\LIDAR Tanguro\\LidarLDA_MS\\simplex')
coord.sel=read.csv('coord select.csv')

theta1=merge(theta,coord.sel,all.y=T); dim(coord.sel); dim(theta1)
theta2=aggregate(cbind(comm1,comm2,comm3,comm4)~fire.treat+edge,data=theta1,mean)

# write.csv(theta2,'data 2014.csv',row.names=F)
write.csv(theta2,'data 2018.csv',row.names=F)