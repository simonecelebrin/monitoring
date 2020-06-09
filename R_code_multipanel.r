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
#poi posso cambiare simboli, colori ecc
plot(cadmium,zinc, pch=15,col="red")
#chiamo "red" con nome perchè è un nome che richiamo da fuori
#Excercise: make all the possible pairwis plots of the dataset (ora per fare i plot di tutte le variabili con tutte, posso:) 
#fare il plot di tutte le combinazioni, oppure:
pairs(meuse)
#in case you recive the error "the size is too large" reshape with the mouse the dimension of the window and relounch the comand
#risultato non molto leggibile, come faccio? I had to rettify or subset the meuse dataset to have a low number of variables
pairs(~cadmium+copper+lead+zinc, data=meuse)
#gruppicg caracter using a tilde 
#altro metodo: tutte le variabili =make a subset)
pairs(meuse[,3:6])
#la , serve per dire "parti da" mentre i : per dire "fino a " non funziona con i nomi ma con i numeri!
#exercise: prettify this graph (cambiare colori a questa funzione) 
pairs(meuse[,3:6],pch=19,col="yellow")
pairs(meuse[,3:6],pch=19,col="blue",cex=2)
#per fare altri scatterplot più carini con più dati, usiamo, pacchetto GGally
library(GGAlly)
 ggpairs(meuse[,3:6])
#IMPORTANTE: quando intallo un pacchetto è instalato per sempre. ma se lo voglio usare in una sessione di R, devo chiamarlo all'inizio con library("...")
