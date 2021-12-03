rm(list=ls())

#root path
setwd('U:\\independent studies\\LIDAR Tanguro\\LidarLDA_MS')

#3 communities
ncomm=3
height=1:30
nheight=length(height)
phi=matrix(NA,ncomm,nheight)

media1=c(20,15,10)
sd1=5
max1=dnorm(media1,media1,sd=sd1)
phi[1,]=0.8*dnorm(height,mean=media1[1],sd=sd1)/max1[1]
phi[2,]=0.8*dnorm(height,mean=media1[2],sd=sd1)/max1[2]
phi[3,]=0.8*dnorm(height,mean=media1[3],sd=sd1)/max1[3]

range(phi)
par(mfrow=c(3,1),mar=rep(1,4))
for (i in 1:ncomm) plot(phi[i,],type='h')

#export true parameters
write.csv(phi,'simul\\fake data\\phi3.csv',row.names=F)
#------------------------------------------------
#5 communities

ncomm=5
height=1:30
nheight=length(height)
phi=matrix(NA,ncomm,nheight)

media1=c(25,20,15,10,5)
sd1=2
max1=dnorm(media1,media1,sd=sd1)
phi[1,]=0.8*dnorm(height,mean=media1[1],sd=sd1)/max1[1]
phi[2,]=0.8*dnorm(height,mean=media1[2],sd=sd1)/max1[2]
phi[3,]=0.8*dnorm(height,mean=media1[3],sd=sd1)/max1[3]
phi[4,]=0.8*dnorm(height,mean=media1[4],sd=sd1)/max1[4]
phi[5,]=0.8*dnorm(height,mean=media1[5],sd=sd1)/max1[5]

range(phi)
par(mfrow=c(5,1),mar=rep(1,4))
for (i in 1:ncomm) plot(phi[i,],type='h')

#export true parameters
write.csv(phi,'simul\\fake data\\phi5.csv',row.names=F)
