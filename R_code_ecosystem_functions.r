# R code ecosystem function.r 

#R code to view biomass over the word and calculate changes in ecosystem functions
# we use copernicus: sentinel 2, createt to misure byodiversity
# we use rasterdiv package, created by the Prof.

install.packages(rasterdiv)
install.packages(rasterVis)
library(rasterdiv)
library(rasterVis) # vis=visualization

data(copNDVI)
plot(copNDVI)

# we reclassify data removing the values between 253 and 255, giveing them NA value
copNDVI<- reclassify(copNDVI, cbind(253:255, NA))

levelplot(copNDVI) 
#WITH ONLY ONE FUNCTION WE SEE THE BIOMASS CHANGE FROM 1999 TO NOWADAYS, SO EASY, WITHOUT ANY PROBLEM!

#now we aggregate the values with a factor of 10 (before 8km now 80)
copNDV10<- aggregate(copNDVI, fact=10)


copNDV100<- aggregate(copNDV10, fact=10)
#####################################################àà

#NEW THEME

#Ora guardiamo uno scenario per rendere la vita sostenibile

setwd("C:/lab/")
library(raster)
defor1<-brick("defor1_.jpg") #per importare le immagini con tute le bande
defor2<-brick("defor2_.jpg")

# band 1: NIR
# band2: R
# band3: G

plotRGB(defor1, r=1, g=2, b=3, stretch="Lin")
plotRGB(defor2, r=1, g=2, b=3, stretch="Lin")

par(mfrow=c(1,2))
plotRGB(defor1, r=1, g=2, b=3, stretch="Lin")
plotRGB(defor2, r=1, g=2, b=3, stretch="Lin")

#ora facciamo i conti dell'NDVI
dvi1<- defor1$defor1_.1 - defor1$defor1_.2 #il dollaro è usarto per parti diverse di R
dvi2<- defor2$defor2_.1 - defor2$defor2_.2
cl<- colorRampPalette(c("darkblue","yellow","red","black"))(100)

par(mfrow=c(1,2))
plot(dvi1, col=cl)
plot(dvi2, col=cl)

difdiv=dvi1-dvi2 #ora facciamo la differenza fra i dvi
#warning message:
#In dvi1 - dvi2 :
#Raster objects have different extents. Result for their intersection is returned
#ma non è un problema

dev.off()
cld<- colorRampPalette(c("blue","white","red"))(100)
plot(difdiv, col=cld)

#histogram che mostra bil plot del dvi

hist(difdiv)
