
io <- NULL
msoffcrypto <- NULL
OOXMLFile <- NULL


#' @noRd
.onLoad <- function(libname, pkgname) {
  # the full dependency chain is pinned so that uv's resolution is
  # deterministic and its cached environment can be reused, rather than
  # re-resolving (and possibly re-downloading or building) newly-published
  # releases on every load
  reticulate::py_require(c(
    "msoffcrypto-tool==6.0.0",
    "cryptography==50.0.1",
    "olefile==0.47",
    "cffi==2.1.1",
    "pycparser==3.0"
  ))

  io <<- reticulate::import("io", delay_load = TRUE)
  msoffcrypto <<- reticulate::import("msoffcrypto", delay_load = TRUE)
  OOXMLFile <<- reticulate::import("msoffcrypto.format.ooxml", delay_load = TRUE)
}

