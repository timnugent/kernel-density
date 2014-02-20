#!/usr/bin/Rscript
filename <- "univariate_pdf.png"
data <- read.table("uni_pdf.csv", header=FALSE, sep="," ,comment.char="#")
png(filename)
plot(data$V1,data$V2,xlab="x",ylab="density",main="Univariate PDF")
x <-dev.off()

filename <- "univariate_cdf.png"
data <- read.table("uni_cdf.csv", header=FALSE, sep="," ,comment.char="#")
png(filename)
plot(data$V1,data$V2,xlab="x",ylab="density",main="Univariate CDF")
x <-dev.off()

filename <- "pdf_default_gaussian.png"
png(filename, width = 1000, height = 1000)
tab = read.csv("matrix_default.csv", header=F ,comment.char="#") # read in data in a dataframe
x = as.numeric(tab[1,-1]) # assign values of first axis
y = as.numeric(tab[-1,1]) # assign values of second axis
z = as.matrix(tab[-1,-1]) # cast the remaining data into a  matrix
nrz <- nrow(z)
ncz <- ncol(z)
jet.colors <- colorRampPalette( c("red", "yellow") )
nbcol <- 20
color <- jet.colors(nbcol)
zfacet <- z[-1, -1] + z[-1, -ncz] + z[-nrz, -1] + z[-nrz, -ncz]
facetcol <- cut(zfacet, nbcol)
persp(x,y,z,col = color[facetcol],zlab="density",main="PDF - default bandwidth, gaussian kernel",phi = 30, theta = -30)
t <-dev.off()

filename <- "pdf_optimal_secant_gaussian.png"
png(filename, width = 1000, height = 1000)
tab = read.csv("matrix_optimal.csv", header=F ,comment.char="#") # read in data in a dataframe
x = as.numeric(tab[1,-1]) # assign values of first axis
y = as.numeric(tab[-1,1]) # assign values of second axis
z = as.matrix(tab[-1,-1]) # cast the remaining data into a  matrix
nrz <- nrow(z)
ncz <- ncol(z)
jet.colors <- colorRampPalette( c("red", "yellow") )
nbcol <- 20
color <- jet.colors(nbcol)
zfacet <- z[-1, -1] + z[-1, -ncz] + z[-nrz, -1] + z[-nrz, -ncz]
facetcol <- cut(zfacet, nbcol)
persp(x,y,z,col = color[facetcol],zlab="density",main="PDF - optimal bandwidth (secant), gaussian kernel",phi = 30, theta = -30)
t <-dev.off()

filename <- "pdf_optimal_bisection_guassian.png"
png(filename, width = 1000, height = 1000)
tab = read.csv("matrix_optimal_safe.csv", header=F ,comment.char="#") # read in data in a dataframe
x = as.numeric(tab[1,-1]) # assign values of first axis
y = as.numeric(tab[-1,1]) # assign values of second axis
z = as.matrix(tab[-1,-1]) # cast the remaining data into a  matrix
nrz <- nrow(z)
ncz <- ncol(z)
jet.colors <- colorRampPalette( c("red", "yellow") )
nbcol <- 20
color <- jet.colors(nbcol)
zfacet <- z[-1, -1] + z[-1, -ncz] + z[-nrz, -1] + z[-nrz, -ncz]
facetcol <- cut(zfacet, nbcol)
persp(x,y,z,col = color[facetcol],zlab="density",main="PDF - optimal bandwidth (bisection), gaussian kernel",phi = 30, theta = -30)
t <-dev.off()

filename <- "pdf_default_box.png"
png(filename, width = 1000, height = 1000)
tab = read.csv("matrix_default_box.csv", header=F ,comment.char="#") # read in data in a dataframe
x = as.numeric(tab[1,-1]) # assign values of first axis
y = as.numeric(tab[-1,1]) # assign values of second axis
z = as.matrix(tab[-1,-1]) # cast the remaining data into a  matrix
nrz <- nrow(z)
ncz <- ncol(z)
jet.colors <- colorRampPalette( c("red", "yellow") )
nbcol <- 20
color <- jet.colors(nbcol)
zfacet <- z[-1, -1] + z[-1, -ncz] + z[-nrz, -1] + z[-nrz, -ncz]
facetcol <- cut(zfacet, nbcol)
persp(x,y,z,col = color[facetcol],zlab="density",main="PDF - default bandwidth, box kernel",phi = 30, theta = -30)
t <-dev.off()

filename <- "pdf_default_epanechnikov.png"
png(filename, width = 1000, height = 1000)
tab = read.csv("matrix_default_epa.csv", header=F ,comment.char="#") # read in data in a dataframe
x = as.numeric(tab[1,-1]) # assign values of first axis
y = as.numeric(tab[-1,1]) # assign values of second axis
z = as.matrix(tab[-1,-1]) # cast the remaining data into a  matrix
nrz <- nrow(z)
ncz <- ncol(z)
jet.colors <- colorRampPalette( c("red", "yellow") )
nbcol <- 20
color <- jet.colors(nbcol)
zfacet <- z[-1, -1] + z[-1, -ncz] + z[-nrz, -1] + z[-nrz, -ncz]
facetcol <- cut(zfacet, nbcol)
persp(x,y,z,col = color[facetcol],zlab="density",main="PDF - default bandwidth, epanechnikov kernel",phi = 30, theta = -30)
t <-dev.off()



