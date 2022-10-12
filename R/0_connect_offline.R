# This file establishes a connection to the server with the survey data
# This version is intended for use on a local computer (not on github)

# Code author(s): Adrian Gadient-Bruegger (Editor-In-Chief)
# Last updated: 7 October 2022
# adrian.gadient@unibe.ch / adrian.gadient@protonmail.com

# load package
library(formr)

# import credentials from local directory 
source("~aioi/Documents/formr_credentials_gep.R") 
# path on computer at work:
# source("~adrian/Documents/formr_credentials_gep.R")

# connect to formR server
formr::formr_connect(email=credentials$email,password=credentials$password, host = "https://formr.org")

# download data from different parts of the submission process
# basic manuscript information and question about ethics
key_data <- formr::formr_results("key_data", remove_test_sessions = TRUE)
saveRDS(key_data, "data/key_data.rds")

# stage 1 & 2 of registered reports
stage1 <- formr::formr_results("stage1", remove_test_sessions = TRUE)
saveRDS(stage1, "data/stage1.rds")

# questions for empirical submissions
open_science <- formr::formr_results("open_science", remove_test_sessions = TRUE)
saveRDS(open_science, "data/open_science.rds")

# questions about diversity
diversity <- formr::formr_results("diversity", remove_test_sessions = TRUE)
saveRDS(diversity, "data/diversity.rds")
