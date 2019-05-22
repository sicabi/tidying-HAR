################################################################################
###                         P  R  O  J  E  C  T                              ###
###                             TIDYING THE                                  ###
###     HUMAN ACTIVITY RECOGNITION USING SMARTPHONES DATA SET (VERSION 1)    ###
###                 OF THE UNIVERSITY OF GENOA-SMARTLAB                      ###
###          https://sites.google.com/view/smartlabunige/research            ###
###                                                                          ###
###              SCRIPT 1: DOWNLOAD AND EXTRACT THE DATASET FILES            ###
###                                                                          ###
### This R script downloads and extracts the HAR dataset into our working    ###
### (project) directory. It is the first of three files written to tidy      ###
### the HAR dataset. The script creates an specific folder for the dowloaded ###
### zip files and another one for the extracted (unzipped) dataset files. If ###
### the files or directories have already been created or downloaded, it     ###
### does not execute the function and returns a console message to notify    ###
### the user. The extraction filepaths from the zip file are ignored in      ###
### order to place all the HAR dataset files(txt) in one folder.             ###
###                                                                          ###
################################################################################

################################################################################
###  1. Download the files of the HAR dataset in the project directory       ###
################################################################################

# 1. Create destination folder for the ZIP file into the project directory------
if (!file.exists("ZIP_files")) {
        dir.create("ZIP_files")
} else {
        message("The \"ZIP_files/\" directory has already been created")
}

# 2. Download zip file into the destination directory --------------------------
if (!file.exists("ZIP_files/UCI HAR Dataset.zip")) {
        HAR.url <- "https://bit.ly/2JQgycv" # Bitly shortened link
        download.file(url = HAR.url, 
                      destfile = "./ZIP_files/UCI HAR Dataset.zip", 
                      quiet = FALSE)
        rm("HAR.url")
} else {
        message("A \"UCI HAR Dataset.zip\" file has already been downloaded")
}


# 3. Create destination folder for the unzipped DATASET files ------------------
if (!file.exists("DATASET_files")) {
        dir.create("DATASET_files")
} else {
        message("The \"DATASET_files/\" directory has already been created")
}
if (!file.exists("DATASET_files/TXT_files")) {
        dir.create("DATASET_files/TXT_files")
} else {
        message("The \"DATASET_files/TXT_files\" directory has already 
                been created")
}


################################################################################
###  2. Unzip the files of the HAR dataset in the project directory          ###
################################################################################

# 1. Extract the DATASET files into de DATASET_files directory------------------
if (!file.exists("DATASET_files/README.txt")) {
        unzip(zipfile = "ZIP_files/UCI HAR Dataset.zip", overwrite = TRUE, 
              exdir = "DATASET_files/TXT_files/", junkpaths = TRUE, setTimes = TRUE)
} else {
        message("\"UCI HAR Dataset.zip\" has already been extracted")
}

################################################################################
###                         P  R  O  J  E  C  T                              ###
###                             TIDYING THE                                  ###
###     HUMAN ACTIVITY RECOGNITION USING SMARTPHONES DATA SET (VERSION 1)    ###
###                 OF THE UNIVERSITY OF GENOA-SMARTLAB                      ###
###          https://sites.google.com/view/smartlabunige/research            ###
###         SCRIPT 2: LOAD THE DATA SET FILES INTO THE R ENVIRONMENT         ###
###                                                                          ###
### This R script loads the HAR data set(s) into the R environmennt. It is   ###
### the second of three files written to tidy the HAR data set. The script   ###
### parses the labels txt-files, as well as the training and test txt-files, ###
### the databases we will merge. It reads the selected txt-files and creates ###
### eight data.frame objects in the R environment. It uses the fread         ###
### function from the data.table package, which is significantly faster than ###
### the read.table or read.fwf functions from the utils R-base package.      ###
### IMPORTANT: In order to properly identify the variables to import for     ###
### each txt-file, it is recommended that the user reads the README.txt file ###
### carefully and then skims through the txt-files, using with a word        ###
### processor and a spreadsheet program before executing any function to     ###
### read the data.                                                           ###
###                                                                          ###
################################################################################

################################################################################
##  1. Setup digit display and the packages to import the data               ###
################################################################################

# 1. Disable scientific notation to see all the digits in the datasets----------
options(scipen = 999)
# 2. Load the data.table package to import data faster--------------------------
if (!require("data.table")) {
        install.packages("data.table", dependencies = TRUE)
        library("data.table")
} else {
        message("Package is already loaded")
}


################################################################################
###  2. Load files into the R environment using data.table                   ###
################################################################################

# 1. Load feature and activity labels datasets using fread----------------------
feature.labels <- fread(file = "./DATASET_files/TXT_files/features.txt", 
                        header = FALSE, sep = " ", 
                        col.names = c("feature_id", "feature"), 
                        stringsAsFactors = FALSE, encoding = "UTF-8", 
                        data.table = FALSE)
activity.labels <- fread(file = "DATASET_files/TXT_files/activity_labels.txt", 
                         header = FALSE, sep = " ", 
                         col.names = c("activity_id", "activity"), 
                         stringsAsFactors = FALSE, encoding = "UTF-8",
                         data.table = FALSE)

# 2. Load training datasets using fread ----------------------------------------
training.subject <- fread(file = "DATASET_files/TXT_files/subject_train.txt", 
                          header = FALSE, sep = " ", 
                          col.names = c("subject_id"), 
                          stringsAsFactors = FALSE, encoding = "UTF-8",
                          data.table = FALSE)
training.activity <-  fread(file = "DATASET_files/TXT_files/y_train.txt", 
                            header = FALSE, sep = " ", 
                            col.names = c("activity_id"), 
                            stringsAsFactors = FALSE, encoding = "UTF-8",
                            data.table = FALSE)
training.features <- fread(file = "DATASET_files/TXT_files/X_train.txt", 
                           header = FALSE, 
                           col.names = paste0("feature_", 
                                              feature.labels$feature_id),
                           stringsAsFactors = FALSE, encoding = "UTF-8", 
                           data.table = FALSE)




# 3. Load testing datasets using fread------------------------------------------
test.subject <- fread(file = "DATASET_files/TXT_files/subject_test.txt", 
                      header = FALSE, sep = " ", 
                      col.names = c("subject_id"), 
                      stringsAsFactors = FALSE, encoding = "UTF-8",
                      data.table = FALSE)
test.activity <-  fread(file = "DATASET_files/TXT_files/y_test.txt", 
                        header = FALSE, sep = " ", 
                        col.names = c("activity_id"), 
                        stringsAsFactors = FALSE, encoding = "UTF-8",
                        data.table = FALSE)
test.features <- fread(file = "DATASET_files/TXT_files/X_test.txt", 
                       header = FALSE, 
                       col.names = paste0("feature_", 
                                          feature.labels$feature_id),
                       stringsAsFactors = FALSE, encoding = "UTF-8",
                       data.table = FALSE)


################################################################################
###                         P  R  O  J  E  C  T                              ###
###                             TIDYING THE                                  ###
###     HUMAN ACTIVITY RECOGNITION USING SMARTPHONES DATA SET (VERSION 1)    ###
###                 OF THE UNIVERSITY OF GENOA-SMARTLAB                      ###
###          https://sites.google.com/view/smartlabunige/research            ###
###                                                                          ###
###         SCRIPT 3: MERGE AND TIDY THE TRAINING AND TEST DATA SETS         ###
###                                                                          ###
### This R script merges and tidies the HAR data set(s). It is the last one  ###
### of three files written to tidy the HAR data set. Firts, it checks if the ###
### required datasets are already loaded into the R environment. In case     ###
### they are not, it sources the firts two scripts. Then, it executes the    ###
### next instructions:                                                       ###
###     1. Merge the training and the test sets to create one data set.      ###
###     2. Extracts only the measurements on the mean and standard deviation ###
###     for each feature.                                                    ###
###     3. Match the activity names with their id to name the activities     ###
###     in the data set.                                                     ###
###     4. Appropriately labels the data set with descriptive variable       ###
###     names                                                                ###
###     5. Cretates an independent tidy data set with the average of each    ###
###     variable for each activity and each subject                          ###
###     6. Saves tidy data set into the DATASET directory                    ###
###                                                                          ###
################################################################################


################################################################################
###  1. Merge the training and the test sets to create one data set.         ###
################################################################################

# 1. Match the subject and activity id with measured features------------------
test.dataset <- cbind(subject_id = test.subject$subject_id, 
                      activity_id = test.activity$activity_id, 
                      test.features)
training.dataset <- cbind(subject_id = training.subject$subject_id, 
                           activity_id = training.activity$activity_id,
                           training.features)
# 2. Join the test and training datasets----------------------------------------
complete.dataset <- rbind(test.dataset, training.dataset)



################################################################################
###  2. Extract only the measurements on the mean and standard deviation for ###
###  each measurement.                                                       ###
################################################################################

# 1. Generate a data frame of the feature labels to be keep-------------------

features.keep <- feature.labels[grep(pattern = "mean\\(\\)|std\\(\\)", 
                                     feature.labels$feature), ]
# 2. Adjust features id according to the first 2 columns of complete.dataset----
features.keep$feature_id <- features.keep$feature_id + 2 
# 3. Extract the features to be keep using the features.keep data.frame-------
complete.dataset <- complete.dataset[, c(1:2, features.keep$feature_id)]


################################################################################
###  3. Use descriptive activity names to name the activities in             ###
###  the data set.                                                           ###
################################################################################

# 1. Match the activities id with the activity labels---------------------------
complete.dataset <- merge(activity.labels, complete.dataset, 
                          by = c("activity_id"), all = TRUE)
# 2. Delete activity_id column and resort the column order----------------------
complete.dataset <- data.frame(subject = complete.dataset$subject_id, 
                               activity = tolower(complete.dataset$activity), 
                               complete.dataset[4:length(complete.dataset)], 
                               stringsAsFactors = FALSE)


################################################################################
### 4. Appropriately label the data set with descriptive variable names.     ###
################################################################################

# 1. Clean special characters and typos-----------------------------------------
features.keep$feature <- gsub(pattern = "[()]", replacement = "", 
                              x = features.keep$feature)
features.keep$feature <- sub(pattern = "^t", replacement = "time", 
                              x = features.keep$feature)
features.keep$feature <- sub(pattern = "^f", replacement = "frequency", 
                             x = features.keep$feature)
features.keep$feature <- sub(pattern = "BodyBody", replacement = "Body", 
                           x = features.keep$feature)
# 2. Assign names according to the features keep data frame---------------------
names(complete.dataset)[3:length(complete.dataset)] <- features.keep$feature


################################################################################
### 5. Create a second, independent tidy data set with the average of each   ###
### variable for each activity and each subject.                             ###
################################################################################

# 1. Tidyr to the rescue: load the tidyverse package ---------------------------
if (!require("tidyverse")) {
        install.packages("tidyverse", dependencies = TRUE)
        library("tidyverse")
}

# 2. Generate tidy datset-------------------------------------------------------
HAR.dataset <- gather(complete.dataset, key = "feature", value = "measure", 
                         -c("subject", "activity"))
HAR.dataset <- HAR.dataset %>% 
                       group_by(subject, activity, feature) %>% 
                       mutate(average = mean(measure)) %>% 
                       select(-measure) %>%  
                       unique() %>% 
                       ungroup()
HAR.dataset <- arrange(HAR.dataset, subject, activity, feature)
HAR.dataset <- spread(data = HAR.dataset, key = feature, value =  average)

################################################################################
### 6.  Saves the tidy data set into the working (project) directory         ###
################################################################################

# 1. Remove objects and save data.frames in the working (project) directory-----
rm(list = setdiff(ls(), c("HAR.dataset")))
write.table(x = HAR.dataset, file = "HAR_tidydata.txt", row.names = FALSE)

# 2. Delete unzipped files to save disk/cloud space-----------------------------
txt.names <- list.files("DATASET_files/TXT_files/", full.names = TRUE)
file.remove(txt.names)
rm(txt.names)