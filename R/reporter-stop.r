#' Test reporter: stop on error.
#'
#' The default reporter, executed when \code{expect_that} is run
#' interactively, or when the test files are executed by R CMD check. It
#' responds by \link{stop}()ing on failures and doing nothing otherwise. This
#' will ensure that a failing test will raise an error.
#'
#' This should be used when doing a quick and dirty test, or during the final
#' automated testing of R CMD check.  Otherwise, use a reporter that runs all
#' tests and gives you more context about the problem.
#'
#' @export
#' @name StopReporter
#' @keywords debugging
NULL

StopReporter$do({
  self$add_result <- function(result) {
    if (result$passed) return()
    
    if (is.null(self$test)) stop(result$message, call. = FALSE)
    
    type <- if (result$error) "error" else "failure"
    msg <- str_c(
      "Test ", type, ": ", self$test, "\n", 
      result$message)
    stop(msg, call. = FALSE)
  }  
})