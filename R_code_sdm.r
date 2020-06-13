#R_code_sdm.r: Species Distribution Modelling

#We will obtain a model that shows the distribution of a certain specie thanks to different raster variables

#all the data will be set on the library
install.packages("sdm")
library(raster) #for function usefull to predict 
library(rgdal) #to import the data
library(sdm)

#let's import the species data
file<- system.file("external/species.shp", package="sdm")
#the directory "external" of the package sdm is the right one where ther's the file we need
#the file is inside the package sdm
species<-shapefile(file) #we convert the file to a real shop file
plot(species)
species #just to have the main information
#each point has a value: 1 or 0: 1=present, 0=not prestent
#let's plot with a condition:
#THE SPECIES OCCURRENT IS 1 (presenza)
#for a condition we need to use "=="
plot(species[species$Occurrence == 1,],col='blue',pch=16)
#now let's plot over the point with value 0
#to plot over we need to use the function: POINTS
points(species[species$Occurrence==0,],col="red", pch=16)
