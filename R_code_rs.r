# R code for remote sensing data analysis
#we have to install this packages
#raster
install.packages("raster")
install.packages("RStoolbox")
setwd("C:/lab/")
library(raster)

#to import a set of raster data: brick function!
p224r63_2011<- brick("p224r63_2011_masked.grd")
plot(p224r63_2011)
#let's change the color ramp
cl<- colorRampPalette(c("black","grey", "light grey")) (100)
plot(p224r63_2011, col=cl)
#bands of landsat
# B1= blue
#B2= green
#B3= red
#B4=NIR
#B5=medium IR
#B6= Termal red
#B7= medium IR

#multiframe of different plots
par(mfrow=c(2,2)) #par means: do a graph with 2x2 dimensions, so we can plot 4 raster: divided into 2 rows and 2 colums. 
#if we put (2,1) then 2 rows and 1 column
#we create once of (2,2) because we will do a graph with 4 bands. and for each box we will have a graph
#so basically par creates an area with 4 boxes where I can plot

#B1=blue
clb<- colorRampPalette(c("dark blue", "blue", "light blue")) (100)
plot(p224r63_2011$B1_sre, col=clb) #$ to recall an inside information

#B2=green
clg<-colorRampPalette(c("dark green", "green", "light green")) (100)
plot(p224r63_2011$B2_sre, col=clg)

#B3= red
clr<-colorRampPalette(c("dark red", "red", "pink")) (100)
plot(p224r63_2011$B3_sre, col=clr)

#B4= NIR
cln<-colorRampPalette(c("red", "orange", "yellow")) (100)
plot(p224r63_2011$B4_sre, col=cln)

#let's change par
par(mfrow=c(4,1))
dev.off() #to close the par

#now we put 2 or 3 bands one over the others just to see the plot in the same way we would see in realty
#how the PC create the colours
# RGB are the 3 components to meke visibles the colours
# we have to associate for exemple the 3 band at the red colour and so for each colour (RGB)

#plotRGB
plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="Lin") #stratch is the command to do the stratching of the colours, lin(=linear)
#stretch does the "tiraggio" of the different colours, just to see them better

plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin") #we want to underline the objects using another band: NIR. 
#the objects becomes red due to we put NIR on red position. 
#the pink part is the agricolture activity
#another exemple: NIR on top of the G component of RGB
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=2, b=4, stretch="Lin")

#new lesson
#load saved data
setwd("C:/lab/")
load("rs.RData")
ls() #to see a list of loaded datas or libraries
p224r63_1988<- brick("p224r63_1988_masked.grd") #I import a new map with lot of bands
plot(p224r63_1988)

#exercise: plot in visible RGB 321 both images

par(mfrow=c(2,1)) #2 righe, 1 colonna
p224r63_2011<- brick("p224r63_2011_masked.grd") 
plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="Lin")
plotRGB(p224r63_1988, r=3, g=2, b=1, stretch="Lin")

#stretch: if we have colours between 50 and 100 thanks to the strach we organize them from 0 to 100.
#In this way we see the values detailed
#now we show the NIR shifting all of one position 
#plot in false colour RGB 432 both images
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_1988, r=4, g=3, b=2, stretch="Lin")

#plot in false colour RGB 324 both images
plotRGB(p224r63_2011, r=3, g=2, b=4, stretch="Lin")
plotRGB(p224r63_1988, r=3, g=2, b=4, stretch="Lin")

#analyse the noise (il rumore) of these images
#we have 2 ways:

#1) use a particular stretch: histogram 
#it shows the noise, mabye due to the umidity. It's so visible into the 1988 image 
#(1988 images has more noise because: it has more green, so more evapotraspiraton and so more humidity, 
#and the sensor is less developed)
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="hist")
plotRGB(p224r63_1988, r=4, g=3, b=2, stretch="hist")
#histogram stretch: makes the integral and shocks the data, because it classify the datas into small classes, and for each class
#it create a rectangle and gives a different colour

#NOW WE COMPARE THE VEGETATION INDEX OF THE TWO IMAGES
#DVI= vegetation index= NIR - RED

#bands of landsat
# B1= blue
#B2= green
#B3= red
#B4=NIR
#B5=medium IR
#B6= Termal red
#B7= medium IR

#let's create the index
dvi2011<- p224r63_2011$B4_sre -p224r63_2011$B3_sre
cl<- colorRampPalette(c("darkorchid3", "light blue", "lightpink4")) (100)
plot(dvi2011,col=cl)

#the same for 1988
dvi1988<- p224r63_1988$B4_sre -p224r63_1988$B3_sre
cl<- colorRampPalette(c("darkorchid3", "light blue", "lightpink4")) (100)
plot(dvi1988,col=cl)

#now we do the difference
dif<- dvi2011-dvi1988
plot(dif)

#now we have to consider the scale 
#let's change pixels dimensions
#grain is the resolution in remote sensing
#it aggregate pixels with a factor #fact= factor
#res means resample: it does the resampling of the pixels
p224r63_2011res<- aggregate(p224r63_2011, fact=10)
p224r63_2011res100<- aggregate(p224r63_2011, fact=100)

par(mfrow=c(3,1))
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_2011res, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_2011res100, r=4, g=3, b=2, stretch="Lin")

#if I wright
p224r63_2011
#I see the base info of each image
#we usually don't need super detailed datas, because they are heavy. 
#we need the right resolution for our finallity


