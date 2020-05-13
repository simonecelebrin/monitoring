#trasformiamo un valore di radianza in bits

library(raster)

#creiamo unn nuovo raster con 2 rows and 2 colloumns
#inventiamo i dati
toy<- raster(ncol=2, nrow=2, xmn=1, xmx=2, ymn=1, ymx=2)
values(toy) <- c(1.13,1.44,1.55,3.4)

plot(toy)
text(toy, digits=2) #digit dice il numero di cifre decimali

#ora trasformiamo
#cambiamo il range di dati che abbiamo in un insieme di 4 possibili dati potenziali

#quindi 2^2=4 #4 combinazioni 00 01 10 11, con 4 possibili valori associati. 0 1 2 3

toy2bits <- stretch(toy,minv=0,maxv=3) 
storage.mode(toy2bits[]) = "integer"  # significa che usiamo numeri integer = intero il numero

plot(toy2bits)
text(toy2bits, digits=2)

#creiamo nuovo raster con 4bits
16 combinazioni da 0 a 15
toy4bits <- stretch(toy,minv=0,maxv=15) #quindi stretch è quello che ci streccia i dati in un nuovo intorno
storage.mode(toy4bits[]) = "integer"
plot(toy4bits)
text(toy4bits, digits=2)

#se aumentiamo il numero di bits aumentiamo il range e quindi la differenza fra valori per meglio descrivere i alori numerici iniziali. 

# con 8 bits = 2^8= 256 valori potenziali
#allora streccio i valori iniziali di toy in 256 valori 
toy8bits <- stretch(toy,minv=0,maxv=255)
storage.mode(toy8bits[]) = "integer"
plot(toy8bits)
text(toy8bits, "digits=2)
#ora le plottiamo tutte assieme con il par

par(mfrow=c(1,4))
plot(toy)
text(toy, digits=2)
plot(toy2bits)
text(toy2bits, digits=2)
plot(toy4bits)
text(toy4bits, digits=2)
plot(toy8bits)
text(toy8bits, digits=2)

 #più alto è il numero di bits dei pixel, più alta sarà la discriminanza tra i valori originali

#c'è una fz inversa per calcolare anche la radianza da una semplificazione in bits a quella originale
dev.off()

library(rasterdiv)
plot(copNDVI)
 
 #la maggiorparte dei casi i valori di freq sono espressi in 8bits (265) 
 al massimo in 16bits
 
 


