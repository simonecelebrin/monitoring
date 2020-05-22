#Essential Biodiversity variables
#calcoliamo alcuni indici statistici per la biodiversità
setwd("C:/lab/")
library(raster)
#raster è un comando che importa solo una banda
#usiamo comando brick così importiamo tutte le bande
snt<-brick("snt_r10.tif") #snt sta per sentinel 
snt
#4 bande con 
#B1=blu
#B2=green
#B3=red
#B4=NIR
plot(snt)
#R3 G2 B1  
plotRGB(snt,3,2,1, stretch="lin")
plotRGB(snt,4,3,2, stretch="lin")

#calcoliamo la dev.stand (variabilità)
#può essere calcolata solo per un layer
#lo facciamo con l'analisi multivariabile (che da più variabile ne crea solo una)
#quindi da queste 4 bande ne creiamo solo una
#da li calcoliamo la dev sta
pairs(snt) #per vedere la correlazione tra le due

#CREIAMO QUINDI PCA
library(RStolbox)
sntpca<-rasterPCA(snt)
sntpca
summary(sntpca$model) #vediamo nel $model che PC1 riassume il 70%
plot(sntpca$map)

#ora plottiamo in RGB giusto per vedere le 3 componenti in modo carino psichedelico
plotRGB(sntpca$map, 1, 2, 3, stretch="lin")

#ora calcoliamo dev stand del PC1 con finestra pixel 5x5

 #spieghiamo al software che unsiamo una moving window quella che analizza 5x5 
#creiamo allora la matrice 5x5 (i suoi valori non ci interessano)
window <- matrix(1, nrow = 5, ncol = 5) #tutte le finestre hanno valore 1 (così non impattano e sono considerate vuote)
#la funzione per spostare la finestra è "focal"
#focal fz significa che: it calculate values for the neighborhood of focal cells
#quindi per un intorno def dalla windows lui calcola la fz che gli dici. e lo fa per tutti gli intorni possibili
sd_str<- focal(sntpca$map$PC1, w=window, fun=sd) #sd=standard dev e w è la finestra creata prima
cl <- colorRampPalette(c('dark blue','green','orange','red'))(100)
plot(sd_str)
par(mfrow=c(1,2))
plotRGB(snt,4,3,2, stretch="lin", main="original image") 
plot(sd_snt, col=cl, main="diversity")
#si vede che la variabilità aumenta nelle zone di ecotono, i bordi da un ecosistema all'altro

