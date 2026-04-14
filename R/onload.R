
io <- NULL
msoffcrypto <- NULL
OOXMLFile <- NULL


#' @noRd
.onLoad <- function(libname, pkgname) {
  reticulate::py_require("msoffcrypto-tool")

  io <<- reticulate::import("io", delay_load = TRUE)
  msoffcrypto <<- reticulate::import("msoffcrypto", delay_load = TRUE)
  OOXMLFile <<- reticulate::import("msoffcrypto.format.ooxml", delay_load = TRUE)
}

