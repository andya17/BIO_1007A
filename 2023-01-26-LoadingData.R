#### Loading in Data
#### 26 January 2023
#### AMA

## Reading in a dataset
# read.table(file="path/to/data.csv, header=true, sep=",")
# read.csv(file="data.csv", header=T)

## Create a dataset
# write.table(x=varName, file="outputFileName", header=T, sep=",")

## RDS functions when only working in R; helpful with large datasets
# saveRDS(my_data, file="FileName.RDS") #save as own R object
# readRDS("FileName.RDS")
# p <- readRDS("FileName.RDS")

## Long vs wide data formats
# long more rows than columns, wide more columns than rows
# wide: contains values that do not repeat in the ID column
# long: contains values that do repeat in the ID column

library(tidyverse)
glimpse(billboard) #wide because more columns than rows
b1 <- billboard %>%
  pivot_longer(
    cols=starts_with("wk"), #specify which columns want to make longer
    names_to="Week", #name of new column which will contain header names
    values_to="Rank", #name of new column which will contain the values
    values_drop_na=T #remove any rows where the values = NA
  )
## pivot_wider()
#best for making occupancy matrix

glimpse(fish_encounters)
fish_encounters %>%
  pivot_wider(names_from=station, #which column we want to turn into multiple columns
              values_from=seen, #which column contains the values for the new column cells
              values_fill=0) #0s instead of NAs

### Dryad: makes research data publicly available

dryad = read.table(file="Data/Veysey-Babbitt_data_amphibians.csv", header=T, sep=",")
glimpse(dryad)
head(dryad)
table(dryad$species) #allows you to see differentg groups of character column
summary(dryad$mean.hydro) #min, quartile, med, mean, max

dryad$species<-factor(dryad$species, labels=c("Spotted Salamander", "Wood Frog")) #creating 'labels' to use for the plot

class(dryad$treatment)

dryad$treatment <- factor(dryad$treatment, 
                              levels=c("Reference",
                                       "100m", "30m")) #sets groups to be compared
p<- ggplot(data=dryad, #use data from the dryad dataset
           aes(x=interaction(wetland, treatment), #group treatment and wetland
               y=count.total.adults, fill=factor(year))) + geom_bar(position="dodge", stat="identity", color="black") + #use count.total.adults for y variable; fill color based on year; create bar graph with different years as different bars next to one another instead of being one stack for each x axis break
  ylab("Number of breeding adults") + #use this as the y label
  xlab("") + #do not have a normal x axis label
  scale_y_continuous(breaks = c(0,100,200,300,400,500)) + #y axis should be broken up by 100s
  scale_x_discrete(labels=c("30 (Ref)", "124 (Ref)", "141 (Ref)", "25 (100m)","39 (100m)","55 (100m)","129 (100m)", "7 (30m)","19 (30m)","20 (30m)","59 (30m)")) + #x axis should have these particular values, which are not equal distance apart
  facet_wrap(~species, nrow=2, strip.position="right") + #make two strips so that one of the plots is on top of the other; have two rows; display the labels to the right
  theme_few() + scale_fill_grey() + #use this theme and use grayscale for the bars
  theme(panel.background = element_rect(fill = 'gray94', color = 'black'), legend.position="top",  legend.title= element_blank(), axis.title.y = element_text(size=12, face="bold", colour = "black"), strip.text.y = element_text(size = 10, face="bold", colour = "black")) + #use gray for the background and black for the outline; place year legend at top of graph; do not have a title for the legend; set formatting for the y axis title; set vertical labels on the right for species
  guides(fill=guide_legend(nrow=1,byrow=TRUE)) #make the legend be one row 

p
