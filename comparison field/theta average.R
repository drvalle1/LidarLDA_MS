rm(list=ls(all=TRUE))

#get theta
setwd('U:\\independent studies\\LIDAR Tanguro\\LidarLDA_MS\\results 2014')
theta.m=read.csv('theta.m.csv',as.is=T)
order1=c(3,2,4,1)
theta.m=theta.m[,order1]
names1=paste0('gr',1:4)
colnames(theta.m)=names1

#get coordinates
setwd('U:\\independent studies\\LIDAR Tanguro\\LidarLDA_MS\\edited data\\2014')
dat=read.csv('y1.csv',as.is=T)
ind=which(colnames(dat)%in%c('X','Y'))
coord=dat[,ind]

#combine these results
theta.m1=cbind(coord,theta.m)

#get distance to edge 
setwd('U:\\independent studies\\LIDAR Tanguro\\LidarLDA_MS\\comparison field')
dist1=read.csv('dist edge for theta.csv')
theta.m2=merge(theta.m1,dist1,all.y=T); dim(dist1); dim(theta.m2)
apply(is.na(theta.m2),2,sum)

#create variable d.edge
sort(unique(theta.m2$dist.borda))
theta.m2$d.edge=NA
cond=theta.m2$dist.borda==0; theta.m2$d.edge[cond]=50
cond=theta.m2$dist.borda%in%c(50,100); theta.m2$d.edge[cond]=100
cond=theta.m2$dist.borda%in%c(200,250); theta.m2$d.edge[cond]=250
cond=theta.m2$dist.borda%in%c(450,500); theta.m2$d.edge[cond]=500
cond=theta.m2$dist.borda%in%c(700,750); theta.m2$d.edge[cond]=750

#summarize results for each "fire.treat" and "dist.borda"
theta.m3=aggregate(cbind(gr1,gr2,gr3,gr4)~fire.treat+Parcela+d.edge,
                   data=theta.m2,mean)

#export results
write.csv(theta.m3,'theta average.csv',row.names=F)
