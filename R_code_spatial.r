# R code for spatial view of points

# first thing: reuse the library called "sp"
library(sp) 
# sp has a dataset called meuse
data(meuse)
head(meuse) #it's a spatial dataset, has some coordinates!
#let's explain to R that we are gonna use data that has coordinates:
coordinates(meuse)= ~x+y
#dopo l'uguale descriviamo intervallo coordinate: X e Y
#stiamo spiegando a meuse to think spatially
# ~ è un simbolo vecchio che usa "sp"
plot(meuse)
#vediamo i punti nello spazio
spplot(meuse, "zinc")
#con questo comando invece usiamo il dataset in una variabile localizzata. 
#vediamo varie classi e quindi diverse concentrazioni di zinco
#exercise: plot the spatial amount of copper)
spplot(meuse, "copper")
spplot(meuse, "copper") #per vedere anche il titolo che vogliamo
spplot(meuse, "copper", main= "Copper concentration")
# per cambiare simbolo e vedere non in classi ma in cerchi dimensionati alla concentrazione
bubble(meuse, "zinc")
bubble(meuse, "zinc", main="Zinc concentration")
#exercise: bubble copper in red
bubble(meuse, "zinc", main="Zinc concentration", col="red")
#per inserire un dataset in R creiamo una cartella senza capital letter nel disco C del computer e poi inseriamo i file cvs nella cartella
#setting the working directory for windows
setwd("C:/lab/")
#associamo un nome ad un dataset e poi diciamo che c'è una riga titolo
covid <- read.table("covid_agg.csv", head=TRUE)
#scrivere TRUE o T è uguale
head(covid)
#facciamo un plot di numeri di casi per paesi
attach(covid) #così facciamo i plot usando i nomi delle colonne
attach(covid)
plot (country, cases)
#se non si fa attach(covid) si deve scrivere
plot(covid$country, covid$cases)
#ma non vediamo tutti i casi nel grafico, allora possiamo scrivere etichette in orizzontali o verticali, così dovremmo vederli.
plot(country, cases, las=0)
#las=0 si mettono labels parallele
plot(country, cases, las=1) #orizzontal labels
plot(country, cases, las=2) #perpendicular labels
plot(country, cases, las=3) #vertical labels
plot(country, cases, las=2, cex.axis=0.5) #per cambiare dimensione scritte
#vediamo ggplot ha 3 componenti: dati, estetica della mappa, funzione geometrica che vuoi usare per graficizzare dati
#intal ggplot2 package
install.packets("ggplot2")


