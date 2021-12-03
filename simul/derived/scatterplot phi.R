rm(list=ls(all=TRUE))

#root path
setwd('U:\\independent studies\\LIDAR Tanguro\\LidarLDA_MS')

#get true parameter values
phi.t3=read.csv('simul\\fake data\\phi3.csv')
phi.t5=read.csv('simul\\fake data\\phi5.csv')

#get estimated parameter values
phi.e3=read.csv('simul\\results\\phi3.csv')[1:3,]; 
phi.e5=read.csv('simul\\results\\phi5.csv')[1:5,]; 

#re-order clusters
seq1=c(2,1,3,5,4)
phi.e5=phi.e5[seq1,]

#make graphs for ncluster=3
cores3=c('green','red','cyan')
rango=range(c(phi.t3,phi.e3))

png('simul\\derived\\scatterplot phi3.png',width=700,height=700)
par(mfrow=c(1,1),mar=c(4,6,1,1))
plot(NA,NA,ylim=rango,xlim=rango,xlab='True',ylab='Estimated',
     cex.lab=3,cex.axis=2.5,cex=2,pch=19,
     main='',cex.main=4)
for (i in 1:3) points(phi.t3[i,],phi.e3[i,],col=cores3[i],pch=19,cex=2)
rango1=c(0,1)
lines(rango1,rango1,col='grey',lwd=3)
fim=data.frame(true1=unlist(phi.t3),
               estim=unlist(phi.e3))
r=cor(fim)[1,2]
text(rango[1]+0.05,rango[2],round(r,3),cex=3)
legend(0.6,0.25,pch=19,col=cores3,
       paste0('Cluster ',1:3),cex=2)
dev.off()

#make graphs for ncluster=5
cores5=c('green','red','cyan','orange','blue')
rango=range(c(phi.e5,phi.t5))

png('simul\\derived\\scatterplot phi5.png',width=700,height=700)
par(mfrow=c(1,1),mar=c(4,6,1,1))
plot(NA,NA,ylim=rango,xlim=rango,xlab='True',ylab='Estimated',
     cex.lab=3,cex.axis=2.5,cex=2,pch=19,
     main='',cex.main=4)
for (i in 1:5){
  points(phi.t5[i,],phi.e5[i,],col=cores5[i],pch=19,cex=2)
}
rango1=c(0,1)
lines(rango1,rango1,col='grey',lwd=3)
fim=data.frame(true1=unlist(phi.t5),
               estim=unlist(phi.e5))
r=cor(fim)[1,2]
text(rango[1]+0.05,rango[2],round(r,3),cex=3)

legend(0.6,0.3,pch=19,col=cores5,
       paste0('Cluster ',1:5),cex=2)
dev.off()
