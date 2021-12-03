rm(list=ls(all=TRUE))

#get coordinates for each treatment
setwd('U:\\independent studies\\LIDAR Tanguro\\LidarLDA_MS\\simplex')
coord=read.csv('coord select.csv')
coord1=aggregate(X~fire.treat,data=coord,mean)
coord1$X=floor(coord1$X)
cond=coord1$fire.treat=='C'
coord1$X[cond]=350450
coord1$X=coord1$X-25

yuni=unique(coord$Y)
combo=expand.grid(X=coord1$X,Y=yuni)
coord2=merge(combo,coord1,all=T); dim(combo); dim(coord2)

#calculate distance to forest edge
maxy=max(coord2$Y)
coord2$d.edge=abs(coord2$Y-maxy)

#output results
setwd('U:\\independent studies\\LIDAR Tanguro\\LidarLDA_MS\\CHM')
write.csv(coord2,'CHM transects.csv',row.names=F)