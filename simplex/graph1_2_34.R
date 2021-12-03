rm(list=ls(all=TRUE))

#get 2014 data
setwd('U:\\independent studies\\LIDAR Tanguro\\LidarLDA_MS\\simplex')
a2014=read.csv('data 2014.csv')
# soma=apply(a2014[,paste0('comm',1:4)],1,sum)
# hist(soma)

#edit these data
a2014$comm34=a2014$comm3+a2014$comm4
ind=which(colnames(a2014)%in%c('comm1','comm2','comm34'))
colnames(a2014)[ind]=c('comm1.14','comm2.14','comm34.14')
ind=which(colnames(a2014)%in%c('comm3','comm4'))
a2014a=a2014[,-ind]

#add whatever is missing to sum to 1 into comm34.14
soma=apply(a2014a[,c('comm1.14','comm2.14','comm34.14')],1,sum)
a2014a$comm34.14=a2014a$comm34.14+(1-soma)
apply(a2014a[,c('comm1.14','comm2.14','comm34.14')],1,sum)

#get 2018 data
a2018=read.csv('data 2018.csv')

#edit these data
a2018$comm34=a2018$comm3+a2018$comm4
ind=which(colnames(a2018)%in%c('comm1','comm2','comm34'))
colnames(a2018)[ind]=c('comm1.18','comm2.18','comm34.18')
ind=which(colnames(a2018)%in%c('comm3','comm4'))
a2018a=a2018[,-ind]

#combine these datasets and make plot
fim=merge(a2014a,a2018a,all=T); dim(a2014a); dim(a2018a); dim(fim)
aux=data.frame(fire.treat=c('C','1x','3x','6x'),
               cores=c('green','orange','red','purple'))
fim1=merge(fim,aux,all=T); dim(fim); dim(fim1)

#function to convert into barycentric coordinates
get.stuff=function(k){
  x=k[2]+k[3]*(1/2)
  y=k[3]*sqrt(3)/2
  c(x,y)
}

#get tick marks
seq1=seq(from=0,to=1,by=0.2)
tmp1=data.frame(comm1=seq1,comm2=1-seq1,comm34=0)
tmp2=data.frame(comm1=seq1,comm2=0,     comm34=1-seq1)
tmp3=data.frame(comm1=0   ,comm2=seq1,  comm34=1-seq1)
ticks=rbind(tmp1,tmp2,tmp3)

#plot results
png('graph1_2_34.png',width=500,height=1000)
par(mfrow=c(2,1),mar=c(1,1,4,1))
tipo=c('edge','interior')
titulo=paste0('Forest ',tipo)
for (i in 1:2){
  plot(NA,NA,xlim=c(-0.1,1.1),ylim=c(0,1.05*sqrt(3)/2),
       xlab='',ylab='',xaxt='n',yaxt='n',main=titulo[i],
       cex.main=3)
  text(c(-0.08,1.08,0.5),c(0,0,1.03*sqrt(3)/2),c(1,2,'3+4'),cex=3)
  lines(c(0,1,1/2,0),c(0,0,sqrt(3)/2,0))

  #draw ticks
  for (j in 1:nrow(ticks)){
    coord1=ticks[j,c('comm1','comm2','comm34')]
    coord1a=get.stuff(unlist(coord1))
    points(x=coord1a[1],
           y=coord1a[2],cex=1,pch=19)
  }

  #draw grid
  for (j in 1:nrow(ticks)){
    coord1=ticks[j,c('comm1','comm2','comm34')]
    coord1a=get.stuff(unlist(coord1))
    if (sum(coord1!=1)==3){
      if (coord1[1]!=0 & coord1[2]!=0) coord2=coord1[c(1,3,2)]
      if (coord1[2]!=0 & coord1[3]!=0) coord2=coord1[c(3,2,1)]
      if (coord1[1]!=0 & coord1[3]!=0) coord2=coord1[c(2,1,3)]
      coord2a=get.stuff(unlist(coord2))
      lines(x=c(coord1a[1],coord2a[1]),
            y=c(coord1a[2],coord2a[2]),col='grey')
    }
  }

  #draw data  
  cond=fim1$edge==tipo[i]
  fim2=fim1[cond,]
  for (j in 1:nrow(fim2)){
    coord1=fim2[j,c('comm1.14','comm2.14','comm34.14')]
    coord1a=get.stuff(unlist(coord1))
    coord2=fim2[j,c('comm1.18','comm2.18','comm34.18')]
    coord2a=get.stuff(unlist(coord2))
    points(x=c(coord1a[1],coord2a[1]),
           y=c(coord1a[2],coord2a[2]),
           col=fim2$cores[j],cex=3,pch=19)
    arrows(x0=coord1a[1], y0=coord1a[2], 
           x1=coord2a[1], y1=coord2a[2],col=fim2$cores[j],lwd=3,lty=2)
  }
  
  if (i==1) legend(-0.08,1.03*sqrt(3)/2,
                   col=aux$cores,
                   aux$fire.treat,
                   lwd=3,cex=2)
}
dev.off()

