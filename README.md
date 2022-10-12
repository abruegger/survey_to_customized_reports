# Automated creation of open science and diversity reports

This repository is part of a <a href="https://www.adrianbruegger.com/post/" target="_blank">blogpost</a> that explains how GitHub can be used to automatically generate customised reports. The workflow is explained with respect to open science reports for the journal <a href="https://gep.psychopen.eu" target="_blank">Global Environmental Psychology</a>. These reports are used to verify and document authors' compliance with the journal's open science and diversity policies. Examples of test reports can be found <a href="https://github.com/abruegger/survey_to_customized_reports/tree/main/pdfs/open_science_peer_review" target="_blank">here</a>. 

To protect sensitive data this repository doesn't contain any real data or passwords. Obviously the code will not run either. 

The R code to create the reports was developed by Adrian Gadient-Brügger.  Michael Wenger helped to implement the automated creation on git. 

Key resources for creating our github workflow: 
- R code to generate the reports <a href="https://www.adrianbruegger.com/post/automating-reports-with-r-markdown/" target="_blank">described here</a>    
- Various blogposts and tutorials (e.g., <a href="https://blog--simonpcouch.netlify.app/blog/r-github-actions-commit/" target="_blank">this</a> or <a href="https://sabeeh.medium.com/using-github-actions-as-a-job-scheduler-for-r-scripts-7b92539372f4" target="_blank">this</a>)