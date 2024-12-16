# PROGRAMMING FOR COGNITIVE SCIENCES: Lecture 2
# Joanna Tobiasz, Anna Papiez

rm(list = ls()) # cleaning the workspace


# Grouping functions ---------------------------------------------------------------

# apply
M <- matrix(1:16, nrow = 4, ncol = 4)
M
apply(M, 1, min)

# lapply
L <- list(a = 1, b = 1:3, c = 10:100) 
L
lapply(L, length)
list_data <- list(a = 1:5, b = 6:10)
list_data
lapply(list_data, mean) 
unlist(lapply(list_data, mean) )

# sapply
L <- list(a = 1, b = 1:3, c = 10:100)
L
sapply(L, length)

# mapply
mapply(sum, 1:5, 1:5, 1:5) 


# tapply
x <- 1:20
x
y <- factor(rep(letters[1:5], each = 4))
y
tapply(x, y, sum)

# by
data("iris")
attach(iris)
head(iris)
by(iris, list(Species=iris$Species), function(x){
  y <- subset(x, select= -Species)
  apply(y, 2, mean)
} )

# aggregate
iris.x <- subset(iris, select= -Species)
iris.s <- subset(iris, select= Species)
aggregate(iris.x, iris.s, mean)

# Sorting
sort(iris$Sepal.Length) #vector

# Sorting a data frame the hard way
sIris <- sort(iris$Sepal.Length, index.return=TRUE) 
head(iris[sIris$ix,]) #sorted data frame

# Elegant data frame sorting
library(dplyr)
sIris <- arrange(iris, Sepal.Length)
head(sIris)

L <- list(a = 1, b = 1:3, c = 10:100) # creating a list with three elements, each of them is a numeric vector
L
str(L)


# Let's check the number of elements in each vector:

for(i in 1:length(L)) {
  cat('Number of elements in vector ', i, ': ', length(L[[i]]), '\n')
  
}

lapply(L, length)
sapply(L, length)


# Now let's print the summary for the first 4 columns of the iris data frame:
apply(iris[1:4], 2, summary)


# Basic data visualization ------------------------------------------------

rm(list = ls()) # cleaning the workspace

x <- seq(0, 100, 5)
x
y <- log(x)
y

# plot example

plot (x, y,                                   # plot arguments and values
      type="o",                               # lines and points
      col="red", 
      xaxt="n", yaxt="n",                     # suppress the axes
      xlab = expression(paste("Value ", italic(x))),     # use math notation 
      ylab = expression(paste(alpha, '=', log(x))),     
      ylim = log(c(1,50))
)    

# format X axis
axis(side=1, at=x, labels = FALSE)            # add ticks
xlabels=parse(text=paste(x, "%*% 10^5 ",sep=""))  # format tick labels with math notation
xlabels
text(                 
  x = x,          # horizontal ticks coordinates
  y = par("usr")[3] - 0.1, # y coordinate of horizontal axis
  labels = xlabels,        # tock 
  srt = 45,      # rotation in degrees
  pos = 1,       # text below coordinate
  xpd = TRUE)    # clipping to the figure region (not plot region)

# format Y axis
yticks = c(0.1, 0.2, 0.5, 1.0)
yticks
axis(side=2, at=yticks, labels = FALSE)
text(
  x = par("usr")[1], # x coordinate of vertical axis
  y = yticks,   # vertical ticks coordinates
  labels = yticks, 
  pos = 2, 
  xpd = TRUE)

# grid lines
abline(v = x, lty = 6)
abline(h = y, lty = 6)

dev.off()


# alternative - write to file
pdf("chart.pdf",width=5,height=4)
# ploting
dev.off()



# Data visualization with ggplot2 ------------------------------------------------------

rm( list = ls()) # cleaning the workspace


## Package and data loading ----------------------------------------------

# Load ggplot package
library(ggplot2)

# Load package with data
library(ISLR)
data(Auto)
attach(Auto)
head(Auto)

## Scatterplot ------------------------------------------------------------

# Initialize a ggplot
g <- ggplot(Auto, aes(x=acceleration, y=mpg)) +
  geom_point() +
  geom_smooth(method="lm", se=FALSE)
plot(g)
g + scale_x_reverse()

# Zoom in on plot
g1 <- g + coord_cartesian(xlim=c(10,20),ylim=c(10,40))
plot(g1)


# Change titles
g1 + labs(title="Plot of mileage vs acceleration", 
          subtitle = "Auto data",
          x = "Acceleration",
          y = "MPG",
          caption = "ISLR dataset")

# Change marker size and color
g2 <- ggplot(Auto, aes(x=acceleration, y=mpg)) +
  geom_point(col="purple", size=3) +
  geom_smooth(method="lm", col="darkgreen",linewidth=2) +
  coord_cartesian(xlim=c(10,25),ylim=c(10,40)) +
  labs(title="Plot of mileage vs acceleration", 
       subtitle = "Auto data",
       x = "Acceleration",
       y = "MPG",
       caption = "ISLR dataset")
plot(g2)

# Change color gradient
g3 <- ggplot(Auto, aes(x=acceleration, y=mpg)) +
  geom_point(aes(col=year), size=3) +
  geom_smooth(method="lm", col="darkgreen",size=2) +
  coord_cartesian(xlim=c(10,25),ylim=c(10,40)) +
  labs(title="Plot of mileage vs acceleration", 
       subtitle = "Auto data",
       x = "Acceleration",
       y = "MPG",
       caption = "ISLR dataset")

g3 + scale_color_gradient(low="green",high="red")

# Change axis tick density and labels
g3 + scale_x_continuous(breaks = seq(10,25,3), 
                        labels = function(x){paste0(x, 'm/s^2')})


# Change plot theme
g3 + theme_bw() + labs(subtitle="BW theme")


# Different regression model
g4 <- ggplot(Auto, aes(x=acceleration, y=mpg)) +
  geom_point(aes(col=year), size=3) +
  geom_smooth(method="loess", col="magenta", se=F) +
  coord_cartesian(xlim=c(10,25),ylim=c(10,40)) +
  labs(title="Plot of mileage vs acceleration", 
       subtitle = "Auto data",
       x = "Acceleration",
       y = "MPG",
       caption = "ISLR dataset")
plot(g4)

# Extra boxplots

library(ggExtra)
ggMarginal(g4, type="boxplot", fill="transparent")


## Correlogram ---------------------------------------------------------------

correl <- cor(Auto[,1:8])
correl
library(ggcorrplot)
ggcorrplot(correl)
ggcorrplot(correl,
           type="lower",
           lab=TRUE,
           lab_size=3,
           method="square",
           colors= c("pink","white","purple"))



## Density plot ---------------------------------------------------------------

g5 <- ggplot(Auto, aes(mpg))
g5
g5 + geom_density()
g5 + geom_density(fill = "red")

g5 + geom_density(aes(fill=factor(cylinders)), alpha=.7)
g5 + geom_density(aes(fill=factor(year)), alpha=.7)

## Deviation plot ----------------------------------------------------------

# Extract car brand names
splitNames <- strsplit(as.character(Auto$name),
                       split=" ")
splitNames
b <- c()
for(i in 1:length(splitNames)){
  b <- c(b,splitNames[[i]][1])
}

Auto$brand <- factor(b)

# Calculate deviations from the mean                
uniqueAuto <- Auto[!duplicated(Auto$brand),]

meanMPG <- mean(uniqueAuto$mpg)

uniqueAuto$mpg_dev <- uniqueAuto$mpg -meanMPG
uniqueAuto$mpg_type <- ifelse(uniqueAuto$mpg_dev <0,
                              "below",
                              "above")
uniqueAuto <- uniqueAuto[order(uniqueAuto$mpg_dev),]
uniqueAuto$brand <- factor(uniqueAuto$brand, 
                           levels = uniqueAuto$brand)

# Deviation bar plot
ggplot(uniqueAuto, aes(x=brand, y=mpg_dev, labels=mpg_dev)) +
  geom_bar(stat="identity", aes(fill=mpg_type),width=0.5) +
  scale_fill_manual(name="Mileage",
                    labels=c("Above Average", "Below Average"),
                    values = c("above"="hotpink","below"="turquoise"))+
  coord_flip()



## Boxplot ---------------------------------------------------------------------

brand8 <- unique(Auto$brand)[1:8]
Auto8 <- Auto[!is.na(match(Auto$brand,brand8)),]

library(RColorBrewer)
g6 <- ggplot(Auto8,aes(brand,mpg))
g6
g6 + geom_boxplot()
g6 + geom_boxplot(fill=brewer.pal(8,"Set2"))
g6 + geom_boxplot(fill=brewer.pal(8,"Set2"))+
  geom_dotplot(binaxis = 'y',
               stackdir="center",
               dotsize=0.5,
               fill="orange")+
  theme(axis.text = element_text(size=12))


## Violin plot ------------------------------------------------------------

ggplot(Auto8, aes(brand, mpg)) +
  geom_violin(aes(fill=brand ), trim=FALSE) +
  scale_fill_brewer(palette="Dark2") +
  theme(axis.text=element_text(size=8)) + 
  theme(axis.title=element_text(size=15))



## Fancy animation (may require installing dependencies) ----------------------
library(gganimate)
g7 <- ggplot(Auto,aes(acceleration,mpg,colour=cylinders))
g7
g7 <- ggplot(Auto,aes(acceleration,mpg,colour=cylinders))+
  geom_point() +
  facet_wrap(~origin)
g7
g7 <- ggplot(Auto,aes(acceleration,mpg,colour=cylinders))+
  geom_point() +
  facet_wrap(~origin) +
  labs(title="Year: {closest_state}") +
  transition_states(year, transition_length = 2, 
                    state_length = 1)
animate(g7)

## Grouped scatter plot ---------------------------------------

# Extract car brand names
splitNames <- strsplit(as.character(Auto$name),
                       split=" ")
b <- c()
for(i in 1:length(splitNames)){
  b <- c(b,splitNames[[i]][1])
}

Auto$brand <- factor(b)

brand8 <- unique(Auto$brand)[1:8]
Auto8 <- Auto[!is.na(match(Auto$brand,brand8)),]

# Grouped scatter plot 

ggplot(Auto, aes(x=acceleration, y=mpg, size=cylinders, color=weight)) +
  geom_point(alpha=0.8) +
  scale_size_continuous() +
  scale_color_distiller(palette = "Spectral") +
  facet_wrap(~origin) +
  theme(axis.text=element_text(size=15)) + 
  theme(axis.title=element_text(size=20)) +
  labs(title="Car parameters by origin")


## Circular barplot --------------------------------------------------------

library(dplyr)

meanAuto <- aggregate(Auto8[,1:8],list(Auto8$brand),mean)
names(meanAuto)[1] <- "brand"

ggplot(meanAuto, aes(fill=brand, y=mpg, x=1:dim(meanAuto)[1])) + 
  geom_bar(stat="identity", width = .9) +
  ylim(-10,40) +
  coord_polar() +
  scale_fill_brewer(palette="Accent") +
  scale_x_continuous(breaks = 1:8, expand = c(.005,0)) +
  theme_bw() +1
  theme(axis.text.x=element_blank(), axis.text=element_text(size=15), axis.title=element_text(size=15)) +
  # theme(axis.text=element_text(size=8)) + 
  labs(title="Circular barplot for average MPG", x="")

