test_that("Distance normalization methods work", {
  expect_equal(dist_normalize(matrix(10), 10, "gaussian"), matrix(0.01))
  expect_equal(dist_normalize(matrix(10), 10, "gravity"), matrix(0.01))
  expect_equal(dist_normalize(matrix(10), 10, "exponential"), matrix(0.01))
  expect_equal(dist_normalize(matrix(10), 10, "logistic"), matrix(2))
  expect_error(dist_normalize(matrix(10), 10, "invalid_imp_function"), "Invalid `imp_function` value")
})
