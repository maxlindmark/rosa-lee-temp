# Minimal ss3sim example: run cod, flatfish, sardine life histories

library(ss3sim)
library(ss3models)
library(r4ss)

# where example data live in the package
d <- system.file("extdata", package = "ss3sim")
case_folder <- file.path(d, "eg-cases")

# life history IDs
species_ids <- c("cod", "fla", "sar")

# helper to make scenarios
make_scenarios <- function(sp) {
  c(
    paste("D0", "E0", "F0", "M0", "R0", sp, sep = "-"),
    paste("D1", "E1", "F0", "M0", "R0", sp, sep = "-")
  )
}

# loop over species
for (sp in species_ids) {
  om <- file.path(d, "models", paste0(sp, "-om"))
  em <- file.path(d, "models", paste0(sp, "-em"))
  scenarios <- make_scenarios(sp)
  out_dir <- paste0("out_", sp)
  
  run_ss3sim(
    iterations = 1:2,
    scenarios = scenarios,
    case_folder = case_folder,
    om_dir = om,
    em_dir = em,
    out_dir = out_dir,
    bias_adjust = TRUE,
    ss3_exe = "path/to/ss3"   # set explicitly
  )
  
  
  setwd(out_dir)
  get_results_all(path = out_dir)
  setwd("..")
}
