rm(list=ls(all=TRUE))
library(ggplot2)   #ggplot2_3.3.3
library('sf')      #sf_0.9-8 

#root path
setwd('U:\\independent studies\\LIDAR Tanguro\\LidarLDA_MS')

#get river shapefile and coordinates of transects
river1 <- st_read("GIS TAN\\rio_tanguro_dissp.shp")
experim.fire <- st_read("GIS TAN\\Polygon_A_B_C_D.shp")

#get estimated parameters
theta.m=read.csv('results 2014\\theta.m.csv',as.is=T)

#get coordinates
dat=read.csv('edited data\\2014\\y1.csv',as.is=T)
ind=which(colnames(dat)%in%c('X','Y'))
coord=dat[,ind]

#combine with theta
order1=c(3,2,4,1)
theta.m1=theta.m[,order1]
max.groups=4
colnames(theta.m1)=paste0('gr2014.',1:max.groups)
theta.2014=cbind(coord,theta.m1)

#get 2018 parameters
theta.2018=read.csv('derived 2018\\theta_m_interp.csv')

#merge
fim=merge(theta.2014,theta.2018,all.x=T); dim(theta.2014); dim(fim)
apply(is.na(fim),2,mean)

#plot spatial distribution
max.groups=4
xrango=range(fim$X)
yrango=range(fim$Y)
yrango[2]=8554325
diffx=diff(xrango)
diffy=diff(yrango)
labels1=c('1. Near surf.','2. Short','3. Intermed.','4. Tall')
for (j in 1:max.groups){
  nomes.2014=paste0('gr2014.',j)
  nomes.2018=paste0('gr',j)
  fim$response=fim[,nomes.2018]-fim[,nomes.2014]
  minx=xrango[1]
  maxy=yrango[2]
  res=ggplot() +
    geom_tile(data = fim, alpha = 0.8,aes(x = X, y = Y,fill = response)) +
    scale_fill_gradient2(low = "red", mid = "white",high='blue',limits=c(-1,1),midpoint=0) +
    guides(fill='none') +
    annotate("text",x=minx,y=maxy-0.15*diffy,label=labels1[j],
             size=8,hjust = 0) +
    annotate("text",x=mean(xrango),y=maxy,label='Agricult. field',
             size=5,col='brown',fontface=3) +
    theme(axis.title.x=element_blank(),
          axis.title.y=element_blank(),
          axis.text.x=element_text(size=12),
          axis.text.y=element_text(size=12),
          axis.text=element_text(size=16),
          plot.title = element_text(size=30,hjust = 0.5),
          plot.margin=grid::unit(c(0,0,0,0), "mm"))+
    geom_sf(data=river1,colour='darkblue') +
    geom_sf(data=experim.fire,colour='black',fill=NA) +
    xlim(xrango) +
    ylim(c(8552220,yrango[2])) +
    annotate("text", x = 350500, y = 8552950, label = "C",size=9) +
    annotate("text", x = 350000, y = 8552950, label = "3x",size=9) +
    annotate("text", x = 349500, y = 8552950, label = "6x",size=9) +
    annotate("text", x = 348500, y = 8552950, label = "1x",size=9) +
    scale_size_identity() #+
    ggsave(file=paste('derived 2014\\maps diff',j,'.jpeg',sep=''), res,width=7,height=(diffy/diffx)*7)
}

#--------------------------
#plot legend
res=ggplot() +
  geom_tile(data = fim, alpha = 0.8,aes(x = X, y = Y,fill = response)) +
  scale_fill_gradient2(low = "red", mid = "white",high='blue',limits=c(-1,1),midpoint=0) +
  theme(legend.title = element_blank())
ggsave(file='derived 2014\\maps diff legend.jpeg', res,width=7,height=(diffy/diffx)*7)
