
io <- NULL
msoffcrypto <- NULL


#' @noRd
.onLoad <- function(libname, pkgname) {
  reticulate::use_virtualenv("r-rpxl", required = FALSE)

  io <<- reticulate::import("io", delay_load = TRUE)
  msoffcrypto <<- reticulate::import("msoffcrypto", delay_load = TRUE)
}

