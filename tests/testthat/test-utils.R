test_that("compute_lambda() calibration matches Argarwal et al. (2013) p. 603 example", {
  lambda_example <- compute_lambda(mu = 0.1, i_0 = 0.06, gamma_uppercase = 25, pi = 0.03)
  expect_equal(round(lambda_example, 3), 0.147)
})


test_that("multiplication works", {
  expect_equal(2 * 2, 4)
})
