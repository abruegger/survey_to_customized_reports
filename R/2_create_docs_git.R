# This file prepares summary tables for the peer review process for the journal 
# Global Environmental Psychology https://gep.psychopen.eu/
# More specifically, this script selects and sends the relevant content to the placeholders in the template

# Code author(s): Adrian Gadient-Bruegger (Editor-In-Chief)
# Last updated: 4 October 2022
# adrian.gadient@unibe.ch / adrian.gadient@protonmail.com

# load required packages
library(rmarkdown)
library(tidyverse)
library(knitr)
library(flextable)
library(showtext)

# load data that was download in previous script (1_import.R) from formr.org
df <- readRDS("data/rawdata.rds")

# only consider submissions submitted during last 2 days
df <- df %>% filter(date_ended_key_data > Sys.time()-(48*60*60))

# Create a file for each participant according to the template "Transparency_Peer_Review.Rmd"
# .-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-
apply(df, 1, function(x){
  # set path and file name
  fname <- paste0("../pdfs/open_science_peer_review/","Transparency",x["max_date"],"_",x["ID_anonymous"], ".pdf")
  # send data to placeholders for each participant
  rmarkdown::render(input="R/Transparency_Peer_Review.Rmd", 
                    output_file = fname,
                    output_format = "pdf_document",
                    # Indicate which variables are needed to fill in the placeholders in the template 
                    # left part = name of placeholder, right part = name of the variable in the dataframe
                    # for the sake of simplicity and to avoid errors, these are identical
                    params = list(ID_anonymous=x["ID_anonymous"],
                                  date_ended_key_data=x["date_ended_key_data"],
                                  title=x["title"], # 
                                  article_type=x["article_type"],
                                  paper_collection=x["paper_collection"],
                                  name_collection=x["name_collection"],
                                  rr=x["rr"],
                                  replication=x["replication"],
                                  os_prereg=x["os_prereg"],
                                  empirical=x["empirical"],
                                  data_collected=x["data_collected"],
                                  ethics_complied=x["ethics_complied"],
                                  ethics_approval=x["ethics_approval"],
                                  ethics_comments=x["ethics_comments"],
                                  max_date=x["max_date"],
                                  last_part_submitted=x["last_part_submitted"],
                                  
                                  # registered report variables
                                  rr_st1_data_type=x["rr_st1_data_type"],
                                  rr_st1_data_collected=x["rr_st1_data_collected"],
                                  rr_st1_examined=x["rr_st1_examined"],
                                  rr_st1_examined_explain=x["rr_st1_examined_explain"],
                                  rr_st1_timeline=x["rr_st1_timeline"],
                                  rr_st1_explain=x["rr_st1_explain"],
                                  rr_st1_sharing=x["rr_st1_sharing"],
                                  rr_st1_protocol=x["rr_st1_protocol"],
                                  rr_st1_meth_comment=x["rr_st1_meth_comment"],
                                  rr_st2_data=x["rr_st2_data"],
                                  rr_st2_primary=x["rr_st2_primary"],
                                  rr_st2_secondary=x["rr_st2_secondary"],
                                  rr_st2_explain=x["rr_st2_explain"],
                                  
                                  # open science variables
                                  os_prereg_theory=x["os_prereg_theory"],
                                  os_prereg_hypotheses=x["os_prereg_hypotheses"],
                                  os_prereg_design=x["os_prereg_design"],
                                  os_prereg_meth_mat=x["os_prereg_meth_mat"],
                                  os_prereg_analysis=x["os_prereg_analysis"],
                                  os_prereg_interpretation=x["os_prereg_interpretation"],
                                  os_prereg_when=x["os_prereg_when"],
                                  os_prereg_describe=x["os_prereg_describe"],
                                  os_prereg_url=x["os_prereg_url"],
                                  os_prereg_other=x["os_prereg_other"],
                                  os_prereg_other_explain=x["os_prereg_other_explain"],
                                  os_prereg_analyses_all=x["os_prereg_analyses_all"],
                                  os_prereg_analyses_details=x["os_prereg_analyses_details"],
                                  os_prereg_changes=x["os_prereg_changes"],
                                  os_prereg_changes_ms=x["os_prereg_changes_ms"],
                                  os_prereg_expl_conf=x["os_prereg_expl_conf"],
                                  os_prereg_comment=x["os_prereg_comment"],
                                  os_cited=x["os_cited"],
                                  os_cited_explain=x["os_cited_explain"],
                                  os_doi=x["os_doi"],
                                  os_doi_explain=x["os_doi_explain"],
                                  os_meth_design=x["os_meth_design"], 
                                  os_meth_measures=x["os_meth_measures"],
                                  os_meth=x["os_meth"],
                                  os_meth_other=x["os_meth_other"],
                                  os_other_standard=x["os_other_standard"],
                                  os_meth_exemption=x["os_meth_exemption"],
                                  os_meth_comment=x["os_meth_comment"],
                                  os_quant_sample=x["os_quant_sample"],
                                  os_quant_exclusions=x["os_quant_exclusions"],
                                  os_quant_exclusions_n=x["os_quant_exclusions_n"],
                                  os_quant_exclusions_criteria=x["os_quant_exclusions_criteria"],
                                  os_quant_ivs=x["os_quant_ivs"],
                                  os_quant_dvs=x["os_quant_dvs"],
                                  os_quant_reliability=x["os_quant_reliability"],
                                  os_quant_descriptives=x["os_quant_descriptives"],
                                  os_quant_inferential_stats=x["os_quant_inferential_stats"],
                                  os_qual_context=x["os_qual_context"],
                                  os_qual_recruitment=x["os_qual_recruitment"],
                                  os_qual_saturation=x["os_qual_saturation"],
                                  os_qual_data_collection=x["os_qual_data_collection"],
                                  os_qual_recording=x["os_qual_recording"],
                                  os_qual_analysis=x["os_qual_analysis"],
                                  os_qual_grounded=x["os_qual_grounded"],
                                  os_mixed_definition_type=x["os_mixed_definition_type"],
                                  os_mixed_rationale_mixed=x["os_mixed_rationale_mixed"],
                                  os_mixed_separte_sections=x["os_mixed_separte_sections"],
                                  os_mixed_integration=x["os_mixed_integration"],
                                  os_mixed_sequence=x["os_mixed_sequence"],
                                  os_data_type=x["os_data_type"],
                                  os_data_type_describe=x["os_data_type_describe"],
                                  os_data_public=x["os_data_public"],
                                  os_data_url=x["os_data_url"],
                                  os_data_complete=x["os_data_complete"],
                                  os_data_codebook=x["os_data_codebook"],
                                  os_data_explain=x["os_data_explain"],
                                  os_data_codebook_explain=x["os_data_codebook_explain"],
                                  os_data_procedures=x["os_data_procedures"],
                                  os_code=x["os_code"],
                                  os_code_url=x["os_code_url"],
                                  os_code_explain=x["os_code_explain"],
                                  os_materials=x["os_materials"],
                                  os_materials_url=x["os_materials_url"],
                                  os_steps=x["os_materials_explain"],
                                  os_steps=x["os_steps"],
                                  os_partial_subset=x["os_partial_subset"],
                                  os_protected_sharing=x["os_protected_sharing"],
                                  os_data_comment=x["os_data_comment"],
                                  
                                  # justify sample 
                                  div_sample_justification=x["div_sample_justification"],
                                  div_justification_explain=x["div_justification_explain"],
                                  
                                  # extensive sample description
                                  div_sample_description=x["div_sample_description"],
                                  div_description_explain=x["div_description_explain"],
                                  
                                  # generalizeability of findings
                                  div_discussion=x["div_discussion"],
                                  div_discussion_explain=x["div_discussion_explain"],
                                  div_citations=x["div_citations"],
                                  div_citations_explain=x["div_citations_explain"]
                    ),
                    clean = TRUE) # removes log files
})