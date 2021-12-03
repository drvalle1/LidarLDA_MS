rm(list=ls(all=TRUE))

#root path
setwd('U:\\independent studies\\LIDAR Tanguro\\LidarLDA_MS')

#get 2014 CHM data
dat14=read.csv('CHM\\2014 edited data\\TAN 2014 edited.csv')
cond=dat14$nobs==25000; mean(cond)
dat14=dat14[cond,c('X','Y','q99')]
colnames(dat14)[ncol(dat14)]='q99.14'

#get 2018 CHM data
dat18=read.csv('CHM\\2018 edited data\\TAN 2018 edited.csv')
cond=dat18$nobs==25000; mean(cond)
dat18=dat18[cond,c('X','Y','q99')]
colnames(dat18)[ncol(dat18)]='q99.18'

#combine datasets
fim=merge(dat14,dat18,all=T); dim(dat14); dim(dat18); dim(fim)

#get coordinates for transects
CHM.transects=read.csv('CHM\\CHM transects.csv')

#only retain data in transects
fim1a=merge(fim,CHM.transects,all.y=T); dim(fim1a); dim(CHM.transects)

#create smooth curves for each transect
trat=c('C','1x','3x','6x')
cores=c('green','orange','red','purple')

res=numeric()
plot(NA,NA,xlim=range(fim1a$d.edge),
     ylim=c(0,max(fim1a$q99.14,na.rm=T)))
for (i in 1:length(trat)){
  cond=fim1a$fire.treat==trat[i]
  fim2=fim1a[cond,]
  fim3=fim2[order(fim2$d.edge),]
  points(fim3$d.edge,fim3$q99.14,col=cores[i])
  smooth1=lowess(x=fim3$d.edge,y=fim3$q99.14,f=1/3)
  lines(smooth1$x,smooth1$y,col=cores[i],lwd=2)
  fim3$q99.14s=smooth1$y
  
  res=rbind(res,fim3)
}

#plot results separately
trat=c('C','1x','3x','6x')
cores=c('green','orange','red','purple')

for (i in 1:length(trat)){
  nome=paste('CHM\\compare CHM ',trat[i],'.png')
  png(nome,height=500,width=700)
  par(mfrow=c(1,1),mar=c(4,4,1,1))
  plot(NA,NA,xlim=range(fim1a$d.edge),
       ylim=c(0,max(fim1a$q99.14,na.rm=T)),
       ylab='',xlab='',cex.axis=3)
  
  points(res$d.edge,res$q99.14,col='grey',pch=19)
  for (j in 1:length(trat)){
    cond=res$fire.treat==trat[j]
    res1=res[cond,]
    if (i==j) {
      points(res1$d.edge,res1$q99.14,col='black',cex=2,pch=19)
      lines(res1$d.edge,res1$q99.14s,col='black',lwd=3)
    }
    if (i!=j) lines(res1$d.edge,res1$q99.14s,col='grey',lwd=2)
  }
  dev.off()
}
