# R_code_exercise.r

setwd("C:/lab/ese/")
library(raster)
library(ncdf4)
library(RStoolbox)
library(ggplot2)
library(rgdal)
library(rasterVis)
library(sf) 

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
png("serieC02.png",  width = 4, height = 4, units = 'in', res = 1200)
plot(serieC02,, main="CO2 serie", col.main="red",font.main=4)
dev.off()

########################
#PREVISIONE CO2
#serieC02<-brick("PC1s_all.tif")
source("predictionCo2.r")
plot(predicted.co2)
click(predicted.co2, n=Inf, id=FALSE, xy=FALSE, cell=FALSE, type="n", show=TRUE)
x <- reclassify(predicted.co2, cbind(6.75477e-05,6.75478e-05,NA))
cl<- colorRampPalette(c("dark green", "light gray", "dark red")) (25)
plot(x, col=cl)
writeRaster(x, "previsione_co2.tif")
x100<-x*100
plot(x100, col=cl)
png("co2_prevista.png", width = 4, height = 4, units = 'in', res = 3000)
plot(x100, col=cl, main= "Previsione CO2")
dev.off()

png("co2_prevista_confini.png", width = 4, height = 4, units = 'in', res = 3000)
plot(x100, col=cl, main= "Previsione CO2")
coastlines<- readOGR("ne_10m_coastline.shp")
plot(coastlines, add=T,lwd=0.1)
dev.off()

#DIFFERENZA CO2
dif<- (serieC02$PC1s_all.17 - serieC02$PC1s_all.1)
dif
plot(dif)
click(dif, n=Inf, id=FALSE, xy=FALSE, cell=FALSE, type="n", show=TRUE)
d <- reclassify(dif, cbind(0.0007800222,NA))
png("co2_dif.png", width = 4, height = 4, units = 'in', res = 1200)
plot(d, col=cl, main="Differenza CO2 2018-2002")
dev.off()

#correlazione tra previsione e differenza
plot(x,d)
png("co2_corr_prev_diff.png") 
plot(x,d, main="Correlazione fra CO2 prevista e differenza annuale", ylab="Immagine previsione", xlab="Immagine dif")
dev.off()

#TREND NE TEMPO 
#let's put image 1 on x aix
#image 13 aix y
#we obtain a 45° line that describes corrispondence 1 to 1 (y=x)
#the data majority will be under this line, because the image 1 has highter values
#x=y is the not changeing line 
#so, for each pixel there's a place into the graph and the values of the two images (of thesame pixels) are related
#if values are the same, that pixel will be on the straight line, otherwise no
png("Trend C02.png")
plot(serieC02$PC1s_all.1, serieC02$PC1s_all.17, main="CO2 variation (2018-2002)", ylab="CO2 2018", xlab="CO2 2002")
abline(0,1,col="red")
dev.off()

#############

#NDVI
rNlist<-list.files(pattern="c_gls_NDV")
rNlist
importN<-lapply(rNlist,raster)
NDVI.multitemp<-stack(importN)
NDVI.multitemp
summary(NDVI.multitemp)
clN <- colorRampPalette(c('light green','green','dark green'))(100)
#togli valori non colorati di sfondo
plot(NDVI.multitemp$Normalized.Difference.Vegetation.Index.1KM.1)
click(NDVI.multitemp$Normalized.Difference.Vegetation.Index.1KM.1, n=Inf, id=FALSE, xy=FALSE, cell=FALSE, type="n", show=TRUE)
NDVI.multitempR<- calc(NDVI.multitemp, fun=function(x){ x[x > 0.936000] <- NA; return(x)} )

#or: faster for PC:
NDVI_corr.1<- calc(NDVI.multitemp$Normalized.Difference.Vegetation.Index.1KM.1, fun=function(x){ x[x > 0.936000] <- NA; return(x)} )
NDVI_corr.2<- calc(NDVI.multitemp$Normalized.Difference.Vegetation.Index.1KM.2, fun=function(x){ x[x > 0.936000] <- NA; return(x)} )
NDVI_corr.3<- calc(NDVI.multitemp$Normalized.Difference.Vegetation.Index.1KM.3, fun=function(x){ x[x > 0.936000] <- NA; return(x)} )
NDVI_corr.4<- calc(NDVI.multitemp$Normalized.Difference.Vegetation.Index.1KM.4, fun=function(x){ x[x > 0.936000] <- NA; return(x)} )
NDVI_corr.5<- calc(NDVI.multitemp$Normalized.Difference.Vegetation.Index.1KM.5, fun=function(x){ x[x > 0.936000] <- NA; return(x)} )
NDVI_corr.6<- calc(NDVI.multitemp$Normalized.Difference.Vegetation.Index.1KM.6, fun=function(x){ x[x > 0.936000] <- NA; return(x)} )
NDVI.multitempR<-stack(NDVI_corr.1,NDVI_corr.2,NDVI_corr.3,NDVI_corr.4,NDVI_corr.5,NDVI_corr.6)
png("NDVI serie.png",width = 4, height = 4, units = 'in', res = 3000) 
plot(NDVI.multitempR, main="NDVI serie")
dev.off()
#############

writeRaster(NDVI.multitempR, "NDVI_corr.tif")
#NDVI 3 periods in rgb
png("NDVI_RGB_serie 1998-2020.png",width = 6, height = 4, units = 'in', res = 1200)
plotRGB(NDVI.multitempR, r=1, g=4, b=6, stretch="Lin",main="RGB NDVI 1998-2010-2020") #bello
dev.off()
#so where there are highter values the image thakes the red, green or blue color
#so we understand in wich month there's been the highter values and where!!!


################################

window <- matrix(1, nrow = 5, ncol = 5) #all pixels have value 1(so they do not impact and are considered empty)
#the function to move the window is "focal"
#focal function means: it calculate values for the neighborhood of focal cells
#so it calculate the function you set (sd=standard deviation) for the neighborhood of the windows you define
#and it makes for all the possible neighborhoods
aggr_NDVI <- aggregate(NDVI.multitempR$Normalized.Difference.Vegetation.Index.1KM.6, fact=10)
sd_str<- focal(aggr_NDVI, w=window, fun=sd)
#sd=standard dev and w is the windows 
cl <- colorRampPalette(c('dark blue','green','orange','red'))(100)
writeRaster(sd_str, "Dev.st_NDVI.tif")

png("Dev.st_NDVI.png", width = 6, height = 8, units = 'in', res = 3000)
par(mfrow=c(2,1))
plot(sd_str, main="Dev.standard NDVI")
plot(NDVI.multitempR$NDVI_corr.6, main="NDVI")
dev.off()
#veriability increases on ecotone zones, or rather the borders between ecosystems
########################################

#general model:
NDVI2020<-raster("c_gls_NDVI_202006010000_GLOBE_PROBAV_V2.2.1.nc")
serieC02<-brick("PC1s_all.tif")
CO2ult<-serieC02$PC1s_all.1
Temper2020<-raster("c_gls_LST10-DC_202006110000_GLOBE_GEO_V1.2.1.nc")
Costru2020<- raster("lulc-human-modification-terrestrial-systems_geographic.tif")

NDVI2020r <- resample(NDVI2020, CO2ult, resample='bilinear') 
Temper2020r<-resample(Temper2020, CO2ult, resample='bilinear') 
Costru2020r<-resample(Costru2020, CO2ult, resample='bilinear')
modelvariables<-stack(NDVI2020r,Temper2020r,CO2ult,Costru2020r)
writeRaster(modelvariables, "stack_variables.tif")


vuln<-rasterPCA(modelvariables)
vulnPC1_stand<-(vuln$map$PC1)/maxValue(vuln$map$PC1)
vulnPC2_stand<-(vuln$map$PC2)/maxValue(vuln$map$PC2)
vulntot<-(vulnPC1_stand+vulnPC2_stand)
vulntot_stand<-vulntot/maxValue(vulntot)
ext <- c(-130, -20, -80, 80)
extension <- crop(vulntot_stand, ext)
writeRaster(extension, "vulnerability.tif")

png("vulnerability.png", width = 6, height = 8, units = 'in', res = 3000)
plot(extension, main="vulnerability")
cities<- readOGR("Americas_Cities.shp")
plot(cities, pch = 16,cex = 0.3,add=T)
text(cities, labels=cities$NAME, cex= 0.2)
states<- readOGR("Americas.shp")
plot(states, lwd = 0.4, add=T)
dev.off()

