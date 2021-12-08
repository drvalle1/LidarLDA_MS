rm(list=ls(all=TRUE))
library('coda')  #coda_0.19-4

#root path
setwd('U:\\independent studies\\LIDAR Tanguro\\LidarLDA_MS')

#get llk
llk=read.csv('simul\\results\\llk5.csv')$x
ngibbs=length(llk)
nburn=ngibbs*0.7
seq1=nburn:ngibbs 

#plot results
png('simul\\derived\\convergence5.png',width=1000,height=700)
par(mfrow=c(1,2),mar=c(2,3,2,3))
plot(llk,type='l',ylab='',xlab='',main='',
     cex.main=3,cex.axis=2)
abline(v=nburn,col='grey')
plot(llk[seq1],type='l',ylab='',xlab='',main='',
     cex.main=3,cex.axis=2)
dev.off()

#convergence matrics
llk1=mcmc(llk[seq1])
heidel.diag(llk1)
geweke.diag(llk1)