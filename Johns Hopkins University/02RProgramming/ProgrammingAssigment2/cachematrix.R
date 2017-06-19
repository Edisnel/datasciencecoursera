## This function creates a matrix object that can cache its inverse

#This second programming assignment will require you to write an R
#function that is able to cache potentially time-consuming computations.
#For example, taking the mean of a numeric vector is typically a fast
#operation. However, for a very long vector, it may take too long to
#compute the mean, especially if it has to be computed repeatedly (e.g.
                                                                  in a loop). If the contents of a vector are not changing, it may make
#sense to cache the value of the mean so that when we need it again, it
#can be looked up in the cache rather than recomputed. In this
#Programming Assignment you will take advantage of the scoping rules of
#the R language and how they can be manipulated to preserve state inside
#of an R object.

makeCacheMatrix <- function(x = matrix()) {
  invm <- NULL
  set <- function(y) {
    x <<- y
    invm <<- NULL
  }
  get <- function() x
  setsolve <- function(sol) invm <<- sol
  getsolve <- function() invm
  list(set = set, get = get,
       setsolve = setsolve,
       getsolve = getsolve)     
}


## This function computes the inverse of the matrix

cacheSolve <- function(x, ...) 
{
  invm <- x$getsolve()
  
  if(!is.null(invm)) 
  {
    message("getting the inverse from the cache")
    return(invm)
  }
  data <- x$get()
  invm <- solve(data)
  x$setsolve(invm)
  invm
}

