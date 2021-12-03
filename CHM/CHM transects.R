rm(list=ls(all=TRUE))

#root path
setwd('U:\\independent studies\\LIDAR Tanguro\\LidarLDA_MS')

#get coordinates of transect for each treatment
coord=read.csv('simplex\\coord select.csv')
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
write.csv(coord2,'CHM\\CHM transects.csv',row.names=F)