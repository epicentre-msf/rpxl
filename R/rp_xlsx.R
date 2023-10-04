#' Read a protect .xlsx file
#'
#' A wrapper to [readxl::read_xlsx] with an initial call to [decrypt_wb] to
#' decrypt the password-protected workbook
#'
#' @inheritParams readxl::read_xlsx
#' @param password Workbook password
#'
#' @return
#' A [`tibble`][tibble::tbl_df]-style data frame
#'
#' @examples
#' path_xlsx <- system.file("extdata", "xltest.xlsx", package = "rpxl")
#' rp_xlsx(path_xlsx, password = "1234")
#'
#' @importFrom readxl read_xlsx readxl_progress
#' @export rp_xlsx
rp_xlsx <- function(path,
                    sheet = NULL,
                    password,
                    range = NULL,
                    col_names = TRUE,
                    col_types = NULL,
                    na = "",
                    trim_ws = TRUE,
                    skip = 0,
                    n_max = Inf,
                    guess_max = min(1000, n_max),
                    progress = readxl_progress(),
                    .name_repair = "unique") {

  path_decrypt <- decrypt_wb(path, password)

  out <- tryCatch(
    readxl::read_xlsx(
      path = path_decrypt,
      sheet = sheet,
      range = range,
      col_names = col_names,
      col_types = col_types,
      na = na,
      trim_ws = trim_ws,
      skip = skip,
      n_max = n_max,
      guess_max = guess_max,
      progress = progress,
      .name_repair = .name_repair
    ),
    error = function(e) { e }
  )

  file.remove(path_decrypt)

  if ("error" %in% class(out)) {
    stop(out)
  }

  out
}

