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
    test/X_test.txt, test/y_test.txt, test/subject_test, train/X_train.txt, train/y_train.txt, train/subject_train  
    for X_test and X_train, the labels are defined by the column 2 of features dataset.


B - ASSEMBLING OF THE DATA IN ONE SINGLE DATA SET

columns assembled with cbind() as follow for both test and train data: subject, X, y
lines are assembled with rbind(), to have one single dataset for test and train.

C - SELECT RELEVANT COLUMNS
Only the columns containing string mean an std are selected.
Of course Activity_id and subject_id also remain in the dataframe

D - REPLACE THE ACTIVITYIF BY ITS NAME
The name is taken from the activity_label file.

E - TIDY THE NAMES
Some "()" are removed from the names as they are not very intuitive.
Also all the uppercase are removed.

F - SUMMARIZE THE DATA
The script uses the group_by function to summarize the mean values by subject_id and activity.
In the result datasset, there will therefore be 30 subjects * 6 activities = 180 lines

G - WRITE THE DATA ON AN EXTERNAL FILE




