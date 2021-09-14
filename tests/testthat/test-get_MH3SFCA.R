test_that("3SFCA works", {

  # Observed
  p <- 1:4
  s <- 1:6
  D <- matrix(1:24, ncol = 4, nrow = 6)
  spai <- get_MH3SFCA(p, s, D, "step3")

  # Expected
  expected <- data.frame(
    step3 = c(9.617634, 21.717421, 34.325798, 47.032856)
  )
  rownames(expected) <- seq_len(4)

  # Test
  expect_equal(spai, expected)
})
