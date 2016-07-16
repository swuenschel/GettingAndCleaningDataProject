#to run this function type source("run_analysis.R") 

  library("dplyr")
  
  setwd("UCI\ HAR\ Dataset")
  
  var_names = read.table("features.txt", header = FALSE)
  #read in and manipulate the test data
  X_test = read.table("test/X_test.txt", header = FALSE)
  Y_test = read.table("test/Y_test.txt", header = FALSE)
  sub_test = read.table("test/subject_test.txt", header = FALSE)
  var_names = read.table("features.txt", header = FALSE)
  colnames(X_test) = var_names[,2]
  colnames(Y_test) = c("Activity")
  colnames(sub_test) = c("Subject")
  total_test = cbind(sub_test,Y_test,X_test)
  
  #read in and manipulate the training data
  X_train = read.table("train/X_train.txt", header = FALSE)
  Y_train = read.table("train/Y_train.txt", header = FALSE)
  sub_train = read.table("train/subject_train.txt", header = FALSE)
  colnames(X_train) = var_names[,2]
  colnames(Y_train) = c("Activity")
  colnames(sub_train) = c("Subject")
  total_train = cbind(sub_train,Y_train,X_train)
  
  total = rbind(total_test, total_train)
  total[,2] = factor(total[,2],
                     labels = c("WALKING","WALKING_UPSTAIRS","WALKING_DOWNSTAIRS",
                                "SITTING","STANDING","LAYING"))
  
  #let's do some clean up
  rm(total_train, total_test)
  rm(sub_test, sub_train, X_test, X_train,Y_test, Y_train)
  rm(var_names)
  
  #extract variables for mean and stdev
  total_meansStd = total[,grepl("mean|std",names(total))]
  #add the subject/activity columns back
  total_meansStd = cbind(total[,1:2],total_meansStd)
  
  #create summary data set - two methods of getting summaries, differ in output format
  summary_set_1 = total_meansStd %>% group_by(Subject,Activity) %>%
    summarise_each(funs(mean))
  
  summary_set_2 = aggregate(total_meansStd[,3:81],
                            by = list(total_meansStd$Activity,total_meansStd$Subject), 
                            FUN = mean)
