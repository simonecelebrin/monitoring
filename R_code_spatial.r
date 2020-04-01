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
