# Install package
pak::pkg_install(
  pkg = "ss3sim/ss3sim",
  # pkg = "ss3sim" # CRAN version
  dependencies = TRUE
)


library(ss3sim)


simdf <- setup_scenarios_defaults()


system.file("extdata/models", package = "ss3sim")

df <- setup_scenarios_defaults(nscenarios = 2)

df[, "bias_adjust"] <- FALSE

df[, grep("^cf\\.", colnames(df))]

# Display the default composition-data settings
# sa is for ages and sl is for lengths
df[, grep("^s[al]\\.", colnames(df))]

# Create a biennial survey starting in year 76 and ending in the terminal year
df[, "si.years.2"] <- "seq(76, 100, by = 2)"
# Set sd of observation error for each scenario
df[, "si.sds_obs.2"] <- c(0.1, 0.4)

df <- rbind(df, df)
df[, "ce.par_name"] <- "NatM_uniform_Fem_GP_1"
df[, "ce.par_int"] <- NA
# Set the phase for estimating natural mortality
df[, "ce.par_phase"] <- rep(c(-1, 3), each = 2)
# Name the scenarios
df[, "scenarios"] <- c(
  "D0-E0-F0-cod", "D1-E0-F0-cod",
  "D0-E1-F0-cod", "D1-E1-F0-cod"
)

iterations <- 1:5
scname <- run_ss3sim(iterations = iterations, simdf = df)
