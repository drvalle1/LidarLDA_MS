rm(list=ls(all=TRUE))
library(ggplot2)

#get data
setwd('U:\\independent studies\\LIDAR Tanguro\\LidarLDA_MS\\edited data\\2014')
dat=read.csv('y1.csv',as.is=T)
ind=which(colnames(dat)%in%c('X','Y'))
coord=dat[,ind]

#get theta
setwd('U:\\independent studies\\LIDAR Tanguro\\LidarLDA_MS\\results 2014')
order1=c(3,2,4,1)
theta.m=read.csv('theta.m.csv',as.is=T)[,order1]
colnames(theta.m)=paste0('cluster',1:4)

#change format
res=numeric()
for (i in 1:4){
  tmp=cbind(coord,theta.m[,i],i)
  res=rbind(res,tmp)
}
colnames(res)=c('X','Y','theta','cluster')

#CHM transects
setwd('U:\\independent studies\\LIDAR Tanguro\\LidarLDA_MS\\CHM')
CHM.transects=read.csv('CHM transects.csv')

#only retain data in transects
fim1a=merge(res,CHM.transects,all.y=T); dim(fim1a); dim(CHM.transects)
fim1a$cluster=as.factor(fim1a$cluster)

#plot results together
trat=c('C','1x','3x','6x')
cores=c('green','red','cyan','orange')

setwd('U:\\independent studies\\LIDAR Tanguro\\LidarLDA_MS\\CHM')
fim1a$cluster=factor(fim1a$cluster,levels=c(4,3,2,1))
for (i in 1:length(trat)){
  cond=fim1a$fire.treat==trat[i]
  fim2=fim1a[cond,]
  res=ggplot(fim2,aes(fill=cluster,y=theta,x=d.edge))+
        geom_bar(position="fill", stat="identity")+
        scale_fill_manual(values=cores)+
        xlab("")+ylab('')+
        theme(axis.text=element_text(size=20),
              axis.title=element_text(size=20),
              plot.margin=unit(c(0.1,0.7,0,0),"cm")) +
        guides(fill=FALSE) 
  ggsave(file=paste('compare thetas ',trat[i],'.jpeg',sep=''), 
         res,width=7,height=5)  
}

#plot legend
res=ggplot(fim2,aes(fill=cluster,y=theta,x=d.edge))+
  geom_bar(position="fill", stat="identity")+
  scale_fill_manual(values=cores)
ggsave(file='compare thetas legend.jpeg', 
       res,width=7,height=5)  

