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
