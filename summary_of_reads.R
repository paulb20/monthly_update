library(readr)
test <- read_log("stats.learningandwork.org.uk.access.log")
summary(as.factor(test$X5))
