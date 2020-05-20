#How to look at chemical cycling from satellite
#usiamo le immagini compernicus aggregate del prof (pesano meno)
#usiamo la luce (freq rosso e blu): rosso e blu luce - rosso e blu riflesso dalla pianta
#la luce quindi è un proxy che usiamo per comprendere l'attività clorofilliana delle foglie

#NOTA: NDVI calcola la biomassa non l'att. clorofilliana

library(raster)
library(rasterVis)
library(rasterdiv)
setwd("C:/lab/")

copNDVI<-reclassify(copNDVI, cbind(253:255,NA))
levelplot(copNDVI)

faPAR10<-raster("faPAR10.tif") #10 perchè prof ha aggregato con fat=10
levelplot(faPAR10)
#vediamo che è più restrittivo dell'NDVI perchè non stiamo considerando la biomassa ma la reale potenza delle piante 
# nell'assorbire carbonio
#il sole cade a terra nelle foreste di conifere, e quindi non è usato in parte
#all'equatore invece nella foresta tropicale, non giunnge a terra, per la densità di piante, quindi è sruttato completamente. 
#ora salviamo in PDF

pdf("copNDVI.pdf")
levelplot(copNDVI)
dev.off()

pdf("faPAR10.pdf")
levelplot(faPAR10)
dev.off()

############# day 2

setwd("C:/lab/")
 load("faPAR.RData")
#original faPAR is 2gb
#let's see how much space is needed for an 8 bits set

library(rasterdiv)
library(raster)
#per scrivere un file raster di una libreria nel pc
writeRaster(copNDVI, "copNDVI.tif")
#poi guardo sulla cartella lab il peso
#solo 5.4MB

library(rasterVis)
#faPAR levelplot this set
levelplot(faPAR10)


################
#modello regressione lineare tra faPAR e NDVI

erosion <- c(12, 14, 16, 24, 26, 40, 55, 67) #creata così una variabile sull'erosione
hm <- c(30, 100, 150, 200, 260, 340, 460, 600) #parti per milione di metalli pesanti 

plot(erosion, hm, col="red", pch=19, xlab="erosion", ylab="heavy metals")
#pch=point character

#creiamo un modello matematico tra queste due variabii, ovvero ci scrve l'equazione della retta
#di regressione lineare

model1<-lm (hm ~ erosion) #ovvero y=x
#y è hm e la x è erosion

#ora possiamo fare il summary del modello creato
summary(model1)
#ci dice:
#intercetta
#sotto ci dice il coeff della pendenza

#ora mettiamo l'eq del modello nel grafico

#y=bx+a
abline(model1)
#così compare la retta sul grafico

#ORA FACCIAMO UN MODELLO SUL faPAR!!!!!!!!!
setwd("C:/lab/")
library(raster)
faPAR10 <- raster("faPAR10.tif")
library(rasterdiv)
plot(copNDVI) #per plottare COPNDVI contenuta in rasterdiv
#ora togliamo l'acqua da COPNDVI
copNDVI <- reclassify(copNDVI, cbind(253:255, NA))

#guardiamo i pixel di faPAR10
faPAR10 #56899584
#lo semplifichiamo 
install.packages("sf")
library(rasterVis)
library(sf) # to call st_* functions
#definiamo la funzione per il random
random.points <- function(x,n) #n=numero di random points
 #x=numero massimo di pixel che può guardare. Poichè i due raster sono uguali in estensione posso usare o l'uno o l'altro
 #prendiamo solo 1000 punti fra tutti i pixel
{
lin <- rasterToContour(is.na(x))
pol <- as(st_union(st_polygonize(st_as_sf(lin))), 'Spatial') # st_union to dissolve geometries
pts <- spsample(pol[1,], n, type = 'random')
}
#ora lo facciamo
pts<-random.points(faPAR10,1000)

#ora associamo a questi punti random i valori faPAR10 e COPNDVI
pts <- random.points(faPAR10,1000) #usiamo solo 
copNDVIp <- extract(copNDVI, pts)
faPAR10p <- extract(faPAR10,pts)

#photosyntesis (y) vs biomass (x) model
model2<-lm(faPAR10p ~ copNDVIp)
summary(model2)
plot(copNDVIp,faPAR10p,col="green")
abline(model2, col="red")

#le due variabili sono correlate ma non troppo
#la presa di carbonio dipende non solo dalla biomassa ma anche dal tipo di piante
#per dire c'è tanta biomassa nelle foreste europee ma non produce cos' tanta fotosintesi quanto quelle equatoriali
#si può vedere anche facendo i levelplot di copNDVI e di faPAR10
