###README

The run_analysis.R file is an R script that takes the raw inertial data collected from the smartphones of volunteers performing various activities and creates two tidy data sets from this data.

The source data is available here: <http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones>

The tidy data sets produced have the same format and are with the Means_Tidy_Data.txt containing the mean values of the full Inertial_Tidy_Data.txt

The files are space separated with the first row containing the field names and can be read back into R
using read.table(filename)

To run the run_analysis.R script you will need to:

1. Download the source zip file from <https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip> 

2. Unzip it with the paths to a working folder

3. Change your working folder to the root where you unzipped the run_analysis.R script.  You can uncomment and edit the line in the file
```{r}
#setwd('C:/Coursera/GandCData/Assignment/data')
```

4. Run the script

The code book describing the data is in the file code_book.md.