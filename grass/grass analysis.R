rm(list=ls(all=TRUE))
library('rgdal')
library(ggplot2)
library('sf')
library('raster')

#get theta
setwd('U:\\independent studies\\LIDAR Tanguro\\LidarLDA_MS\\results 2014')
theta.m=read.csv('theta.m.csv',as.is=T)

#get data
setwd('U:\\independent studies\\LIDAR Tanguro\\LidarLDA_MS\\edited data\\2014')
dat=read.csv('y1.csv',as.is=T)
ind=which(colnames(dat)%in%c('X','Y'))
coord=dat[,ind]

#combine with theta
order1=c(3,2,4,1)
theta.m1=theta.m[,order1]
colnames(theta.m1)=paste0('gr',1:4)
theta2=cbind(coord,theta.m1)
theta3=theta2[,c('X','Y','gr1')]

#get coordinates to retain
setwd('U:\\independent studies\\LIDAR Tanguro\\LidarLDA_MS\\grass')
coord.sel=read.csv('coord select.csv')
cond=coord.sel$fire.treat%in%c('C','3x','6x')
coord.sel1=coord.sel[cond,]
theta4=merge(theta3,coord.sel1,all.y=T); dim(coord.sel1); dim(theta4)

#get coordinate system (following instructions from https://www.slideshare.net/vitor_vasconcelos/dados-espaciais-em-r)
EPSG=make_EPSG()
ind=grep('SIRGAS 2000 / UTM zone 22S',EPSG$note)
sirgas.2000=EPSG[ind,'prj4']
sirgas.2000=paste(sirgas.2000,'+datum=WGS84')

#get grass raster
grama <- raster('Grass2015.tif')
grama1 = raster::projectRaster(grama,crs=sirgas.2000)
grama2 <- raster::as.data.frame(grama1,xy=T)
cond=!is.na(grama2$Grass2015) & grama2$Grass2015>0
grama2$Grass2015[cond]=1

#summarize grass data for each pixel of theta4
theta4$pgrass=NA
for (i in 1:nrow(theta4)){
  print(i)
  x2=(grama2$x-theta4$X[i])^2
  y2=(grama2$y-theta4$Y[i])^2
  dist1=sqrt(x2+y2)
  cond=dist1<25
  if (sum(cond)>0){
    grama3=grama2[cond,]
    theta4$pgrass[i]=mean(grama3$Grass2015,na.rm=T)
  }
}

cond=is.na(theta4$pgrass)
theta4$pgrass[cond]=NA

#create scatterplot of proportion of grass and relative abundance of cluster 1
png('grass analysis scatter.png',width=700,height=700)
par(mfrow=c(1,1),mar=c(5,5,1,1))
rango=c(0,1)
plot(theta4$gr1,theta4$pgrass,xlim=rango,ylim=rango,
     xlab='Relative abundance cluster 1',
     ylab='Proportion of grass',cex.lab=3,cex.axis=1.5,cex=1.5)
lines(rango,rango,col='grey')
dev.off()

#get boundaries of plots
setwd('U:\\independent studies\\LIDAR Tanguro\\LidarLDA_MS\\GIS TAN')
experim.fire <- st_read("Polygon_A_B_C_D.shp")
cond=is.na(experim.fire$Nome) | experim.fire$Nome!='Parcela C'
experim.fire1=experim.fire[cond,]

#get coordinate system (following instructions from https://www.slideshare.net/vitor_vasconcelos/dados-espaciais-em-r)
experim.fire2=st_transform(experim.fire1,crs=sirgas.2000)
tmp1=st_coordinates(experim.fire2)

#look at spatial distribution
xrango=range(tmp1[,'X'])
yrango=range(tmp1[,'Y'])
diffx=diff(xrango)
diffy=diff(yrango)

#plot proportion of grass
cond=!is.na(theta4$pgrass)
res1=ggplot() + 
  geom_tile(data = theta4[cond,],alpha=0.8,
            aes(x = X, y = Y,fill = pgrass))+
  scale_fill_gradient2(low = "white", mid = "red",high='purple',
                       limits=c(0,1),midpoint=0.5)+
  guides(fill=FALSE) +
  ggtitle('Proportion of grass') +
  theme(axis.title.x=element_blank(),
        axis.title.y=element_blank(),
        axis.text.x=element_text(size=12),
        axis.text.y=element_text(size=12),
        axis.text=element_text(size=16),
        plot.title = element_text(size=30,hjust = 0.5),
        plot.margin=grid::unit(c(0,0,0,0), "mm"))+
  geom_sf(data=experim.fire2,colour='black',fill=NA) +
  annotate("text", x = 350500, y = 8553350, label = "C",size=9) +
  annotate("text", x = 350000, y = 8553350, label = "3x",size=9) +
  annotate("text", x = 349500, y = 8553350, label = "6x",size=9) +
  scale_size_identity()
res1

#save plot
setwd('U:\\independent studies\\LIDAR Tanguro\\LidarLDA_MS\\grass')
ggsave(file='grass analysis pgrass.jpeg', 
       res1,width=7,height=(diffy/diffx)*7)  

#plot proportion of group 1
res2=ggplot() + 
  geom_tile(data = theta4[cond,],alpha=0.8,
            aes(x = X, y = Y,fill = gr1))+
  scale_fill_gradient2(low = "white", mid = "red",high='purple',
                       limits=c(0,1),midpoint=0.5)+
  guides(fill=FALSE) +
  ggtitle('Relative abundance cluster 1') +
  theme(axis.title.x=element_blank(),
        axis.title.y=element_blank(),
        axis.text.x=element_text(size=12),
        axis.text.y=element_text(size=12),
        axis.text=element_text(size=16),
        plot.title = element_text(size=30,hjust = 0.5),
        plot.margin=grid::unit(c(0,0,0,0), "mm"))+
  geom_sf(data=experim.fire2,colour='black',fill=NA) +
  annotate("text", x = 350500, y = 8553350, label = "C",size=9) +
  annotate("text", x = 350000, y = 8553350, label = "3x",size=9) +
  annotate("text", x = 349500, y = 8553350, label = "6x",size=9) +
  scale_size_identity()
res2

ggsave(file='grass analysis gr1.jpeg', 
       res2,width=7,height=(diffy/diffx)*7)  
#--------------------------
#plot legend
res2=ggplot() + 
  geom_tile(data = theta4[cond,],alpha=0.8,
            aes(x = X, y = Y,fill = gr1))+
  scale_fill_gradient2(low = "white", mid = "red",high='purple',
                       limits=c(0,1),midpoint=0.5)

ggsave(file='grass analysis legend.jpeg', res2,width=7,height=(diffy/diffx)*7)  
