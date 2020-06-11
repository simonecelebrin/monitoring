# Point pattern analysis: Density map

#let' install the library for this analysis
install.packages("spatstat")
library(spatstat)
attach(covid)
head(covid)
#convert the data to a point pattern object using the spatstat command ppp
covids<- ppp(lon,lat, c(-180,180), c(-90,90)) #The general form is covids<- ppp(x.coordinates, y.coordinates, x.range, y.range)
#without the attach the function will be
#covids<- ppp(covis$lon, covid$lat, c(-180,180), c(-90,90))
# c is used to claster the data into a range
# now let's do a density map
d<- density(covids)
plot(d)
#let's put the point over the density map
points(covids)

setwd("C:/lab/")
load("point_pattern_analysis.RData")
ls()
#covid: point pattern
#d: was the density map
library(spatstat)
plot(d)
#now we put over the points
points(covids)

#now we load the continents base map, and we load like a line database 
#there are 3 kind of vectors in R: point, lines and polygons
#installiamo rgdall
install.packages("rgdal")
library(rgdal)
#let's insert the line vector of the coasts (it is a shp file)
coastlines<- readOGR("ne_10m_coastline.shp")
#to plot over 
plot(coastlines, add=T)
#to change the colours (inside the "c" we describes the colour claster and we put (100) like colour scale
cl<- colorRampPalette(c("yellow","orange", "red")) (100)
plot(d,col=cl) #to see the colour palette we created over we have to plot again the function d writhing: col=cl
#then we put againg point and lines over
points(covids)
plot(coastlines, add=T)

#let's create a new colour ramp palette
cl2<- colorRampPalette(c("blue","green", "yellow","orange", "red")) (50)
> plot(d,col=cl2, main= "Densities of covid-19")
> points(covids)
> plot(coastlines, add=T)

#HOW TO EXPORT A MAP (in pdf)
pdf("covid_density.pdf") #and put all the things needs to be printed
cl2<- colorRampPalette(c("blue","green", "yellow","orange", "red")) (50)
> plot(d,col=cl2, main= "Densities of covid-19")
> points(covids)
plot(coastlines, add=T)
dev.off() #to close

#and we find the new pdf on the foulder we set at the beginning
