# Excercise: make all the possible pairwis plots in R
#we use a packet called "sp" and we use it because we use a dataset in it
#so we install it
install.packages("sp")
install.packages("GGally") #watch out! R is capital letter sensitive!
#after we need to say to R that we use them
library(sp) #require(sp) will also do the job
#inside ther's a dataset called meuse. The dataset in R are called dataframe
data(meuse)
#now we had explain that we need this package but we neet to explain to R that 
#we need to use it, so:
attach(meuse)
#now we see the names of variables and we plot cadmio and zinc
head(meuse) 
#it shows the forst lines of dataframe
#wrighting "meuse" instead I see the complete dataframe
#for the exercise we wright:
plot(cadmium,zinc)
#then I can change symbols, colours, etc.
plot(cadmium,zinc, pch=15,col="red")
#I wright "red" like a name, with "" because I call it from outside R
#Excercise: make all the possible pairwis plots of the dataset (now to do all the pairwise with all the variables, I can:) 
#Make the plot of all the combinations, too ling!, or:
pairs(meuse)
#in case you recive the error "the size is too large" reshape with the mouse the dimension of the window and relounch the comand
#if the result is not so readable, I had to rettify or subset the meuse dataset to have a low number of variables
pairs(~cadmium+copper+lead+zinc, data=meuse)
#grupping carachters using a tilde 
#other method: all the variables=make a subset)
pairs(meuse[,3:6])
#the comma , is necessaty to say: "start form". Instead the duble dots : says "untill" 
#it works with numbers, not with the names!
#exercise: prettify this graph (let's change the colours) 
pairs(meuse[,3:6],pch=19,col="yellow")
pairs(meuse[,3:6],pch=19,col="blue",cex=2)
#to do others scatterplot cutest with more data we can use GGally package
library(GGAlly)
ggpairs(meuse[,3:6])
#IMPORTANT: when I install a package it is installed forever
#but if I want to use it into an R session i have to recall at the beghinning with library("...")
