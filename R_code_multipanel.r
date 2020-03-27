#multipanel in R: the second lecture of monitoring Ecosystems
#usiamo un pacchetto detto "sp" e usiamo le " perchè richiamiamo il nome di un pacchetto esterno
#ce l'ho già intallato cmq la fz sarebbe
install.packages("sp")
#poi dobiamo dirgli che lo usiamo
library(sp) #require(sp) will also do the job
#dentro il pacchetto c'è un data set detto meuse. i dataset in R sono detti dataframe
data(meuse)
#ora abbiamo spieegato che usiamo questo pacchetto. Ma ora vogliamo attach meuse, ovvero usarlo
attach(meuse)
#ora guardo il nome delle variabili e plot cadmio e zinc
