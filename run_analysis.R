## run_analysis.R - GCD Course Project - RPL - 2014-08-17
## assumes that working directory is "UCI HAR Dataset" with subdirectories "test" and "train" 

run_analysis <- function () {

## read data from "test" subdirectory (use LaF package to save time with x_test.txt)
    x_test_read  <- laf_open_fwf("./test/x_test.txt", column_widths = rep(16,times=561), 
                                 column_types=rep("numeric", times=561))
    
    x_test       <- x_test_read[,]
    y_test       <- fread ("./test/y_test.txt", stringsAsFactors=F)
    subject_test <- fread ("./test/subject_test.txt", stringsAsFactors=F)
    
## read data from "train" subdirectory (use LaF package to save time with x_train.txt)
    x_train_read  <- laf_open_fwf ("./train/x_train.txt", column_widths = rep(16,times=561), 
                                   column_types=rep("numeric", times=561))
    
    x_train       <- x_train_read[,]
    y_train       <- fread ("./train/y_train.txt", stringsAsFactors=F)
    subject_train <- fread ("./train/subject_train.txt", stringsAsFactors=F)
    
## create vector of feature column names from features.txt (which is in current directory)
    feature_list <- read.table ("features.txt", sep=" ", stringsAsFactors=F)
    feature_colnames <- feature_list[,2]

## set column names in each table; will be inherited below when creating full tables
    setnames (subject_test,   colnames(subject_test),    "Subject")
    setnames (y_test,         colnames(y_test),          "Activity")
    setnames (x_test,         colnames(x_test),          feature_colnames)
    
    setnames (subject_train,  colnames(subject_train),   "Subject")
    setnames (y_train,        colnames(y_train),         "Activity")
    setnames (x_train,        colnames(x_train),         feature_colnames)

## create full train and test data tables, for each combining: subjects, activities, readings
    full_test  <- data.table (subject_test,  y_test, x_test)
    full_train <- data.table (subject_train, y_train,x_train)
    
## combine test and train data into a single table
    test_train <- list (full_test, full_train)
    full_data  <- rbindlist (test_train)
    
## extract only the mean and standard deviation measurements
## first build logical vector of columns that have 'mean' and 'std' in their column names
## double backslash (\\) necessary to search for mean() and std()    
    temp_cols <- grepl ("mean\\(\\)",colnames(full_data)) | 
                 grepl ("std\\(\\)",colnames(full_data))

## add the Subject and Activity columns to selection
## then OR the two selections to get logical vector of all desired columns
    temp_cols2 <- grepl ("Subject", colnames(full_data)) | grepl ("Activity",colnames(full_data))
    keep_cols <- temp_cols | temp_cols2
    
## create new table with only the desired columns (requires null row argument)     
    keep_table <- subset (full_data, , keep_cols)
    
## replace activity code (from y_test & y_train) with activity name as factor in Activity column 
## (LAYING should really be LYING unless test subjects were hens)
    activity_names <- read.table("activity_labels.txt", stringsAsFactors=T)
    acnames <- activity_names[,2]
    keep_table [, Activity:=acnames[Activity]]

## set Subject and Activity as keys to data table for summarization
    keycols <- c("Subject", "Activity")
    setkeyv (keep_table, keycols)

## create final tidy data set with mean of each column by key (subject, activity)
    final_tab <- keep_table[, lapply(.SD,mean), by = key(keep_table)]


## write tidy data set as csv in working directory to easily view results
## keep one old copy just in case
    check_csv <- "analysisresult.csv"
    if (file.exists ("oldtest.csv"))  {file.remove("oldtest.csv")}
    if (file.exists (check_csv))      {file.rename(check_csv,"oldtest.csv")}    
    write.csv (final_tab, check_csv, row.names=F)  

## write the text file required as upload for the course project
    if (file.exists ("final_table.txt"))  {file.remove("final_table.txt")}
    write.table (final_tab, "final_table.txt", sep=" ", quote=F, row.names=F)
    
## return file dimensions of new tidy data set to indicate completion
    dim (final_tab)    

}
