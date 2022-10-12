# This file imports data from the Online Submission Form for the Journal
# Global Environmental Psychology https://gep.psychopen.eu/
# The data are stored on a formr server (https://formr.org/)

# Code author(s): Adrian Gadient-Bruegger (Editor-In-Chief)
# Last updated: 7 July 2022
# adrian.gadient@unibe.ch / adrian.gadient@protonmail.com

# load packages
library(tidyverse)
library(haven)

# read data
# basic manuscript information and question about ethics
key_data     <- readRDS("data/key_data.rds")
stage1       <- readRDS("data/stage1.rds")
open_science <- readRDS("data/open_science.rds")
diversity    <- readRDS("data/diversity.rds")

# rename variables that are included in all parts to indicate clearly from which part (survey) they are coming
key_data <- key_data %>% 
  rename(date_created_key_data = created,
         date_modified_key_data = modified,
         date_expired_key_data = expired,    
         date_ended_key_data = ended)

stage1 <- stage1 %>% 
  rename(date_created_stage1 = created,
         date_modified_stage1 = modified,
         date_expired_stage1 = expired,    
         date_ended_stage1 = ended)

open_science <- open_science %>% 
  rename(date_created_open_science = created,
         date_modified_open_science = modified,
         date_expired_open_science = expired,    
         date_ended_open_science = ended)

diversity <- diversity %>% 
  rename(date_created_diversity = created,
         date_modified_diversity = modified,
         date_expired_diversity = expired,    
         date_ended_diversity = ended)


# problem: 
# if people submit more than one publication in one day (or without closing their browser), 
# their session ID may appear multiple times, which causes problems
# add unique identifier if session exists more than once
key_data <- key_data %>% 
  mutate(suffix = duplicated(session)+1,
         session_unique = paste0(session,"_",suffix)) %>%
  select(session,session_unique,everything(),-suffix) 

stage1 <- stage1 %>% 
  mutate(suffix = duplicated(session)+1,
         session_unique = paste0(session,"_",suffix)) %>%
  select(session,session_unique,everything(),-suffix) 


open_science <- open_science %>% 
  mutate(suffix = duplicated(session)+1,
         session_unique = paste0(session,"_",suffix)) %>%
  select(session,session_unique,everything(),-suffix) 


diversity <- diversity %>% 
  mutate(suffix = duplicated(session)+1,
         session_unique = paste0(session,"_",suffix)) %>%
  select(session,session_unique,everything(),-suffix) 


# combine different parts into a single dataframe
rawdata <- list(key_data,
     stage1,
     open_science,
     diversity) %>% 
  reduce(full_join, by = "session_unique")


# .-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-
# Data cleaning and preparation ----
# .-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-

# To show text rather than numbers in the documents that will be created, 
# it is necessary to replace numeric answers (e.g., "1") with choice labels (e.g., "yes")
# Note that this removes some information, e.g., the text of the questions

# replace numeric values with chosen answers
rawdata <- rawdata %>%
  mutate(across(where(is.labelled), ~formr::choice_labels_for_values(rawdata, cur_column())))

# simplify date and time to 16-digit date
rawdata <- rawdata %>% 
  mutate_at(vars(starts_with("date_")), list(~ substr(., 0 ,16)))

# Determine which was the last part of the submission form that an author submitted
rawdata <- rawdata %>%
  mutate(last_part_submitted = case_when(
    !is.na(date_ended_diversity) ~ 'Diversity',     
    !is.na(date_ended_open_science) ~ 'Transparency / Open Science',  
    !is.na(date_ended_stage1) ~ 'Stage 1',          
    !is.na(date_ended_key_data) ~ 'Basic manuscript information',
    !is.na(date_created_key_data) ~ 'Started to enter basic manuscript information',
    TRUE ~ 'No parts were completed'))

# create new variable indicating most recent activity
rawdata <- rawdata %>% 
  rowwise() %>% 
  mutate(max_date =  max(as.Date(c_across(starts_with('date_'))), 
                         na.rm = TRUE))

# replace missing values (NA) in variables that are used as filters when creating pdfs 
# (because they cause problems in the conditional execution, 
# e.g., when determining if table X should be generated) 
rawdata$os_prereg <- dplyr::recode(rawdata$os_prereg,"yes"="yes",.missing = "no")
rawdata$rr <- dplyr::recode(rawdata$rr,"yes"="yes",.missing = "no")
rawdata$os_meth <- dplyr::recode(rawdata$os_meth,"yes"="yes",.missing = "no")
rawdata$replication <- dplyr::recode(rawdata$replication,"yes"="yes",.missing = "no")


# Save object to a file
saveRDS(rawdata, "data/rawdata.rds")
