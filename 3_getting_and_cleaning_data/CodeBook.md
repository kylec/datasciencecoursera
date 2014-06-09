Cleaning human activity data
========================================================
run_analysis.R cleans UCI HAR DATAset and outputs a tidy dataset. The script should be run at the root director of UCI HAR DATAset

The following describes the behaviour of the scirpt.

Read trainig, testing data and their labels and store them in the following variables.
```{r}
train_data = read.table("train/X_train.txt")
train_labels = read.table("train/y_train.txt")
train_subjects = read.table("train/subject_train.txt")
test_data = read.table("test/X_test.txt")
test_labels = read.table("test/y_test.txt")
test_subjects = read.table("test/subject_test.txt")
activity_labels = read.table("activity_labels.txt")
colnames(activity_labels) = c("activity_number", "activity")
features = read.table("features.txt", stringsAsFactors=FALSE)
```

Combine training data, test data, and assign each data row with an activity number
```{r}
combined_data = data.frame(data=rbind(train_data, test_data), activity=rbind(train_labels, test_labels), subjects=rbind(train_subjects, test_subjects))
```

Give data columns descriptive names
```{r}
colnames(combined_data) = c(features$V2, "activity_number", "subject")
```

Replace activity number with descriptive names
```{r}
combined_data= merge(combined_data, activity_labels, by.x="activity_number", by.y="activity_number",all)
```

Find column index of measurements that are either mean or std of the measurements, and include subject and activity column. Extract the data into another variable
```{r}
index = grep("(mean|std|activity$|subject)",colnames(combined_data))
extracted_data = combined_data[,index]
```

Find the mean of each measurement for each subject and each activity. Save data as a text file
```{r}
tidy_data = ddply(extracted_data, .(subject, activity), numcolwise(mean))
write.table(tidy_data, "tidy_data.txt", quote=F, sep="\t", col.names=T, row.names=F)
```