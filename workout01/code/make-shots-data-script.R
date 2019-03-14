##Title: Data Preparation
##Description: For the data preparation phase, we are basically creating a new csv file, 
##            which contains some required variables to be used in the visualization phase
##Inputs: andre-iguodala.csv, draymond-green.csv, kevin-durant.csv, klay-thompson.csv, stephen-curry.csv
##Outputs: andre-iguodala-summary.txt, draymond-green-summary.txt, kevin-durant-summary.txt, klay-thompson-summary.txt, 
##       stephen-curry-summary.txt, shots-data-summary.txt
###
curry <- read.csv("Desktop/workout01/data/stephen-curry.csv", stringsAsFactors = FALSE)
thompson <- read.csv("Desktop/workout01/data/klay-thompson.csv", stringsAsFactors = FALSE)
durant <- read.csv("Desktop/workout01/data/kevin-durant.csv", stringsAsFactors = FALSE)
green <- read.csv("Desktop/workout01/data/draymond-green.csv", stringsAsFactors = FALSE)
andre <- read.csv("Desktop/workout01/data/andre-iguodala.csv", stringsAsFactors = FALSE)

curry$name <- "Stephen Curry"
thompson$name <- "Klay Thompson"
durant$name <- "Kevin Durant"
green$name <- "Draymond Green"
andre$name <- "Andre Iguodala"

curry$shot_made_flag[curry$shot_made_flag  == "n"] <- "shot_no"
curry$shot_made_flag[curry$shot_made_flag  == "y"] <- "shot_yes"
thompson$shot_made_flag[thompson$shot_made_flag  == "n"] <- "shot_no"
thompson$shot_made_flag[thompson$shot_made_flag  == "y"] <- "shot_yes"
durant$shot_made_flag[durant$shot_made_flag  == "n"] <- "shot_no"
durant$shot_made_flag[durant$shot_made_flag  == "y"] <- "shot_yes"
green$shot_made_flag[green$shot_made_flag  == "n"] <- "shot_no"
green$shot_made_flag[green$shot_made_flag  == "y"] <- "shot_yes"
andre$shot_made_flag[andre$shot_made_flag  == "n"] <- "shot_no"
andre$shot_made_flag[andre$shot_made_flag  == "y"] <- "shot_yes"

curry$minute <- (curry$period)*12 - curry$minutes_remaining
thompson$minute <- (thompson$period)*12 - thompson$minutes_remaining
durant$minute <- (durant$period)*12 - durant$minutes_remaining
green$minute <- (green$period)*12 - green$minutes_remaining
andre$minute <- (andre$period)*12 - andre$minutes_remaining

sink("Desktop/workout01/output/stephen-curry-summary.txt")
summary(curry)
sink()

sink("Desktop/workout01/output/klay-thompson-summary.txt")
summary(thompson)
sink()

sink("Desktop/workout01/output/kevin-durant-summary.txt")
summary(durant)
sink()

sink("Desktop/workout01/output/draymond-green-summary.txt")
summary(green)
sink()

sink("Desktop/workout01/output/andre-iguodala-summary.txt")
summary(andre)
sink()

total <- rbind(curry, thompson, durant, green, andre)
write.csv(total, "Desktop/workout01/data/shots-data.csv", row.names = FALSE)
sink(file = 'Desktop/workout01/output/shots-data-summary.txt')
summary(total)
sink()


 
