#' Read a protected .xlsb file
#'
#' A wrapper to [readxlsb::read_xlsb], with an initial call to [rpxl_decrypt] to
#' decrypt the password-protected workbook
#'
#' @inheritParams readxlsb::read_xlsb
#' @param password Workbook password
#'
#' @return
#' A data frame
#'
#' @examples
#' path_xlsb <- system.file("extdata", "xltest.xlsb", package = "rpxl")
#' rpxlsb(path_xlsb, sheet = 1, password = "1234")
#'
#' @importFrom readxlsb read_xlsb
#' @export rpxlsb
rpxlsb <- function(path,
                   sheet = NULL,
                   password,
                   range = NULL,
                   col_names = TRUE,
                   col_types = NULL,
                   na = "",
                   trim_ws = TRUE,
                   skip = 0,
                   ...) {


  path_decrypt <- rpxl_decrypt(path, password)

  out <- tryCatch(
    readxlsb::read_xlsb(
      path = path_decrypt,
      sheet = sheet,
      range = range,
      col_names = col_names,
      col_types = col_types,
      na = na,
      trim_ws = trim_ws,
      skip = skip,
      ...
    ),
    error = function(e) { e }
  )

  file.remove(path_decrypt)

  if ("error" %in% class(out)) {
    stop(out)
  }

  out
}

