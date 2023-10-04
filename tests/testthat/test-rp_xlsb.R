
test_that("rp_xlsb works as expected", {

  skip_if_no_py_mods()

  path_xlsb <- system.file("extdata", "xltest.xlsb", package = "rpxl")

  x1 <- rp_xlsb(path_xlsb, password = "1234", sheet = 1)
  expect_s3_class(x1, "data.frame")

  expect_error(rp_xlsb(path_xlsb, password = "wrong_pwd", sheet = 1L))
  expect_error(rp_xlsb(path_xlsb, password = "1234", sheet = "not_a_sheet"))

})

