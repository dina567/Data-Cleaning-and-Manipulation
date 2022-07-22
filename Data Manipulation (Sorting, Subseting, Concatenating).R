# ------------DATA MANIPULATION -------------
# -------Order, Arrange, or Sort Data-----------
?mtcars
data(mtcars)

# Arrange rows by column values-----------

# Example 1: Sort data according to the cylinder number and engine displacement descendingly 

# Soluation 1: by arrange()

## Syntax: arrange(.data, ..., .by_group = FALSE)
## ... Use desc() to sort a variable in descending order 
## ... Use across(starts_with("Sepal")) to sort all columns start with Sepal in ascending order 
## ... Use across(starts_with("Sepal"), desc) to sort all columns start with Sepal in descending order
## If by_group = TRUE, will sort first by grouping variable.

library(dplyr)
arrange(mtcars, desc(cyl), desc(disp))

# Solution 2: by order()

# order(…, na.last = TRUE, decreasing = FALSE)
# …: a vectors (with sequence of numeric, complex, character or logical)
# na.last: If TRUE, missing values in the data are put last; if FALSE, they are put first; if NA, they are removed

mtcars[order(-mtcars$cyl, -mtcars$disp), ]

# Note: Sort() can be used to order a vector or factor (partially) into ascending or descending order. Not for dataframe.
# Sort() syntax: sort(x, decreasing = FALSE, na.last = NA)
x = c(110, 3, 4, 2, 5, 10, 11)
sort(x)

# Background of the mtcar disp column: displacement
# An engine is an air pump, which displace a certain amount of air to combine it with fuel, ignite, and produce power
# displacement describes how much air an engine is capable of displacing -> determine the power potential
# displacement depends on the number of cylinders, the area of the pistons, and how far they travel in the cylinder
# Reference: https://www.thedrive.com/cars-101/40767/what-is-engine-displacement


# -------Subset data----------
# Select columns that contain certain characters ---------

# Example 1: select columns contains Sepal in column names in iris data

# Solution 1: select()

## Syntax: select(.data, ...)
## ...: starts_with(), ends_with(), contains(), matches(), num_range(), one_of(), everything()

data(iris)
select(iris,contains("Sepal")) # OR
select(iris,matches("Sepal"))

# Solution 2: grep or grepl()

## grep returns a vector of the indices of the elements of x that yielded a match 
## grepl returns a logical vector (match or not for each element of x)
## Syntax: 
# grep(pattern, x, ignore.case = FALSE, perl = FALSE, value = FALSE,
#      fixed = FALSE, useBytes = FALSE, invert = FALSE)
# grepl(pattern, x, ignore.case = FALSE, perl = FALSE,
#       fixed = FALSE, useBytes = FALSE)
# grepl does not have value and invert assingment 
# x: a character vector where matches are sought
# ignore.case = TRUE, case is ignored during matching.
# invert = TRUE return indices or values for elements that do "not" match.


iris[,grepl("Sepal", colnames(iris)]
iris[,grep("Sepal", colnames(iris))]

##
# Note: Useful fun inside select() 
## everything(): Matches all variables.
## num_range(): Matches a numerical range like x01, x02, x03.
## all_of(): Matches variable names in a character vector. All names must be present, otherwise an out-of-bounds error is thrown.
## any_of(): Same as all_of(), except that no error is thrown for names that don't exist. This helper selects variables with a function:
## where(): Applies a function to all variables and selects those for which the function returns TRUE.

# everything()
# Move Sepal.Width before the rest of columns:
select(iris, Sepal.Width, everything())

# where()
# apply functions to columns using where()
select(iris,where(where(function(x) is.numeric(x) && mean(x) > 5))) # mean of the whole column
select(iris,where(where(~is.numeric(.x) && mean(.x) > 5)))
##


# Concatenate the character form multiple Columns -------------

# Example 1: Concatenate disp and cyl in mtcars data separated by -

# Method 1: paste() or paste0

  ## Syntax: paste(..., sep = " ", collapse = NULL, recycle0 = FALSE)
  ## paste0: paste without space
  ## ...: character vectors

paste(mtcars$cyl, mtcars$disp, sep = "-")
?paste()

# Method 2: str_c()
  
  ## Syntax: str_c(input vector, sep = "", input vector)
library("stringr")
str_c(mtcars$cyl, "-", mtcars$disp)

  ## can also concatenate both cyl and disp columns with *
  ## str_c(c(mtcars$cyl, mtcars$disp), "*")

# Method 3: unite()
  ## Syntax: unite(data, col, ..., sep = "_", remove = TRUE, na.rm = FALSE)
  ## col: The name of the new column, as a string or symbol.
  ## ...: columns to unite
  ## remove = TRUE: remove input columns from output data frame
  ## Note: the new col will be inserted before the first column to unite
library("tidyr")
unite(mtcars, col = "Merged", cyl:disp, sep = "-", remove = F)
