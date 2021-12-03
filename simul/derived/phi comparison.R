rm(list=ls(all=TRUE))

setwd('U:\\independent studies\\LIDAR Tanguro\\LidarLDA_MS\\simul\\fake data')
phi.t3=read.csv('phi3.csv')
phi.t5=read.csv('phi5.csv')

#make graphs for ncluster=3
nspp=ncol(phi.t3)
setwd('U:\\independent studies\\LIDAR Tanguro\\LidarLDA_MS\\simul\\derived')
cores=c('green','red','cyan')
png('phi comparison3.png',width=700,height=1000)
par(mfrow=c(3,1),mar=c(3,3,1,1),oma=c(4,4,0,0))
for (i in 1:3){
  plot(1:nspp,phi.t3[i,],type='h',ylim=c(0,1),xlab='',ylab='',main='',
       cex.axis=2,lwd=3,col=cores[i])  
  text(2,0.9,i,cex=5)
  # for (j in 1:nspp){
  #   lines(rep(j,2)+0.1,c(0,phi.e3[i,j]),col='red')
  # }
}
# legend(20,0.9,col=c('black','red'),c('True','Estimated'),lty=1,cex=2)
mtext(side=1,at=0.5,outer=T,line=1,'Height (m)',cex=2)
mtext(side=2,at=0.5,outer=T,line=1,'Absorptance probability',cex=2)
dev.off()

#make graphs for ncluster=5
cores=c('green','red','cyan','blue','orange')
png('phi comparison5.png',width=700,height=1000)
par(mfrow=c(5,1),mar=c(3,3,1,1),oma=c(4,4,0,0))
for (i in 1:5){
  plot(1:nspp,phi.t5[i,],type='h',ylim=c(0,1),xlab='',ylab='',main='',
       cex.axis=2,lwd=3,col=cores[i])  
  text(2,0.9,i,cex=5)
  # for (j in 1:nspp){
  #   lines(rep(j,2)+0.1,c(0,phi.e5[i,j]),col='red')
  # }
}
# legend(20,0.9,col=c('black','red'),c('True','Estimated'),lty=1,cex=2)
mtext(side=1,at=0.5,outer=T,line=1,'Height (m)',cex=2)
mtext(side=2,at=0.5,outer=T,line=1,'Absorptance probability',cex=2)
dev.off()


