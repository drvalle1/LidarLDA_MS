rm(list=ls(all=TRUE))
library(ggplot2) #ggplot2_3.3.3

#root path
setwd('U:\\independent studies\\LIDAR Tanguro\\LidarLDA_MS')

#get data
dat=read.csv('edited data\\2014\\y1.csv',as.is=T)
ind=which(colnames(dat)%in%c('X','Y'))
coord=dat[,ind]

#get theta
order1=c(3,2,4,1)
theta.m=read.csv('results 2014\\theta.m.csv',as.is=T)[,order1]
colnames(theta.m)=paste0('cluster',1:4)

#change format
res=numeric()
for (i in 1:4){
  tmp=cbind(coord,theta.m[,i],i)
  res=rbind(res,tmp)
}
colnames(res)=c('X','Y','theta','cluster')

#get coordinates for transects
CHM.transects=read.csv('CHM\\CHM transects.csv')

#only retain data in transects
fim1a=merge(res,CHM.transects,all.y=T); dim(fim1a); dim(CHM.transects)
fim1a$cluster=as.factor(fim1a$cluster)

#plot results for each transect
trat=c('C','1x','3x','6x')
cores=c('green','red','cyan','orange')

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
  ggsave(file=paste('CHM\\compare thetas ',trat[i],'.jpeg',sep=''), 
         res,width=7,height=5)  
}

#plot legend
res=ggplot(fim2,aes(fill=cluster,y=theta,x=d.edge))+
  geom_bar(position="fill", stat="identity")+
  scale_fill_manual(values=cores)
ggsave(file='CHM\\compare thetas legend.jpeg', 
       res,width=7,height=5)  

