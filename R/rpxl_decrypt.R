#' Decrypt a password-protected Excel file
#'
#' Uses the Python library
#' [msoffcrypto-tool](https://pypi.org/project/msoffcrypto-tool/) to decrypt
#' password-protected Excel files (either .xlsx or .xlsb), which can then be
#' read in with e.g. the [readxl] or [readxlsb][readxlsb::read_xlsb] R packages.
#'
#' @param path Path to an Excel workbook file (either .xlsx or .xlsb)
#' @param password Workbook password
#' @param path_out Output path for decrypted workbook
#'
#' @return
#' Path to the decrypted workbook file (same as argument `path_out`)
#'
#' @examples
#' path_xlsx <- system.file("extdata", "xltest.xlsx", package = "rpxl")
#' decrypt_wb(path_xlsx, password = "1234")
#'
#' @importFrom reticulate import_builtins %as%
#' @export decrypt_wb
decrypt_wb <- function(path,
                       password,
                       path_out = tempfile(fileext = get_ext(path))) {


  if (!get_ext(path) %in% c(".xlsx", ".xlsb")) {
    stop("Argument `path` must have extension .xlsx or .xlsb")
  }

  if (get_ext(path) != get_ext(path_out)) {
    stop("Arguments `path` and `path_out` do not have the same extension")
  }

  if (normalizePath(path, mustWork = FALSE) == normalizePath(path_out, mustWork = FALSE)) {
    stop("Arguments `path` and `path_out` must not be the same")
  }

  py <- reticulate::import_builtins()

  file_encrypted_rb <- py$open(path, "rb")

  with(py$open(path_out, "wb") %as% file_decrypt, {
    file_encrypted = msoffcrypto$OfficeFile(file_encrypted_rb)
    file_encrypted$load_key(password = password)
    file_encrypted$decrypt(file_decrypt)
  })

  file_encrypted_rb$close()

  return(path_out)
}

