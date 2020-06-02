#R_code_snor.r

setwd("C:/lab/")
#import the file downloaded by copernicus
#the one about snow
#we need some libraryes
#ncdf4 library that load CDF datas(.nc) 
#CDF are similar to TIF datas
install.packages("ncdf4")
library(raster)
library(ncdf4)
snowmay<-raster("c_gls_SCE_202005260000_NHEMI_VIIRS_V1.0.1.nc")
#c'è un warning message, perchè l'immagine è word wile, and we do a crop, so the warning say that the reference sistem is not define in R
#praticamete il warning dice che non stiamo usando una parte dell'immagine che non è presente nel file scaricato ma è presente nel sr del file scaricato

#plot the data
#create a color ramp palette
cl <- colorRampPalette(c('darkblue','blue','light blue'))(100)
plot(snowmay, col=cl)
#snow (per capire il numero dei pixel)

#now how to apply the function to several layers in just one command
#the function is: lapply
#we use 5 snow data downloaded from copernicus by Duccio
#5 images, of 2000-2005-2010-2015-2020
#images has been resamples to a fixed and common value of pixels
#we see a manner to import all the data togheter
#we need to create a new folder into lab folder called snow

#so let's see a slow manner to import the set
setwd("C:/lab/snow")

#how to import the data?
#simply with the function raster
snow2000<-raster("snow2000r.tif")
#same thing for 2005, 2010, etc

snow2005 <- raster("snow2005r.tif")
snow2010 <- raster("snow2010r.tif")
snow2015 <- raster("snow2015r.tif")
snow2020 <- raster("snow2020r.tif")
par(mfrow=c(2,3))
plot(snow2000, col=cl)
plot(snow2005, col=cl)
plot(snow2010, col=cl)
plot(snow2015, col=cl)
plot(snow2020, col=cl)
#but this proces is really annoing
#we use 20 lines to do the job
#to much

########## so a fast method to import and plot 

#funtion called: lapply
#apply a function over a list or vector
#we want to apply the funtion raster to several layers at a time and we do with lapply

#first we make the list of the files we are going to import
#the function is list.files #and it riunisce tot files that cointains a common pattern into the name
rlist<-list.files(pattern="snow") #we can use also snow20
rlist #to see the output of the function
#now we apply the function lapply to the list called rlist (composed by the 5 files)
#use lapply to use raster to all the rlist
import<-lapply(rlist,raster) #we use the fuction raster to the list with the function lapply to import all the images togheter
#(note: raster is a function to import a single images, not to plot it)
#now we do a STACK, so we put togheter a number of layer, like the satellite images do with lots of bands
snow.multitemp<-stack(import) #in this way we created a single stack of different images in multitemporary dimension
snow.multitemp #to see stack details

plot(snow.multitemp, col=cl)

#so we do a list, then with lapply we apply the function raster to each single layer
#then we created a stack of different layers all togheter
#and we plot it

#in monitoring activities is important due to the importance of haveing different time images


#now we make a prediction!
#PREDICTION! TA TA TA TA!
#how the snow will change in the future?
#we can predict something using a regression model
#so we can usa a function called: ordinary least square regrassion to se the values expected in a fixed future period

######### lst's see the prediction function!

#we do it with a function prepared by the prof: "prediction"
source("prediction.r") #prediction.r make a prediction
#source is a function that take a certain file and use it like a code
#soucre read R code from a file!

#but let's see in detail prediction.r #####################
library(raster)
library(rgdal)

# define the extent
#here the prof describe the extention and cropped (ritaglia) the file snow.multitemp)
ext <- c(-180, 180, -90, 90)
extension <- crop(snow.multitemp, ext) 
#extension is the new snow.multitemp cropped

# make a time variable (to be used in regression)
time <- 1:nlayers(snow.multitemp)
#it's the numbers of layers, so in practis is thinkig to a n layers one afther the other.

# run the regression
#describe function fun (a linear model functuion)
fun <- function(x) {if (is.na(x[1])){ NA } else {lm(x ~ time)$coefficients[2] }} 
#calcolate on extension the function fun thanks to "calc"
#Calculate values for a new Raster* object from another Raster* object, using a formula.
predicted.snow.2025 <- calc(extension, fun) # time consuming
predicted.snow.2025.norm <- predicted.snow.2025*255/53.90828 #normalize the data
################### finish description of prediction file

#so let's do the prediction
source("prediction.r")








