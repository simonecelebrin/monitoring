# R code for Multivariate Analysis

setwd("C:/lab/")
install.packages("vegan")
library(vegan)
biomes<- read.table("biomes.csv", head=T, sep=",")
#sep è per definire la virgola come separatore
head(biomes)
#ora facciamo l'analisi multivariata
#la funzione che si usa è DEtrended CORrespondence ANAlysis. ovvero trasforma tutto in una due 2 
#20 dimensioni in 2 dimensioni! 
#diamo un nome alla fz decorana per velocizzare
multivar<- decorana(biomes)
plot(multivar)

#per vedere lo stesso grafico di analisi ma nella sua interezza
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

