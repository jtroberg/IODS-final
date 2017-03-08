# Data wrangling

# Johanna Troberg
# johanna.troberg@helsinki.fi
# 27.2.2017

# The data used in this final assignment is combination of my previously published data about dog 
# and human enzymes, as well as other published articles from the same study object.

# List of references given at the end of the final assignment web page.

# The data was first collected into three separate excel files and saved as csv format. 

# Access to dplyr
library(dplyr)
library(tidyr)

# Data wrangling for the dog and human 1A families file
enzymes<-read.table("~/Desktop/IODS-project/IODS-final/data/doghuman1As.txt", sep="\t", header=T)

# In original data of the 1A families there are 19 objects and 20 variables (9 human and 10 dog enzymes and substrates)
str(enzymes)
colnames(enzymes)

# Combining the file about the physicochemical properties of the drugs that are used here as substrates.
physicochemprop<-read.table("~/Desktop/IODS-project/IODS-final/data/physchemprop.txt", sep="\t", header=T)

# The data set 2 has 19 objects and 9 variables (19 glucuronides and 9 physicochemical properties)
str(physicochemprop)

# Telling which columns are the identifiers (for later use)
join_by<-c("Substrate")

# Joining these two data sets with the identifier (=Substrate)
enz <- inner_join(enzymes, physicochemprop, by = join_by, suffix=c(".enzymes", ".physicochemprop"))
glimpse(enz)

#Changing the column name "Substrate" into "glucuronide"
colnames(enz)[1]<-"glucuronide"

# Setting the first column (=glucuronide) as rownames
rownames(enz)<-enz$glucuronide

# Remove the glucuronide column and check the variables
enz<-select(enz, -glucuronide)
dim(enz)

# Now the joined data has 18 objects and 27 variables.


# Saving the data in the data folder 
setwd("~/Desktop/IODS-project/IODS-Final/data")
write.table(enz, file="enzymes.txt")





