test_that("2SFCA works", {

  # Observed
  p <- 1:4
  s <- 1:6
  D <- matrix(1:24, ncol = 4, nrow = 6)
  spai <- spai_2sfca(p, s, D, step = 2)

  # Expected
  expected <- as.data.frame(
    cbind(
      step2 = c(2.1, 2.1, 2.1, 2.1),
      r = c(21.00, 10.50, 7.00, 5.25)
    )
  )
  rownames(expected) <- seq_len(4)

  # Test
  expect_equal(spai, expected)
})
