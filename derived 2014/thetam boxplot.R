rm(list=ls(all=TRUE))

#root path
setwd('U:\\independent studies\\LIDAR Tanguro\\LidarLDA_MS')

#get colors right
cores=col2rgb(c('green','red','cyan','orange',
              rep('grey',6)))/255
cores1=rgb(cores[1,],cores[2,],cores[3,],alpha=1,maxColorValue=1)
cores1.trans=rgb(cores[1,],cores[2,],cores[3,],alpha=0.5,maxColorValue=1)

#get parameter estimates
theta.m=read.csv('results 2014\\theta.m.csv',as.is=T)

#change order of clusters
order1=c(3,2,4,1)
seq1=c(order1,5:10)
theta.m=theta.m[,seq1]

#plot theta
png('derived 2014\\thetam boxplot.png',width=700,height=1000)
par(mar=c(5,6,1,1))
boxplot(theta.m,xaxt='n',xlab='Cluster',ylab='Relative abundance',
        cex.lab=3,cex.axis=2,
        border=cores1,col=cores1.trans)
axis(side=1,at=1:ncol(theta.m),1:ncol(theta.m),cex.axis=2)
dev.off()

