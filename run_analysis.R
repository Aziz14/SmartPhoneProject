##Maindirectory and documents
mainDirectory  <- ("UCI\ HAR\ Dataset")
featuresDoc  <- paste(mainDirectory, "/features.txt", sep ="")
activityLabelsDoc <- paste(mainDirectory, "/activity_labels.txt", sep = "")

library(plyr)

##Loading the data
features <- read.table(featuresDoc, colClasses = c("character"))
activityLabels <- read.table(activityLabelsDoc, col.names= c("Id", "Activity"))

## Training documents
xTrainDoc <- paste(mainDirectory, "/train/X_train.txt", sep = "")
yTrainDoc <- paste(mainDirectory, "/train/y_train.txt", sep = "")
subjectTrainDoc <- paste(mainDirectory, "/train/subject_train.txt", sep = "")

##Loading training documents
xTrain  <- read.table(xTrainDoc)
yTrain <- read.table(yTrainDoc)
subjectTrain <- read.table(subjectTrainDoc)


##Testing Documents
xTestDoc <- paste(mainDirectory , "/test/X_test.txt", sep = "")
yTestDoc <- paste(mainDirectory, "/test/y_test.txt", sep = "")
subjectTestDoc <- paste(mainDirectory, "/test/subject_test.txt", sep = "")

##Loading testing Documents                    
xTest <- read.table(xTestDoc)
yTest <- read.table(yTestDoc)
subjectTest <- read.table(subjectTestDoc)
                      
          
## Step1. Merging Training and test data sets to create a one dataset.
trainSignalData <- cbind(cbind(xTrain, subjectTrain), yTrain) ##Training dataset
testSignalData  <-  cbind(cbind(xTest, subjectTest), yTest)  ## testing dataset
signalData <- rbind(trainSignalData, testSignalData)  ##merging train and test datasets
signalLabels  <- rbind(rbind(features, c(562, "Subject")), c(563,"Id")) [,2]
names(signalData) <- signalLabels 
dim(signalData)

### Step2. Extract only the measurements on the mean and standard deviation for each measurement 
signalDataMeanStd <- signalData[, grepl("mean|std|Subject|Id", names(signalData))]
dim(signalDataMeanStd)

##Step3. Using Descriptive activity names to name the activities in the dataset
signalDataMeanStd <- merge(signalDataMeanStd, activityLabels, by = "Id", match = "first")
signalDataMeanStd <- signalDataMeanStd[ , -1]
dim(signalDataMeanStd)

## Step4. Appropriately labels the dataset with descriptive variable names

##Remove parentheses and capitalize Mean and Std
names(signalDataMeanStd) <- gsub('\\(|\\)',"",names(signalDataMeanStd), perl = TRUE) # Remove parentheses
names(signalDataMeanStd) <- gsub("mean", "Mean",names(signalDataMeanStd)) # Capitalize M
names(signalDataMeanStd) <- gsub("std", "Std",names(signalDataMeanStd)) # Capitalize S

# Make names readable 
names(signalDataMeanStd) <- gsub('Acc',"Acceleration",names(signalDataMeanStd)) # Replace Acc by Acceleration 
names(signalDataMeanStd) <- gsub('GyroJerk',"AngularAcceleration",names(signalDataMeanStd)) 
names(signalDataMeanStd) <- gsub('Gyro',"AngularSpeed",names(signalDataMeanStd)) 
names(signalDataMeanStd) <- gsub('Mag',"Magnitude",names(signalDataMeanStd)) 

# 5 Creating a second tidy dataset with average of each variable for each activity and each subject
signalMeanByActBySub <- ddply(signalDataMeanStd, c("Subject", "Activity"), numcolwise(mean))
write.table(signalMeanByActBySub, file = "signalMeanByActBySub.txt", row.name= FALSE )
