# Project Page - MICS R Consulting


Github page for the MICS R analysis project. 

This repo is for keeping track of project code, allowing team members to view progress, and versioning / centralization of code for future wrappings, and centralized access to tools or functions developed during project. 


---

### Directories

`Data` Folder contains datasets / input data files 
  
`R` Contains the working versions of the scripts for producing the SFR tables
Within R folders - `_environ.RData` are the `.RData` files containing the full working environment. You can load these files and it will contain all the objects, lists / tables / datasets etc
produced from running through a script

`R` subdirectories by SFR chapter

Note: Within R directory, one rmarkdown version will be to produce md / html to be linked on the project page, while the `_prettydoc` suffixed `.Rmd` files will be to explore greater customizations, they should be otherwise the same other than display capabilities (i.e. prettydoc versions can't be displayed on github markdown)

`SPS` folder contains the .SPS files of SPSS syntax to translate into R

`SFR` Folder contains the SFR reports - we want to match the table outputs as close to the corresponding 
SFR as possible

## Meetings:

Meeting notes:

- Discussed differences between value / variable labels vs CSPro output as single source of truth. 
Jose: Use CSPro and just go with whatever is easiest in R, i.e. disregard SPSS routines wherever convenient if we can do the same thing in R.

- Next Steps: 
1. Match WS-1.1 as closely to report as possible for full 1.1 section
2. then proceed forward with next two sections to start seeing how much can be rolled into automation. 

# Tables

Below are the direct markdown links to the tables

# Ch10


[Ch10 WS 1.1](https://github.com/RMinto/UNICEF-MICS/blob/master/R/ch10/ch10-1-1.md#sfr-table-ch10-ws-11)

[Ch10 WS 1.2]()
