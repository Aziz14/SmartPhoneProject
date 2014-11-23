SmartPhoneProject
=================

Project Description

The aim of this project is to allow the learner to demonstrate his/her ability to collect and clean data and  ultimately generate a dataset that can be used to conduct analysis. 

 The current repository contains the following files:

• CodeBook.md is document that describes the study, including a brief description of the experiment, source of raw data, variables used, and how to generate a tidy dataset. 

• README.md :  A file that describes how to generate the tidy dataset.

• run_analysis.R: This is the R script that will generate the tidy data.

The following 5 steps were carried out to generate tidy data (Please see CodeBook.md document for detailed explanation)

1.	Step1: Merges the training and the test sets to create one data set.
2.	Step2:Extracts only the measurements on the mean and standard deviation for each measurement. 
3.	Step3: Uses descriptive activity names to name the activities in the data set
4.	Step4: Appropriately labels the data set with descriptive activity names. 
5.	Step5: Creates a second, independent tidy data set with the average of each variable for each activity and each subject

Please follow these steps to run 'run_analysis.R' script to generate the tidy data

1.	1.download data to current working directory from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR
2.	2.Uzip data in current working directory. Folder called "UCI HAR Dataset" will created containing all files.
3.	To run the R scrip use the following: source("run_analysis.R")
