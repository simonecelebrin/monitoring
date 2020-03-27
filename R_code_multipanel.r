Excercise: make all the possible paiwis plots po#multipanel in R: the second lecture of monitoring Ecosystems
#usiamo un pacchetto detto "sp" e usiamo le " perchè richiamiamo il nome di un pacchetto esterno
#ce l'ho già intallato cmq la fz sarebbe
install.packages("sp")
install.packages("GGally") #occhio che R sente i maiuscolo e minuscolo, cambia
#poi dobiamo dirgli che lo usiamo
library(sp) #require(sp) will also do the job
#dentro il pacchetto c'è un data set detto meuse. i dataset in R sono detti dataframe
data(meuse)
#ora abbiamo spieegato che usiamo questo pacchetto. Ma ora vogliamo attach meuse, ovvero usarlo
attach(meuse)
#ora guardo il nome delle variabili e plot cadmio e zinc
#head(meuse) ci mostra le prime righe del dataset mentre scrivendo meuse vedo il dataset completo
#per l'esercizio scivo:
plot(cadmium,zinc)
#poi posso cambiare simboli, colori ecc
plot(cadmium,zinc, pch=15,col="red")
#chiamo "red" con nome perchè è un nome che richiamo da fuori
#Excercise: make all the possible paiwis plots of the dataset (ora per fare i plot di tutte le variabili con tutte, posso:) 
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
