# R code for remote sensing data analysis
#dopo installiamo questi pacchetti
#raster
install.packages("raster")
install.packages("RStoolbox")
setwd("C:/lab/")
library(raster)
#per importare un set di bande raster 
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
par(mfrow=c(2,2)) #par significa: fare un grafico con 2x2 plot=4. 2 rows e 2 colums. 
#se mettiamo (2,1) allora 2 rows and 1 column
#lo mettiamo (2,2) perchè faremo un grafico di 4 bande. e per ogni riquadro avremo un grafico
# praticamente mi crera un area con 4 grafici che vado a plottare

#B1=blue
clb<- colorRampPalette(c("dark blue", "blue", "light blue")) (100)
plot(p224r63_2011$B1_sre, col=clb) #$ per richiamare un solo plot

#B2=green
clg<-colorRampPalette(c("dark green", "green", "light green")) (100)
plot(p224r63_2011$B2_sre, col=clg)

#B3= red
clr<-colorRampPalette(c("dark red", "red", "pink")) (100)
plot(p224r63_2011$B3_sre, col=clr)

#B4= NIR
cln<-colorRampPalette(c("red", "orange", "yellow")) (100)
plot(p224r63_2011$B4_sre, col=cln)

#cambiamo par
par(mfrow=c(4,1))
dev.off() #per chiudere il par

#ora mettiamo 2 o 3 bande una sopra l'altra per vedere il plot come lo vedremmo noi o come lo vogliamo
#come monta i colori il pc?
# RGB sono i 3 componenti per rendere i colori visibili.
# dobbiamo associare la banda 3 ad esempio al rosso e così per ogni colore (RGB)

#plotRGB
plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="Lin") #stratch è lo stratching lin(=lineare) ovvero il "tiraggio" dei vari colori per vederli meglio
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin") #evidenziamo gli oggetti con un alta banda di NIR. e diventano rossi perchè li abbiamo associati al rosso. 
#la parte in rosa che compare è l'agricoltura
#altro esempio NIR on top of the G component of RGB
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=2, b=4, stretch="Lin")

#new lesson
#carico dati salvataggio
setwd("C:/lab/")
load("rs.RData")
ls() #per avere una lista di dati caricati
p224r63_1988<- brick("p224r63_1988_masked.grd") #così importo nuova mappa con più bade
plot(p224r63_1988)

#exercise: plot in visible RGB 321 both images

par(mfrow=c(2,1)) #2 righe, 1 colonna
p224r63_2011<- brick("p224r63_2011_masked.grd") #necessario ricaricare l'immagine se no da errore
plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="Lin")
plotRGB(p224r63_1988, r=3, g=2, b=1, stretch="Lin")

 #stretch: se abbiamo colori da 50 a 100 con lo strach li allunghiamo da 0 a 100. per vedere più valori dettagliati.
#ora mostriamo il NIR sciftando tutto di una posizione 
#plot in false colour RGB 432 both images
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_1988, r=4, g=3, b=2, stretch="Lin")

#plot in false colour RGB 324 both images
plotRGB(p224r63_2011, r=3, g=2, b=4, stretch="Lin")
plotRGB(p224r63_1988, r=3, g=2, b=4, stretch="Lin")

#analizziamo il noise (il rumore) di queste immagini
#abbiamo 2 modi
#1 usare un altro tipo di stretch: histogram 
#mostra il rumore, magari dovutio all'umidità. è molto visibile nel 1988 
#(più verde, più eapo traspirazione, più rumore da umidità, oltre che al sensore meno capace ovviamente)
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="hist")
plotRGB(p224r63_1988, r=4, g=3, b=2, stretch="hist")
#histogram stretch: fa l'integrale e fa uno shock dei dati, perchè classificsa i dati in piccole classi di cui fa 
#il rettangolo e ppoi cambia classe di colore

#ORA COMPARIAMO L'INDICE DI VEGETAZIONE DELLE 2 FOTO
#DVI= vegetation index= NIR-RED

#bands of landsat
# B1= blue
#B2= green
#B3= red
#B4=NIR
#B5=medium IR
#B6= Termal red
#B7= medium IR

#creiamo l'indice
dvi2011<- p224r63_2011$B4_sre -p224r63_2011$B3_sre
cl<- colorRampPalette(c("darkorchid3", "light blue", "lightpink4")) (100)
plot(dvi2011,col=cl)

#the same for 1988
dvi1988<- p224r63_1988$B4_sre -p224r63_1988$B3_sre
cl<- colorRampPalette(c("darkorchid3", "light blue", "lightpink4")) (100)
plot(dvi1988,col=cl)

#ora si fa la differenza
dif<- dvi2011-dvi1988
plot(dif)

#ora dobbiamo considerare la scala 
#cambiamo la dimensione dei pixel
#grain è la risoluzione in remote sensing
#aggrega pixel #fact= fattore= di quanto aumentiamo i pixel
#res sta per resample. ovvero fare resampling dei pixel
p224r63_2011res<- aggregate(p224r63_2011, fact=10)
p224r63_2011res100<- aggregate(p224r63_2011, fact=100)

par(mfrow=c(3,1))
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_2011res, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_2011res100, r=4, g=3, b=2, stretch="Lin")

#se scrivo solo
p224r63_2011
#vedo le info base di cisascun immagine
#non servono sempre dati super dettagliati perchè a volte aumentano il volume. bisogna sempre vedere il fine


