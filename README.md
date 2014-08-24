GettingAndCleaningDataAssignment
================================

Repository for the Coursera course "Getting and Cleaning Data"

The R-Script "run_analysis.R" in this repository creates a tidy data set 
with mean values of a multitude of variables for each activity and each subject.
The underlying data set describes sensor data of accelerometers from smartphones.
More details can be found here:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

The original data set is available at this URL:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

Requirements:
* It is assumed that the original data is available in a subfolder of the
working directory called "UCI HAR Dataset".
* The script requires the library "reshape" for data manipulation.

How the script works:
* The script first reads all necessary files of the original data: The list of
features and the activity labels from the main folder, the sensor data, the 
activities, and subjects from both, the train and the test subfolder.
* The training data and the test data are combined into one data frame 
respectively using cbind(). The activities and subjects are thus added as new
columns. Both data frames are then combined to a single data frame "data" 
using rbind().
* The column of data are renamed using the features data. The two new columns are
named "Activities" and "Subject".
* To make the Activities more easily readable, the numerical values are 
replaced with the textual descriptions from the activity labels.
* All columns that do not describe means, standard deviations, activities or
subject are deleted from the data frame. Mean and standard deviation columns
are identified by the substrings "mean()" and "std()".
* The data fram is melted by activities and subjects, then subsequently reframed
("casted") by the same variables using the mean function. The result is a
tidy data frame with one row for every subject and activity combination and
one column for the means of all other variables.
* Finally, the tidy data frame is written into a text file called 
"tidy_data.txt".
