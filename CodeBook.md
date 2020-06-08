CODE BOOK
=========

The run_analysis.R script compile the data and produces a summary on mean and std values.

The structure of the code is the following : 

A - INPUT FILE READING 

  - Reading of activity_labels file
    ./activity_labels.txt

  - Reading of feature file
    ./feature.txt

  - Reading of the input files for training and test:
    test/X_test.txt, test/y_test.txt, test/subject_test, 
    train/X_train.txt, train/y_train.txt, train/subject_train  

B - SELECT RELEVANT COLUMNS
Only the features containing the string "mean" an "std" are selected thanks to grep function.
Then the corresponding names are modified to remove special character such as (),-, which make the names difficult to read. Also, uppercase are removed.

C - ASSEMBLING OF THE DATA IN ONE SINGLE DATA SET

lines are assembled with rbind(), to have one single dataset for test and train on the three set of variables.
Then the X data set is truncated to select only the "mean" and "std" columns cretaed in B.
Finally, the full dataset is assembled with cbind between Subjetc, Y and X.

D - REPLACE THE ACTIVITYIF BY ITS NAME
The name is taken from the activity_label file.

E - SUMMARIZE THE DATA
The script uses the group_by function to summarize the mean values by subject_id and activity.
In the result datasset, there will therefore be 30 subjects * 6 activities = 180 lines

F - WRITE THE DATA ON AN EXTERNAL FILE




