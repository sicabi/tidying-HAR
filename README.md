# Tidying the Human Activity Recognition Using Smartphones Data Set (Version 1) of The University of Genoa-SmartLab

This repository cointains a tidy-data version of the *[Version 1 of the Human Activity Recognition Using Smartphones Data Set](https://sites.google.com/view/smartlabunige/research)* (**HAR_tidydata.txt**) and its codebook (**Codebook.md**). It also contains an R script (**run_analysis.R**) to reformat the HAR dataset according to the rules of *[Tidy Data](http://vita.had.co.nz/papers/tidy-data.pdf)*. To execute the process of tidying the HAR data, the user should follow these steps:

        1. Set a working directory using the setwd() function in R.
        1. Download the script "run_analysis.R" in the set working directory.
        2. Run the script "run_analysis.R" in R.

## Content of the script

### 1. Download and extract files
This part of the script downloads and extracts the HAR dataset into our working (project) directory. The script creates an specific folder for the dowloaded zip files and another one for the extracted (unzipped) dataset files. If the files or directories have already been created or downloaded, it does not execute the function and returns a console message to notify the user. The extraction filepaths from the zip file are ignored in order to place all the HAR dataset files(txt) in one folder.             

### 2. Load raw data files
This part of the script loads the HAR data set(s) into the R environmennt. The script parses the labels txt-files, as well as the training and test txt-files, the databases we will merge. It reads the selected txt-files and creates eight data.frame objects in the R environment. It uses the fread function from the data.table package, which is significantly faster than the read.table or read.fwf functions from the utils R-base package.

### 3. Run analysis
This part of the script merges and tidies the HAR data set(s). Firts, it checks if the required datasets are already loaded into the R environment. In case they are not, it sources the first two scripts. Then, it executes the next instructions:

        1. Merge the training and the test sets to create one data set.      
        2. Extracts only the measurements on the mean and standard deviation for each feature. 
        3. Match the activity names with their id to name the activities in the data set.
        4. Appropriately labels the data set with descriptive variable names
        5. Cretates an independent tidy data set with the average of each variable for each activity and each subject 
        6. Saves tidy data set in a text file format.                   