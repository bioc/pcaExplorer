#' Title
#'
#' @param df
#' @param method
#'
#' @return
#' @export
#'
#' @examples
pair_corr <- function(df,method="pearson") {
  # get min and max count values for axis range.
  rangeMin = min(df)
  rangeMax = max(df)

  colorFunction = colorRamp(c("black", "red"))
  # colorFunction() expects values from 0 to 1.
  zMatrix = colorFunction(seq(0,1,by=.01))
  # zColors goes from 1 to 100.
  zColors = sort(rgb(zMatrix[,1], zMatrix[,2], zMatrix[,3], maxColorValue=255))
  labelSize=1
  title="Pairwise Correlations"
  # Modified from R pairs() documentation
  panel.cor = function(x, y, digits=2, prefix="", cex.cor, ...) {
    usr = par("usr"); on.exit(par(usr))
    par(usr = c(0, 1, 0, 1))
    r = abs(cor(x, y,method = method))
    txt = format(c(r, 0.123456789), digits=digits)[1]
    txt = paste(prefix, txt, sep="")

    # if (FALSE) {
    #   # color text based on r value and change size of text also based on r value (larger text for larger r value).
    #   if (missing(cex.cor)) cex.cor = labelSize/strwidth(txt)
    #   text(0.5, 0.5, txt, cex=cex.cor*r, col=zColors[r*100])
    # } else {
    # color text based on r value (red is r=1).
    text(0.5, 0.5, txt, cex=labelSize, col=zColors[r*100])
    # }
  }
  par(mar = c(0,0,0,0))

  pairs(df, pch=20, col=alpha("black", 0.4),cex.labels=labelSize, main=title, upper.panel=panel.cor, ylim=c(rangeMin,rangeMax), xlim=c(rangeMin,rangeMax))
}