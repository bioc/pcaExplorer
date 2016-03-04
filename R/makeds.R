
#' Title
#'
#' @param n number of rows (genes)
#' @param m number of columns (samples)
#' @param betaSD_condition the standard deviation for condition betas, i.e. beta ~ N(0,betaSD)
#' @param betaSD_tissue the standard deviation for tissue betas, i.e. beta ~ N(0,betaSD)
#' @param interceptMean the mean of the intercept betas (log2 scale)
#' @param interceptSD the standard deviation of the intercept betas (log2 scale)
#' @param dispMeanRel a function specifying the relationship of the dispersions on
#' \code{2^trueIntercept}
#' @param sizeFactors multiplicative factors for each sample
#'
#' @return a \code{\link{DESeqDataSet}} with true dispersion,
#' intercept for two factors (condition and tissue) and beta values in the
#'  metadata columns.  Note that the true betas are provided on the log2 scale.
#'
#' @examples
#'
#'
#' @export
makeExampleDESeqDataSet_multifac <- function (n = 1000, m = 12,
                                              betaSD_condition = 1,
                                              betaSD_tissue = 3,
                                              interceptMean = 4,
                                              interceptSD = 2,
                                              dispMeanRel = function(x) 4/x + 0.1,
                                              sizeFactors = rep(1,m))
{
  beta <- cbind(rnorm(n, interceptMean, interceptSD),
                rnorm(n,0, betaSD_condition),
                rnorm(n,0,betaSD_tissue)) # added a tissue covariate

  dispersion <- dispMeanRel(2^(beta[, 1]))
  colData <- S4Vectors::DataFrame(condition = factor(rep(c("A", "B"),
                                              times = c(ceiling(m/2), floor(m/2)))),
                       tissue = factor(rep(
                         rep(c("t1", "t2"),times = c(ceiling(m/4), floor(m/4))),2))
  )
  x <- if (m > 1) {
    model.matrix(~colData$condition + colData$tissue)
  }  else {
    cbind(rep(1, m), rep(0, m))
  }
  mu <- t(2^(x %*% t(beta)) * sizeFactors)
  countData <- matrix(rnbinom(m * n, mu = mu, size = 1/dispersion),
                      ncol = m)
  mode(countData) <- "integer"
  colnames(countData) <- paste("sample", 1:m, sep = "")
  rowRanges <- GRanges("1", IRanges(start = (1:n - 1) * 100 +
                                      1, width = 100))
  names(rowRanges) <- paste0("gene", 1:n)
  design <- if (m > 1) {
    as.formula("~ condition", env = .GlobalEnv)
  } else {
    as.formula("~ 1", env = .GlobalEnv)
  }
  object <- DESeqDataSetFromMatrix(countData = countData, colData = colData,
                                   design = design, rowRanges = rowRanges)
  trueVals <- DataFrame(trueIntercept = beta[, 1], trueBeta = beta[,
                                                                   2], trueDisp = dispersion)
  mcols(trueVals) <- DataFrame(type = rep("input", ncol(trueVals)),
                               description = c("simulated intercept values", "simulated beta values",
                                               "simulated dispersion values"))
  mcols(object) <- cbind(mcols(object), trueVals)
  return(object)
}