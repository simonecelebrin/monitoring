install.packages("sp")

library(sp)
data(meuse)

# let's see how the meuse dataset is structured:
meuse

#let's look at the first row of the set
head(meuse)

#lets'plot two variables
#let's see f zinc concentration is related to that of copper
attach(meuse)
plot(zinc,copper)
#col=green è un colore associato ad un numero, serve per colorare il grafico
plot(zinc,copper,col="green")
#per cambiare i simboli inseriamo la funzione e il numero associato ad un simbolo
plot(zinc,copper,col="green",pch=19)
#aumentare dimensione dei punti
plot(zinc,copper,col="green",pch=19,cex=2)
