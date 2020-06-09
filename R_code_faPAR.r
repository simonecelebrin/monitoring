#How to look at chemical cycling from satellite
#we use compernicus images (aggregated by prof (pesano meno))
#we use the lights (freq of red and blue): red and blue quantity on lights - (minus) red and blue reflected by the plant
#the light is a proxy che we use to understand the leaves chlorophyll activity

#NOTE: NDVI shows the BIOMASS, not the chlorophyll activity

library(raster)
library(rasterVis)
library(rasterdiv)
setwd("C:/lab/")

copNDVI<-reclassify(copNDVI, cbind(253:255,NA)) #we delete the wather values
levelplot(copNDVI)

faPAR10<-raster("faPAR10.tif") #we aggregate with fact=10
levelplot(faPAR10)
#we see that faPAR is more restrictive than NDVI, because we are not considering biomass but the real plant power  in carbon absorption
#light of sun into conifer forestrs partly falls to the ground
#so partly is not used
#at the equator instead, in tropical forest, light does not reach the grounde, due to plant density,
#so it's fully eplotied (sfruttato)
#now we save on pdf

pdf("copNDVI.pdf")
levelplot(copNDVI)
dev.off()

pdf("faPAR10.pdf")
levelplot(faPAR10)
dev.off()

############# day 2

setwd("C:/lab/")
load("faPAR.RData")
#original faPAR is 2gb
#let's see how much space is needed for an 8 bits set

library(rasterdiv)
library(raster)
#to wright a raster file of a library into the PC
writeRaster(copNDVI, "copNDVI.tif")
#then we see the dimension on pc folder
#only 5.4MB

library(rasterVis)
#faPAR levelplot this set
levelplot(faPAR10)


################
#LINEAR REGRESSION MODEL between faPAR and NDVI

#erosion exemple
erosion <- c(12, 14, 16, 24, 26, 40, 55, 67) #we create a erosion variable
hm <- c(30, 100, 150, 200, 260, 340, 460, 600) #heavy metals part per millions

plot(erosion, hm, col="red", pch=19, xlab="erosion", ylab="heavy metals") #EASY WITH PLOT FUNCTION
#pch=point character

#we create a math model between these two variables, or rather (ovvero) we need the straight line equation
# of the linear regression

model1<-lm (hm ~ erosion) #or rather (ovvero) y=x 
#in general lm is used to fit linear models. It can be used to carry out regression
#y is hm and x is the erosion
#now we can do the summary of the new model
summary(model1)
#it says:
#intercept
#under it says the slope coefficient
#now we put the stright line equation on the graph
#y=bx+a
abline(model1)
#so compare the straight line on te graph
#in practice: we create the regression model between erosion and hm with the plot,
#but we obtain only the graph, so we create the math model with lm function: lm (hm ~ erosion)
#then we plot the straight line thanks to: abline(model1)


#NOW WE DO A MODEL ABOUT faPAR!!!!!!!!!
setwd("C:/lab/")
library(raster)
faPAR10 <- raster("faPAR10.tif")
library(rasterdiv) #to plot copNDVI that is inside rasterdiv
plot(copNDVI) 
#we delete wather from COPNDVI
copNDVI <- reclassify(copNDVI, cbind(253:255, NA))

#we analize the pixels of faPAR10
faPAR10 #56899584
#we want to simplify
install.packages("sf")
library(rasterVis)
library(sf) # to call st functions
#we define the random function
random.points <- function(x,n) #n=number of random points
 #x=maximum number of pixel that the function can see. Because the two rasters have the same ammount of pixels
 #I can use one or the other, it doesn't matter
 #we take only 1000 points among all the pixels
 
{
lin <- rasterToContour(is.na(x))
pol <- as(st_union(st_polygonize(st_as_sf(lin))), 'Spatial') # st_union to dissolve geometries
pts <- spsample(pol[1,], n, type = 'random')
}
#now we do it
pts<-random.points(faPAR10,1000)

#now we associate the faPAR10 and COPNDVI values to these random points 
#with the function EXTRACT
pts <- random.points(faPAR10,1000) #we use only
copNDVIp <- extract(copNDVI, pts)
faPAR10p <- extract(faPAR10,pts)

#photosyntesis (y) vs biomass (x) model
model2<-lm(faPAR10p ~ copNDVIp)
summary(model2)
plot(copNDVIp,faPAR10p,col="green")
abline(model2, col="red")
#so we have extracted 1000 random values from the rasters of cpNDVI and faPAR and 
#we calculate the correlation with a linear regression model

#two wariables are correlated but not so much
#the C02 taken dipends not only about the biomass but also from the kind of plants
#for exemple: ther's a lot of biomass in european forests, but it do not produce as much photosintesys as the equetors forests do
#it's visible also doing the levelplot of copNDVI and faPAR10
