test_that("multiplication works", {
  expect_equal(get_distance_weights(matrix(10), 10, "gaussian"), matrix(0.01))
})
