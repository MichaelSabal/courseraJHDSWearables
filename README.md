## Repository name: courseraJHDSWearables
## Description: John Hopkins Data Science course on Coursera, Getting and Cleaning Data, 
## 				Week 4 assignment
## Author: Michael J. Sabal
## Start date: 13 July 2016

The basis for this project comes from an article posted on the Inside Activity Tracking 
blog on August 23, 2013 at http://www.insideactivitytracking.com/
data-science-activity-tracking-and-the-battle-for-the-worlds-top-sports-brand/.
I heeded some of the tips for this assignment given in the blog post, https://thoughtfulbloke.wordpress.com/2015/09/09/getting-and-cleaning-the-assignment/.

## Project synopsis
### Getting and Cleaning Data Course Project

The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on a series of yes/no questions related to the project. You will be required to submit: 1) a tidy data set as described below, 2) a link to a Github repository with your script for performing the analysis, and 3) a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected.

One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Here are the data for the project:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

## Project requirements
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Analysis of the source data set
The data are split into multiple files and levels of directories, with "UCI HAR Dataset" as the root.  I started by reading each file into a dataframe to get a better handle of what state the data was in.  Based on the originating documentation, the data had already been manipulated and summarized to some degree.
The files activity_labels.txt and features.txt could be read using read.table as space delimited files.  
The file features_info.txt is a plain text document forming a rather basic codebook.
The test and train subdirectories are identical, each having three files named "subject_train.txt", "X_train.txt", and "y_train.txt" (the word train is replaced by test in the test directory).  Alongside those three files is another subdirectory named "Intertial Signals".
The subject_train file contains 7352 records of participant IDs, corresponding to the 7352 records of observational data in X_train.  X_train contains 561 columns, corresponding to the 561 names in the features.txt file.  The y_train file contains 7352 records of activity codes, record matching the 7352 rows of X_train, and code matching the six activity labels in the file of the same name.

## Manipulation of the data.
Based on David Hood's tips, the Inertial Signals files have been ignored.
The first step, then, is to add the column names to the xTrain and xTest dataframes.  The second step is to merge together the three text files in the test and train folders, before paring them down and joining them together.  A simple for loop converts the activity codes to their plain text equivalents.  While the wide form of summary data, with fewer rows, may be easier to create, a longer and narrower form is easier to work with, and easier to check for missing or errant data.

## Review of the data.
Once you have downloaded summaryData.txt to your working directory, run the following two commands:
summaryData <- read.table("./summaryData.txt", header=TRUE)
View(summaryData)
