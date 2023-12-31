#' Read a protected .xlsb file
#'
#' A wrapper to [readxlsb::read_xlsb], with an initial call to [decrypt_wb] to
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
#' rp_xlsb(path_xlsb, password = "1234", sheet = 1)
#'
#' @importFrom readxlsb read_xlsb
#' @export rp_xlsb
rp_xlsb <- function(path,
                    password,
                    sheet = NULL,
                    range = NULL,
                    col_names = TRUE,
                    col_types = NULL,
                    na = "",
                    trim_ws = TRUE,
                    skip = 0,
                    ...) {


  path_decrypt <- decrypt_wb(path, password)

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

