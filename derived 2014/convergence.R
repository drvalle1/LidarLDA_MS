rm(list=ls(all=TRUE))
library('coda')  #coda_0.19-4

#root path
setwd('U:\\independent studies\\LIDAR Tanguro\\LidarLDA_MS')

#get llk
llk=read.csv('results 2014\\llk.csv')$x
ngibbs=length(llk)
nburn=ngibbs*0.1
seq1=nburn:ngibbs 

#plot results
png('derived 2014\\convergence.png',width=1000,height=700)
par(mfrow=c(1,2),mar=c(2,2,4,3),oma=c(3,3,0,0))
plot(llk,type='l',ylab='',xlab='',main='Before removing burn-in',
     cex.main=3,cex.axis=2)
abline(v=nburn,col='grey')
plot(llk[seq1],type='l',ylab='',xlab='',main='After removing burn-in',
     cex.main=3,cex.axis=2)
mtext(side=1,at=0.5,outer=T,line=1.5,'Iterations',cex=3)
mtext(side=2,at=0.5,outer=T,line=1,'Log-likelihood',cex=3)
dev.off()

#convergence matrics
llk1=mcmc(llk[seq1])
heidel.diag(llk1)
geweke.diag(llk1)