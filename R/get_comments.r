#' Collect comments lines starting from "#C"
#' in datfile, ctlfile, starter.ss, forecast.ss etc
#'
#' This function is used internally by SS_readdat_3.30,
#' SS_readctl_3.30.
#' This will identify 1st numeric data in dat (vector of string)
#' Then this function collects lines starting "#C" from lines
#' above 1st numeric data.
#' @param dat vector of strings usually outputs of readLines(*)
#'            * is filename of datfile, ctlfile etc
#' @param defaultComments vector of strings
#'        default : NULL, to read whole comments
#'        If this function finds lines containg one of elements
#'        of defaultComments, those lines will be ignored
#'        e.g. c("^#C file created using the SS_writectl function in the R package r4ss",
#'                "^#C file write time:")
#'        is given, comments generated by SS_writectl_3.30 will be ignored.
#' @author Yukio Takeuchi
#' @seealso \code{\link{SS_readdat}}, \code{\link{SS_readdat_3.30}},
#' \code{\link{SS_readctl}}, \code{\link{SS_readctl_3.30}}
#' 
#
get_comments <-
  function (dat, defaultComments = NULL) {
    # Remove left and right trailing spaces of each line
    dat <- sapply(dat, "trimws")
    names(dat) <- NULL
    if (length(defaultComments) > 0) {
      delLns <-
        unlist(sapply(defaultComments, "grep", x = dat))
      delLns <- unique(delLns)
      if (length(delLns) > 0)
        dat <- dat[- delLns]
    }

    # Regular expression hopefully covering most of numerics
    # https://qiita.com/BlueSilverCat/items/f35f9b03169d0f70818b (in Japanese)
     regexpNumeric <-
      '^[+-]?(?:\\d+\\.?\\d*|\\.\\d+)(?:(?:[eE][+-]?\\d+)|(?:\\*10\\^[+-]?\\d+))?'
    # Find the 1st line containing numeric data
    firstNumericLine <- grep(dat, pattern = regexpNumeric)[1]
    res <-
      grep(x = dat[seq_len(firstNumericLine - 1)],
        pattern = "^#C", value = TRUE)
    if (length(res) == 0)res <- NULL
    return(res)
  } 