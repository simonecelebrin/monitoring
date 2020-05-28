# R code for spatial view of points

# first thing: reuse the library called "sp"
library(sp) 
# sp has a dataset called meuse
data(meuse)
head(meuse) #it's a spatial dataset, has some coordinates!
#let's explain to R that we are gonna use data that has coordinates:
coordinates(meuse)= ~x+y
#after = we describe the coordinates intervall: X e Y
#we are explaining meuse to think spatially
# ~ it's an ols symbol used by "sp"
plot(meuse)
#let's see spatial points
spplot(meuse, "zinc")
#this command let us see a single variable of the dataset. 
#we see different classes and so different zinc concentration
#exercise: plot the spatial amount of copper)
spplot(meuse, "copper")
spplot(meuse, "copper") #just to se also the title we want
spplot(meuse, "copper", main= "Copper concentration")
#how to change type of rappresentation? 
#in this way we see not classes but circles sized to concentration
bubble(meuse, "zinc")
bubble(meuse, "zinc", main="Zinc concentration")
#exercise: bubble copper in red
bubble(meuse, "zinc", main="Zinc concentration", col="red")
#to insert on R a dataset, we need to create a directory (without capital letter) into C disk
#then we insert all the files we want inside
#setting the working directory for windows
setwd("C:/lab/")
#we associate a name with a dataset and then say that there is a title row
covid <- read.table("covid_agg.csv", head=TRUE)
#to writing TRUE or T is the same
head(covid)
#let's do a plot of case numbers in each country
attach(covid) #so we plot using column names
plot (country, cases)
#if we don't use attach(covid) we need to write:
plot(covid$country, covid$cases)
#but we don't see all the cases into the graph, so we can  we can write labels horizontally or vertically, so we should see them
plot(country, cases, las=0)
#las=0 put labels parallels
plot(country, cases, las=1) #orizzontal labels
plot(country, cases, las=2) #perpendicular labels
plot(country, cases, las=3) #vertical labels
plot(country, cases, las=2, cex.axis=0.5) #to change text dimension

#now we see ggplot. It has 3 components: data, map estetic, geometric function we want touse to graph the data
#intal ggplot2 package
install.packets("ggplot2")
#to load a work space
load("arealavoro_R_covid.RData")
#just to see if R has implemented the command 
ls()
#ls is a command that shows all the processing made into the file
#it shows what data sets and functions a user has defined. 
#When invoked with no argument inside a function, ls returns the names of the function's local variables
#let's introduce ggplot
#it is the most fancy packages in R to do beautiful graphs
library(ggplot2)
#ggplot has a cars database called MPG
data(mpg)
head(mpg)
#3 key components in GGPLOT: data, aes(aestetic function), geometry 
ggplot #function to plot the data
ggplot(mpg, aes(x=displ, y=hwy)) + geom_point() #geometry is separated 
#let's change geometry of the graph using lines
ggplot(mpg, aes(x=displ, y=hwy)) + geom_line()
ggplot(mpg, aes(x=displ, y=hwy)) + geom_polygon()
#back to covid
head(covid) #we use ggplot specifying that point dimension = number of cases
ggplot(covid,aes(x=lon, y=lat, size=cases)) + geom_point()


                 
                 
                 
                 
                 
                 
                 
                 
