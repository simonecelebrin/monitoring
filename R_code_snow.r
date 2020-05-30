#R_code_snor.r

setwd("C:/lab/")
#import the file downloaded by copernicus
#the one about snow
#we need some libraryes
#ncdf4 library that load CDF datas(.nc) 
#CDF are similar to TIF datas
install.packages("ncdf4")
library(raster)
library(ncdf4)
snowmay<-raster("c_gls_SCE_202005260000_NHEMI_VIIRS_V1.0.1.nc")
#c'è un warning message, perchè l'immagine è word wile, and we do a crop, so the warning say that the reference sistem is not define in R
#praticamete il warning dice che non stiamo usando una parte dell'immagine che non è presente nel file scaricato ma è presente nel sr del file scaricato

#plot the data
#create a color ramp palette
cl <- colorRampPalette(c('darkblue','blue','light blue'))(100)
plot(snowmay, col=cl)
