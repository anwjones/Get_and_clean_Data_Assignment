# run_Analysis.R
#
# R script for Coursera course 'Getting the Cleaning Data' Assignment
# 
# Aims
# 1. Merge the training and test sets to create one data set
# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names
# 5. From the data set in step 4, creates a second, independent tidy data set 
#    with the average of each variable for each activity and each subject.

#set the location of the working folder
#setwd('C:/Coursera/GandCData/Assignment/data')

#read the features.txt file as this maps feature variable position to variable name
features <- read.table('features.txt', stringsAsFactors=FALSE, col.names=c('POS','DESC'))

#remove features which do not contain 'mean()', or 'std()' in the description as not interested in these 
features.reqd_list <- union(grep('mean()',features$DESC,fixed=TRUE),grep('std()',features$DESC, fixed=TRUE))
features <- features[features.reqd_list,]

#function to clean up the descriptions to make useful variable names
clean.name <- function(s){
    s1 <- gsub("()",'',s, fixed=TRUE) #drop brackets
    return(gsub('[^a-z|^0-9]+',"_", s1, perl=TRUE, ignore.case=TRUE))   #swap non alphanum to _
}
#apply the function to create a list of usable names
features$NAME <- sapply(features$DESC, clean.name)

#read the activity_labels.txt file which maps numeric activity to names
activities <- read.table('activity_labels.txt', stringsAsFactors=FALSE, col.names=c('ID','LABEL'))

#read the training sets (x, y and subject) and remove unwanted features
x.train <- read.table('train/X_train.txt')              #load training data
x.train <- x.train[,features$POS]                       #drop unwanted - retaining $POS (original position index)
names(x.train) <- features$NAME                         #attach the names from features
y.train <- read.table('train/y_train.txt')              #activity (y) associated with observations (x)
s.train <- read.table('train/subject_train.txt')        #subject performing the activity

#read the test sets
x.test <- read.table('test/X_test.txt')                #load test data
x.test <- x.test[,features$POS]                        #drop unwanted
names(x.test) <- features$NAME                         #attach the names from features
y.test <- read.table('test/y_test.txt')                #activity (y) associated with observations (x)
s.test <- read.table('test/subject_test.txt')          #subject performing the activity

# add in the Activity and Subject and put into the combined set (idf for Inertial Data Frame)
idf <- rbind(cbind(y.train, s.train, x.train),
             cbind(y.test,  s.test,  x.test))

#some tidying up of the data
names(idf)[1:2] <- c("Activity", "Subject")                   #rename the first two columns that were appended
idf$Activity <- factor(idf$Activity, labels=activities$LABEL) #convert activities to a factor

#now create the "means" data frame
library(sqldf)

#build a sql expression from the names
sql <- names(idf)[seq(3, length(names(idf)))]                            # list of names
sql <- paste0(paste("avg(", sql, ") as ", sql,sep=""), collapse=",\n")   # [avg(name) as name] (repeated),
sql <- paste0("Select Activity, Subject,\n",                             #rest of the SQL statement
              sql, 
              "\nfrom idf \ngroup by Activity, Subject")
#cat(sql)                                                                #print the sql statement

#put in the means in their own data frame
mdf <- sqldf(sql)


mdf <- sqldf(
    "Select *
    from idf
    group by Activity, Subject"
    )

#write the tidy data sets
write.table(idf, "Inertial_Tidy_Data.txt", row.names=FALSE)
write.table(mdf, "Means_Tidy_Data.txt", row.names=FALSE)

