
<!-- README.md is generated from README.Rmd. Please edit that file -->

# MortgageRefiOptimizer

<!-- badges: start -->
<!-- badges: end -->

MortgageRefiOptimizer computes optimal refinance rates for fixed rate
mortgages from various financial parameters from Agarwal et al (2013;
“Optimal Mortgage Refinancing: A Closed-Form Solution”).

## Installation

``` r
devtools::install_github("ChandlerLutz/MortgageRefiOptimizer")
```

## Example

The main package function is `compute_optimal_refi_rates()`

- See `?compute_optimal_refi_rates` for function parameters and a
  description of the output.

Reproduce Agarwal Table 1 for a \$1M mortgage:

``` r
library(MortgageRefiOptimizer)

df_optimal_rates <- compute_optimal_refi_rates(
  rho = 0.05, sigma = 0.0109, mu = 0.1, i_0 = 0.06,
  gamma_uppercase = 25, pi = 0.03, tau = 0.28,
  M = 1e06, F = 2000, f = 0.01, N = 30,
  itemize_mtg_pymts = TRUE
)
print(df_optimal_rates)
#>   x_star_optimal_refi_differential max_refi_rate_using_x_star x_star_sqrt_rule
#> 1                       0.01069965                 0.04930035      0.009704472
#>   max_refi_rate_using_x_star_sqrt_rule   x_pv_rule max_refi_rate_using_x_pv_rule   lambda
#> 1                           0.05029553 0.002713264                    0.05728674 0.147233
#>      kappa      C_M      psi     phi
#> 1 9904.783 13756.64 57.62067 1.15634
```

- The package tests reproduce Agarwal et al. (2013) tables 1 and 2.
