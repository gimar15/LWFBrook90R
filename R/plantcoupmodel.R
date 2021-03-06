#' Interpolate plant properties using the 'Coupmodel' method.
#'
#' Creates a daily sequence for one year from parameters
#'
#' @param minval Minimum value.
#' @param maxval Maximum value.
#' @param doy.incr Date (day of year) when increasing to maxval begins.
#' @param doy.max  Date (day of year) when maxval is reached.
#' @param doy.min Date (day of year) when minval is reached.
#' @param shape.incr Shape parameter of the increasing phase.
#' @param shape.decr Shape parameter of the decreasing phase.
#' @param maxdoy Length of the year, 366 for leap years, 365 for normal years.
#'
#' @return A numeric vector of length \code{maxdoy}.
#'
#' @references
#' Jansson, P.-E. & Karlberg, L. (2004): "Coupled heat and mass transfer model for
#' soil-plant-atmosphere systems."
#' \emph{Royal Institute of Technolgy, Dept of Civil and Environmental Engineering Stockholm}
#'
#' @examples
#' plot(plant.coupmodel(0,5, 121, 200, 280, 0.3, 3, 365))
#' @export
plant.coupmodel <- function(minval,
                            maxval,
                            doy.incr,
                            doy.max,
                            doy.min,
                            shape.incr,
                            shape.decr,
                            maxdoy) {

  inddays <- as.integer(c(1,doy.incr,doy.max,doy.min,maxdoy))
  values <- c(minval, minval,maxval,minval,minval)

  forms <- c(1,shape.incr,shape.decr,1)

  ind <- c(rep(1, doy.incr - 1), rep(2, doy.max - doy.incr),
           rep(3, doy.min - doy.max), rep(4, maxdoy - doy.min + 1))

  doy <- 1:maxdoy

  alpha <-  sin(
    (doy - inddays[ind]) /  (inddays[ind+1] - inddays[ind]) * pi / 2) ^ (forms[ind])

  (1 - alpha)*values[ind] + alpha * values[ind+1]

}
