# Programming in R
# 12 January 2023
# AMA

# Advantages (interactive, graphics/stats, active community of contributors, accessible package creation, works on multiple platforms)
# Disadvantages (lazy evaluation, some packages poorly documented, some functions are hard to learn, some packages are unreliable, problems with large files)

### Assignment operator: used to assign a new value to a variable; run with command enter; print(x) or x in CONSOLE to see value. ###

x <- 5 #preferred

y = 4 #legal but not used except in function arguments
y = y + 1.1
y <- y + 1.1

### Variables: used to store information (a container). ###

z <- 3 #single-letter variables for temp or unimportant ones
plantHeight <- 10 #camelCase format
plant_height <- 3.3 #snakecase format, preferred
plant.height <- 4.2 #probably should avoid
. <- 5.5 #reserve this for a temporary variable; not saved in environment

### Functions: blocks of code that perform a task; use short command over again instead of writing out code block multiple times. ###

# You can create your own function.

square <- function(x = NULL){
  x <- x^2
  print(x)
}
z <- 103
square(x=z) #the argument name is x; after equals sign is what you want to put into the function

# Or there are built-in functions with specified arguments.

sum(109, 3, 10) #look at package info using ?sum or going to Help panel

### Atomic Vectors: one-dimensional, like a single row; fundamental data structure in R ###

# Types: character strings (words within quotes), integers (whole numbers; numeric), double (real numbers, decimal; numeric), logical (true/false), factor (puts variables into different groups)

# c function (combines elements)

z <- c(3.2, 5, 5, 6)
print(z)
class(z) #lets you know what you're working with: class
typeof(z) #it converted all to double because of 3.2; returns type
is.numeric(z) #returns true/false

# c() always flattens to a vector.
z <- c(c(3, 4), c(5, 6)) #avoid using multiple c()s

# Character vectors

z <- c("perch", "bass", "trout")
print(z)
z <- c("This is only 'one' character string", "a second", "a third")
print(z)
typeof(z)
class(z)
is.character(z) #is functions test whether it is a certain data type, and as functions forces a data type

# Logical (Boolean), no quotes, all caps: true and/or false.

z <- c(T, F, T, F)
is.logical(z)
z <- as.character(z)
print(z)

# Type: is.numeric, as.character, typeof()

# Length: how long is the vector?

length(z)
dim(z) #no dimension

# Names

z <- runif(5) #random values from 0 to 1
names(z) #no names yet
names(z) <- c("chow", "pug", "beagle", "greyhound", "akita")
print(z)
names(z) <- NULL #reset names

# NA values: missing data

z <- c(3.2, 3.5, NA)
typeof(z)
mean(z) #arithmetic does not work if you have NA
anyNA(z) #check for NAs
is.na(z) #looks at each element, useful for smaller vectors
which(is.na(z)) #returns which element is an NA

# Subsetting vectors, so certain elements show.

z <- c(3.1, 9.2, 1.3, 0.4, 7.5)
z[4] #vectors are indexed (given value); use square brackets to subset by index number.
z[c(4, 5)] #use c to get 2 or more values back
z[-c(2, 3)] #everything except for 2 and 3
z[z==7.5] #double equals sign in brackets to only return the elements that meet the condition.
z[z<7.5] #use logical statements within square brackets to subset by conditions
which(z < 7.5) #which indices are less than 7.5
z[which(z < 7.5)] #same as z[z<7.5]

# Subsetting characters (named elements).

names(z) <- c("a", "b", "c", "d", "e")
z[c("a", "d")]
subset(x=z, subset=z>1.5) #can't change argument name from x

# Randomly sample, add/edit elements

story_vec <- c("A", "Frog", "Jumped", "Here")
sample(story_vec) #shuffle around elements
sample(story_vec, size=3) #randomly select 3 elements from vector
story_vec <- c(story_vec[1], "Green", story_vec[2:4]) #first element, add something else, then everything else
story_vec[2] <- "Blue" #overwrite

# Vector function
vec <- vector(mode = "numeric", length=5)

# Rep and seq functions

z <- rep(x=0, times=100) #repeat 100 times
z <- rep(x=1:4, each=3) #colon for sequence, do each element x # times

z <- seq(from=2, to=4)
z <- seq(from=2, to=4, by=0.5) #each number different by 0.5
seq(from=1, to=length(z))




