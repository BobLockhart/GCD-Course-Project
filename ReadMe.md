## Getting and Cleaning Data - Course Project

## ReadMe.txt

R Lockhart
2014-08-24

This repo contains the files required as deliverables for the Getting and Cleaning Data course project.  The input data sets have not been uploaded; they are available at the UCI HAR website as indicated in the course project instructions.

The objective of the course project was to take the input data sets, presented in a rather disjointed and unorganized set of files and folders, and to create a single tidy data set that summarizes the input data by subect (participant) and activity.  There are 30 subjects in the test, each participating in 6 activities many times, so that the summary data set has 180 rows.  The results of the project, and an analysis of the R script used to perform that analysis, are detailed in the code book.

This repo therefore contains 5 elements:

* This ReadMe.txt file, which lists the contents of the repo

* The *Getting and Cleaning Data Code Book* (PDF format), which divides into 3 sections:
  - Description of the Input Data 
  - Description of the Output Tidy Data Set
  - Analysis of the R script used to create the output tidy data set

* The R script *run_analysis.R*, which creates the output data set

* The output required by the course exercise, *final_table.txt*, a tidy data set created from the input data

* Another version of the required output in .csv format, *analysisresult.csv*, which may be easier to view

The .csv format file was added since the required output, in .txt format, is somewhat difficult to view, even in well suited for processing within R.  

The Code Book contains quite detailed descriptions of the input and output data sets (including a screen shot of the output as viewed in Microsoft Excel), plus a walk through the source code for the R script that explains each section of code.