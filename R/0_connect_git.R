# This file establishes a connection to the server with the survey data

# Code author(s): Adrian Gadient-Bruegger (Editor-In-Chief)
# Last updated: 3 October 2022
# adrian.gadient@unibe.ch / adrian.gadient@protonmail.com

# load package
library(formr)

token_R <- Sys.getenv("TOKEN")
email_R <- Sys.getenv("EMAIL")
password_R <- Sys.getenv("PASSWORD")

# connect to formR server
formr::formr_connect(email= email_R ,password= password_R
, host = "https://formr.org")


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
