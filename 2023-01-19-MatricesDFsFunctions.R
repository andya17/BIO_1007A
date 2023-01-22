#### Finishing up matrices and data frames
#### 19 January 2023
#### AMA

### Matrices

m <- matrix(data=1:12, nrow=3)

m[1:2, ] #subset based on elements
m[, 2:4]

colSums(m) > 15 #logical for all columns with totals > 15
m[, colSums(m) > 15] #subset based on the condition

rowSums(m) == 22
m[rowSums(m) == 22, ] #rows that sum up to 22
m[!rowSums(m) == 22, ] #rows that do not sum up to 22 (or !=22,) [ Logical operators: == != > < ]

z <- m[1, ]
print(z) 
str(z) #now a vector
z2 <- m[1, , drop=F] #keeps it as a matrix

m2 <- matrix(data=runif(9), nrow=3)
m2[3,2] #use rows and columns (both indices) to select
m2[m2 > 0.6]<- NA #makes those values greater than 0.6 NA

### Data Frames

data <- iris
head(data) #see the first 6 rows of the DF
tail(data) #see the last 6 rows of the DF
data[3,2] #numbered indices
dataSub <- data[,c("Species", "Petal.Length")] #all rows and named columns

orderedIris <- iris[order(iris$Petal.Length),] #sorting the rows by petal length
head(orderedIris) #now starts with the lowest petal length

### Functions

sum(3,2) #sum() is function
3 + 2 #plus sign is function
sd #run to see structure of stdev function

# functionName <- function(argX=defaultX, argY = defaultY){
  #can create local variables- within a function and not global
  #will be using argX and argY in body since they were specified above
  #end with return(z), not print
#}

myFunction <- function(a=3, b=4){
  z <- a+b
  return(z)
}
myFunction() #runs with the default
myFunction(a=100, b=3.4)

myFunctionBad <- function(a=3){ #will give errors because b is undefined; but it would recognize a global variable
  z <- a+b
  return(z)
}

myFunction2 <- function(a=NULL, b=NULL){
  z <- a+b
  return(z)
}

# Multiple return statements

#######################################
# Function: HardyWeinberg
# Input: all allele frequency p (0,1)
# Output: p and the frequencies of 3 genotypes: AA, AB, BB
# -----------------------------------------------
HardyWeinberg <- function(p=runif(1)){
  if(p> 1.0 | p < 0.0){
    return("Function failure: p must be between 0 and 1")
  }
  q <- 1-p
  fAA <- p^2
  fAB <- 2*p*q
  fBB <- q^2
  vecOut <- signif(c(p=p, AA=fAA, AB=fAB, BB=fBB), digits = 3)
  return(vecOut)
}
# -----------------------------------------------
#######################################

HardyWeinberg()
freqs <- HardyWeinberg()
HardyWeinberg(p=3)

#######################################
# Function: fitLinear2
# Fits a simple regression line
# Input: numeric list (p) of predictor (x) and response (y)
# Output: slope and p-value
# -----------------------------------------------

fitLinear2 <- function(p=NULL){
  if(is.null(p)){
    p <- list(x=runif(20), y=runif(20))
  }
  myMod <- lm(p$x~p$y)
  myOut <- c(slope=summary(myMod)$coefficients[2,1], pValue=summary(myMod)$coefficients[2,4]) 
  plot(x=p$x, y=p$y)
  return(myOut)
}
# -----------------------------------------------
#######################################
fitLinear2()
myPars <- list(x=1:10, y=runif(10))
fitLinear2(p=myPars)
