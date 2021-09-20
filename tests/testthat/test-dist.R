test_that("Distance normalization methods work", {
  expect_equal(dist_normalize(matrix(10), 10, "gaussian"), matrix(0.01))
})
