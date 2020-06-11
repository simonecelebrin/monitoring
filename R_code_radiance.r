#let's TRANSFORM A RADIANCE VALUE IN BITS (for pixels)

library(raster)

#let's create a new raster with 2 rows and 2 colloumns
#let's invent the data
toy<- raster(ncol=2, nrow=2, xmn=1, xmx=2, ymn=1, ymx=2)
values(toy) <- c(1.13,1.44,1.55,3.4)

plot(toy)
text(toy, digits=2)#we put over the text and "digit" describes the number of decimal places (cifre decimali)

#now let's transform
#we change the data range into a set(insieme) of 4 possible potential data

#so 2^2=4 #4 combinations: 00 01 10 11, with 4 possible values: 0 1 2 3

toy2bits <- stretch(toy,minv=0,maxv=3) 
storage.mode(toy2bits[]) = "integer"  # means that we use integer numbers = numeri interi

plot(toy2bits)
text(toy2bits, digits=2)

#let's create a new raster with 4bits
# so 16 combinations, form 0 to 15
toy4bits <- stretch(toy,minv=0,maxv=15) #so the stretch it the command that stretch the data inside a new range
storage.mode(toy4bits[]) = "integer"
plot(toy4bits)
text(toy4bits, digits=2)

#if we increase the number of bits we increase the range and so the difference between the values
#to better describe the initial numerical values.

# with 8 bits = 2^8= 256 possible values
#so we stretch the initial toy values into 256 values 
toy8bits <- stretch(toy,minv=0,maxv=255)
storage.mode(toy8bits[]) = "integer"
plot(toy8bits)
text(toy8bits, "digits=2)

#now we plot all togheter with the par function
par(mfrow=c(1,4))
plot(toy)
text(toy, digits=2)
plot(toy2bits)
text(toy2bits, digits=2)
plot(toy4bits)
text(toy4bits, digits=2)
plot(toy8bits)
text(toy8bits, digits=2)

#highter is the number of bits (of pixels), highter is the  discriminance between the original values
#there's alsto an inverse function that calculate the radiance from a pixels matrix
dev.off()

library(rasterdiv)
plot(copNDVI)
 
 #like here, the the majority of cases the frequency values ​​are expressed in 8bits (265)
 #at most in 16bits
 
 


