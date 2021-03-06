% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/adjusted_envelopes.r
\name{combined_global_envelope_with_sims}
\alias{combined_global_envelope_with_sims}
\title{A combined global envelope test}
\usage{
combined_global_envelope_with_sims(X, nsim, simfun = NULL,
  simfun.arg = NULL, ..., testfuns = NULL, test = c("rank", "qdir", "st"),
  alpha = 0.05, alternative = c("two.sided", "greater", "less"),
  r_min = NULL, r_max = NULL, take_residual = FALSE, lexo = TRUE,
  ties = NULL, save.envelope = TRUE, savefuns = FALSE,
  savepatterns = FALSE, verbose = FALSE)
}
\arguments{
\item{X}{An object containing point pattern data. A point pattern (object of class "ppp")
or a fitted point process model (object of class "ppm" or "kppm"). See
\code{\link[spatstat]{envelope}}.}

\item{nsim}{The number of simulations.}

\item{simfun}{A function for generating simulations from the null model. If given, this function
is called by replicate(n=nsim, simfun(simfun.param), simplify=FALSE) to make nsim simulations.
The function should return an \code{\link[spatstat]{ppp}} object as those are further passed to
\code{\link[spatstat]{envelope}}.
If the function is not provided, then \code{\link[spatstat]{envelope}} is used also for generating
the point patterns from the null hypothesis.}

\item{simfun.arg}{The parameter to be passed to simfun. The function simfun should handle
with the structure of simfun.param.}

\item{...}{Additional parameters passed to \code{\link[spatstat]{envelope}}.
For example, the test function in the argument 'fun' and further specifications regarding that.
If \code{\link[spatstat]{envelope}} is also used to generate simulations under the null hypothesis
(if simfun not provided), then also recall to specify how to generate the simulations.}

\item{testfuns}{A list of lists of parameters to be passed to \code{\link[spatstat]{envelope}}.
A list of parameters should be provided for each test function that is to be used in the combined test.}

\item{test}{Either "rank" for the \code{\link{rank_envelope}} test, "qdir" for the
\code{\link{qdir_envelope}} test or "st" for the \code{\link{st_envelope}} test.}

\item{alpha}{The significance level. The 100(1-alpha)\% global envelope will be calculated.}

\item{alternative}{A character string specifying the alternative hypothesis. Must be one of
the following: "two.sided" (default), "less" or "greater" for "rank". Relevant only for the
rank test (otherwise ignored).}

\item{r_min}{The minimum radius to include in the test.}

\item{r_max}{The maximum radius to include in the test. Note: cannot be larger than r-values used
in calculating functions by \code{\link[spatstat]{envelope}}.}

\item{take_residual}{If (needed for visual reasons only) the theoretical or mean behaviour of the
test function is reduced from the test functions. If TRUE, then: If \code{\link[spatstat]{envelope}}
provides the theoretical value 'theo' for the simulated model, then this value is used. Otherwise,
the theoretical function is taken as the mean of the simulations.}

\item{lexo}{Logical, whether or not to use lexical ordering for calculation of the p-value.
in the rank envelope test. See \code{\link{rank_envelope}}.}

\item{ties}{Ties method to be passed to \code{\link{rank_envelope}}. Used to obtain a point estimate
for the p-value, if lexo=FALSE. The default point estimate is the mid-rank p-value.}

\item{save.envelope}{Logical flag indicating whether to save all envelope test results.}

\item{savefuns}{Logical flag indicating whether to save all the simulated function values.
See \code{\link[spatstat]{envelope}}.}

\item{savepatterns}{Logical flag indicating whether to save all the simulated point patterns.
See \code{\link[spatstat]{envelope}}.}

\item{verbose}{Logical flag indicating whether to print progress reports during the simulations.
See \code{\link[spatstat]{envelope}}.}
}
\description{
A combined global envelope test including simulations from a point process model.
}
\details{
Details of the tests are given in \code{\link{rank_envelope}} (rank envelope test),
\code{\link{combined_scaled_MAD_envelope}} (directional quantile and studentized envelope tests).

The specification of X is important here:
if simfun is not provided, the function \code{\link[spatstat]{envelope}} is used to generate
simulations under the null hypothesis and to calculate the test functions (specified in the
arguments ...) and then
\itemize{
\item If X is a point pattern, the null hypothesis is CSR.
\item If X is a fitted model, the null hypothesis is that model.
}
If simfun is provided, then the null model is the one simulated by this given function,
and X is expected to be a point pattern of \code{\link[spatstat]{ppp}} object, for which data
pattern and simulations \code{\link[spatstat]{envelope}} calculates the test statistics.

If savefuns is TRUE, all the simulated functions are saved in an attribute "simfuns" as a list
of curve sets for each test function.
}
\seealso{
\code{\link[spatstat]{envelope}} (that is used to perform simulations),
\code{\link{rank_envelope}}, \code{\link{qdir_envelope}}, \code{\link{st_envelope}}
}
