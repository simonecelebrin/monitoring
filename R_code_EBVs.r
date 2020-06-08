#Essential Biodiversity variables
#let's calculate some biodiversity statistics indices
setwd("C:/lab/")
library(raster)
#raster it's a command that import only one band
#we use brick so we import all the bands
snt<-brick("snt_r10.tif") #snt means sentinel
snt
#it shows 4 bands  
#B1=blu
#B2=green
#B3=red
#B4=NIR
plot(snt) #it shows 4 rasters
#R3 G2 B1  NIR
plotRGB(snt,3,2,1, stretch="lin") #we can decide 3 bands order and plot togheter
plotRGB(snt,4,3,2, stretch="lin")

#let's calculate standard deviation (variabiility)
#it can be calculated for only one layer
#so we can obtain only one layer with multivariate analisys and calculate st.dev on this layer 
#so from these 4 band we create only one layer
#and on this we calculate st.deviation
pairs(snt) #to se the correlation between all bands

#SO LET'S CREATE THE PCA
library(RStolbox)
sntpca<-rasterPCA(snt)
sntpca
summary(sntpca$model) #we see into $model that PC1 explain the 70% of all data
plot(sntpca$map)

#Now we plot on RGB just to see three components into a good way (psichedelic)
plotRGB(sntpca$map, 1, 2, 3, stretch="lin")

#now we calculate PC1 stand. dev PC1 with a pixel window 5x5

#let's say to R  that we use a moving window (that analize 5x5 pixels) 
#we create a matrix 5x5 (we don't care about its values)
window <- matrix(1, nrow = 5, ncol = 5) #all pixels have value 1(so they do not impact and are considered empty)
#the function to move the window is "focal"
#focal function means: it calculate values for the neighborhood of focal cells
#so it calculate the function you set (sd=standard deviation) for the neighborhood of the windows you define
#and it makes for all the possible neighborhoods
sd_str<- focal(sntpca$map$PC1, w=window, fun=sd) #sd=standard dev and w is the windows 
cl <- colorRampPalette(c('dark blue','green','orange','red'))(100)
plot(sd_str)
par(mfrow=c(1,2))
plotRGB(snt,4,3,2, stretch="lin", main="original image") 
plot(sd_snt, col=cl, main="diversity")
#veriability increases on ecotone zones, or rather the borders between ecosystems

#############################################
#the same algorithm applyed to a different images
#cladonia exemple
#we want to DEMOSTRATE THAT THE ALGORITHM CAN BE APPLYED TO ANY IMAGES
#also to a lichen photograph
setwd("C:/lab/")
library(raster)
#it's an RGB immages so we need to use Brick
clad<-brick("cladonia_stellaris_calaita.JPG")
plotRGB(clad,1,2,3, stretch="lin") #bands are yet in order
# create the window
window <- matrix(1, nrow = 3, ncol = 3) #numeber 1 is a fixed abritaty value that do not impact on the calculation
#we use focal function
#we see the 3 bands correlation
pairs(clad)
#they're very correlated, and we could use only one, but let's create the PCA
library(RStoolbox)
cladpca<-rasterPCA(clad)
cladpca
#we obtain:
#the call
#the model
#map
#let's do the summary
summary(cladpca$model)
#PC1=98% 
#plot in RGB the pca
plotRGB(cladpca$map, 1, 2, 3, stretch="lin")

#let's do the moving window measure
sd_clad<-focal(cladpca$map$PC1, w=window, fun=sd) #fun=sd:standard deviation
#if it will be to heavy and it use too much time we can aggregate the image
PC1_agg<-aggregate(cladpca$map$PC1, fact=10) #aggregation
sd_clad_agg<-focal(PC1_agg, w=window, fun=sd)
#let's create a colour palette
cl <- colorRampPalette(c('yellow','violet','black'))(100)
par(mfrow=c(1,3))
cl <- colorRampPalette(c('yellow','violet','black'))(100) #
plotRGB(clad,1,2,3, stretch="lin")
plot(sd_clad, col=cl)
plot(sd_clad_agg, col=cl)

#the second graph shows normal stand dev and the third the aggregated once
#it describes the individual complexity in all its parts 
#obviusly with the aggregation we have a different image






