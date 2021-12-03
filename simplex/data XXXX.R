rm(list=ls(all=TRUE))

#root path
setwd('U:\\independent studies\\LIDAR Tanguro\\LidarLDA_MS')

#get data
dat=read.csv('edited data\\2014\\y1.csv',as.is=T)
# dat=read.csv('edited data\\2018\\y1.csv',as.is=T)
ind=which(colnames(dat)%in%c('X','Y'))
coord=dat[,ind]

#get parameter estimates
theta.m=read.csv('results 2014\\theta.m.csv',as.is=T)
# theta.m=read.csv('results 2018\\theta.m.csv',as.is=T)
order1=c(3,2,4,1)
theta.m=theta.m[,order1]
nomes=paste0('comm',1:4)
colnames(theta.m)=nomes
theta=cbind(coord,theta.m)

#get coordinates to retain
coord.sel=read.csv('simplex\\coord select.csv')

theta1=merge(theta,coord.sel,all.y=T); dim(coord.sel); dim(theta1)
theta2=aggregate(cbind(comm1,comm2,comm3,comm4)~fire.treat+edge,data=theta1,mean)

write.csv(theta2,'simplex\\data 2014.csv',row.names=F)
# write.csv(theta2,'simplex\\data 2018.csv',row.names=F)