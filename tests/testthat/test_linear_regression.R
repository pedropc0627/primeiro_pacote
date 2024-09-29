library(testthat)

test_that("linear_regression returns correct structure", {
  simulated_data <- data.frame(X1 = rnorm(100), X2 = rnorm(100), Y = rnorm(100))
  result <- linear_regression(simulated_data, "Y", c("X1", "X2"))
  expect_equal(length(result), 5)
  expect_true(is.matrix(result$coefficients))
})