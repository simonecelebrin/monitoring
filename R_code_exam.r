#R_code_exam

#1. R first code
#2. R_code_multipanel
#3. R_code_spatial
#4. R_code_point_pattern_analysis
#5. R_code_multivar
#6. R_code_rs
#7. R_code_ecosystem_functions
#8. R_code_pca_remote_sensing
#9. R_code_faPAR
#10. R_code_radiance
#11. R_code_EBVs
#12. R_code_snow
#13. R_code_no2
#14. R_code_crop&zoom
#15. R_code_interpolation
#16. R_code_sdm
#17. R_code_exercise

#####################################################################################################################################
#####################################################################################################################################

#1. R Code first ####################################################################################################################

#Let's install a package
install.packages("sp")
#we recall it 
library(sp)
data(meuse) #it's a dataset in meuse

#let's see how the meuse dataset is structured:
meuse
#let's look at the first row of the set
head(meuse)

#lets'plot two variables
#let's see if zinc concentration is related to copper once
attach(meuse) #attach is necessary to recall single variables in meuse
plot(zinc,copper)
#col=green it's a color associated to a number, it colors the graph
plot(zinc,copper,col="green")
#to change symbols we insert the function and the number associated to the symbol we want
plot(zinc,copper,col="green",pch=19)
#to increase point dimension
plot(zinc,copper,col="green",pch=19,cex=2)

#####################################################################################################################################
#####################################################################################################################################

#2. R_code_multipanel ###############################################################################################################

# Excercise: make all the possible pairwis plots in R
#we use a packet called "sp" and we use it because we use a dataset in it
#so we install it
install.packages("sp")
install.packages("GGally") #watch out! R is capital letter sensitive!
#after we need to say to R that we use them
library(sp) #require(sp) will also do the job
#inside ther's a dataset called meuse. The dataset in R are called dataframe
data(meuse)
#now we had explain that we need this package but we neet to explain to R that 
#we need to use it, so:
attach(meuse)
#now we see the names of variables and we plot cadmio and zinc
head(meuse) 
#it shows the forst lines of dataframe
#wrighting "meuse" instead I see the complete dataframe
#for the exercise we wright:
plot(cadmium,zinc)
#then I can change symbols, colours, etc.
plot(cadmium,zinc, pch=15,col="red")
#I wright "red" like a name, with "" because I call it from outside R
#Excercise: make all the possible pairwis plots of the dataset (now to do all the pairwise with all the variables, I can:) 
#Make the plot of all the combinations, too ling!, or:
pairs(meuse)
#in case you recive the error "the size is too large" reshape with the mouse the dimension of the window and relounch the comand
#if the result is not so readable, I had to rettify or subset the meuse dataset to have a low number of variables
pairs(~cadmium+copper+lead+zinc, data=meuse)
#grupping carachters using a tilde 
#other method: all the variables=make a subset)
pairs(meuse[,3:6])
#the comma , is necessaty to say: "start form". Instead the duble dots : says "untill" 
#it works with numbers, not with the names!
#exercise: prettify this graph (let's change the colours) 
pairs(meuse[,3:6],pch=19,col="yellow")
pairs(meuse[,3:6],pch=19,col="blue",cex=2)
#to do others scatterplot cutest with more data we can use GGally package
library(GGAlly)
ggpairs(meuse[,3:6])
#IMPORTANT: when I install a package it is installed forever
#but if I want to use it into an R session i have to recall at the beghinning with library("...")

#####################################################################################################################################
#####################################################################################################################################

#3. R_code_spatial ##################################################################################################################

#R code for spatial view of points
#first thing: reuse the library called "sp"
library(sp) 
#sp has a dataset called meuse
data(meuse)
head(meuse) #it's a spatial dataset, has some coordinates!
#let's explain to R that we are gonna use data that has coordinates:
coordinates(meuse)= ~x+y
#after = we describe the coordinates intervall: X e Y
#we are explaining meuse to think spatially
# ~ it's an ols symbol used by "sp"
plot(meuse)
#let's see spatial points
spplot(meuse, "zinc")
#this command let us see a single variable of the dataset. 
#we see different classes and so different zinc concentration
#exercise: plot the spatial amount of copper)
spplot(meuse, "copper")
spplot(meuse, "copper") #just to se also the title we want
spplot(meuse, "copper", main= "Copper concentration")
#how to change type of rappresentation? 
#in this way we see not classes but circles sized to concentration
bubble(meuse, "zinc")
bubble(meuse, "zinc", main="Zinc concentration")
#exercise: bubble copper in red
bubble(meuse, "zinc", main="Zinc concentration", col="red")
#to insert on R a dataset, we need to create a directory (without capital letter) into C disk
#then we insert all the files we want inside
#setting the working directory for windows
setwd("C:/lab/")
#we associate a name with a dataset and then say that there is a title row
covid <- read.table("covid_agg.csv", head=TRUE)
#to writing TRUE or T is the same
head(covid)
#let's do a plot of case numbers in each country
attach(covid) #so we plot using column names
plot (country, cases)
#if we don't use attach(covid) we need to write:
plot(covid$country, covid$cases)
#but we don't see all the cases into the graph, so we can  we can write labels horizontally or vertically, so we should see them
plot(country, cases, las=0)
#las=0 put labels parallels
plot(country, cases, las=1) #orizzontal labels
plot(country, cases, las=2) #perpendicular labels
plot(country, cases, las=3) #vertical labels
plot(country, cases, las=2, cex.axis=0.5) #to change text dimension

#now we see ggplot. It has 3 components: data, map estetic, geometric function we want touse to graph the data
#intal ggplot2 package
install.packets("ggplot2")
#to load a work space
load("arealavoro_R_covid.RData")
#just to see if R has implemented the command 
ls()
#ls is a command that shows all the processing made into the file
#it shows what data sets and functions a user has defined. 
#When invoked with no argument inside a function, ls returns the names of the function's local variables
#let's introduce ggplot
#it is the most fancy packages in R to do beautiful graphs
library(ggplot2)
#ggplot has a cars database called MPG
data(mpg)
head(mpg)
#3 key components in GGPLOT: data, aes(aestetic function), geometry 
ggplot #function to plot the data
ggplot(mpg, aes(x=displ, y=hwy)) + geom_point() #geometry is separated 
#let's change geometry of the graph using lines
ggplot(mpg, aes(x=displ, y=hwy)) + geom_line()
ggplot(mpg, aes(x=displ, y=hwy)) + geom_polygon()
#back to covid
head(covid) #we use ggplot specifying that point dimension = number of cases
ggplot(covid,aes(x=lon, y=lat, size=cases)) + geom_point()

#####################################################################################################################################
#####################################################################################################################################

#4. R_code_point_pattern_analysis ###################################################################################################

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

 
#####################################################################################################################################
#####################################################################################################################################

#5. R_code_multivar #################################################################################################################

# R code for Multivariate Analysis
setwd("C:/lab/")
install.packages("vegan")
biomes<- read.table("biomes.csv", head=T, sep=",")
#sep is to define the comma as separator
head(biomes) #just to see the first lines
#now we do the multivariate analisys
#the function we use is DEtrended CORrespondence ANAlysis, it changes all in two dimensions 
#20 dimensions in 2 dimensions! 
#we give a name to the function
multivar<- decorana(biomes)
plot(multivar)
#to see the same analysis graph but on its entirety (interezza)
multivar
# eigenvalues shows the percentage of informations we see divided into the 4 acxes in 2d. 
#In particular we see around 80% divided between the firs 2 graphs
# but what do we see in detail?
# tree_ferm is linked to the gigant spider as much to the bufo(mashroom) to fox and squirtle
# each point is a plot 
# now we want to do the UNION of the plots to each bioma
biomes_types<- read.table("biomes_types.csv", head=T, sep=",") #to import a csv file
head(biomes_types)
#let's do the JOIN (unione) of each plot belonghing with the same bioma
attach(biomes_types) #due to we need to reffer to the coloums of this dataset
#it will circle with a line the elements belonghing to the same bioma 
ordiellipse (multivar, type, col=1:4, kind="ehull", lwd=3)
#the function up from here circle, as written at the 28 row
#let's explain it (analisi multivar, type=the coloumn to use for the type of bioma, col= colours for each bioma,
#kind= type of graph (ehull)
#green=tropical forest, red=temperate forest, etc
#spider web that link the plots of a bioma
ordispider(multivar, type, col=1:4, label=TRUE) # label= bioma names
#the 20% of the spieces are not visible
#them would be visible if we add the other two axes
# these species do not enter inside the eclipses
#because they're visible in other dimensions

#####################################################################################################################################
#####################################################################################################################################
    
#6. R_code_rs #######################################################################################################################

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

#####################################################################################################################################
#####################################################################################################################################

#7. R_code_ecosystem_functions ######################################################################################################

#R code to view biomass over the word and calculate changes in ecosystem functions
# we use copernicus: sentinel 2, createt to misure byodiversity
# we use rasterdiv package, created by the Prof.

install.packages(rasterdiv)
install.packages(rasterVis)
library(rasterdiv)
library(rasterVis) # vis=visualization
data(copNDVI)
plot(copNDVI)

# we reclassify data removing the values between 253 and 255, giveing them NA value
copNDVI<- reclassify(copNDVI, cbind(253:255, NA))
levelplot(copNDVI) 
#WITH ONLY ONE FUNCTION WE SEE THE BIOMASS CHANGE FROM 1999 TO NOWADAYS, SO EASY, WITHOUT ANY PROBLEM!

#now we aggregate the values with a factor of 10 (before 8km now 80)
copNDV10<- aggregate(copNDVI, fact=10)
copNDV100<- aggregate(copNDV10, fact=10)

#NEW THEME
#So now we want to study a scenario usefull to reach a sustainble life
#we want to see the BIOMASS DIFFERENCE of amazon forest during one period.
setwd("C:/lab/")
library(raster)
defor1<-brick("defor1_.jpg") #to import the images with all the bands
defor2<-brick("defor2_.jpg")
# band 1: NIR
# band2: R
# band3: G
plotRGB(defor1, r=1, g=2, b=3, stretch="Lin") #just to see
plotRGB(defor2, r=1, g=2, b=3, stretch="Lin") #just to see
par(mfrow=c(1,2))
plotRGB(defor1, r=1, g=2, b=3, stretch="Lin")
plotRGB(defor2, r=1, g=2, b=3, stretch="Lin")

#now we calculate the NDVI index
dvi1<- defor1$defor1_.1 - defor1$defor1_.2 #the dollar is used to link a band inside the image
dvi2<- defor2$defor2_.1 - defor2$defor2_.2
cl<- colorRampPalette(c("darkblue","yellow","red","black"))(100)
#so we obtain 2 NDVI in 2 different period
par(mfrow=c(1,2))
plot(dvi1, col=cl)
plot(dvi2, col=cl)

difdiv=dvi1-dvi2 #now we do the difference between the two NDVI
#warning message:
#In dvi1 - dvi2 :
#Raster objects have different extents. Result for their intersection is returned
#but is not a problem
dev.off()
cld<- colorRampPalette(c("blue","white","red"))(100)
plot(difdiv, col=cld) #we plot the difference
#histogram che mostra bil plot del dvi
hist(difdiv)

#####################################################################################################################################
#####################################################################################################################################

#8. R_code_pca_remote_sensing #######################################################################################################

#let's see the CORRELATION OF DIFFERENT BANDS INTO A PCA GRAPH with more of 3 dimensions
#PCA= it reduces the number of variables (that describes the data) to a lower latents variables number
# it limits as much as possible the loss of informations
setwd("C:/lab/")
library(raster)
install.packages("RStoolbox")
library(RStoolbox)
p224r63_2011<-brick("p224r63_2011_masked.grd")
#b1 blue
#b2 green
#b3 red
#b4 NIR
#b5 SWIR (medium infrared)
#b6 thermal infrared
#b7SWIR (other infrered, with a different wavelength)
#b8 panchromatic
plotRGB(p224r63_2011,r=5, g=4, b=3, stretch="Lin") 
library(ggplot2)

#we do the same with ggpolot
ggRGB(p224r63_2011, 5,4,3)

#the same with the 1988 image
p224r63_1988<-brick("p224r63_1988_masked.grd")
plotRGB(p224r63_1988,r=5, g=4, b=3, stretch="Lin")

par(mfrow=c(1,2))
plotRGB(p224r63_2011,r=5, g=4, b=3, stretch="Lin") 
plotRGB(p224r63_1988,r=5, g=4, b=3, stretch="Lin")

#NOW LET'S USE THE PCA!!!
#(to see the hidden percentage it's enought to change the aixs)
dev.off()
#we attend to see that blu and red are so related  because they're absorbed for photosintesis
names(p224r63_2011) #to see band's names
# "B1_sre" "B2_sre" "B3_sre" "B4_sre" "B5_sre" "B6_bt"  "B7_sre"
# "$" per unire 
plot(p224r63_2011$B1_sre, p224r63_2011$B3_sre)
#with this function, as usual, we se the correlation between only two bands, (b1,b3) and it'hight and +

#let's DO THE PCA
#let's reduce images dimension to avoid that they're too heavy
p224r63_2011_res <- aggregate(p224r63_2011, fact=10)

#now we create the PCA with this function of RStoolbox librart
p224r63_2011_pca <- rasterPCA(p224r63_2011_res)
p224r63_2011_pca # just to see PCA characteristics

#call: it's only the indication of the PCA done over the file
#model: we are using the variables correlation, so it's shows the covariance matrix
#map: map info

#now we plot
#it has different output: the call, the model and the map
#so we plot the map using: $
plot(p224r63_2011_pca$map)
cl<- colorRampPalette(c("dark grey","grey","light grey"))(100)
plot(p224r63_2011_pca$map, col=cl)

#we obtain 7 PC 
#different components: PC1 give us the main part of the components, and gradually PC2, PC3 etc (decreasing the number of components)
# the main PC shows the 90% of all the informations, and the others gradually less. The PC7 maybe it only has unnecessary noise

#now how to see the variation of each PCA
summary(p224r63_2011_pca$model) #it does a summary of the model 
#so it explain all and sum (riassume) each PCA
#we see that PC1 rapresent 99,83 etc of all variability
#so the bands are very correlated. 

#now we see how much each band was correlated to the others, with the function pairs()
pairs(p224r63_2011)
#all the bands are very correlated eachother
#this is the reason why PC1 shows 99,83%

#now we create a new image with PC1, PC2, PC3
plotRGB(p224r63_2011_pca$map, r=1,g=2,b=3, stretch="Lin") #before we have found the names of the differents PCA (PC1 is the first and...)

#we do the same with the 1988 image
p224r63_1988_res <- aggregate(p224r63_1988, fact=10) #aggregation
p224r63_1988_pca <- rasterPCA(p224r63_1988_res) #analysis of every band thank to the PCA
plot(p224r63_1988_pca$map, col=cl)
summary(p224r63_1988_pca$model)
#PC1 =99.56%
pairs(p224r63_1988)

#now we do the DIFFERENCE between PCA 2011 and 1988
difpca<-p224r63_2011_pca$map - p224r63_1988_pca$map  #it does the difference between PC1 1988 with 2011, then the PC2 2011 with PC2 of 1988 etc
cldif<- colorRampPalette(c("blue","black","yellow"))(100)
#let's plot only the difference of PC1
difpca #to see the components
plot(difpca$PC1, cl=cldif ) 
#it shows the biggest possible variation between two images of 2011 and 1988
#we know where there's been the biggest variation!!

#so we have summarize into a single layer the 8 bands of 2011
#we have summarize into a single layer the 8 bands of 1988
#and we calculated the difference, seeing the temporal variation

#####################################################################################################################################
#####################################################################################################################################

#9. R_code_faPAR ####################################################################################################################

#How to look at chemical cycling from satellite
#we use compernicus images (aggregated by prof (pesano meno))
#we use the lights (freq of red and blue): red and blue quantity on lights - (minus) red and blue reflected by the plant
#the light is a proxy che we use to understand the leaves chlorophyll activity

#NOTE: NDVI shows the BIOMASS, not the chlorophyll activity
library(raster)
library(rasterVis)
library(rasterdiv)
setwd("C:/lab/")
copNDVI<-reclassify(copNDVI, cbind(253:255,NA)) #we delete the wather values
levelplot(copNDVI)
faPAR10<-raster("faPAR10.tif") #we aggregate with fact=10
levelplot(faPAR10)
#we see that faPAR is more restrictive than NDVI, because we are not considering biomass but the real plant power  in carbon absorption
#light of sun into conifer forestrs partly falls to the ground
#so partly is not used
#at the equator instead, in tropical forest, light does not reach the grounde, due to plant density,
#so it's fully eplotied (sfruttato)
#now we save on pdf
pdf("copNDVI.pdf")
levelplot(copNDVI)
dev.off()
pdf("faPAR10.pdf")
levelplot(faPAR10)
dev.off()

#Day 2

setwd("C:/lab/")
load("faPAR.RData")
#original faPAR is 2gb
#let's see how much space is needed for an 8 bits set
library(rasterdiv)
library(raster)
#to wright a raster file of a library into the PC
writeRaster(copNDVI, "copNDVI.tif")
#then we see the dimension on pc folder
#only 5.4MB
library(rasterVis)
#faPAR levelplot this set
levelplot(faPAR10)


#LINEAR REGRESSION MODEL between faPAR and NDVI
#erosion exemple
erosion <- c(12, 14, 16, 24, 26, 40, 55, 67) #we create a erosion variable
hm <- c(30, 100, 150, 200, 260, 340, 460, 600) #heavy metals part per millions
plot(erosion, hm, col="red", pch=19, xlab="erosion", ylab="heavy metals") #EASY WITH PLOT FUNCTION
#pch=point character

#we create a math model between these two variables, or rather (ovvero) we need the straight line equation
# of the linear regression
model1<-lm (hm ~ erosion) #or rather (ovvero) y=x 
#in general lm is used to fit linear models. It can be used to carry out regression
#y is hm and x is the erosion
#now we can do the summary of the new model
summary(model1)
#it says:
#intercept
#under it says the slope coefficient
#now we put the stright line equation on the graph
#y=bx+a
abline(model1)
#so compare the straight line on te graph
#in practice: we create the regression model between erosion and hm with the plot,
#but we obtain only the graph, so we create the math model with lm function: lm (hm ~ erosion)
#then we plot the straight line thanks to: abline(model1)

#NOW WE DO A MODEL ABOUT faPAR!!!!!!!!!
setwd("C:/lab/")
library(raster)
faPAR10 <- raster("faPAR10.tif")
library(rasterdiv) #to plot copNDVI that is inside rasterdiv
plot(copNDVI) 
#we delete wather from COPNDVI
copNDVI <- reclassify(copNDVI, cbind(253:255, NA))

#we analize the pixels of faPAR10
faPAR10 #56899584
#we want to simplify
install.packages("sf")
library(rasterVis)
library(sf) # to call st functions
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
pts<-random.points(faPAR10,1000)

#now we associate the faPAR10 and COPNDVI values to these random points 
#with the function EXTRACT
pts <- random.points(faPAR10,1000) #we use only
copNDVIp <- extract(copNDVI, pts)
faPAR10p <- extract(faPAR10,pts)

#photosyntesis (y) vs biomass (x) model
model2<-lm(faPAR10p ~ copNDVIp)
summary(model2)
plot(copNDVIp,faPAR10p,col="green")
abline(model2, col="red")
#so we have extracted 1000 random values from the rasters of cpNDVI and faPAR and 
#we calculate the correlation with a linear regression model

#two wariables are correlated but not so much
#the C02 taken dipends not only about the biomass but also from the kind of plants
#for exemple: ther's a lot of biomass in european forests, but it do not produce as much photosintesys as the equetors forests do
#it's visible also doing the levelplot of copNDVI and faPAR10

#####################################################################################################################################
#####################################################################################################################################

#10. R_code_radiance#################################################################################################################

#let's TRANSFORM A RADIANCE VALUE IN BITS (for pixels)
library(raster)
#let's create a new raster with 2 rows and 2 colloumns
#let's invent the data
toy<- raster(ncol=2, nrow=2, xmn=1, xmx=2, ymn=1, ymx=2)
values(toy) <- c(1.13,1.44,1.55,3.4)
plot(toy)
text(toy, digits=2)#we put over the text and "digit" describes the number of decimal places (cifre decimali)

#now let's transform
#we change the data range into a set(insieme) of 4 possible potential data
#so 2^2=4 #4 combinations: 00 01 10 11, with 4 possible values: 0 1 2 3
toy2bits <- stretch(toy,minv=0,maxv=3) 
storage.mode(toy2bits[]) = "integer"  # means that we use integer numbers = numeri interi
plot(toy2bits)
text(toy2bits, digits=2)

#let's create a new raster with 4bits
# so 16 combinations, form 0 to 15
toy4bits <- stretch(toy,minv=0,maxv=15) #so the stretch it the command that stretch the data inside a new range
storage.mode(toy4bits[]) = "integer"
plot(toy4bits)
text(toy4bits, digits=2)
#if we increase the number of bits we increase the range and so the difference between the values
#to better describe the initial numerical values.

#with 8 bits = 2^8= 256 possible values
#so we stretch the initial toy values into 256 values 
toy8bits <- stretch(toy,minv=0,maxv=255)
storage.mode(toy8bits[]) = "integer"
plot(toy8bits)
text(toy8bits, "digits=2)

#now we plot all togheter with the par function
par(mfrow=c(1,4))
plot(toy)
text(toy, digits=2)
plot(toy2bits)
text(toy2bits, digits=2)
plot(toy4bits)
text(toy4bits, digits=2)
plot(toy8bits)
text(toy8bits, digits=2)
#highter is the number of bits (of pixels), highter is the  discriminance between the original values
#there's alsto an inverse function that calculate the radiance from a pixels matrix
dev.off()

library(rasterdiv)
plot(copNDVI)
 
#like here, the the majority of cases the frequency values ​​are expressed in 8bits (265)
#at most in 16bits
 
#####################################################################################################################################
#####################################################################################################################################

#11. R_code_EBVs ####################################################################################################################

#Essential Biodiversity variables
#let's calculate some biodiversity statistics indices
setwd("C:/lab/")
library(raster)
#raster it's a command that import only one band
#we use brick so we import all the bands
snt<-brick("snt_r10.tif") #snt means sentinel
snt
#it shows 4 bands  
#B1=blu
#B2=green
#B3=red
#B4=NIR
plot(snt) #it shows 4 rasters
#R3 G2 B1  NIR
plotRGB(snt,3,2,1, stretch="lin") #we can decide 3 bands order and plot togheter
plotRGB(snt,4,3,2, stretch="lin")

#let's calculate standard deviation (variabiility)
#it can be calculated for only one layer
#so we can obtain only one layer with multivariate analisys and calculate st.dev on this layer 
#so from these 4 band we create only one layer
#and on this we calculate st.deviation
pairs(snt) #to se the correlation between all bands

#SO LET'S CREATE THE PCA
library(RStolbox)
sntpca<-rasterPCA(snt)
sntpca
summary(sntpca$model) #we see into $model that PC1 explain the 70% of all data
plot(sntpca$map)

#Now we plot on RGB just to see three components into a good way (psichedelic)
plotRGB(sntpca$map, 1, 2, 3, stretch="lin")

#now we calculate PC1 stand. dev PC1 with a pixel window 5x5
#let's say to R  that we use a moving window (that analize 5x5 pixels) 
#we create a matrix 5x5 (we don't care about its values)
window <- matrix(1, nrow = 5, ncol = 5) #all pixels have value 1(so they do not impact and are considered empty)
#the function to move the window is "focal"
#focal function means: it calculate values for the neighborhood of focal cells
#so it calculate the function you set (sd=standard deviation) for the neighborhood of the windows you define
#and it makes for all the possible neighborhoods
sd_str<- focal(sntpca$map$PC1, w=window, fun=sd) #sd=standard dev and w is the windows 
cl <- colorRampPalette(c('dark blue','green','orange','red'))(100)
plot(sd_str)
par(mfrow=c(1,2))
plotRGB(snt,4,3,2, stretch="lin", main="original image") 
plot(sd_snt, col=cl, main="diversity")
#veriability increases on ecotone zones, or rather the borders between ecosystems

#the same algorithm applyed to a DIFFERENT IMAGE
#cladonia exemple
#we want to DEMOSTRATE THAT THE ALGORITHM CAN BE APPLYED TO ANY IMAGES
#also to a lichen photograph
setwd("C:/lab/")
library(raster)
#it's an RGB immages so we need to use Brick
clad<-brick("cladonia_stellaris_calaita.JPG")
plotRGB(clad,1,2,3, stretch="lin") #bands are yet in order
# create the window
window <- matrix(1, nrow = 3, ncol = 3) #numeber 1 is a fixed abritaty value that do not impact on the calculation
#we use focal function
#we see the 3 bands correlation
pairs(clad)
#they're very correlated, and we could use only one, but let's create the PCA
library(RStoolbox)
cladpca<-rasterPCA(clad)
cladpca
#we obtain:
#the call
#the model
#map
#let's do the summary
summary(cladpca$model)
#PC1=98% 
#plot in RGB the pca
plotRGB(cladpca$map, 1, 2, 3, stretch="lin")

#let's do the moving window measure
sd_clad<-focal(cladpca$map$PC1, w=window, fun=sd) #fun=sd:standard deviation
#if it will be to heavy and it use too much time we can aggregate the image
PC1_agg<-aggregate(cladpca$map$PC1, fact=10) #aggregation
sd_clad_agg<-focal(PC1_agg, w=window, fun=sd)
#let's create a colour palette
cl <- colorRampPalette(c('yellow','violet','black'))(100)
par(mfrow=c(1,3))
cl <- colorRampPalette(c('yellow','violet','black'))(100) #
plotRGB(clad,1,2,3, stretch="lin")
plot(sd_clad, col=cl)
plot(sd_clad_agg, col=cl)

#the second graph shows normal stand dev and the third the aggregated once
#it describes the individual complexity in all its parts 
#obviusly with the aggregation we have a different image

#####################################################################################################################################
#####################################################################################################################################

#12. R_code_snow.r ##################################################################################################################

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

#A FASTER method to import and plot 
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
#PREDICTION!
#how the snow will change in the future?
#we can predict something using a regression model
#so we can usa a function called: ordinary least square regrassion to se the values expected in a fixed future period
#lst's see the prediction function!
#we do it with a function prepared by the prof: "prediction"
source("prediction.r") #prediction.r make a prediction
#source is a function that take a certain file and use it like a code
#soucre read R code from a file!
#but let's see in detail prediction.r 
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

# DAY 2
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

#####################################################################################################################################
#####################################################################################################################################

#13. R_code_no2 #####################################################################################################################

setwd("C:/lab/NO2/")
library(raster)
#first we make the list of the files we are going to import
#the function is list.files 
nlist<-list.files(pattern="EN") #pattern=EN (watch out at capital letters)
nlist #to see the output of the function
#now we apply the function lapply to the list called nlist
#use lapply to use raster to all the nlist
import<-lapply(nlist,raster)
#now we do a STACK, so we put togheter a number of layer of NO2
EN<-stack(import)
EN #to see stack details
#NOTE: the images we used has only one band, they are not RGB
#with raster function we import only one band that has the value highter following the scale describes into the legend of the images
cl <- colorRampPalette(c('darkblue','blue','light blue','yellow','orange','red','dark red'))(100)
plot(EN, col=cl)
#let's plot only two images
par(mfrow=c(1,2))
plot(EN$EN_0001, col=cl)
plot(EN$EN_0013, col=cl)

#now we do a strange RGB image
#we built a 3 layer image based on RGB space
#a single image with:
#r= EN_0001 image (jenuary)
#g= EN_0007 image(february)
#b= EN_0013 image (march)
#so where there are highter values the image thakes the red, green or blue color
#so we understand in wich month there's been the highter values and where!!!
#so cool, the yellow is a mix of the tree colors
plotRGB(EN, r=1, g=7, b=13, stretch="lin")
#we use 3 images of the stack called EN
png("impressive.png")
plotRGB(EN, r=1, g=7, b=13, stretch="lin")
dev.off()

#let's make a different map (difference between 0013 - 0001)
cl2 <- colorRampPalette(c('blue','white','red'))(100)
dif<-EN$EN_0013 - EN$EN_0001,
plot(dif, col=cl2)

##let's do some STATISTICS
#let's do with the ages
mean(c(22,23,24,24,24))
#23.4
median(c(22,23,24,24,24))
#median is 24
#median is important because if we put prof age
mean(c(22,23,24,24,24,44)) #26.83
median(c(22,23,24,24,24,44)) #24
#the mean changes but not the median
#the mean if we got outlayer data could be a problem

#create a box plot
#y aix: the different times 
#boxplot takes in any number of numeric vectors, drawing a boxplot for each vector
boxplot(EN)
#in black the outlayers
#to remove them:
boxplot(EN, outline=F) #F=false
#to make it orizontaly
boxplot(EN, outline=F, horizontal=T) #T=true
#put the axes names
boxplot(EN, outline=F, horizontal=T, axes=T)
#the bolt black line is the median
#the lines at the ends are minimum and maximus
#over time maximus is decreased 

#now other kind of graph
#let's put image 1 on x aix
#image 13 aix y
#we obtain a 45° line that describes corrispondence 1 to 1 (y=x)
#the data majority will be under this line, because the image 1 has highter values
#x=y is the not changeing line 
#so, for each pixel there's a place into the graph and the values of the two images (of thesame pixels) are related
#if values are the same, that pixel will be on the straight line, otherwise no
plot(EN$EN_0001, EN$EN_0013)
#and to put the line
abline(0,1, col="red") #0,1 it means x=y

#let's play a bit
#1:1 line with snow data
#so we prepare the work area
rlist 
import<-lapply(rlist,raster) 
snow.multitemp<-stack(import) 
plot(snow.multitemp)
#now let's do the graph
plot(snow.multitemp$snow2010r, snow.multitemp$snow2020r)
abline(0,1)
#the bold square it's linked to simulated datas of 2010
plot(snow.multitemp$snow2000r, snow.multitemp$snow2020r)
abline(0,1,col="red")
#we see that hight walues of snow cover are always under the red line so it means that there's a decrease of snow

#####################################################################################################################################
#####################################################################################################################################

#14. R_code_crop&zoom ###############################################################################################################

#How to crop and zoom
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
#and we can do the same for the crop, using the mouse and drowing a rectangle
crop(snow, drawExtent())

#####################################################################################################################################
#####################################################################################################################################

#15. R_code_interpolation ###########################################################################################################

setwd("C:/lab/")
#to import a csv file (it's a table) we use
library(spatstat) #the same package we use to calculate point density
#function to import:
inp<-read.table("dati_plot55_LAST3.csv", sep=";", head=T) #sep=separator and head= there's a titlle for the coloums
head(inp)
#the table has the coordinatex X and Y (x=metric distance from the first meridian and Y from the equator)
#table has also the slope
#C.cov=canopy cover from 100 to 0 (copertura della chioma)

#we are going to estimate the canopy cover where there's not the value!
attach(inp)
#plot(inp$X, inp$Y) or:
plot(X,Y) #because we have attach the table

#let's do the planar point pattern: we explayn the X, the Y of our dataset and they'r range
#in this way R can understand the known area
#to see the X and Y max and min:
summary(inp)
#X= 7
inppp <- ppp(x=X, y=Y, c(716000,718000),c(4859000,4861000)) #we explain the coordinates and the range
#now we use the function: marks
#R don't know the value of the point it plottet
#we are going to give this information to R
#we marks the inpppp with the canopy cover!
names(inppp) #just to see the name of te Canoly cover
#now we use marks
marks(inppp) <- Canopy.cov
#so now we have the point and their canopy cover values

#NOW let's ESTIMATE THE VALUES 
#the function is: Smooth that interpolates the data
canopy <- Smooth(inppp)
plot(canopy) #we plot the interpolated map
points(inppp, col="green") #we put the points over the map
#highter density on south est


#Now we want to mark the lichens information of quantity
marks(inppp) <- cop.lich.mean #the lichens
lichs <- Smooth(inppp)
plot(lichs)
points(inppp)
#hight ammount of lichens on north west

#now let's plot the images togheter
par(mfrow=c(1,2))
plot(canopy)
points(inppp)
plot(lichs)
points(inppp)
dev.off()
#there's no relation between the two maps

#final plot:
par(mfrow=c(1,3))
plot(canopy)
points(inppp)
plot(lichs)
points(inppp)
plot(Canopy.cov, cop.lich.mean, col="red",pch=19, cex=2)
#we have not many point to calculate a linear regression between the two variables

#LET'S PLAY WITH A NEW SET
#psammophilus vegetation
inp.psm<-read.table("dati_psammofile.csv", sep=";", head=T)
attach(inp.psm)
summary(inp.psm)
plot(E,N) #x=E and y=N
summaty(inp.psm)
#to see coordinates maximum and minimum
inp.psm.ppp <- ppp(x=E,y=N,c(356450,372240),c(5059800,5064150))
#we need to do the mark
#we mark the orgaic carbon
marks(inp.psm.ppp) <- C_org
#NOW let's ESTIMATE THE VALUES 
Carbon <-Smooth(inp.psm.ppp)
plot(Carbon)
points(inp.psm.ppp, col="green")

#####################################################################################################################################
#####################################################################################################################################

#16. R_code_sdm #####################################################################################################################

# Species Distribution Modelling
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
    
plot(p1, col=cl)
points(species[species$Occurrence == 1,], pch=16)
#so we obtain the plot of the probability of distribution of the specie on the space

#we create a stack with the predictors and the prediction
s1 <- stack(preds,p1)
plot(s1, col=cl)

#####################################################################################################################################
#####################################################################################################################################

#17. R_code_exercise #####################################################################################################################

#directory and libraries
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

#CO2 PREVISION
source("predictionCo2.r")
#################
#predictionCo2.r code:
## prediction
require(raster)
require(rgdal)
# define the extent
ext <- c(-180, 180, -90, 90)
extension <- crop(serieC02, ext)
# make a time variable (to be used in regression)
time <- 1:nlayers(serieC02)
# run the regression
fun <- function(x) {if (is.na(x[1])){ NA } else {lm(x ~ time)$coefficients[2] }} 
predicted.co2 <- calc(extension, fun) 
#################

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

#CO2 DIFFERENCE
dif<- (serieC02$PC1s_all.17 - serieC02$PC1s_all.1)
dif
plot(dif)
click(dif, n=Inf, id=FALSE, xy=FALSE, cell=FALSE, type="n", show=TRUE)
d <- reclassify(dif, cbind(0.0007800222,NA))
png("co2_dif.png", width = 4, height = 4, units = 'in', res = 1200)
plot(d, col=cl, main="Differenza CO2 2018-2002")
dev.off()

#CORRELATION BETWEEN PREVISION AND DIFFERENCE 
plot(x,d)
png("co2_corr_prev_diff.png") 
plot(x,d, main="Correlazione fra CO2 prevista e differenza annuale", ylab="Immagine previsione", xlab="Immagine dif")
dev.off()

#TIME TREND
#let's put image 1 on x aix and image 17 on aix y
#we obtain a 45° line that describes corrispondence 1 to 1 (y=x)
#the data will be under this line if the image 1 has highter values
#x=y is the not changeing line 
#if values are the same, that pixel will be on the straight line, otherwise no
png("Trend C02.png")
plot(serieC02$PC1s_all.1, serieC02$PC1s_all.17, main="CO2 variation (2018-2002)", ylab="CO2 2018", xlab="CO2 2002")
abline(0,1,col="red")
dev.off()

#NDVI EVOLUTION OVER THE TIME
rNlist<-list.files(pattern="c_gls_NDV")
rNlist
importN<-lapply(rNlist,raster)
NDVI.multitemp<-stack(importN)
NDVI.multitemp
summary(NDVI.multitemp)
clN <- colorRampPalette(c('light green','green','dark green'))(100)
plot(NDVI.multitemp$Normalized.Difference.Vegetation.Index.1KM.1)
click(NDVI.multitemp$Normalized.Difference.Vegetation.Index.1KM.1, n=Inf, id=FALSE, xy=FALSE, cell=FALSE, type="n", show=TRUE)
NDVI.multitempR<- calc(NDVI.multitemp, fun=function(x){ x[x > 0.936000] <- NA; return(x)} )

#############
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
#so we understand in wich year there's been the highter values and where!!!

#NDVI STANDARD DEVIATION
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

#GENERAL MODEL:
#Let's create a general model that rapresent into one layer: NDVI, C02, Temperature and built ground cover
#in this way we can express the land vulnerability to heat waves
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

#####################################################################################################################################
#####################################################################################################################################

