# Point pattern analysis: Density map

#installare libreria che ci permetterà di fare questa analisi
install.packages("spatstat")
library(spatstat)
attach(covid)
head(covid)
covids<- ppp(lon,lat, c(-180,180), c(-90,90))
#controlla bene cosa significa questo codice qui sopra!
#senza fare attach la funzione diventa
#covids<- ppp(covis$lon, covid$lat, c(-180,180), c(-90,90))
# c sta per clasterizzare i dati tutti assieme. se ho due numeri descriventi una certa variabile.
# ora facciamo una mappa di densità
d<- density(covids)
plot(d)
#mettiamo i punti sopra 
points(covids)
