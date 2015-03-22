# this function will retrieve all the features
# from file "colNames.txt" (561)
# use: getColNames("path/to/colNames.txt")

getColNames <- function(fileName = "Dataset/colNames.txt")
  labelNames <- as.vector(t(read.table(fileName)[2]))

# this function will combine 3 files
# user ID, type of activity, observation vectors

combineData <- function(userID, activityID, observations)
{
  col1 = read.table(userID, quote = "", sep = "", dec = ".", col.names = "User.ID", fill = T)
  col2 = read.table(activityID, quote = "", sep = "", dec = ".", col.names = "Activity.ID", fill = T)
  col3 = read.table(observations, quote = "", sep = "", dec = ".", col.names = getColNames(), fill = T)
  cbind(col1, col2, col3)
}

#together = rbind(test,train, deparse.level = 0)