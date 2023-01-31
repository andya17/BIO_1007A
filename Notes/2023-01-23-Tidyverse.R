#### Tidyverse
#### 23 January 2023
#### AMA

### Tidyverse: collection of packages that shares philosophy, grammar (code structure), data structures

### Operators: symbols that tell R to perform different operations (between variables and functions)
## Arithmetic: + - * / ^ ~
## Assignment: <-
## Logical: ! & | 
## Relational: == != < > >= <=
## Misc: %>% (forward pipe), %in%

### Only need to install packages once: don't put install.packages as part of script, do it in console
library(tidyverse) #library function to load in packages

### dplyr: new packages provide tools for manipulating datasets; written to be fast; individual functions that correspond to common operations

### Core verbs: filter(); arrange(); select(); groupby() and summarize(), mutate()

## Built-in dataset
data(starwars)
class(starwars) #Tibble

# Tibble: data frame modern take, keeps great aspects and drops frustrating ones
glimpse(starwars)
anyNA(starwars) #is.na, complete.cases, are other functions
starwarsClean <- starwars[complete.cases(starwars[,1:10]),]
glimpse(starwarsClean)
anyNA(starwarsClean[,1:10])

## Filter(): picks/subsets observations (ROWS) by their values
filter(starwarsClean, gender == "masculine" & height < 180) #can replace & with comma
filter(starwarsClean, gender == "masculine", height < 180, height > 100)
filter(starwarsClean, gender == "masculine" | gender == "feminine") #only two in the dataset so doesn't do anything

## %in% operator (matching); similar to == but you can compare vectors of different lengths

a <- LETTERS[1:10]
length(a) #length of vector
b <- LETTERS[4:10]; length(b)

a %in% b #logical statement; output depends on contents of first vector
b %in% a

eyes <- filter(starwars, eye_color %in% c("blue", "brown"))
View(eyes)

## arrange(): reorders rows

arrange(starwarsClean, by=height) #default is ascending order
arrange(starwarsClean, by=desc(height)) #desc around it to make descending
arrange(starwarsClean, height, desc(mass)) #second variable used to break ties
sw <- arrange(starwars, by=height)
tail(sw) #all NAs at the bottom

## select(): chooses variables (columns) by their names

select(starwarsClean, 1:10)
select(starwarsClean, name:species) #names through species
select(starwarsClean, -(films:starships)) #don't want last few
starwarsClean[,1:11] #does same as prev two lines

select(starwarsClean, name, gender, species, everything()) #reorder columns; everythijng is helper function useful if you have a couple of variables you want to move to front
select(starwarsClean, contains("color")) #column names which contain color; others include ends_with(), starts_with(), num_range()

select(starwarsClean, haircolor = hair_color) #returns renamed column
rename(starwarsClean, haircolor = hair_color)

## mutate(): creates new variables using functions of existing variables

mutate(starwarsClean, ratio = height/mass) #puts it at end by default
starwars_lbs <- mutate(starwarsClean, mass_lbs = mass*2.2, .after=mass) #.after or .before for placement
starwars_lbs <- select(starwars_lbs, 1:3, mass_lbs, everything()) #first three columns, then mass_lbs
glimpse(starwars_lbs)

transmute(starwarsClean, mass, mass_lbs=mass*2.2, height) #new column only or add others before and after

## groupby() and summarize()

summarize(starwarsClean, meanHeight=mean(height)) #mean height of all characters in data frame; should use na.rm for unclean datasets
summarize(starwarsClean, meanHeight=mean(height), TotalNumber=n()) #average height and total number of observations

starwarsGenders <- group_by(starwars, gender)
head(starwarsGenders) #says two groups of gender
summarize(starwarsGenders, meanHeight = mean(height, na.rm = TRUE), number = n()) #compare by groups

## Piping (%>%) 
# Used to emphasize a sequence of actions; allows you to pass an intermediate result onto the next function; uses output of one function as input of the next function; should avoid if you need to manipulate more than one object/variable at a time or if variable is meaningful
# Should always have a space before a pipe followed by a new line

starwarsClean %>%
  group_by(gender) %>%
  summarize(meanHeight=mean(height, na.rm=T), TotalNumber=n())

# case_when() is useful for multiple if statements or if/else statements

starwarsClean %>% 
  mutate(sp=case_when(species=="Human" ~ "Human", T ~ "Non-Human")) #if species is human, put it down in new column, otherwise non-human column




