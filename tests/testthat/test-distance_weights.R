test_that("Distance weights methods work", {
  expect_equal(distance_weights(matrix(10), 10, "gaussian"), matrix(0.01))
})
