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

#now we can import the predictors, that will help ut predict the spread of the polar bears
#help us to define the spread of the blue point (where's the polar bears)
#example of predictors for polar bears: snow cover, temperature, fish distribution, absence of disturbance by men...
#we will import these rasters

#we import the predictors with the function system file
path<- system.file("external",package="sdm") #it the folder with the predictors
#then we do a list
lst <- list.files(path=path,pattern='asc$',full.names = T) #asc= file asci thet we need, so we search them using theis extension like pattern
lst #to see the found files: 
#elevation
#precipitation
#temperature
#vegetation

#now we STack the list (lst)
preds <- stack(lst)preds
plot(preds) #just to see the stack
cl <- colorRampPalette(c('blue','orange','red','yellow')) (100)
plot(preds, col=cl)

#now let's do some plots
#we plot every single predictor with over the spices (blu once)
#elevation
plot(preds$elevation, col=cl) 
points(species[species$Occurrence == 1,], pch=16)

#temperature
plot(preds$temperature, col=cl)
points(species[species$Occurrence == 1,], pch=16)

#precipitation
plot(preds$precipitation, col=cl)
points(species[species$Occurrence == 1,], pch=16)

#vegetation
plot(preds$vegetation, col=cl)
points(species[species$Occurrence == 1,], pch=16)

#let' CREATE THE MODEL

#we need to explain to the software what kind of datas we are using
#the function for this is : sdmData
#there are 2 kinds of data for an sdm model:
#1 train data: data mesured in the fiels (in situ)
#2 predictors: the variables that help predict the distribution
#1: train= species
#2: the stack (pres)
d <- sdmData(train=species, predictors=preds)
d #just to see the sdm we create

#now we have to make a linear model to predict the spread
#we do a linear model for each predictors
#usually they usa a logistic function, not a linear model
#and we do a glm: generalised linear model: all the linear model togheter 
#generalized linear model (GLM) is a flexible generalization of ordinary linear regression that 
#allows for response variables that have error distribution models 
#other than a normal distribution
#we do this with the function sdm
m1 <- sdm(Occurrence ~ elevation + precipitation + temperature + vegetation, data=d, methods = "glm")
#Occurrence= Y, and it is the combination of ~ elevation + precipitation + temperature + vegetation
# y=a+b elevations+ c temperatures + d precipitation etc...
#data=d

#NOW WE CAN MAKE THE PREDICTION
#with the function "predict"
p1 <- predict(m1, newdata=preds) #new data= the predictors used to do the final prediction
#we plot it!
plot(p1, col=cl)
[Ieri 17:20] Duccio Rocchini
    
plot(p1, col=cl)
points(species[species$Occurrence == 1,], pch=16)
#so we obtain the plot of the probability of distribution of the specie on the space

#we create a stack with the predictors and the prediction
s1 <- stack(preds,p1)
plot(s1, col=cl)





