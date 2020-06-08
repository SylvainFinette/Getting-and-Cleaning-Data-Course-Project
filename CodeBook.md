CODE BOOK
=========

The run_analysis.R script assembles the data and produces a summary of mean and std values.

The structure of the code is the following : 

A - INPUT FILE READING 
  - Reading of activity_labels file
    ./activity_labels.txt
    ==>Stored in dataframe : activity_labels

  - Reading of feature file
    ./feature.txt
    ==>Stored in dataframe : features

  - Reading of the input files for training and test:
    test/X_test.txt, test/y_test.txt, test/subject_test, 
    train/X_train.txt, train/y_train.txt, train/subject_train
    ==>Stored in dataframe's named as the files.

B - SELECT RELEVANT COLUMNS AND TIDY THE VARIABLE NAMING
Only features containing the string "mean" an "std" are selected, thanks to grep function.
The result of grep is a list of numbers indicating the lines in dataframe features that are matching the criteria
==>list columns

The features name for the lines listed in columns are stored in a new list.
==>list columns_names

These names are modified to remove special character such as (),-, which can make the variable names difficult to manipulate, with the gsub() command. Also, uppercase are removed with tolower() command.
==>all these changes are performed in the same list columns_names.

C - ASSEMBLING OF THE DATA IN ONE SINGLE DATA SET

test and train lines are assembled with rbind(), to have one single dataset for each of the three types of variables
  ==>dataframes : X,Y,Subjects
Then the X data set is truncated to select only the "mean" and "std" columns created in B (defined in columns_names)
Finally, all the columns are assembled with cbind between Subject, Y and X.
  ==>dataframe : data_mean_std

D - REPLACE THE ACTIVITYIF BY ITS NAME
The activity name is taken from the dataframe activity_labels.

E - SUMMARIZE THE DATA
The script uses the group_by function to group the values by subject_id and activity.
The mean value for all variables is then computed by the function summarise_all, and stored in a new dataframe
==>dataframe result
In the result data set, there will therefore be 30 subjects * 6 activities = 180 lines

F - WRITE THE DATA ON AN EXTERNAL FILE
As specified in the instructions.
