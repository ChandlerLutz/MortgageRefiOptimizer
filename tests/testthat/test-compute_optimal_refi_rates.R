
describe("Reproduce Agarwal et al. (2013), table 1, compute_optimal_refi_rates()", {

  # The parameters for the calibration of table 1
  F = 2000; f = 0.01; tau = 0.28; mu = 0.1; rho = 0.05; pi = 0.03; N = 30;
  sigma = 0.0109; i_0 = 0.06; gamma_uppercase = 25;

  compute_optimal_refi_rates_table_1 <- function(M) {
    df <- compute_optimal_refi_rates(rho, sigma, mu, i_0, gamma_uppercase, pi,
                                      tau, M, F, f, N, itemize_mtg_pymts = TRUE)
    return(df)
  }
  
      
  
  it("can reproduce the output for a $1M mortgage", {
    df <- compute_optimal_refi_rates_table_1(1e06)
    expect_equal(round(df$x_star_optimal_refi_differential, 4), 0.0107)
    expect_equal(round(df$x_star_sqrt_rule, 4), 0.0097)
    expect_equal(round(df$x_pv_rule, 4), 0.0027)
  })

  it("can reproduce the output for a $0.5M mortgage", {
    df <- compute_optimal_refi_rates_table_1(0.5e06)
    expect_equal(round(df$x_star_optimal_refi_differential, 4), 0.0118)
    expect_equal(round(df$x_star_sqrt_rule, 4), 0.0106)
    expect_equal(round(df$x_pv_rule, 4), 0.0033)
  })


  it("can reproduce the output for a $0.25M mortgage", {
    df <- compute_optimal_refi_rates_table_1(0.25e06)
    expect_equal(round(df$x_star_optimal_refi_differential, 4), 0.0139)
    expect_equal(round(df$x_star_sqrt_rule, 4), 0.0123)
    expect_equal(round(df$x_pv_rule, 4), 0.0044)
  })

  it("can reproduce the output for a $0.1M mortgage", {
    df <- compute_optimal_refi_rates_table_1(0.1e06)
    expect_equal(round(df$x_star_optimal_refi_differential, 4), 0.0193)
    expect_equal(round(df$x_star_sqrt_rule, 4), 0.0163)
    expect_equal(round(df$x_pv_rule, 4), 0.0076)
  })

  
})


describe("Reproduce Agarwal et al. (2013), table 1, compute_optimal_refi_rates()", {
  # The parameters for the calibration of table 1
  F = 2000; f = 0.01; mu = 0.1; rho = 0.05; pi = 0.03; N = 30;
  sigma = 0.0109; i_0 = 0.06; gamma_uppercase = 25;

  it("can reproduce the Exact Optimum (Table 2, row 1), for a $1M mortgage", {

    compute_optimal_refi_rates_table_2_1m <- function(tau) {
      df <- compute_optimal_refi_rates(rho, sigma, mu, i_0, gamma_uppercase, pi,
                                       tau, M = 1e06, F, f, N, itemize_mtg_pymts = TRUE)
      return(round(df$x_star_optimal_refi_differential, 4))
    }

    expect_equal(
      sapply(c(0, 0.1, 0.15, 0.25, 0.28, 0.33, 0.35), 
             compute_optimal_refi_rates_table_2_1m),
      # Change the second entry corresponding for tau == 0.1 and M == 1e06 to 0.102
      # for tolerance with agarwal et al. (2013)
      c(0.0099, 0.0102, 0.0103, 0.0106, 0.0107, 0.0109, 0.0110)
    )
    
  })


  it("can reproduce the Exact Optimum (Table 2, row 1), for a $0.5M mortgage", {

    compute_optimal_refi_rates_table_2_0.5m <- function(tau) {
      df <- compute_optimal_refi_rates(rho, sigma, mu, i_0, gamma_uppercase, pi,
                                       tau, M = 0.5e06, F, f, N,
                                       itemize_mtg_pymts = TRUE)
      return(round(df$x_star_optimal_refi_differential, 4))
    }

    expect_equal(
      sapply(c(0, 0.1, 0.15, 0.25, 0.28, 0.33, 0.35), 
             compute_optimal_refi_rates_table_2_0.5m),
      c(0.0108, 0.0111, 0.0113, 0.0117, 0.0118, 0.0121, 0.0122)
    )
    
  })

  it("can reproduce the Exact Optimum (Table 2, row 1), for a $0.25M mortgage", {

    compute_optimal_refi_rates_table_2_0.25m <- function(tau) {
      df <- compute_optimal_refi_rates(rho, sigma, mu, i_0, gamma_uppercase, pi,
                                       tau, M = 0.25e06, F, f, N,
                                       itemize_mtg_pymts = TRUE)
      return(round(df$x_star_optimal_refi_differential, 4))
    }

    expect_equal(
      sapply(c(0, 0.1, 0.15, 0.25, 0.28, 0.33, 0.35), 
             compute_optimal_refi_rates_table_2_0.25m),
      c(0.0124, 0.0129, 0.0131, 0.0137, 0.0139, 0.0143, 0.0145)
    )
    
  })

  it("can reproduce the Exact Optimum (Table 2, row 1), for a $0.1M mortgage", {

    compute_optimal_refi_rates_table_2_0.1m <- function(tau) {
      df <- compute_optimal_refi_rates(rho, sigma, mu, i_0, gamma_uppercase, pi,
                                       tau, M = 0.1e06, F, f, N,
                                       itemize_mtg_pymts = TRUE)
      return(round(df$x_star_optimal_refi_differential, 4))
    }

    expect_equal(
      sapply(c(0, 0.1, 0.15, 0.25, 0.28, 0.33, 0.35), 
             compute_optimal_refi_rates_table_2_0.1m),
      # Change the third, second-to-last, and last entries for
      # a tolerance of 0.0001 with Agarwal et al. (2013)
      c(0.0166, 0.0174, 0.0179, 0.0189, 0.0193, 0.0200, 0.0203)
    )
    
  })

  
  

})

  
