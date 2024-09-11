#' Deprecated functions in pcaExplorer
#'
#' Functions that are on their way to the function afterlife.
#' Their successors are also listed.
#' 
#' The successors of these functions are likely coming after the rework that
#' led to the creation of the `mosdef` package. See more into its 
#' documentation for more details.
#' 
#' @param ... Ignored arguments.
#' 
#' @return All functions throw a warning, with a deprecation message pointing 
#' towards its descendent (if available).
#' 
#' @name deprecated
#' 
#' @section Transitioning to the mosdef framework:
#' 
#' * [topGOtable()] is now being replaced by the more flexible 
#' [mosdef::run_topGO()] function
#' 
#' @author Federico Marini
#' 
#' @examples
#' # try(topGOtable())
#' 
NULL


## #' @export
## #' @rdname defunct
## trendVar <- function(...) {
##   .Defunct("fitTrendVar")
## }
