test_that("3SFCA works", {

  # Observed
  p <- 1:4
  s <- 1:6
  D <- matrix(1:24, ncol = 4, nrow = 6)
  spai <- get_3SFCA(p, s, D, "step3")

  # Expected
  expected <- data.frame(
    step3 = c(0.6686168, 1.3565093, 2.0921208, 2.8355005)
  )
  rownames(expected) <- seq_len(4)

  # Test
  expect_equal(spai, expected)
})
