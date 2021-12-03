rm(list=ls(all=TRUE))
# library('devtools')
# devtools::install_github('drvalle1/LidarLDA',build_vignettes = F)
library('LidarLDA')
set.seed(59)

#root folder
setwd('U:\\independent studies\\LIDAR Tanguro\\LidarLDA_MS')

#get data
dat=read.csv('edited data\\2014\\y1.csv',as.is=T)
ind=which(colnames(dat)%in%c('X','Y'))
y=data.matrix(dat[,-ind])

dat=read.csv('edited data\\2014\\n1.csv',as.is=T)
ind=which(colnames(dat)%in%c('X','Y'))
n=data.matrix(dat[,-ind])

#useful stuff
ncomm=10
ngibbs=200000
nburn=ngibbs*0.9

#priors
a.phi=1
b.phi=1
gamma=0.1

#run gibbs
mod=LidarLDA(y=y,n=n,nclust=ncomm,a.phi=a.phi,b.phi=b.phi,
             gamma=gamma,ngibbs=ngibbs,nburn=nburn,theta.post=F,phi.post=F)

#look at convergence
plot(mod$llk,type='l')
seq1=nburn:ngibbs 
plot(mod$llk[seq1],type='l')
tmp=lowess(mod$llk[seq1])
lines(tmp$x,tmp$y,col='red')

#export summaries
write.csv(mod$theta,'results 2014\\theta.m.csv',row.names=F)
write.csv(mod$phi,'results 2014\\phi.m.csv',row.names=F)

#export posterior
write.csv(mod$llk,'results 2014\\llk.csv',row.names=F)