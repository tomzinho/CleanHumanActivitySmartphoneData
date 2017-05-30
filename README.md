# CleanHumanActivitySmartphoneData
Tidy Smartphone Human Activity Data -- Coursera Getting and Cleaning Data Course Project

The source data is fully described in the link below:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The purpose of this R project is to "clean" the above data set and also calculate the means of a set of select variables.

As indicated by the code comments, the initial steps of the R script download the data set, unzip it, and read the relevant
data files into data frames.  Certain source files that are not relevant to the cleaning process are ignored.

In this exercise we focus on the following data elements:

X - core human activity data measures
y - integer values (1-6) indicating the body position (walking, sitting, etc.) of the subject. 
subject - integer values representing the subjects whose bodily measurements were taken.

Each of these data elements have 'test' and 'training' components.

In Step 1, we merge the test and training components so combined data sets are created.

In Step 2, we create a data frame containing the measurements in the X data set and identify the measurements that are means
or standard deviations.  We then combine the two; these are the measurements of interest.

In Steps 3 and 4, the following actions are taken:
* Replace the integers representing body position with more meaningful description
* Rename some of the columns in our combined data frames to have more meaningful names
* Filter the combined X data frame so that it only contains measures related to the means and standard deviations,
as determined in Step 2.
* Names the data element in X with the appropriate feature descriptions.  This provides column headers.
* Combines the subject ID data set, the descriptive body position (label) data set and the core measurement data set (x)
* into a single data frame.  This data is "tidy".

Finally, in Step 5 the averages of the measures are taken and stored in a separate data set.  Before this is done, the
column is removed, since it is text and cannot be average.  The data sets are then saved as .csv files.

