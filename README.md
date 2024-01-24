
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

Reproduce Agarwal et al. (2013) Table 1 for a \$1M mortgage:

``` r
library(MortgageRefiOptimizer)

df_optimal_rates <- compute_optimal_refi_rates(
  rho = 0.05, sigma = 0.0109, mu = 0.1, i_0 = 0.06,
  gamma_uppercase = 25, pi = 0.03, tau = 0.28,
  M = 1e06, F = 2000, f = 0.01, N = 30,
  itemize_mtg_pymts = TRUE
)

str(df_optimal_rates)
#> 'data.frame':    1 obs. of  11 variables:
#>  $ x_star_optimal_refi_differential    : num 0.0107
#>  $ max_refi_rate_using_x_star          : num 0.0493
#>  $ x_star_sqrt_rule                    : num 0.0097
#>  $ max_refi_rate_using_x_star_sqrt_rule: num 0.0503
#>  $ x_pv_rule                           : num 0.00271
#>  $ max_refi_rate_using_x_pv_rule       : num 0.0573
#>  $ lambda                              : num 0.147
#>  $ kappa                               : num 9905
#>  $ C_M                                 : num 13757
#>  $ psi                                 : num 57.6
#>  $ phi                                 : num 1.16
```

- The package tests reproduce Agarwal et al. (2013) tables 1 and 2.

The user can supply $\kappa$, the tax-adjusted cost of refinance. Here
is an example where we compute $\kappa$ using the values parameters in
Agarwal et al. (2013) table 1 for a \$1M mortgage and then supply that
value to `compute_optimal_refi_rates()`.

``` r
# See ?compute_kappa_M_itemize_mtg_pymts for parameter definitions
kappa <- compute_kappa_M_itemize_mtg_pymts(
  F = 2000, f = 0.01, M = 1e06, tau = 0.28, mu = 0.1, rho = 0.05, pi = 0.03, N = 30
)
print(kappa)
#> [1] 9904.783
```

Use `kappa` in `compute_optimal_refi_rates()`:

``` r
df_optimal_rates_with_user_supplied_kappa <- compute_optimal_refi_rates(
  rho = 0.05, sigma = 0.0109, mu = 0.1, i_0 = 0.06,
  gamma_uppercase = 25, pi = 0.03, tau = 0.28,
  M = 1e06, F = 2000, f = 0.01, N = 30, kappa = kappa, 
  itemize_mtg_pymts = TRUE
)

str(df_optimal_rates)
#> 'data.frame':    1 obs. of  11 variables:
#>  $ x_star_optimal_refi_differential    : num 0.0107
#>  $ max_refi_rate_using_x_star          : num 0.0493
#>  $ x_star_sqrt_rule                    : num 0.0097
#>  $ max_refi_rate_using_x_star_sqrt_rule: num 0.0503
#>  $ x_pv_rule                           : num 0.00271
#>  $ max_refi_rate_using_x_pv_rule       : num 0.0573
#>  $ lambda                              : num 0.147
#>  $ kappa                               : num 9905
#>  $ C_M                                 : num 13757
#>  $ psi                                 : num 57.6
#>  $ phi                                 : num 1.16
```

- Note: if you supply `kappa` to `compute_optimal_refi_rates()`, the
  `itemize_mtg_pymts` parameter will not affect the function’s output
