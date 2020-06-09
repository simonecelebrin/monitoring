# R code for Multivariate Analysis

setwd("C:/lab/")
install.packages("vegan")
library(vegan)
biomes<- read.table("biomes.csv", head=T, sep=",")
#sep is to define the comma as separator
head(biomes) #just to see the first lines
#now we do the multivariate analisys
#the function we use is DEtrended CORrespondence ANAlysis, it changes all in two dimensions 
#20 dimensions in 2 dimensions! 
#we give a name to the function
multivar<- decorana(biomes)
plot(multivar)

#to see the same analysis graph but in its entirety (interezza)
multivar
# eigenvalues ci dice la percentuale di variabile che vediamo nei 4 assi in 2d. in particolare noi vediamo l'80% circa
# ma cosa vediamo nel dettaglio?
# tree_ferm è legato al ragno gigante come il bufo(fungo) e la volpe e lo scoiattolo
# ogni punto è un plot 
#ora facciamo l'unione di vari plot di ogni bioma
biomes_types<- read.table("biomes_types.csv", head=T, sep=",")
head(biomes_types)
#ora facciamo un link (unione) di ogni plot appartenente ad uno stesso bioma
attach(biomes_types) #perchè abbiamo bisogno di riferirci alle colonne di quel dataset
#unirà con una linea (analisi multivar, la colonna da usare per il tipo, colori diversi per ogni bioma,
# kind= tipo di grafico (detto ehull)
ordiellipse (multivar, type, col=1:4, kind="ehull", lwd=3)
#verde è la foresta tropicale, rosso è in questo caso la foresta temperata, ecc...)
#ragnatela che unisce i vari plot di un bioma
ordispider(multivar, type, col=1:4, label=TRUE) # label= nomi biomi vogliamo vederli
#alcune specie non sono visibili (20%) sarebbero visibili con l'aggiunta anche di altri due assi. Queste specie non rientrano nelle ellissi tracciate.  Sono specie visibili in
# ...altre dimensioni 

