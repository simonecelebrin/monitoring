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

ora la funzione PCA la attuiamo con questo comando della libreria RStoolbox
p224r63_2011_pca <- rasterPCA(p224r63_2011_res)
