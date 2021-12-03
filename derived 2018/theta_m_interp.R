rm(list=ls(all=TRUE))
library('gstat')
library('sp')

#get data
setwd('U:\\independent studies\\LIDAR Tanguro\\LidarLDA_MS\\edited data\\2018')
dat=read.csv('y1.csv',as.is=T)
ind=which(colnames(dat)%in%c('X','Y'))
coord=dat[,ind]
nloc.2018=nrow(coord)

#get theta
setwd('U:\\independent studies\\LIDAR Tanguro\\LidarLDA_MS\\results 2018')
theta.m=read.csv('theta.m.csv',as.is=T)
order1=c(3,2,4,1)
theta.m=theta.m[,order1]
boxplot(theta.m)
ncomm=4
nomes=paste0('gr',1:ncomm)
colnames(theta.m)=nomes
theta.m1=cbind(coord,theta.m)

#get coordinates from 2014
setwd('U:\\independent studies\\LIDAR Tanguro\\LidarLDA_MS\\edited data\\2014')
dat=read.csv('y1.csv',as.is=T)
ind=which(colnames(dat)%in%c('X','Y'))
coord.complete=dat[,ind]
coordinates(coord.complete)=c('X','Y')
nloc.2014=nrow(dat)
1-(nloc.2018/nloc.2014)

#make interpolation
res=matrix(NA,nrow(dat),ncomm)
for (i in 1:ncomm){
  theta.m1$response=theta.m1[,nomes[i]]
  theta.m2=theta.m1
  coordinates(theta.m2)=c('X','Y')
  tmp=gstat::idw(formula=response~1,theta.m2,
                 newdata=coord.complete,idp=2.0)
  res[,i]=tmp$var1.pred
}
colnames(res)=nomes

#combine with coordinates
ind=which(colnames(dat)%in%c('X','Y'))
res1=cbind(dat[,ind],res)

#was interpolation done correctly?
for (i in 1:ncomm){
  orig=theta.m1[,c('X','Y',nomes[i])]
  colnames(orig)[3]='orig'
  new1=res1[,c('X','Y',nomes[i])]
  colnames(new1)[3]='new1'
  fim=merge(orig,new1,all.x=T)
  print(c(i,unique(fim$orig-fim$new1)))
}

#export results
setwd('U:\\independent studies\\LIDAR Tanguro\\LidarLDA_MS\\derived 2018')
write.csv(res1,'theta_m_interp.csv',row.names=F)