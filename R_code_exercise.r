# R_code_exercise.r

setwd("C:/lab/ese/")
library(raster)
library(ncdf4)
library(RStoolbox)

# C02 file 
rlist<-list.files(pattern="odiac")
import<-lapply(rlist,brick)
PCAS<-lapply(import,rasterPCA)
PCAS
summary(PCAS[[1]]$model)
summary(PCAS[[8]]$model)
summary(PCAS[[17]]$model)

PC1.s1<-(PCAS[[(1)]]$map$PC1)/maxValue(PCAS[[(1)]]$map$PC1)
PC1.s2<-(PCAS[[(2)]]$map$PC1)/maxValue(PCAS[[(2)]]$map$PC1)
PC1.s3<-(PCAS[[(3)]]$map$PC1)/maxValue(PCAS[[(3)]]$map$PC1)
PC1.s4<-(PCAS[[(4)]]$map$PC1)/maxValue(PCAS[[(4)]]$map$PC1)
PC1.s5<-(PCAS[[(5)]]$map$PC1)/maxValue(PCAS[[(5)]]$map$PC1)
PC1.s6<-(PCAS[[(6)]]$map$PC1)/maxValue(PCAS[[(6)]]$map$PC1)
PC1.s7<-(PCAS[[(7)]]$map$PC1)/maxValue(PCAS[[(7)]]$map$PC1)
PC1.s8<-(PCAS[[(8)]]$map$PC1)/maxValue(PCAS[[(8)]]$map$PC1)
PC1.s9<-(PCAS[[(9)]]$map$PC1)/maxValue(PCAS[[(9)]]$map$PC1)
PC1.s10<-(PCAS[[(10)]]$map$PC1)/maxValue(PCAS[[(10)]]$map$PC1)
PC1.s11<-(PCAS[[(11)]]$map$PC1)/maxValue(PCAS[[(11)]]$map$PC1)
PC1.s12<-(PCAS[[(12)]]$map$PC1)/maxValue(PCAS[[(12)]]$map$PC1)
PC1.s13<-(PCAS[[(13)]]$map$PC1)/maxValue(PCAS[[(13)]]$map$PC1)
PC1.s14<-(PCAS[[(14)]]$map$PC1)/maxValue(PCAS[[(14)]]$map$PC1)
PC1.s15<-(PCAS[[(15)]]$map$PC1)/maxValue(PCAS[[(15)]]$map$PC1)
PC1.s16<-(PCAS[[(16)]]$map$PC1)/maxValue(PCAS[[(16)]]$map$PC1)
PC1.s17<-(PCAS[[(17)]]$map$PC1)/maxValue(PCAS[[(17)]]$map$PC1)
union<-list(PC1.s1,PC1.s2, PC1.s3, PC1.s4, PC1.s5, PC1.s6, PC1.s7, PC1.s8, PC1.s9, PC1.s10, PC1.s11, PC1.s12, PC1.s13, PC1.s14, PC1.s15, PC1.s16, PC1.s17)
listPC1s<-stack(union)
writeRaster(listPC1s, "PC1s_all.tif")

serieC02<-brick("PC1s_all.tif")

########################
#PREVISIONE CO2

source("predictionCo2.r")
plot(predicted.co2)
click(predicted.co2, n=Inf, id=FALSE, xy=FALSE, cell=FALSE, type="n", show=TRUE)
x <- reclassify(predicted.co2, cbind(6.75477e-05,6.75478e-05,NA))
cl<- colorRampPalette(c("dark green", "light gray", "dark red")) (25)
plot(x, col=cl)
writeRaster(x, "previsione_co2.tif")
x100<-x*100
plot(x100, col=cl)
png("co2_prevista.png")
plot(x100, col=cl)
dev.off()
#coste
coastlines<- readOGR("ne_10m_coastline.shp")


#DIFFERENZA CO2
dif<- (serieC02$PC1s_all.17 - serieC02$PC1s_all.1)
dif
plot(dif)
click(dif, n=Inf, id=FALSE, xy=FALSE, cell=FALSE, type="n", show=TRUE)
d <- reclassify(dif, cbind(0.0007800222,NA))
png("co2_dif.png")
plot(d, col=cl)
dev.off()

#correlazione tra previsione e differenza
plot(x,d)
png("co2_dif.png")
plot(x,d)
dev.off()

#TREND NE TEMPO 
#let's put image 1 on x aix
#image 13 aix y
#we obtain a 45° line that describes corrispondence 1 to 1 (y=x)
#the data majority will be under this line, because the image 1 has highter values
#x=y is the not changeing line 
#so, for each pixel there's a place into the graph and the values of the two images (of thesame pixels) are related
#if values are the same, that pixel will be on the straight line, otherwise no

plot(serieC02$PC1s_all.1, serieC02$PC1s_all.17, main="CO2 variation")
abline(0,1,col="red")

#############

#NDVI
setwd("C:/lab/ese/")
library(raster)
library(ncdf4)
rNlist<-list.files(pattern="c_gls_NDV")
rNlist
importN<-lapply(rNlist,raster)
NDVI.multitemp<-stack(importN)
NDVI.multitemp
summary(NDVI.multitemp)
clN <- colorRampPalette(c('light green','green','dark green'))(100)
#togli valori non colorati di sfondo
plot(NDVI.multitemp, col=clN)
plot(NDVI.multitemp$ndex.1KM.1, col=cl)

NDVI.multitempR<- reclassify(NDVI.multitemp, cbind(253:255, NA))
NDVI.multitempR

prova=values(NDVI.multitempR$Normalized.Difference.Vegetation.Index.1KM.1)[values(NDVI.multitempR$Normalized.Difference.Vegetation.Index.1KM.5) < 0] = NA
#NDVI 3 periods in rgb
plotRGB(NDVI.multitempR, r=1, g=2, b=3, stretch="Lin") #bello
so where there are highter values the image thakes the red, green or blue color
#so we understand in wich month there's been the highter values and where!!!
#13

GRAFIC OF THE VARANCE (window)

########################################

LINEAR MODEL BETWEEN CO2 and NDVI

library(rasterVis)
library(sf) 
NDVI2020<-raster("c_gls_NDVI_202006010000_GLOBE_PROBAV_V2.2.1.nc")
Co22020<-raster("odiac2019_1x1d_2018.nc")
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
CO22020p <- extract(CO22020,pts)


model<-lm(NDVI2020p ~ Temp2020p)
summary(model)
plot(NDVI2020p,Temp2020p,col="green")
abline(model1, col="red")
NON VA
#######################à
ALL THE INFORMATION PAIRS

