This repository has been built for the "Getting and Cleaning Data" assignment.

The dataset used is the Human Activity Recognition Using Smartphones data set described here:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

CodeBook.txt a basic code book covering the output data set, "tidy_average_data.txt"

run_analysis.R performs the data loading and then carries out the steps required by the assingment instructions:
 1) merges training and testing datasets into one
 2) condenses the variables to only include means and standard deviations
 3) ensures all activities and variables are suitably described
 4) creates a tidied data set showing the average of each variable, for each activity for each subject
 5) write the tidied data set to a txt file

tidy_average_data.txt is the final output data file, written by the run_analysis.R script