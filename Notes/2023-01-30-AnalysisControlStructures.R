#### Simple Data Analyses and More Complex Control Structures
#### 30 January 2023
#### AMA

dryad <- read.table(file="Data/Veysey-Babbitt_data_amphibians.csv", header=T, sep=",")
library(tidyverse)
library(ggthemes)

### Analyses
# Independent/explanatory and dependent/response variable (x vs y)
# Continuous vs discrete/categorical variables (range of numbers vs groups of values, can be put into bins)

# x cont y cont = REGRESSION (Linear, correlation analysis); SCATTER PLOT
# x cat y cont = T-TEST (2 groups) or ANOVA (2+); BAR PLOT or BOX PLOT
# x cat y cat = CHI-SQUARED (count); TABLE or MOSAIC PLOT
# x cont y cat = LOGISTIC REGRESSION (presence and absence)

glimpse(dryad)

### Linear regression
# Is there a relationship between mean pool hydroperiod and number of breeding frogs caught? mean.hydro vs count.total.adults; y var ~ x var

regModel <- lm(count.total.adults~mean.hydro, data=dryad)
summary(regModel) #gives more info than glimpse; Estimate gives slope; usually ignore Intercept row
hist(regModel$residuals) #see the residuals to see if there are outliers
summary(regModel)$"r.squared" #see if similar to one given in summary?
View(summary(regModel)) #gives code to extract when you click on variables

regPlot <- ggplot(data=dryad, aes(x=mean.hydro, y=count.total.adults)) + 
  geom_point() + 
  stat_smooth(method="lm", se=0.99)
regPlot + theme_few()

### Basic ANOVA
# Was there a stat significant difference in the number of adults among wetlands?
#y~x

ANOmodel <- aov(count.total.adults~factor(wetland), data=dryad)
summary(ANOmodel) #wetland is actually different groups, not integers; adding factor() changes the p-value

dryad %>%
  group_by(factor(wetland)) %>%
  summarize(avgHydro=mean(count.total.adults, na.rm=T), N=n())

### Box plot

dryad$wetland <- factor(dryad$wetland) #integer class turned into factor class

ANOplot <- ggplot(data=dryad, aes(x=wetland, y=count.total.adults, fill=species)) + 
  geom_boxplot() +
  scale_fill_grey() #use fill to show another variable, like species, and show it in gray
#ggsave(file="SpeciesBox.pdf", plot=ANOplot, device="pdf")

### Logistic regression
# gamma probabilities are cont variables that are always positive and have a skewed distribution

xVar <- sort(rgamma(n=200, shape=5, scale=5))
yVar <- sample(rep(c(1,0), each=100), prob=seq_len(200))

logRegData <- data.frame(xVar, yVar)
logRegModel <- glm(yVar~xVar, data=logRegData, family=binomial(link=logit))
logRegPlot <- ggplot(data=logRegData, aes(x=xVar, y=yVar)) +
  geom_point() +
  stat_smooth(method="glm", method.args=list(family=binomial))

### Chi-squared (Contingency table)
# Are there differences in counts of males and females between species?

countData <- dryad %>%
  group_by(species) %>%
  summarize(Males=sum(No.males, na.rm=T), Females=sum(No.females, na.rm=T)) %>%
  select(-species) %>%
  as.matrix()

row.names(countData) <- c("SS", "WF")
chisq.test(countData)$residuals #how far away the observed values are from the expected

### Mosaic plot (base R)

mosaicplot(x=countData, col=c("goldenrod", "gray"), shade=F)

### Bar plot

countDataLong <- countData %>%
  as_tibble() %>%
  mutate(Species=c(rownames(countData))) %>%
  pivot_longer(cols=Males:Females, names_to = "Sex", values_to = "Count")

ggplot(data=countDataLong, aes(x=Species, y=Count, fill=Sex)) +
  geom_bar(stat="identity", position="dodge") + #plots bars next to each other
  scale_fill_manual(values=c("darkslategrey", "midnightblue"))

############################################################

### Control structures
## if statements and if else statements
  # if(condition){expression 1}
  # if(condition){expression 1} else {expression 2}
  # if(condition 1){expression 1} else if (condition 2) {exoression 2} else {expression 3}
  # if there are any final unspecified else it will capture the rest of unspecified conditions
  # else must appear on the same line as the expression
  # use it for single values, not necessarily vectors

z <- signif(runif(1), digits=2)
z > 0.5

if (z > 0.8) {cat(z,"is a large number","\n")} else 
  if (z < 0.2) {cat(z,"is a small number","\n")} else
  {cat(z,"is a number of typical size","\n")
    cat("z^2 =",z^2,"\n")}

## ifelse to fill vectors
  # ifelse(condition, yes, no)
  # Insect population where females lay 10.2 eggs on average, follows Poisson distribution (discrete probability distribution showing likely number of times an event will occur). 35% chance of parasitism where no eggs are laid.

tester <- runif(1000)
eggs <- ifelse(tester>0.35, rpois(n=1000, lambda=10.2), 0) #if it's not over 0.35 then it's assigned 0

# Vector of p-values from a simulation

pVals <- runif(1000)
z <- ifelse(pVals <= 0.025, "lowerTail", "nonSig")
z[pVals >= 0.975] <- "upperTail"
table(z)

### For loops
# workhorse function for repetitive tasks; universal in all computer languages
# controversial in R because often not necessary (vectorization, very slow with certain operations, family of applied functions)
  # for(var in sequence){#starts the for loop
   # body
   # end of for loop
   #}
  # var is a counter variable that holds the current value of the loop (i, j, k)
  # sequence is an integer vector that defines the start/end of the loop

for(i in 1:5){
  cat("stuck in a loop", i, "\n")
  cat(3+2, "\n")
  cat(3+i, "\n")
}
print(i) #will be last value

# Use counter variable that maps to position of each element

my_dogs <- c("chow", "akita", "malamute", "husky", "samoyed")

for(i in 1:length(my_dogs)){
  cat("i=", i, "my dogs[i]=", my_dogs[i], "\n")
}

# Loop over rows and columns

m <- matrix(round(runif(20), digits=2), nrow=5)
for(i in 1:nrow(m)){
  m[i,] <- m[i,] + i #overwrite to add i to matrix rows
}

m <- matrix(round(runif(20), digits=2), nrow=5)
for(j in 1:ncol(m)){
  m[,j] <- m[,j] + j #overwrite to add j to matrix columns
}

m <- matrix(round(runif(20), digits=2), nrow=5)
for(i in 1:nrow(m)){
  for(j in 1:ncol(m)){
    m[i,j] <- m[i,j] + i + j
  }
}
