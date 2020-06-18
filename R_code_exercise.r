R_code_exercise.r

#export the predicted output THAT CAN BE USED BY ANOTHER ONE (a raster file)
writeRaster(prediction, "final.tif") #the given name of the file is final.tif 

###################à
#HOW to import a single CO2 map
co2uno<-brick("odiac2019_1x1d_2002.nc")
library(RStoolbox)
co2unopca<-rasterPCA(co2uno)
summary(co2unopca$model) #we see into $model that PC1 explain the 70% of all data
plot(co2unopca$map$PC1)

##########################à
rlist<-list.files(pattern="odiac")
import<-lapply(rlist,brick)
PCAS<-lapply(import,rasterPCA)
plot(PCAS[[1]]$map$PC1)
plot(PCAS[[2]]$map$PC1)
plot(PCAS[[3]]$map$PC1)
plot(PCAS[[4]]$map$PC1)
plot(PCAS[[5]]$map$PC1)
plot(PCAS[[6]]$map$PC1)
plot(PCAS[[7]]$map$PC1)
plot(PCAS[[8]]$map$PC1)
plot(PCAS[[9]]$map$PC1)
plot(PCAS[[10]]$map$PC1)
plot(PCAS[[11]]$map$PC1)
plot(PCAS[[12]]$map$PC1)
plot(PCAS[[13]]$map$PC1)
plot(PCAS[[14]]$map$PC1)
plot(PCAS[[15]]$map$PC1)
plot(PCAS[[16]]$map$PC1)
plot(PCAS[[17]]$map$PC1)

########################à

#PREVISIONE CO2
setwd("C:/lab/ese/")
library(raster)
library(ncdf4)
rlist<-list.files(pattern="odiac")
import<-lapply(rlist,raster)
co2.multitemp<-stack(import)
co2.multitemp
cl <- colorRampPalette(c('green','white','yellow' , 'orange' , 'red'))(100)
plot(co2.multitemp, col=cl)
co2.multitempR<- reclassify(co2.multitemp, cbind(254:255, NA))
plot(co2.multitempR, col=cl)


#oppure
source("prediction.r")
plot(predicted.co2)
#or
source("prediction2.r")
plot(predicted.co21) #no Riclassify

png("my_final_graph_co2_prevista.png")
plot(predicted.co2, col=cl)
dev.off()

#manca rappresentarla a colori

library(colorRamps)
col5 <- colorRampPalette(c('dark green', 'white', 'red'))  #create color ramp starting from green to red
color_levels=100 #the number of colors to use
max_absolute_value=0.9 #what is the maximum absolute value of raster?
plot(predicted.co2, col=col5(n=100), breaks=seq(-max_absolute_value,max_absolute_value,length.out=color_levels+1) , axes=FALSE)
######################

#DIFFERENZA CO2
dif<- co2.multitempR$ffco2_emission.17 - co2.multitempR$ffco2_emission.1
dif
plot(dvif)
tiff("dvi1.tiff")
dev.off()

#TREND NE TEMPO 
#let's put image 1 on x aix
#image 13 aix y
#we obtain a 45° line that describes corrispondence 1 to 1 (y=x)
#the data majority will be under this line, because the image 1 has highter values
#x=y is the not changeing line 
#so, for each pixel there's a place into the graph and the values of the two images (of thesame pixels) are related
#if values are the same, that pixel will be on the straight line, otherwise no

plot(co2.multitempR$ffco2_emission.1, co2.multitempR$ffco2_emission.17, main="CO2 variation",
ylab="2018")
abline(0,1,col="red")



#############

NDVI
setwd("C:/lab/ese/")
library(raster)
library(ncdf4)
rNlist<-list.files(pattern="c_gls_NDV")
rNlist
importN<-lapply(rNlist,raster)
NDVI.multitemp<-stack(importN)
NDVI.multitemp
clN <- colorRampPalette(c('light green','green','dark green'))(100)
plot(NDVI.multitemp, col=clN)

NDVI.multitempR<- reclassify(NDVI.multitemp, cbind(253:255, NA))
NDVI.multitempR

prova=values(NDVI.multitempR$Normalized.Difference.Vegetation.Index.1KM.5)[values(NDVI.multitempR$Normalized.Difference.Vegetation.Index.1KM.5) < 0] = NA
#NDVI 3 periods in rgb
plotRGB(NDVI.multitempR, r=1, g=2, b=3, stretch="Lin") #bello
so where there are highter values the image thakes the red, green or blue color
#so we understand in wich month there's been the highter values and where!!!
#13

GRAFIC OF THE VARANCE (window)

########################################

LINEAR MODEL BETWEEN TEMP and NDVI

library(rasterVis)
library(sf) 
NDVI2020<-raster("c_gls_NDVI_202006010000_GLOBE_PROBAV_V2.2.1.nc")
Temp2020<-raster("c_gls_LST10-TCI_202006010000_GLOBE_GEO_V1.2.1.nc")
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
pts<-random.points(NDVI2020,1000)

#now we associate the NDVI2020 and Temp2020 values to these random points 
#with the function EXTRACT
pts <- random.points(NDVI2020,1000) #we use only
NDVI2020p <- extract(NDVI2020, pts)
Temp2020p <- extract(Temp2020,pts)


model<-lm(NDVI2020p ~ Temp2020p)
summary(model)
plot(NDVI2020p,Temp2020p,col="green")
abline(model1, col="red")
NON VA
#######################à
ALL THE INFORMATION PAIRS

