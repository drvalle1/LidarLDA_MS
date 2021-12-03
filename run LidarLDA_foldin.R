rm(list=ls(all=TRUE))
# library('devtools')
# devtools::install_github('drvalle1/LidarLDA',build_vignettes = F)
library('LidarLDA')
set.seed(59)

#get data
setwd('U:\\independent studies\\LIDAR Tanguro\\LidarLDA_MS\\edited data\\2018')
dat=read.csv('y1.csv',as.is=T)
ind=which(colnames(dat)%in%c('X','Y'))
y=data.matrix(dat[,-ind])

dat=read.csv('n1.csv',as.is=T)
ind=which(colnames(dat)%in%c('X','Y'))
coord8=dat[,ind]
n=data.matrix(dat[,-ind])

#get phi
setwd('U:\\independent studies\\LIDAR Tanguro\\LidarLDA_MS\\results 2014')
phi=data.matrix(read.csv('phi.m.csv'))

#useful stuff
ncomm=4
ngibbs=10000
nburn=ngibbs/2

#priors
gamma=0.1
phi1=phi[1:ncomm,]
#run gibbs
mod=LidarLDA_foldin(y=y,n=n,nclust=ncomm,
                gamma=gamma,ngibbs=ngibbs,nburn=nburn,
                phi.post=F,phi.estim=phi1,theta.post=T)

plot(mod$llk,type='l')
seq1=8500:ngibbs
plot(mod$llk[seq1],type='l')

#look at theta
seq1=floor(seq(from=8500-nburn,to=nrow(mod$theta),length.out=1000))
tmp=apply(mod$theta[seq1,],2,mean)
nloc=nrow(y)
theta.estim=matrix(tmp,nloc,ncomm)
boxplot(theta.estim)

#export results
setwd('U:\\independent studies\\LIDAR Tanguro\\LidarLDA_MS\\results 2018')
write.csv(theta.estim,'theta.m.csv',row.names=F)
write.csv(mod$llk,'llk.csv',row.names=F)