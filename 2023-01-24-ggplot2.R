#### ggplot2
#### 24 January 2023
#### AMA

library(ggplot2)
library(ggthemes)
library(patchwork)

### Template for ggplot2 code

### p1 <- ggplot(data=<DATA>, mapping=aes(x=xVar, y=yVar)) + <GEOM FUNCTION (geom_boxplot)>
### print(p1)

d <- mpg
library(dplyr)
glimpse(d)

## Qplot: quick plotting not for publication

qplot(x=d$hwy) #histogram
qplot(x=d$hwy, fill=I("darkblue"), color=I("black")) #need the I function to actually display color

qplot(x=d$displ, y=d$hwy, geom=c("smooth", "point"), method="lm") #scatterplot; added line that follows distribution, could also make it linear with lm

qplot(x=d$fl, y=d$cty, geom="boxplot", fill=I("forestgreen"))

qplot(x=d$fl, geom="bar", fill=I("forestgreen"))

## Create data

x_trt <-c("Control", "Low", "High")
y_resp <- c(12, 2.5, 22.9)
qplot(x=x_trt, y=y_resp, geom="col", fill=I(c("orange", "yellow", "green"))) #goes in alphabetical order when plotting

### ggplot: uses data frames instead of vectors

p1 <- ggplot(data=d, mapping=aes(x=displ, y=cty, color=cyl)) + #color scale of cylinder
  geom_point()

p1 + theme_base()
p1 + theme_bw()
p1 + theme_classic()
p1 + theme_linedraw()
p1 + theme_dark()
p1 + theme_minimal()

p1 + theme_bw(base_size=20, base_family="serif") #font size and type

p2 <- ggplot(data=d, aes(x=fl, fill=fl)) +
  geom_bar()
p2 + coord_flip() + theme_classic(base_size=15, base_family="sans") #x axis and y axis switch

## Theme modifications

p3 <- ggplot(data=d, aes(x=displ, y=cty)) +
  geom_point(size=4, shape=21, color="magenta", fill="black") + 
  xlab("Count") + ylab("Fuel") + 
  labs(title="My title here", subtitle="My subtitle here") +
  xlim(1, 10) + ylim(0, 35)

library(viridis)
cols <- viridis(7, option = "magma") #also plasma, turbo
ggplot(data=d, aes(x=class, y=hwy, fill=class)) +
  geom_boxplot() +
  scale_fill_manual(values=cols) #give same number of colors that there are groups

p1 + p2 + p3 #patchwork function for layouts
(p1 + p2) / p3  
