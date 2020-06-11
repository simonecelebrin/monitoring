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


