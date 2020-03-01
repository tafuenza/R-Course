install.packages("readtext")
library(readtext)
library(stringr)
library(dplyr)
{xtest <- read.table("X_test_train.txt")
ytest <- read.table("y_test_train.txt")
xtrain <- read.table("X_train_train.txt")
ytrain <- read.table("y_train_train.txt")} ## Open observation files
colnames(ytest) <- "activity" # Give name to the activitys
colnames(ytrain) <- "activity" # Give name to the activitys
data_test <- cbind(xtest,ytest) #Merge files
data_train <- cbind(xtrain,ytrain) #Merge files
data <- rbind(data_train,data_test) #Merge files

subject_train <- read.table("subject_train.txt") # Open file
subject_test <- read.table("subject_test.txt") # Open file
subject <- rbind(subject_train,subject_test) # Merge files
final <- cbind(data,subject) #Merge data.frame with subjects
names(final)[563] <- "subject" #Change subject column name
actividades <- read.table("activity_labels.txt") #Open activity files
final <- split(final,final$activity) # split data by activity
# convert activities to their names
{final[[1]]$activity <- actividades[[2]][[1]] ; final[[2]]$activity <- actividades[[2]][[2]] ; final[[3]]$activity <- actividades[[2]][[3]]
final[[4]]$activity <- actividades[[2]][[4]] ; final[[5]]$activity <- actividades[[2]][[5]] ; final[[6]]$activity <- actividades[[2]][[6]]}
final <- rbind(final[[1]],final[[2]],final[[3]],final[[4]],final[[5]],final[[6]]) #Join the data


features <- read.table("features.txt") #Open file
features$V2 <- as.character(features$V2) #Change the column of features names to character
features <- rbind(features,c(562,"activity")) #add new activity row
features <- rbind(features,c(563,"subject"))
colnames(final) <- features[[2]] # change column names
nombres <- names(final)
promedio <- grep("mean",nombres) #Find all columns that have "mean" in their names
sd <- grep("std",nombres) #Find all columns that have "std" in their names
data_mean <- final[,promedio] #split the data columns with mean
data_std <- final[,c(sd,562,563)] #split the data columns with std (And the last column "Actividad")
final <- cbind(data_mean,data_std) #Merge both data.frames
names(final) <- gsub("-","",names(final)) #Remove "-"
names(final) <- tolower(names(final)) # Lower case
names(final) <- gsub(",","",names(final)) #Remove ","
promedio <- colMeans(final[,1:79]) #mean of the columns
desviacion <- apply(final[,1:79], 2, sd) #std of the columns
step2 <- data.frame(mean = promedio, sd = desviacion) #dataframe with mean of columns and std for each measurement

aux <- group_by(final,subject,activity) #Group by subject and activity
step5 <- summarise_all(aux,mean) #Summarise the group by mean
write.table(step5,file = "step5.txt",row.name = FALSE)

#End
