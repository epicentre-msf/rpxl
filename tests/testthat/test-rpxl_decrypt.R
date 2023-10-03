
test_that("rpxl_decrypt works as expected", {

  skip_if_no_py_mods()

  path_xlsx <- system.file("extdata", "xltest.xlsx", package = "rpxl")
  path_xlsb <- system.file("extdata", "xltest.xlsb", package = "rpxl")

  tmp1 <- tempfile(fileext = ".xlsx")
  x1 <- rpxl_decrypt(path_xlsx, password = "1234", path_out = tmp1)
  expect_equal(x1, tmp1)

  d1 <- readxl::read_xlsx(x1)
  expect_s3_class(d1, "data.frame")
  invisible(file.remove(tmp1))

  tmp2 <- tempfile(fileext = ".xlsb")
  x2 <- rpxl_decrypt(path_xlsb, password = "1234", path_out = tmp2)
  expect_equal(x2, tmp2)

  d2 <- readxlsb::read_xlsb(x2, sheet = 1L)
  expect_s3_class(d2, "data.frame")
  invisible(file.remove(tmp2))

  tmp3 <- tempfile(fileext = ".xlsx")
  expect_error(rpxl_decrypt(path_xlsx, password = "wrong_password", path_out = tmp3))
  invisible(file.remove(tmp3))

})

