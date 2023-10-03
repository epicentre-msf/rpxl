
#' @noRd
get_ext <- function(file) {
  x_split <- strsplit(file, "\\.")[[1]]
  paste0(".", x_split[length(x_split)])
}

