rm(list=ls(all=TRUE))
library('cluster')
library('maptree')
library(factoextra)

#get data
setwd('U:\\independent studies\\LIDAR Tanguro\\LidarLDA_MS\\simul\\fake data')
ncomm.dat=3
nome=paste0('fake data y',ncomm.dat,'.csv')
dat=read.csv(nome,as.is=T)
y=data.matrix(dat)

nome=paste0('fake data n',ncomm.dat,'.csv')
dat=read.csv(nome,as.is=T)
n=data.matrix(dat)

prob=scale(y/n)
dist1=dist(prob)

#--------------------------
#following https://uc-r.github.io/hc_clustering#optimal
res=hclust(dist1,method='complete')
plot(res, cex = 0.6, hang = -1)
dat$hclust1 <- cutree(res, k = ncomm.dat)
# 
# fviz_nbclust(prob, FUN = hcut, method = "wss")
#---------------------------
#following https://www.rdocumentation.org/packages/maptree/versions/1.4-7/topics/kgs
a = agnes(prob,method='complete',metric='euclidean',keep.diss=T)
b <- kgs(a, a$diss, maxclust=20) #Kelley, L.A., Gardner, S.P., Sutcliffe, M.J. (1996) An automated approach for clustering an ensemble of NMR-derived protein structures into conformationally-related subfamilies, Protein Engineering, 9, 1063-1065.
plot (names (b), b, xlab="# clusters", ylab="penalty")
ind=which(b==min(b))
names(b)[ind]

dat$agnes5 <- cutree(a, k = 5) #optimal
# dat$agnes5 <- cutree(a, k = 5) #optimal

setwd('U:\\independent studies\\LIDAR Tanguro\\LidarLDA_MS\\simul\\derived')
nome=paste0('cluster analysis ',ncomm.dat,'.csv')
write.csv(dat[,c('hclust1','agnes5')],nome,row.names=F)
