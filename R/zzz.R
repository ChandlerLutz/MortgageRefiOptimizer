.onLoad <- function(libname, pkgname) {

  out <- try(gsl::airy_Ai(1:3), silent = FALSE)

  if (inherits(out, what = "try-error")) {
    stop("Error:: the `gsl` package is not properly installed. See https://github.com/RobinHankin/gsl")
  }

}
