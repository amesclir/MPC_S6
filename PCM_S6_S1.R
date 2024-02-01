## load the phytools package
library(phytools)
## read the Benun Sutton & Wilson phylogeny
bonyfish.tree<-read.tree(file="bonyfish.tre")
print(bonyfish.tree,printlen=3)

## read the phenotypic trait data
bonyfish.data<-read.csv(file="bonyfish.csv",row.names=1,stringsAsFactors=TRUE)
head(bonyfish.data)

## plot the tree with adjacent data matrix
object<-plotTree.datamatrix(bonyfish.tree,bonyfish.data,fsize=0.5,yexp=1,header=FALSE,xexp=1.45,palettes=c("YlOrRd","PuBuGn"))
## add a legend for trait 1
leg<-legend(x="topright",names(object$colors$spawning_mode),cex=0.7,pch=22,pt.bg=object$colors$spawning_mode,pt.cex=1.5,bty="n",title="spawning mode")
## add a second legend for trait 2
leg<-legend(x=leg$rect$left+4.7,y=leg$rect$top-leg$rect$h,names(object$colors$paternal_care),cex=0.7,pch=22,pt.bg=object$colors$paternal_care,pt.cex=1.5,bty="n",title="paternal care")

spawning_mode<-setNames(bonyfish.data[,1],rownames(bonyfish.data))
paternal_care<-setNames(bonyfish.data[,2],rownames(bonyfish.data))

parentalCare.fit<-fitPagel(bonyfish.tree,paternal_care,spawning_mode)
print(parentalCare.fit)
parentalCare.fitx<-fitPagel(bonyfish.tree,paternal_care,spawning_mode, dep.var="x")
print(parentalCare.fitx)
parentalCare.fity<-fitPagel(bonyfish.tree,paternal_care,spawning_mode, dep.var="y")
print(parentalCare.fity)

#There are not really significant difference between the three models, although the best is fitx
plot(parentalCare.fitx,signif=4,cex.main=1,cex.sub=0.8,cex.traits=0.7,cex.rates=0.7,lwd=1)
