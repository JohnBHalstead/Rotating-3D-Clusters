############################################################
## 3D rotating clusters
## John Halstead, Ph.D.
## Sol id (Jan 10, 2020)
############################################################

#### Libraries and Data

library(rgl)
library(magick)
data(iris)
head(iris)

# Manipulate Iris data

x <- sep.l <- iris$Sepal.Length
y <- pet.l <- iris$Petal.Length
z <- sep.w <- iris$Sepal.Width

#### Basic Graph

rgl.open() # Open a new RGL device
rgl.points(x, y, z, color ="lightgray") # Scatter plot

# Change the background and point colors

rgl.open()# Open a new RGL device
rgl.bg(color = "white") # Setup the background color
rgl.points(x, y, z, color = "blue", size = 5) # Scatter plot

# Change the shape of points

spheres3d(x, y = NULL, z = NULL, radius = 1, ...)
rgl.spheres(x, y = NULL, z = NULL, r, ...)

rgl.open()# Open a new RGL device
rgl.bg(color = "white") # Setup the background color
rgl.spheres(x, y, z, r = 0.2, color = "grey") 

# rgl_init(): A custom function to initialize RGL device

#' @param new.device a logical value. If TRUE, creates a new device
#' @param bg the background color of the device
#' @param width the width of the device
rgl_init <- function(new.device = FALSE, bg = "white", width = 640) { 
  if( new.device | rgl.cur() == 0 ) {
    rgl.open()
    par3d(windowRect = 50 + c( 0, 0, width, width ) )
    rgl.bg(color = bg )
  }
  rgl.clear(type = c("shapes", "bboxdeco"))
  rgl.viewpoint(theta = 15, phi = 20, zoom = 0.7)
}

# Add a bounding box decoration

rgl_init()
rgl.spheres(x, y, z, r = 0.2, color = "yellow")  # Scatter plot
rgl.bbox(color = "#333377") # Add bounding box decoration

rgl_init()
rgl.spheres(x, y, z, r = 0.2, color = "yellow")  
rgl.bbox(color=c("#333377","black"), emission="#333377",
         specular="#3333FF", shininess=5, alpha=0.8 ) 

## A different view

# Make a scatter plot
rgl_init()
rgl.spheres(x, y, z, r = 0.2, color = "green") 
# Add x, y, and z Axes
rgl.lines(c(min(x), max(x)), c(0, 0), c(0, 0), color = "black")
rgl.lines(c(0, 0), c(min(y),max(y)), c(0, 0), color = "red")
rgl.lines(c(0, 0), c(0, 0), c(min(z),max(z)), color = "green")

# scale the data

x1 <- (x - min(x))/(max(x) - min(x))
y1 <- (y - min(y))/(max(y) - min(y))
z1 <- (z - min(z))/(max(z) - min(z))
# Make a scatter plot
rgl_init()
rgl.spheres(x1, y1, z1, r = 0.02, color = "green") 
# Add x, y, and z Axes
rgl.lines(c(0, 1), c(0, 0), c(0, 0), color = "black")
rgl.lines(c(0, 0), c(0,1), c(0, 0), color = "red")
rgl.lines(c(0, 0), c(0, 0), c(0,1), color = "green")

# Make a movi

movie3d(f, duration, dir = tempdir(), convert = TRUE)
rgl_init()
rgl.spheres(x1, y1, z1, r = 0.02, color = "green") 

# Create a movie
movie3d(spin3d(axis = c(1, 1, 1)), duration = 30, 
        dir = getwd(), type = "gif", startTime = 0)

rgl.snapshot(filename = "plot.png")

setwd(tempdir())
for (i in 1:360) {
  rgl.viewpoint(i, 10)
  filename <- paste("~/Documents/data/pic", formatC(i, digits = 1, flag = "0"), 
                    ".png", sep = "")
  rgl.snapshot(filename)
}




