
test_that("rp_xlsx works as expected", {

  skip_if_no_py_mods()

  path_xlsx <- system.file("extdata", "xltest.xlsx", package = "rpxl")

  x1 <- rp_xlsx(path_xlsx, password = "1234")
  expect_s3_class(x1, "data.frame")

  expect_error(rp_xlsx(path_xlsx, password = "wrong_pwd"))
  expect_error(rp_xlsx(path_xlsx, password = "1234", sheet = "not_a_sheet"))

})

