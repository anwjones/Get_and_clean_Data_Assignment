---
title: "Inertial Tidy Data Code Book"
output: html_document
---

###Source of Data
The data was taken from the archives of the Centre for Machine Learning and Intelligence at
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
and is attributed to the following source:

##Human Activity Recognition Using Smartphones Dataset
#Version 1.0

Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.
Smartlab - Non Linear Complex Systems Laboratory
DITEN - Universit?? degli Studi di Genova.
Via Opera Pia 11A, I-16145, Genoa, Italy.
activityrecognition@smartlab.ws
<www.smartlab.ws>

###How the data was collected
A number of attributes were measured by sampling the smartphones of 30 volunteers while they performed various activities.  These attributes are the output of the smartphones inertial sensors (gyroscope and accelerometer). The attributes were subject to various transformations and processes to derive 561 features in the downloaded data set.  These features (x) relate to the activities performed (y) for each subject.  The activities are
Walking, Walking up stairs, walking down stairs, sitting, standing and laying.  The machine learning goal is to use the output of the inertial sensors to determine what the carrier of the smart phone is doing.

###How the tidy data sets are created by the R script
The original data was already split into a training set and and test set.  These were recombined
Only the features that were the mean or standard deviation of the sampled readings were retained, the other features dropped, reducing the 561 attributes to 66.  These features were identified by the original feature name containing the text "mean()" or "std()" .
The data set was expanded to include the Activity being undertaken and the Volunteer.
The feature names were modified to exclude characters that cannot be accomodated in normal programming variable names.
This resulted in the Inertial_Tidy_Data.txt
The Mean_Tidy_Data.txt is just the mean of each value in the Inertial_Tidy_Data.txt 

###Data Fields
Activity: This is the activity being undertaken.  It has a values of WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING
Subject:  This is an identifier of the specific volunteer. It as a range of 1 to 30

The remaining features (with the exception of the last 3) have a name that is structured in the following way (for example tBodyAccJerkMag_std):

Part 1: t or f - whether the attribute is a value at a point in time or a measure of frequency over the sampling interval.

Part2: Body or Gravity - The processing used an algorithm (Butterworth low pass filter) to separate slow movements (assigned to "Gravity") from rapid jerky movements (assigned to "Body").

Part3: Acc or Gyro - Which of the inertial sensors is producing the signal, Accelerometer (which measures stright line force or acceleration) or Gyroscope (which measures angular acceleration).

Part4: (empty) or Jerk - empty for the base acceleration, Jerk for the change in acceleration

Part5:
    mean_X - mean of X plane movements (No gravity readings in this horizonal direction)
    mean_Y - mean of Y plane movements (No gravity)
    mean_Z - mean of Z plane movements
    Mag_mean - mean of the Euclidian magnitude calculated from X,Y,Z
    _std_X - standard deviation of X plane movements
    _std_Y - standard deviation of Y plane movements
    _std_Z - standard deviation of Z plane movements
    Mag_std - standard deviation of Euclidian magnitude caculated from X,Y,Z movements


The last three fields are:
fBodyBodyAccJerkMag_std, fBodyBodyGyroMag_std, fBodyBodyGyroJerkMag_std
These do not fit the naming convention (containing an extra 'Body') and I haven't been able to work out what they contain !

All the feature variables have been normalised to fall into the range (-1, +1)