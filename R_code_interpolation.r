# R_code_interpolation.r

setwd("C:/lab/")

#to import a csv file (it's a table) we use
library(spatstat) #the same package we use to calculate point density

#function to import:
inp<-read.table("dati_plot55_LAST3.csv", sep=";", head=T) #sep=separator and head= there's a titlle for the coloums
head(inp)

#the table has the coordinatex X and Y (x=metric distance from the first meridian and Y from the equator)
#table has also the slope
#C.cov=canopy cover from 100 to 0 (copertura della chioma)

#we are going to estimate the canopy cover where there's not the value!

attach(inp)
#plot(inp$X, inp$Y) or:
plot(X,Y) #because we have attach the table

#let's do the planar point pattern: we explayn the X, the Y of our dataset and they'r range
#in this way R can understand the known area
#to see the X and Y max and min:
summary(inp)
#X= 7
inppp <- ppp(x=X, y=Y, c(716000,718000),c(4859000,4861000)) #we explain the coordinates and the range
#now we use the function: marks
#R don't know the value of the point it plottet
#we are going to give this information to R
#we marks the inpppp with the canopy cover!
names(inppp) #just to see the name of te Canopy cover
#now we use marks
marks(inppp) <- Canopy.cov
#so now we have the point and their canopy cover values

#NOW let's ESTIMATE THE VALUES 
#the function is: Smooth that interpolates the data
canopy <- Smooth(inppp)
plot(canopy) #we plot the interpolated map
points(inppp, col="green") #we put the points over the map
#highter density on south est

#########
#Now we want to mark the lichens information of quantity
  
marks(inppp) <- cop.lich.mean #the lichens
lichs <- Smooth(inppp)
plot(lichs)
points(inppp)

#hight ammount of lichens on north west


#now let's plot the images togheter
par(mfrow=c(1,2))
plot(canopy)
points(inppp)
plot(lichs)
points(inppp)
dev.off()
#there's no relation between the two maps

#final plot:
par(mfrow=c(1,3))
plot(canopy)
points(inppp)
plot(lichs)
points(inppp)
plot(Canopy.cov, cop.lich.mean, col="red",pch=19, cex=2)

#we have not many point to calculate a linear regression between the two variables

########################
#LET'S PLAY WITH A NEW SET
#psammophilus vegetation

inp.psm<-read.table("dati_psammofile.csv", sep=";", head=T)
attach(inp.psm)
summary(inp.psm)

plot(E,N) #x=E and y=N
summaty(inp.psm)
#to see coordinates maximum and minimum
inp.psm.ppp <- ppp(x=E,y=N,c(356450,372240),c(5059800,5064150))
#we need to do the mark
#we mark the orgaic carbon
marks(inp.psm.ppp) <- C_org
#NOW let's ESTIMATE THE VALUES 
Carbon <-Smooth(inp.psm.ppp)
plot(Carbon)
points(inp.psm.ppp, col="green")

