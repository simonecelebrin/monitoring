# Point pattern analysis: Density map

#installare libreria che ci permetterà di fare questa analisi
install.packages("spatstat")
library(spatstat)
attach(covid)
head(covid)
#convert the data to a point pattern object using the spatstat command ppp
covids<- ppp(lon,lat, c(-180,180), c(-90,90)) #The general form is covids<- ppp(x.coordinates, y.coordinates, x.range, y.range)
#senza fare attach la funzione diventa
#covids<- ppp(covis$lon, covid$lat, c(-180,180), c(-90,90))
# c sta per clasterizzare i dati tutti assieme. è il range
# ora facciamo una mappa di densità
d<- density(covids)
plot(d)
#mettiamo i punti sopra 
points(covids)

setwd("C:/lab/")
load("point_pattern_analysis.RData")
ls()
#covid: point pattern
#d: was the density map
library(spatstat)
plot(d)
#ora mettiamo sopra i punti
points(covids)
#ora carichiamo la base dei continenti, e la carichiamo come un file linea da un database. 
#3 tipi di vettori in R. i soliti 3: ounti, linee, poligoni
#installiamo rgdall
install.packages("rgdal")
library(rgdal)
#inseriamo il vettore linee delle coste con estensione shp
coastlines<- readOGR("ne_10m_coastline.shp")
#per incollare linee sopra 
plot(coastlines, add=T)
#per cambiare i colori (dentro la C descriviamo il claster dei colori) e mettiamo (100) come scala di colori
cl<- colorRampPalette(c("yellow","orange", "red")) (100)
plot(d,col=cl) #per attuare la palette che abbiamo creato sopra, riplottiamo la funzione d con la fz colore: col=cl
#poi rimettiamo sopra punti e linee
points(covids)
plot(coastlines, add=T)

#creo una nuova rampa di colori
cl2<- colorRampPalette(c("blue","green", "yellow","orange", "red")) (50)
> plot(d,col=cl2, main= "Densities of covid-19")
> points(covids)
> plot(coastlines, add=T)
#come esportare una mappa (in pdf)
pdf("covid_density.pdf") #e poi mettere tutte le cose da stampare
cl2<- colorRampPalette(c("blue","green", "yellow","orange", "red")) (50)
> plot(d,col=cl2, main= "Densities of covid-19")
> points(covids)
plot(coastlines, add=T)
dev.off() #per chiudere

#e troviamo il file nella cartella
