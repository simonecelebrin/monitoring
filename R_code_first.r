#first R code
#let'install a package
install.packages("sp")
#we recall it 
library(sp)
data(meuse) #it's a dataset in meuse

# let's see how the meuse dataset is structured:
meuse
#let's look at the first row of the set
head(meuse)

#lets'plot two variables
#let's see if zinc concentration is related to copper once
attach(meuse) #attach is necessary to recall single variables in meuse
plot(zinc,copper)
#col=green it's a color associated to a number, it colors the graph
plot(zinc,copper,col="green")
#to change symbols we insert the function and the number associated to the symbol we want
plot(zinc,copper,col="green",pch=19)
#to increase point dimension
plot(zinc,copper,col="green",pch=19,cex=2)
