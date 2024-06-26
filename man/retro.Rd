% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/retro.R
\name{retro}
\alias{retro}
\title{Run a retrospective analyses}
\usage{
retro(
  dir = getwd(),
  masterdir = lifecycle::deprecated(),
  oldsubdir = "",
  newsubdir = "retrospectives",
  subdirstart = "retro",
  years = 0:-5,
  overwrite = TRUE,
  RemoveBlocks = FALSE,
  verbose = FALSE,
  exe = "ss3",
  ...
)
}
\arguments{
\item{dir}{Directory where everything takes place.}

\item{masterdir}{Deprecated. Use \code{dir} instead.}

\item{oldsubdir}{Subdirectory within \code{dir} with existing model
files.}

\item{newsubdir}{Subdirectory within \code{dir} where retrospectives
will be run. Default is 'retrospectives'.}

\item{subdirstart}{First part of the pattern of names for the directories in
which the models will actually be run.}

\item{years}{Vector of values to iteratively enter into the starter file for
retrospective year. Should be zero or negative values.}

\item{overwrite}{Overwrite any input files with matching names in the
subdirectories where models will be run.}

\item{RemoveBlocks}{Logical switch determining whether specifications of
blocks is removed from top of control file. Blocks can cause problems for
retrospective analyses, but the method for removing them is overly
simplistic and probably won't work in most cases. Default=FALSE.}

\item{verbose}{A logical value specifying if output should be printed
to the screen.}

\item{exe}{Executable name. Can be just the name of the executable
file if it is in the specified directory or in the user's PATH. Can
also include the absolute path or a path relative to the specified
directory. Needs to be a single character string, not a vector.
On Windows, \code{exe} can optionally have the \code{.exe} extension appended;
on Unix-based systems (i.e., Mac and Linux), no extension should be
included.}

\item{...}{Additional arguments passed to \code{\link[=run]{run()}}, such as
\code{extras}, \code{show_in_console}, and \code{skipfinished}.}
}
\description{
Do retrospective analyses by creating new directories, copying model files,
and iteratively changing the starter file to set the number of years of data
to exclude. Note that there was a  bug for retrospectives in 3.30.01;
the user should update their model to a newer version of Stock Synthesis to
run retrospectives. To run retrospective models in parallel, use \code{\link[future:plan]{future::plan()}}
before running \code{retro()}.
}
\examples{
\dontrun{
# note: don't run this in your main directory--make a copy in case something
# goes wrong
mydir <- "C:/Simple"

## retrospective analyses
retro(
  dir = mydir,
  years = 0:-5
)

retroModels <- SSgetoutput(
  dirvec = file.path(mydir, "retrospectives", paste("retro", 0:-5, sep = ""))
)
retroSummary <- SSsummarize(retroModels)
endyrvec <- retroSummary[["endyrs"]] + 0:-5
SSplotComparisons(retroSummary,
  endyrvec = endyrvec,
  legendlabels = paste("Data", 0:-5, "years")
)

## run retrospectives in parallel
ncores <- parallelly::availableCores(omit = 1)
future::plan(future::multisession, workers = ncores)
retro(
  dir = mydir,
  years = 0:-5
)
future::plan(future::sequential)
}

}
\seealso{
\code{\link[=SSgetoutput]{SSgetoutput()}}

Other run functions: 
\code{\link{copy_SS_inputs}()},
\code{\link{jitter}()},
\code{\link{populate_multiple_folders}()},
\code{\link{profile}()},
\code{\link{run}()},
\code{\link{tune_comps}()}
}
\author{
Ian G. Taylor, James T. Thorson, Kathryn L. Doering, Kiva L. Oken
}
\concept{run functions}
