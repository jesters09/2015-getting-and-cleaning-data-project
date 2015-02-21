##Code Book##
 
###Data Sources
This dataset is derived from the "Human Activity Recognition Using Smartphones Data Set" which was originally made avaiable here:  [data](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) 

###Raw data collection###
 
Raw data are obtained from UCI Machine Learning repository. In particular we used the Human Activity Recognition Using Smartphones Data Set, that was used by the original collectors to conduct experiments exploiting Support Vector Machine (SVM) .
 
Activity Recognition (AR) aims to recognize the actions and goals of one or more agents from a series of observations on the agents' actions and the environmental conditions [3]. The collectors used a sensor based approach employing smartphones as sensing tools. Smartphones are an effective solution for AR, because they come with embedded built-in sensors such as microphones, dual cameras, accelerometers, gyroscopes, etc.
 
The data set was built from experiments carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (walking, walking upstairs, walking downstairs, sitting, standing, laying) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, 3-axial linear acceleration and 3-axial angular velocity were captured at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually [4].
 
The obtained data set has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.
 
###Signals
 
The 3-axial time domain [5] signals from accelerometer and gyroscope were captured at a constant rate of 50 Hz [6]. Then they were filtered to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals using another filter. Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals [7]. Also the magnitude [8] of these three-dimensional signals were calculated using the Euclidean norm [9]. Finally a Fast Fourier Transform (FFT) [10] was applied to some of these time domain signals to obtain frequency domain [11] signals.
 
The signals were sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window at 50 Hz). From each window, a vector of features was obtained by calculating variables from the time and frequency domain.
 
The set of variables that were estimated from these signals are:
 
- mean(): Mean value
- std(): Standard deviation
- mad(): Median absolute deviation 
- max(): Largest value in array
- min(): Smallest value in array
- sma(): Signal magnitude area
- energy(): Energy measure. Sum of the squares divided by the number of values. 
- iqr(): Interquartile range 
- entropy(): Signal entropy
- arCoeff(): Autoregression coefficients with Burg order equal to 4
- correlation(): Correlation coefficient between two signals
- maxInds(): Index of the frequency component with largest magnitude
- meanFreq(): Weighted average of the frequency components to obtain a mean frequency
- skewness(): Skewness of the frequency domain signal 
- kurtosis(): Kurtosis of the frequency domain signal 
- bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
- angle(): Angle between some vectors.
 
No unit of measures is reported as all features were normalized and bounded within [-1,1].
 
###Data transformation
 
The raw data sets are processed with run_analisys.R script to create a tidy data set called tidy_data.txt
 
###
Merge training and test sets
 
1. Test and training data (X_train.txt, X_test.txt), subject ids (subject_train.txt, subject_test.txt) and activity ids (y_train.txt, y_test.txt) are merged to obtain a single data set. Variables are labelled with the names assigned by original collectors (features.txt).
 
2. Extract mean and standard deviation variables From the merged data set is extracted and intermediate data set with only the values of estimated mean (variables with labels that contain "mean") and standard deviation (variables with labels that contain "std").
 
3. Use descriptive activity names
 
4. A new column is added to intermediate data set with the activity description. Activity id column is used to look up descriptions in activity_labels.txt.
 
5. Label variables appropriately
 
6. Labels given from the original collectors were changed: to obtain valid R names without parentheses, dashes and commas to obtain more descriptive labels
 
###Create a tidy data set
 
From the intermediate data set is created a final tidy data set where numeric variables are averaged for each activity and each subject. The data set was trasformed into a long dataset with one column for all the observations.
 
The tidy data set contains 813621 observations with 4 variables divided in:

- **subject_id**- subject identifier
- **activity_name**- the name of the activity done (walking, walking_upstairs, walking downstairs, sitting, standing, and laying
- **variable**- the variable being measured
- **mean**- the average value for the varaible