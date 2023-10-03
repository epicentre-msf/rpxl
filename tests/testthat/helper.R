
skip_if_no_py_mods <- function() {

  have_io <- reticulate::py_module_available("io")
  have_msoffcrypto <- reticulate::py_module_available("msoffcrypto")

  if (!have_io | !have_msoffcrypto) {
    testthat::skip("Required Python modules not available for testing")
  }
}

