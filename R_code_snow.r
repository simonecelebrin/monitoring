#R_code_snow.r

setwd("C:/lab/")
#import the file downloaded by copernicus
#the one about snow
#we need some libraryes
#ncdf4 library that load NCDF datas(.nc) 
#NCDF are similar to TIF datas
install.packages("ncdf4")
library(raster)
library(ncdf4)
snowmay<-raster("c_gls_SCE_202005260000_NHEMI_VIIRS_V1.0.1.nc")
#there's a warning message, because the image immagine it's word wile, and we do a crop, so the warning says that the reference sistem is not define well
#in practice the warning says: we are not using a part of the image, that's not present into the downloades file but there's into
#the reference sistem of the file

#plot the data
#create a color ramp palette
cl <- colorRampPalette(c('darkblue','blue','light blue'))(100)
plot(snowmay, col=cl)
#snow (to see pixels number)

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

########## so a faster method to import and plot 

#funtion called: lapply
#apply a function over a list or vector
#we want to apply the funtion raster to several layers at a time and we do with lapply

#first we make the list of the files we are going to import
#the function is list.files 
#and it gathers (riunisce) tot files that cointains a common pattern into the name rlist
rlist<-list.files(pattern="snow") #we can use also snow20 as pattern
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

plot(predicted.snow.2025.norm, col=cl)

############### DAY 2
setwd("C:/lab/snow/")

#Exercise: import the snow cover images all togheter
rlist<-list.files(pattern="snow20") #find the files
import<-lapply(rlist,raster)#import them
snow.multitemp<-stack(import) #we put togheter the files
snow.multitemp #to see details of the stack
cl <- colorRampPalette(c('darkblue','blue','light blue'))(100)
plot(snow.multitemp, col=cl)
# we import also the prediction made by the prof
#it will be the same use the once we created:
plot(predicted.snow.2025.norm, col=cl)
#but we use prof's once:
prediction <- raster("predicted.2025.norm.tif")
plot(prediction, col=cl)

#the predicted image is an image where the function, for all the pixels, has calulated a value in relations to the previous values 
#so for each pixel we have a regression line that predict the 2025 value

#export the predicted output THAT CAN BE USED BY ANOTHER ONE (a raster file)
writeRaster(prediction, "final.tif") #the given name of the file is final.tif 


#now we do a final stack (to put all the images togheter)
final.stack<-stack(snow.multitemp, prediction) #we merge into a stack the 5 laayers yet merged previusly, and the predicted image
#so we obtain a final stack with 6 images
plot(final.stack, col=cl)

#now we export this stack in pdf for the thesys
pdf("my_final_graph.pdf")
plot(final.stack, col=cl)
dev.off()
#now we export this stack in png for the thesys
png("my_final_graph.png")
plot(final.stack, col=cl)
dev.off()

#to increase the resolution of a png there are differents methods online



