rm(list=ls(all=TRUE))

#root path
setwd('U:\\independent studies\\LIDAR Tanguro\\LidarLDA_MS')

#get true parameter values
phi.t3=read.csv('simul\\fake data\\phi3.csv')
phi.t5=read.csv('simul\\fake data\\phi5.csv')

#make graphs for ncluster=3
nspp=ncol(phi.t3)
cores=c('green','red','cyan')
png('simul\\derived\\phi comparison3.png',width=700,height=1000)
par(mfrow=c(3,1),mar=c(3,3,1,1),oma=c(4,4,0,0))
for (i in 1:3){
  plot(1:nspp,phi.t3[i,],type='h',ylim=c(0,1),xlab='',ylab='',main='',
       cex.axis=2,lwd=3,col=cores[i])  
  text(2,0.9,i,cex=5)
}
mtext(side=1,at=0.5,outer=T,line=1,'Height (m)',cex=2)
mtext(side=2,at=0.5,outer=T,line=1,'Absorptance probability',cex=2)
dev.off()

#make graphs for ncluster=5
cores=c('green','red','cyan','blue','orange')
png('simul\\derived\\phi comparison5.png',width=700,height=1000)
par(mfrow=c(5,1),mar=c(3,3,1,1),oma=c(4,4,0,0))
for (i in 1:5){
  plot(1:nspp,phi.t5[i,],type='h',ylim=c(0,1),xlab='',ylab='',main='',
       cex.axis=2,lwd=3,col=cores[i])  
  text(2,0.9,i,cex=5)
}
mtext(side=1,at=0.5,outer=T,line=1,'Height (m)',cex=2)
mtext(side=2,at=0.5,outer=T,line=1,'Absorptance probability',cex=2)
dev.off()


