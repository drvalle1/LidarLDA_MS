rm(list=ls(all=TRUE))

#root path
setwd('U:\\independent studies\\LIDAR Tanguro\\LidarLDA_MS')

#get colors right
cores=col2rgb(c('green','red','cyan','orange',
                rep('grey',6)))/255
cores1=rgb(cores[1,],cores[2,],cores[3,],alpha=1,maxColorValue=1)
cores2=cores1[1:4]

#get average theta estimates for each transect x treatment 
theta=read.csv('comparison field\\theta average.csv')

#useful stuff
uni.edge=sort(unique(theta$d.edge))
nuni.edge=length(uni.edge)
ind=grep('gr',colnames(theta))
nomes=colnames(theta)[ind]
max.theta=max(theta[,ind])

#create plots
uni.treat=unique(theta$fire.treat)
nuni.treat=length(uni.treat)
clusters=paste0('gr',1:4)
for (j in 1:nuni.treat){
  nome=paste0('comparison field\\theta distrib ',uni.treat[j],'.png')
  png(nome,width=700,height=1000)
  par(mfrow=c(nuni.edge,1),mar=c(3,3,3,1),oma=c(5,6,1,1))
  for(i in 1:nuni.edge){
    cond=theta$fire.treat==uni.treat[j] & theta$d.edge==uni.edge[i]
    theta1=theta[cond,clusters]
    barplot(as.numeric(theta1),ylim=c(0,max.theta),names.arg='',
            main=uni.edge[i],cex.main=4,cex.axis=3,cex.names=4,
            col=cores2,border=NA,las=1)
    abline(h=seq(from=0.2,to=0.8,by=0.2),col='grey')
    k=barplot(as.numeric(theta1),ylim=c(0,max.theta),names.arg='',
            main=uni.edge[i],cex.main=4,cex.axis=3,cex.names=4,add=T,
            col=cores2,border=NA,las=1)
    axis(side=1,at=k,1:4,cex.axis=4,tick=F,line=1)
  }
  mtext(side=1,at=0.5,outer=T,line=3,'Clusters',cex=3)
  mtext(side=2,at=0.5,outer=T,line=2.5,'Relative abundance',cex=3)

  dev.off()
}
