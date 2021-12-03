rm(list=ls(all=TRUE))
library(ggplot2)

nomes=1:10

setwd('U:\\independent studies\\LIDAR Tanguro\\LidarLDA_MS\\simul\\results')
theta3=read.csv('theta3.csv'); colnames(theta3)=nomes
theta5=read.csv('theta5.csv'); colnames(theta5)=nomes

tmp=apply(theta3[,1:3],1,sum)
hist(tmp); mean(tmp) #0.99

tmp=apply(theta5[,1:5],1,sum)
hist(tmp); mean(tmp) #0.99

setwd('U:\\independent studies\\LIDAR Tanguro\\LidarLDA_MS\\simul\\derived')

cores=col2rgb(c('green','red','cyan',rep('grey',7)))/255
cores1=rgb(cores[1,],cores[2,],cores[3,],alpha=1,maxColorValue=1)
cores1.trans=rgb(cores[1,],cores[2,],cores[3,],alpha=0.5,maxColorValue=1)

png('boxplot3.png',width=700,height=700)
par(mfrow=c(1,1),mar=c(5,5,1,1))
boxplot(theta3,ylab='Relative abundance',cex.axis=2,cex.lab=3,
        border=cores1,col=cores1.trans,xlab='Cluster',
        main='',cex.main=4)
dev.off()

cores=col2rgb(c('red','green','cyan','orange','blue',rep('grey',5)))/255
cores1=rgb(cores[1,],cores[2,],cores[3,],alpha=1,maxColorValue=1)
cores1.trans=rgb(cores[1,],cores[2,],cores[3,],alpha=0.5,maxColorValue=1)

png('boxplot5.png',width=700,height=700)
par(mfrow=c(1,1),mar=c(5,5,1,1))
boxplot(theta5,ylab='Relative abundance',cex.axis=2,cex.lab=3,
        border=cores1,col=cores1.trans,xlab='Cluster',
        main='',cex.main=4)
dev.off()