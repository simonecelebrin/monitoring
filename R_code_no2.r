#R_code_no2.r

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

################let's do some statistics
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
#la linea nera grossa è la mediana
#la linea degli estremi è minimo e massimo
#si vede che il massimo è diminuito nel tempo

#ora altro tipo di grafico
#mettiamo asse x immagine 1
#immagine 13 asse y
#ci viene una linea a 45 gradi che descrive le corrispondenze 1 a 1 (y=x)
#la maggior parte dei dati allora sarà sotto questa linea perchè l'immagine 1 ha i valori più elevati
#x=y è la linea di non cambiamento. 
#quindi per ogni pixel c'è un posto sul grafico e si mettono in relazione i valori fra due immagini. se corrispondono allora quel pixel starà sulla retta, altrimenti no.

plot(EN$EN_0001, EN$EN_0013)
#and to put the line
abline(0,1, col="red") #0,1 significa x=y

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

