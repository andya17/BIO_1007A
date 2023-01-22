#### Vectors, matrices, data frames, lists
#### 17 Jan 2023
#### AMA

### Vectors (continued) - Properties

## Coercion
# All atomic vectors are of the same data type. If you use c() to assemble different types, R coerces them. Logical -> Integer -> Double -> Character. Will go with lowest form when coercing/converting.

a <- c(2, 2.2)
typeof(a) #coerces to double
b <- c("purple", "green")
typeof(b)
d <- c(a, b)
typeof(d) #the doubles have been converted to characters

# Comparison operators yield a logical result.

a <- runif(10)
print(a)
a > 0.5 #conditional statement produces string of T F

# How many elements in the vector are greater than 0.5?

sum(a > 0.5) #there are 3 elements over 0.5; sum of Ts
mean(a > 0.5) #mean of proportion of elements over 0.5 (3/10)

## Vectorization
# Add a constant to a vector and have it applied to all elements within.

z <- c(10, 20, 30)
z + 1 #adds 1 to all elements

# What about when vectors are added together?

y <- c(1, 2, 3)
z + y #results in element by element operation

## Recycling
# What about unequal vector lengths?

z
x <- c(1, 2)
z + x #warning is issued but calculation is made; shorter vector is recycled

## Simulating data: runif() and rnorm()

set.seed(123) #make it produce same random numbers each time to make runif() reproducible; seed can be any #
runif(n=5, min=5, max=10) #n is sample size; change min and max

rnorm(6) #random normal values with mean 0 and SD 1
randomnormal <- rnorm(100)
mean(randomnormal) #mean should approach 0 with more numbers generated; use hist function
hist(rnorm(n=100, mean=100, sd=30)) #simulate data with specific parameters

### Matrices
# 2D with rows and columns, but still homogeneous, usually numeric data types; atomic vector organized into rows and columns.

my_vec <- 1:12
m <- matrix(data = my_vec, nrow = 4) #specify rows
m <- matrix(data = my_vec, ncol = 3) #specify columns
m <- matrix(data = my_vec, ncol = 3, byrow = T) #fill in across

dim(my_vec)
dim(m) #4 rows 3 columns

### Lists
# Atomic vectors but each element can hold different data types and sizes.

myList <- list(1:10, matrix(1:8, nrow=4, byrow=T), letters[1:3], pi)
class(myList) #display class (list)
str(myList) #display structure

# Subsetting lists - [] gives a single item but not the elements

myList[4]
myList[4] - 3 #cannot do this; still in compartment so the type is still a list; shows double brackets in the console 
myList[[4]] - 3 #can do this because we used double brackets
myList[[2]][4,1] #select 4th row 1st column; first number always row index
myList[c(1,2)] #return multiple elements of the list

myList2 <- list(Tester = F, littleM = matrix(1:9, nrow=3)) #give names immediately
myList2$Tester #dollar sign for named slots
myList2$littleM[2,3] #extracts 2nd row, 3rd column of littleM
myList2$littleM[2,] #extracts the entire 2nd row of littleM (2nd row, all columns)
myList2$littleM[2] #giving it just numbers will just take the element which corresponds

# Unlist to string everything back to vector
unRolled <- unlist(myList2)

head(iris) #data(iris) in console
plot(Sepal.Length ~ Petal.Length, data=iris) #sepal length as it relates to petal length using iris data (y~x)
model <- lm(Sepal.Length ~ Petal.Length, data=iris)
results <- summary(model) #significance for petal length; estimate says predicted slope; typeof(results) shows that it is a list

results$coefficients[2,4] #extract the 2nd row 4th column, which is the significance
results[[4]][2,4] #extract the 2nd row 4th column, which is the significance
resultsunroll <- unlist(results)
resultsunroll$coefficients8 #extract the value after unrolling; coefficients8 is always the name of the significance!

### Data Frames 
# Equal-length vectors, each of which is a column

varA <- 1:12
varB <- rep(c("Con", "LowN", "HighN"), each=4)
varC <- runif(12)

dFrame <- data.frame(varA, varB, varC, stringsAsFactors = F)
newData <- list(varA=13, varB='HighN', varC=0.668) #new row creation
dFrame <- rbind(dFrame, newData) #add row to the DF

newVar <- runif(13)
dFrame <- cbind(dFrame, newVar) #new column creation

# Why doesn't c() work?

newData2 <- c(14, "HighN", 0.668)
dFrame <- rbind(dFrame, newData2) #this will make everything characters because it coerced; see str(dFrame) in console to check

### Data Frames vs. Matrices

zMat <- matrix(data=1:30, ncol=3, byrow=T)
zDframe <- as.data.frame(zMat) #try to coerce into DF; has default headings

zMat[3,3] #3rd row and 3rd column
zDframe[3,3] #3rd row and 3rd column

zMat[,3] #all the rows in the third column
zDframe[,3] #all the rows in the third column
zDframe$V3 #all the rows in the third column
zDframe["V3"]

zMat[3,] #all columns in 3rd row
zDframe[3,] #all columns in 3rd row

zMat[3] #3rd element
zDframe[3] #whole 3rd column

### Eliminate NAs

zD <- c(NA, rnorm(10), NA, rnorm(3))
complete.cases(zD) #returns false for any NAs
zD[complete.cases(zD)] #removes the two NAs
which(!complete.cases(zD)) #which ones are the NAs

m <- matrix(1:20, nrow=5)
m[1,1] <- NA
m[5,4] <- NA
complete.cases(m) #gives the whole row
m[complete.cases(m),] #all columns but only rows that are complete

m[complete.cases(m[,c(1:2)]),] #replacing the m (entire matrix) and saying only look at first two columns; have to end with comma so that we get all columns
