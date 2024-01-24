# Fixture for table 1 calibration
compute_x_star_table_1 <- function(M) {

  ## Test x_star using calibration from p. 602 (p. 12 of the pdf); section 2
  f_kappa_calibration_1 <- function(M) {
    kappa <- compute_kappa_M_itemize_mtg_pymts(
      F = 2000, f = 0.01, M = M, tau = 0.28, mu = 0.1, rho = 0.05, pi = 0.03, N = 30
    )

    kappa
    
  }

  x_star <- compute_x_star(
    rho = 0.05, sigma = 0.0109, mu = 0.1, i_0 = 0.06, gamma_uppercase = 25,
    pi = 0.03, tau = 0.28, M = 1e06, kappa = f_kappa_calibration_1(M)
  )

}
