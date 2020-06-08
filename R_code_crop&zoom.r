#R_code_crop&zoom.r
#how to crop and zoom

setwd("C:/lab/")
#how to crop an image
#let's import an image
library(raster)
library(ncdf4)
snow<-raster("c_gls_SCE_202005260000_NHEMI_VIIRS_V1.0.1.nc")
cl <- colorRampPalette(c('darkblue','blue','light blue'))(100)
plot(snow,col=cl)
#let's do a zoom
#we need to define the extension to we wont to zoom
#italy is from 0-20 long and 35 until 50 of lat)
ext <- c(0, 20, 35, 50)
#now we use zoom with this ext
zoom(snow,ext=ext)
#now we crop, creating a new image
#we don't lose the original one
snowitaly<-crop(snow, ext)
plot(snow)
plot(snowitaly)
#let's make a zoom with a rectangle
zoom(snow,ext=drawExtent())
#and we do a rectangle with the mouse, clicking on the hight left corner and right down once
#so easy
