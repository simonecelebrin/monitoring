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

