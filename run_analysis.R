run_analysis <- function() {
	## Description: John Hopkins Data Science course on Coursera, Getting and Cleaning Data, 
	## 				Week 4 assignment
	## Author: Michael J. Sabal
	## Start date: 13 July 2016

	# Load raw data into dataframes
	baseDir  <- "./UCI HAR Dataset/"
	trainDir <- "./UCI HAR Dataset/train/"
	testDir  <- "./UCI HAR Dataset/test/"
	
	activityLabel	<- read.table(paste(baseDir,"activity_labels.txt",sep=""))
	features		<- read.table(paste(baseDir,"features.txt",sep=""))
	
	subjectTrain 	<- read.table(paste(trainDir,"subject_train.txt",sep=""))
	xTrain 			<- read.table(paste(trainDir,"X_train.txt",sep=""))
	yTrain 			<- read.table(paste(trainDir,"y_train.txt",sep=""))

	subjectTest 	<- read.table(paste(testDir,"subject_test.txt",sep=""))
	xTest 			<- read.table(paste(testDir,"X_test.txt",sep=""))
	yTest 			<- read.table(paste(testDir,"y_test.txt",sep=""))
	
	# Add column names to xTrain and xTest (requirement #4)
	colnames(xTrain)<- features[ ,2]
	colnames(xTest) <- features[ ,2]
	
	# Merge the 3 test and 3 train datasets into one
	trainData 				<- cbind(subjectTrain,yTrain,matrix(nrow(xTrain),1),xTrain)
	colnames(trainData)[1:3]<- c("Participant","Activity","Source")
	trainData[ ,3] 			<- "Train"
	testData 				<- cbind(subjectTest,yTest,matrix(nrow(xTest),1),xTest)
	colnames(testData)[1:3]	<- c("Participant","Activity","Source")
	testData[ ,3] 			<- "Test"
	rm(list=c("subjectTrain","xTrain","yTrain","subjectTest","xTest","yTest")) # Memory cleanup
	gc(FALSE)
	
	# Merge the train and test datasets into one (requirement #1)
	allData <- rbind(trainData,testData)
	rm(list=c("trainData","testData"))
	gc(FALSE)
	
	# Change the activity codes to descriptive names (requirement #3)
	for (idx in 1:nrow(activityLabel))
		allData[allData$Activity==idx,2] <- as.character(activityLabel[activityLabel$V1==idx,2])

	# Include only columns related to keys (Participant, Activity, Source), means, and 
	# standard deviations (requirement #2)
	# Note: meanFreq() and angle(...,mean) are interpreted as being outside the scope of
	# the requested columns.
	# Note 2: The "Source" column is also removed here because the final dataset needs to
	# summarize across both sets.  It is trivial to add it back in if we want to reanalyze
	# both sets separately.
	columnList <- sort(c(1,2,grep("mean\\(\\)",names(allData)),grep("std\\(\\)",names(allData))))
	allData <- allData[,columnList]
	
	# Create a new data.frame averaging the measurements, grouped by participant and activity
	# (requirement #5)
	cnameList 		<- names(allData)[3:length(names(allData))]
	participantList	<- unique(allData$Participant)
	activityList	<- unique(allData$Activity)
	dfLength		<- length(participantList) * length(activityList) * length(cnameList)
	participantVector	<- numeric(dfLength)
	activityVector		<- character(dfLength)
	measurementVector	<- character(dfLength)
	averageVector		<- numeric(dfLength)
	rowNum				<- 1
	for (partIdx in participantList)
		for (actIdx in activityList)
			for (measIdx in cnameList) {
				participantVector[rowNum] <- partIdx
				activityVector[rowNum] <- actIdx
				measurementVector[rowNum] <- measIdx
				averageVector[rowNum] <- mean(allData[allData$Participant==partIdx & 
											allData$Activity==actIdx, measIdx])
				rowNum <- rowNum + 1
			}
	summaryData <- cbind(participantVector,activityVector,measurementVector,averageVector)
	colnames(summaryData) <- c("Participant","Activity","Measurement","Average")
	write.table(summaryData,"./summaryData.txt",col.names=TRUE,row.names=FALSE)
	summaryData
}