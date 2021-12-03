rm(list=ls(all=TRUE))

#get estimated parameters
setwd('U:\\independent studies\\LIDAR Tanguro\\LidarLDA_MS\\results 2014')
theta=read.csv('theta.m.csv')
phi=read.csv('phi.m.csv')

#plot each group
order1=c(3,2,4,1)
phi1=phi[order1,]
range(phi1)
max1=0.6
ngroup=4

#get colors
cores=c('green','red','cyan','orange')
tipos=c('1. Near surface','2. Short','3. Intermediate','4. Tall')

#plot phi
setwd('U:\\independent studies\\LIDAR Tanguro\\LidarLDA_MS\\derived 2014')
png('phi ordered.png',width=700,height=1000)
par(mfrow=c(4,1),mar=c(3,3,4,1),oma=c(3,5,0,0))
for (i in 1:ngroup){
  plot(1:ncol(phi1),as.numeric(phi1[i,]),type='h',main='',
       cex.axis=2.5,xlab='',ylab='',
       ylim=c(0,max1),col=cores[i],lwd=3)
  text(0,max1-0.05,tipos[i],cex=3,pos=4)
}
mtext(side=1,at=0.5,outer=T,line=1,'Height (m)',cex=3)
mtext(side=2,at=0.5,outer=T,line=1,'Absorptance probability',cex=3)
dev.off()