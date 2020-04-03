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
