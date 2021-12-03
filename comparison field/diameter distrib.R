rm(list=ls(all=TRUE))

#root path
setwd('U:\\independent studies\\LIDAR Tanguro\\LidarLDA_MS')

#get tree data
tree=read.csv('comparison field\\field data.csv')

#some minor modifications
cond=tree$treat=='C'; tree$treat[cond]='Control'
cond=tree$d.edge==50; tree$d.edge[cond]='0,10,30'

#useful stuff
uni.edge=sort(unique(tree$d.edge))
nuni.edge=length(uni.edge)
ind=grep('dclass',colnames(tree))
nomes=colnames(tree)[ind]
max.ntree=max(tree[,ind])

#create plots
uni.treat=unique(tree$treat)
nuni.treat=length(uni.treat)
for (j in 1:nuni.treat){
  nome=paste0('comparison field\\diameter distrib ',uni.treat[j],'.png')
  png(nome,width=700,height=1000)
  par(mfrow=c(nuni.edge,1),mar=c(3,3,3,1),oma=c(5,6,1,1))
  for(i in 1:nuni.edge){
    cond=tree$treat==uni.treat[j] & tree$d.edge==uni.edge[i]
    tree1=tree[cond,]
    diam=gsub('dclass.','',nomes)
    barplot(as.numeric(tree1[ind]),ylim=c(0,max.ntree),names.arg='',
            main=uni.edge[i],cex.main=4,cex.axis=2,cex.names=2)
    abline(h=seq(from=20,to=80,by=20),col='grey')
    k=barplot(as.numeric(tree1[ind]),ylim=c(0,max.ntree),names.arg='',
            main=uni.edge[i],cex.main=4,cex.axis=2,cex.names=2,add=T)
    axis(side=1,at=k,diam,cex.axis=4,tick=F,line=1)
  }
  mtext(side=1,at=0.5,outer=T,line=3,'Diameter class (cm)',cex=3)
  mtext(side=2,at=0.5,outer=T,line=2.5,'Number of trees per hectare',cex=3)
  dev.off()
}
