# Getting and Cleaning Data Course Project

## Data contents

The data set utilized for this assignment is located in "Dataset/" folder.
The contents of the folder are:
- activityLabels.txt (the 6 types of activities employed in this research)
- colNames.txt (a list of all variables employed in this research)
- test_X.txt (test set)
- test_Y.txt (test set labels)
- test_subject.txt (each row represents the subject that performed a certain activity)
- train_X.txt (train set)
- train_Y.txt (train set labels)
- train_subject.txt (each row represents the subject that performed a certain activity)

## Data manipulation

All of the above files had their space characters `^\s+` removed from the beginning of each line.

## Script description

1. The script is utilizing `dplyr` library, so make sure you have it installed. If it is not installed, please do so with `install.packages("dplyr")` prior to execution.
2. The script `run_analysis.R` is composed of the following functions:
	- `getColNames` - this function will retrieve all entries from the file `Dataset/colNames.txt` and store it in a vector to use it as column headers. There are 561 entries.
**Usage**: `getColNames("path/to/colNames.txt")`
**Note**: by default the path to the file is `Dataset/colNames.txt`

	- `getFiles` - this function is taking as argument a regular expression used to identify the file containing either the test set or the train set data.
**Usage**: `getFiles("train_*")`
**Note**: by default the path to the files is `Dataset/`. 

	- `getActionLabel` - this function will replace all occurencies of the searched item inside an input set
**Usage**: `getActionLabel(input, search, replace)`
**Note**: it will be used to replace the sequence 1 to 6 with the appropriate action name, such as "WALKING", "SITTING" etc...

	- `combineData` - this function will take 3 arguments and combine the objects by column
**Usage**: `combineData(userID, activityID, observations)`
**Note**:

3. The flow of the script
	1. The script will load the data sets into 2 separate objects `test` and `train`, one for each type of data.. Eg: `train <- combineData("train_subject.txt", "train_Y.txt", "train_X.txt")`,
	2. It will then perform a bind by row of the above 2 mentioned objects in one object called `together`,
	3. Next it will create 2 vectors. One of the vectors is with all the mean and std variables (`labelsMeanStd`) and the other vector is with the human readable activity type label (`activityName`),
	4. A data subset (`subsetData`) is being created by column bidning the subjects, human readable activity type and all the mean and std variables. At the same time, the new object will be arragend based on `User.ID` and `Activity.ID`
	5. A group by `User.ID` and `Activity.ID` object is formed and a new set of data is being saved in `tidy_data` object with the mean for each of the `labelsMeanStd` columns
	6. Finally, the data inside `tidy_data` is being dumped in a txt file called `tidy_data.txt`

## How to execute

1. Clone the repository on your local machine `ssh clone git@github.com:rgeos/ProgrammingAsignment3.git`
2. Fire up `RStudio` or `R` and `setwd("/path/to/cloned/ProgrammingAsignment3/")`
3. Then source the R script as `source('~/path/to/cloned/ProgrammingAssignment3/run_analysis.R')`
4. Once the source is done, the output will be a file called `tidy_data.txt`

The following Warning sign may appear:
`Warning message:
In write.table(tidy_data, "tidy_data.txt", append = T, row.names = F) :
  appending column names to file`
