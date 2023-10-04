#' Install Python dependencies for the rpxl package
#'
#' @param envname Name of Python environment to install within. Defaults to
#'   "r-rpxl".
#' @param new_env Logical indicating whether to remove the existing virtual
#'   environment of the same name as `envname` before installing the required
#'   Python packages.
#' @param method Installation method. Defaults to "auto" to automatically find a
#'   method that will work in the local environment. Note that the "virtualenv"
#'   method is not available on Windows.
#' @param ... Additional arguments passed to [reticulate::py_install]
#'
#' @importFrom reticulate py_install virtualenv_exists virtualenv_remove
#' @export
install_rpxl <- function(envname = "r-rpxl",
                         new_env = identical(envname, "r-rpxl"),
                         method = "auto",
                         ...) {

  if (new_env && reticulate::virtualenv_exists(envname)) {
    reticulate::virtualenv_remove(envname)
  }

  reticulate::py_install(
    c("msoffcrypto-tool"),
    envname = envname,
    method = method,
    ...
  )
}
