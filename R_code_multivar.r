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

#to see the same analysis graph but on its entirety (interezza)
multivar
# eigenvalues shows the percentage of informations we see divided into the 4 acxes in 2d. 
#In particular we see around 80% divided between the firs 2 graphs
# but what do we see in detail?
# tree_ferm is linked to the gigant spider as much to the bufo(mashroom) to fox and squirtle
# each point is a plot 
# now we want to do the UNION of the plots to each bioma
biomes_types<- read.table("biomes_types.csv", head=T, sep=",") #to import a csv file
head(biomes_types)
#let's do the JOIN (unione) of each plot belonghing with the same bioma
attach(biomes_types) #due to we need to reffer to the coloums of this dataset
#it will circle with a line the elements belonghing to the same bioma 
ordiellipse (multivar, type, col=1:4, kind="ehull", lwd=3)
#the function up from here circle, as written at the 28 row
#let's explain it (analisi multivar, type=the coloumn to use for the type of bioma, col= colours for each bioma,
#kind= type of graph (ehull)
#green=tropical forest, red=temperate forest, etc
#spider web that link the plots of a bioma
ordispider(multivar, type, col=1:4, label=TRUE) # label= bioma names
#the 20% of the spieces are not visible
#them would be visible if we add the other two axes
# these species do not enter inside the eclipses
#because they're visible in other dimensions
