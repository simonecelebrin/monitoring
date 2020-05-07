#vedremo la correlazione di varie bande in un grafico pca con più di 3 dimensioni
#PCA=  ridurre il numero più o meno elevato di variabili che descrivono
 # un insieme di dati a un numero minore di variabili latenti,
 # limitando il più possibile la perdita di informazioni


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
#b7SWIR (un altro medium infrared, con un'altra lunghezza d'onda)
#b8 panchromatic

plotRGB(p224r63_2011,r=5, g=4, b=3, stretch="Lin") 
library(ggplot2)

#facciamo lo stesso con la funzione ggplot
ggRGB(p224r63_2011, 5,4,3)

#lo stesso con immagine 1988
p224r63_1988<-brick("p224r63_1988_masked.grd")
plotRGB(p224r63_1988,r=5, g=4, b=3, stretch="Lin")

par(mfrow=c(1,2))
plotRGB(p224r63_2011,r=5, g=4, b=3, stretch="Lin") 
plotRGB(p224r63_1988,r=5, g=4, b=3, stretch="Lin")

#ora usiamo il metodo PCA
#per vedere anche la percentuale nascosta basta cambiare gli assi
dev.off()

#ci aspettiamo che blu e rosso siano molto correlate perchè sono assorbite per la fotosintesi
names(p224r63_2011) #per vedere i nomi delle bande
# "B1_sre" "B2_sre" "B3_sre" "B4_sre" "B5_sre" "B6_bt"  "B7_sre"

# "$" per unire 
plot(p224r63_2011$B1_sre, p224r63_2011$B3_sre)
#con questa funzione vediamo la correlazione b1 e b3, ed è positiva

#facciamo analisi PCA

#riduciamo la risoluzione dell'immagine per evitare che diventi troppo pesante
p224r63_2011_res <- aggregate(p224r63_2011, fact=10)

#ora la funzione PCA la attuiamo con questo comando della libreria RStoolbox
p224r63_2011_pca <- rasterPCA(p224r63_2011_res)
p224r63_2011_pca # per vedere le caratteristiche del PCA

#call: è solo l'indicazione della PCA svolta sul file
#model: stiamo usando la correlazione tra le variabile quindi la matrice di covarianza
#map: info sulla mappa

#ora la plottiamo
#ha diversi output: la call, il model e la mappa
#quindi plottiamo la mappa usando il $

plot(p224r63_2011_pca$map)
cl<- colorRampPalette(c("dark grey","grey","light grey"))(100)
plot(p224r63_2011_pca$map, col=cl)

#ci da 7 PC 
#varie componenti: PC1 ci da tutte le componenti, e via via PC2, PC3 ecc riducono le componenti
# il componente principale ci da magari il 90% di info e via via di meno gli altri. Il PC7 ha magari solo del rumore inutile

#ora come vedere la variazione di ogni componente in un PC
summary(p224r63_2011_pca$model) #fa un sommario del modello 
#così ti spiega tutto riassumento per ogni PC plottato
#e vediamo che il PC1 rappresenta il 99,83 ecc della variabilità, quindi le bande erano molto correlate. 

#ora vediamo quanto ogni banda era correlata con l'altra con la funzione pairs()
pairs(p224r63_2011)
#tutte le bande sono molto correlate, per quello nel PC1 sta il 99,83%

#ora componiamo una immagine nuova con il PC1, PC2, PC3

plotRGB(p224r63_2011_pca$map, r=1,g=2,b=3, stretch="Lin") #ricerchiamo i nomi delle componenti (PC! è la prima ecc...

#facciamo lo stesso con foto 1988
p224r63_1988_res <- aggregate(p224r63_1988, fact=10) #aggreghiamo
p224r63_1988_pca <- rasterPCA(p224r63_1988_res) #analisi di tutte le bande con PCA
plot(p224r63_1988_pca$map, col=cl)
summary(p224r63_1988_pca$model)
#PC1 =99.56%
pairs(p224r63_1988)

#ora facciamo la differenza di PCA dal 2011 al 1988
difpca<-p224r63_2011_pca$map - p224r63_1988_pca$map  #differenza tra PC1 2011 e PC1 1988 e poi PC2 e poi avanti
cldif<- colorRampPalette(c("blue","black","yellow"))(100)
#plottiamo solo PC1 del difpca
difpca #per vedere componenti
plot(difpca$PC1, cl=cldif ) 
#ci mostra la piu grande possibile variazione tra due immagini 2011 e 2988, dove c'è stata la più grande variazione
#abbiamo riassunto in un layer le 8 bande del 2011
#abbiamo riassunto in un layer le 8 bande del 1988
#abbiamo fatto la differenza fra i due, vedendo le variazione temporale


