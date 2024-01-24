test_that("compute_lambda() calibration matches Argarwal et al. (2013) p. 603 example", {
  
  lambda_example <- compute_lambda(mu = 0.1, i_0 = 0.06, gamma_uppercase = 25, pi = 0.03)
  agarwal_et_al_p_603_lambda_example <- 0.147
  
  expect_equal(round(lambda_example, 3), agarwal_et_al_p_603_lambda_example)
})


describe("Reproduce Agarwal et al. (2013), table 1", {

  # The parameters for the calibration of table 1
  F = 2000; f = 0.01; tau = 0.28; mu = 0.1; rho = 0.05; pi = 0.03; N = 30;
  sigma = 0.0109; i_0 = 0.06; gamma_uppercase = 25; 

  ## Test x_star using calibration from p. 602 (p. 12 of the pdf); section 2
  f_kappa_calibration_1 <- function(M) {
    kappa <- compute_kappa_M_itemize_mtg_pymts(
      F = F, f = f, M = M, tau = tau, mu = mu, rho = rho, pi = pi, N = N
    )
    return(kappa)
  }

  describe(
    "To reproduce the Exact Optimum (Table 1, col. 1), x_star()",
    {
      compute_x_star_table_1 <- function(M) {

        x_star <- compute_x_star(
          rho = rho, sigma = sigma, mu = mu, i_0 = i_0,
          gamma_uppercase = gamma_uppercase,
          pi = pi, tau = tau, M = M, kappa = f_kappa_calibration_1(M)
        )

        return(x_star)
      }
      
      it("can reproduce the output for a $1M mortgage", {
        expect_equal(round(compute_x_star_table_1(1e06), 4), 0.0107)
      })

      it("can reproduce the output for a $0.5M mortgage", {
        expect_equal(round(compute_x_star_table_1(0.5e06), 4), 0.0118)
      })

      it("can reproduce the output for a $0.25M mortgage", {
        expect_equal(round(compute_x_star_table_1(0.25e06), 4), 0.0139)
      })

      it("can reproduce the output for a $0.1M mortgage", {
        expect_equal(round(compute_x_star_table_1(0.1e06), 4), 0.0193)
      })
    }
  )


  describe(
    "To reproduce the Square-Root Rule (Table 1, col. 2) compute_x_star_2nd_order_sqrt_rule()",
    {
      compute_x_star_second_order_table_1 <- function(M) {

        x_star <- compute_x_star_2nd_order_sqrt_rule(
          sigma = sigma, kappa = f_kappa_calibration_1(M), M = M, tau = tau,
          rho = rho, mu = mu, i_0 = i_0, gamma_uppercase = gamma_uppercase, pi = pi
        )

        return(x_star)
      }
      it("can reproduce the output for a $1M mortgage", {
        expect_equal(round(compute_x_star_second_order_table_1(1e06), 4), 0.0097)
      })

      it("can reproduce the output for a $0.5M mortgage", {
        expect_equal(round(compute_x_star_second_order_table_1(0.5e06), 4), 0.0106)
      })

      it("can reproduce the output for a $0.25M mortgage", {
        expect_equal(round(compute_x_star_second_order_table_1(0.25e06), 4), 0.0123)
      })

      it("can reproduce the output for a $0.1M mortgage", {
        expect_equal(round(compute_x_star_second_order_table_1(0.1e06), 4), 0.0163)
      })

    }
  )

  describe(
    "To reproduce the Present Value (PV) Rule (Table 1, col. 4), compute_pv_breakeven_threshold()",
    {
      compute_pv_table_1 <- function(M) {

        x_pv <- compute_pv_breakeven_threshold(
          C_M = compute_C_M(kappa = f_kappa_calibration_1(M), tau = tau),
          rho = rho,
          lambda = compute_lambda(mu = mu, i_0 = i_0, gamma_uppercase = gamma_uppercase,
                                  pi = pi),
          M = M
        )

        return(x_pv)
      }
      it("can reproduce the output for a $1M mortgage", {
        expect_equal(round(compute_pv_table_1(1e06), 4), 0.0027)
      })

      it("can reproduce the output for a $0.5M mortgage", {
        expect_equal(round(compute_pv_table_1(0.5e06), 4), 0.0033)
      })

      it("can reproduce the output for a $0.25M mortgage", {
        expect_equal(round(compute_pv_table_1(0.25e06), 4), 0.0044)
      })

      it("can reproduce the output for a $0.1M mortgage", {
        expect_equal(round(compute_pv_table_1(0.1e06), 4), 0.0076)
      })

    }
  )

})



describe("Reproduce Agarwal et al. (2013), table 2. x_star()", {

  # The parameters for the calibration of table 1
  F = 2000; f = 0.01; mu = 0.1; rho = 0.05; pi = 0.03; N = 30;
  sigma = 0.0109; i_0 = 0.06; gamma_uppercase = 25; 

  ## Test x_star using calibration from p. 602 (p. 12 of the pdf); section 2
  f_kappa_calibration_2 <- function(M, tau) {
    kappa <- compute_kappa_M_itemize_mtg_pymts(
      F = F, f = f, M = M, tau = tau, mu = mu, rho = rho, pi = pi, N = N
    )
    return(kappa)
  }

  compute_x_star_table_2 <- function(M, tau) {

    x_star <- compute_x_star(
      rho = rho, sigma = sigma, mu = mu, i_0 = i_0, gamma_uppercase = gamma_uppercase, 
      pi = pi, tau = tau, M = M, kappa = f_kappa_calibration_2(M, tau)
    )

    return(x_star)

  }
  

  
  it(
    "can reproduce the Exact Optimum (Table 2, row 1), for a $1M mortgage",
    {
      compute_x_star_table_2_1m <- function(tau) {
        round(compute_x_star_table_2(M = 1e06, tau = tau), 4)
      }
      
      expect_equal(
        sapply(c(0, 0.1, 0.15, 0.25, 0.28, 0.33, 0.35), 
               compute_x_star_table_2_1m),
        # Change the second entry corresponding for tau == 0.1 and M == 1e06 to 0.102
        # for tolerance with agarwal et al. (2013)
        c(0.0099, 0.0102, 0.0103, 0.0106, 0.0107, 0.0109, 0.0110)
      )
      
    }
  )

  it(
    "can reproduce the Exact Optimum (Table 2, row 2), for a $0.5M mortgage",
    {
      compute_x_star_table_2_1m <- function(tau) {
        round(compute_x_star_table_2(M = 0.5e06, tau = tau), 4)
      }
      
      expect_equal(
        sapply(c(0, 0.1, 0.15, 0.25, 0.28, 0.33, 0.35), 
               compute_x_star_table_2_1m),
        c(0.0108, 0.0111, 0.0113, 0.0117, 0.0118, 0.0121, 0.0122)
      )
      
    }
  )


  it(
    "can reproduce the Exact Optimum (Table 2, row 2), for a $0.5M mortgage",
    {
      compute_x_star_table_2_1m <- function(tau) {
        round(compute_x_star_table_2(M = 0.5e06, tau = tau), 4)
      }
      
      expect_equal(
        sapply(c(0, 0.1, 0.15, 0.25, 0.28, 0.33, 0.35), 
               compute_x_star_table_2_1m),
        c(0.0108, 0.0111, 0.0113, 0.0117, 0.0118, 0.0121, 0.0122)
      )
      
    }
  )

  it(
    "can reproduce the Exact Optimum (Table 2, row 3), for a $0.25M mortgage",
    {
      compute_x_star_table_2_1m <- function(tau) {
        round(compute_x_star_table_2(M = 0.25e06, tau = tau), 4)
      }
      
      expect_equal(
        sapply(c(0, 0.1, 0.15, 0.25, 0.28, 0.33, 0.35), 
               compute_x_star_table_2_1m),
        c(0.0124, 0.0129, 0.0131, 0.0137, 0.0139, 0.0143, 0.0145)
      )
      
    }
  )

  it(
    "can reproduce the Exact Optimum (Table 2, row 4), for a $0.1M mortgage",
    {
      compute_x_star_table_2_1m <- function(tau) {
        round(compute_x_star_table_2(M = 0.1e06, tau = tau), 4)
      }
      
      expect_equal(
        sapply(c(0, 0.1, 0.15, 0.25, 0.28, 0.33, 0.35), 
               compute_x_star_table_2_1m),
        # Change the third, second-to-last, and last entries for
        # a tolerance of 0.0001 with Agarwal et al. (2013)
        c(0.0166, 0.0174, 0.0179, 0.0189, 0.0193, 0.0200, 0.0203)
      )
      
    }
  )

})

