rm(list=ls(all=TRUE))
library(ggplot2)
library('sf')
library('gstat')
library('sp')

#get CHM transects
setwd('U:\\independent studies\\LIDAR Tanguro\\LidarLDA_MS\\CHM')
CHM.transects=read.csv('CHM transects.csv')
trat=unique(CHM.transects$fire.treat)

#get river shapefile and coordinates of transects
setwd('U:\\independent studies\\LIDAR Tanguro\\LidarLDA_MS\\GIS TAN')
river1 <- st_read("rio_tanguro_dissp.shp")
experim.fire <- st_read("Polygon_A_B_C_D.shp")

#get 2014 CHM data
setwd('U:\\independent studies\\LIDAR Tanguro\\LidarLDA_MS\\CHM\\2014 edited data')
dat14=read.csv('TAN 2014 edited.csv')
cond=dat14$nobs==25000; mean(cond)
dat14=dat14[cond,c('X','Y','q99')]
colnames(dat14)[ncol(dat14)]='q99.14'

#get 2018 CHM data
setwd('U:\\independent studies\\LIDAR Tanguro\\LidarLDA_MS\\CHM\\2018 edited data')
dat18=read.csv('TAN 2018 edited.csv')
cond=dat18$nobs==25000; mean(cond)
dat18=dat18[cond,c('X','Y','q99')]
colnames(dat18)[ncol(dat18)]='q99.18'

#combine datasets
fim=merge(dat14,dat18,all=T); dim(dat14); dim(dat18); dim(fim)

#interpolate results for q99.14
tmp=fim
coordinates(tmp)=c('X','Y')
cond=!is.na(tmp$q99.14)
tmp1=tmp[cond,]
tmp2=gstat::idw(formula=q99.14~1,tmp1,
                newdata=tmp,idp=2.0)
fim$q99.14.interp=tmp2$var1.pred

cond=!is.na(tmp$q99.18)
tmp1=tmp[cond,]
tmp2=gstat::idw(formula=q99.18~1,tmp1,
                newdata=tmp,idp=2.0)
fim$q99.18.interp=tmp2$var1.pred

#look at spatial distribution
setwd('U:\\independent studies\\LIDAR Tanguro\\LidarLDA_MS\\CHM')
xrango=range(fim$X)
yrango=range(fim$Y)
yrango[2]=8554325
diffx=diff(xrango)
diffy=diff(yrango)
anos=c(14,18)
max1=max(fim[,c('q99.14.interp','q99.18.interp')],na.rm=T)

for (j in 1:2){
  nomes=paste0('q99.',anos[j],'.interp')
  fim$response=fim[,nomes]
  minx=xrango[1]
  maxy=yrango[2]
  res=ggplot() + 
    geom_tile(data = fim, alpha = 1,aes(x = X, y = Y,fill = response)) +
    scale_fill_gradient2(low = "cyan", mid = "red",
                         high='purple',limits=c(0,max1),
                         midpoint=max1/2,
                         na.value="transparent") +
    guides(fill=FALSE) +
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
    scale_size_identity() 
  
    for (ooo in 1:length(trat)){
      cond=CHM.transects$fire.treat==trat[ooo] &
           CHM.transects$Y%in%range(CHM.transects$Y)
      trans1=CHM.transects[cond,]
      res=res+geom_line(data=trans1,mapping=aes(x=X,y=Y),
                            linetype=3) 
    }
    
    ggsave(file=paste('maps',anos[j],'.jpeg',sep=''), res,width=7,height=(diffy/diffx)*7)  
}

#--------------------------
#plot legend
res=ggplot() + 
  geom_tile(data = fim, alpha = 1,aes(x = X, y = Y,fill = response)) +
  scale_fill_gradient2(low = "cyan", mid = "red",high='purple',limits=c(0,max1),midpoint=max1/2) +
  theme(legend.title = element_blank())
ggsave(file='mapsXX legend.jpeg', res,width=7,height=(diffy/diffx)*7)  
  