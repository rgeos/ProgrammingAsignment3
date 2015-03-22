# load necessary libraries
library(dplyr)

# this function will retrieve all the features (column headers)
# from file "colNames.txt" (561)
# use: getColNames("path/to/colNames.txt")

getColNames <- function(fileName = "Dataset/colNames.txt")
  labelNames <- as.vector(t(read.table(fileName)[2]))

# this function will return a vector of files based on a regular expression
# use: getFiles("test_*")

getFiles <- function(regex, path = "Dataset/")
  allFiles <- list.files(path, pattern = regex, full.names = T)

# this function will replace all occurencies of "search" in "input" with "replace"
# use: getActionLabel(data.frame, 1, "WALKING")

getActionLabel <- function(input, search, replace)
{
  if (length(search) != length(replace))
    stop("Search and Replace Must Have Equal Number of Items\n") 
  changed <- as.data.frame(input)
  
  for (i in 1:length(search))
    changed <- replace(changed, changed == search[i], replace[i])
  
  changed
}


# this function will combine 3 files and appropriately label the column
# user ID, type of activity, observation vectors

combineData <- function(userID, activityID, observations)
{
  col1 = read.table(userID, quote = "", sep = "", dec = ".", col.names = "User.ID", fill = T)
  col2 = read.table(activityID, quote = "", sep = "", dec = ".", col.names = "Activity.ID", fill = T)
  col3 = read.table(observations, quote = "", sep = "", dec = ".", col.names = getColNames(), fill = T)
  cbind(col1, col2, col3)
}

# this is a bit ugly but it does the trick

# regex for test files
test_files = "test_*"
test = combineData(getFiles(test_files)[1], getFiles(test_files)[3], getFiles(test_files)[2])

# regex for train files
train_files = "train_*"
train = combineData(getFiles(train_files)[1], getFiles(train_files)[3], getFiles(train_files)[2])

# 1. Merges the training and the test sets to create one data set.
together = rbind(test,train, deparse.level = 0)

# check which labels have "mean|Mean|std|Std"
labelsMeanStd <- grep("mean|std", names(together), ignore.case = T, value = T)

# 2. Extracts only the measurements on the mean and standard deviation for each measurement
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names. (already done by the combineData() function)
activityName <- c("WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING","LAYING")
subsetData <- arrange(cbind(together[1], getActionLabel(together[2], 1:6,activityName),together[labelsMeanStd]), User.ID, Activity.ID)

# 5. From the data set in step 4, create a second, independent tidy data set 
# with the average of each variable for each activity and each subject.
grouping <- group_by(subsetData, User.ID, Activity.ID)
tidy_data <- summarise_each(grouping, funs(mean))

write.table(tidy_data, "tidy_data.txt", append = T, row.names = F)