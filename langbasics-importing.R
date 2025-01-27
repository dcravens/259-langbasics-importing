##### Base R vs readr importing -----
# read.csv is part of base R, the default fx set
ds <- read.csv('data_raw/vocab16.csv')
print(ds)

# Let's load the readr package to use read_csv
library(readr) #for read_csv
ds <- read_csv('data_raw/vocab16.csv')
print(ds)

##### READING DATA WITH READR ----- 
library(dplyr) #Needed for bind_rows

# Each file contains data for 2-week intervals
dir('data_raw') #function for listing a directory

# This is slow and tedious! Also, to use this you MUST have same column names.
ds12 <- read_csv('data_raw/vocab12.csv')
ds12.5 <- read_csv('data_raw/vocab12.5.csv')
ds13.5 <- read_csv('data_raw/vocab13.5.csv')
ds_all <- bind_rows(ds12, ds12.5, ds13.5)
print(ds_all)

# read_csv can read a list of files! However, to use this you MUST have same column names.
full_file_names <- list.files('data_raw', full.names = TRUE)
ds_all <- read_csv(full_file_names)
print(ds_all)

##### Getting file paths -----
# Use the fs package to have more control over files
# install.packages("fs") # If needed

install.packages("fs")
library(fs)
files <- dir_ls("data_raw")
print(files)
print(path_file(files)) #Get file names
print(path_ext_remove(path_file(files))) #Get file names but remove ".csv"
print(path_abs(files)) #Get absolute paths

##### WRITING DATA ----- 

# Let's add some things and write a combined output

# Create a new column in a dataset
ds_all$ppt_name <- "Jonah"

# Create a calculated column
ds_all$age_round <- round(ds_all$age)

# See the results
print(ds_all)

# Let's write the combined data to disk (aka cleaned data file)
write_csv(ds_all, file = "data_cleaned/vocab_combined.csv")

##### USING READ_CSV OPTIONS ----- 

# Set up some variables to use in the read_csv options
fname <- "data_cleaned/vocab_combined.csv"
colname <- c("AGE", "WORD", "NAME", "MONTH")
coltypes <- "cccc"

# Read the file using different options
# Use the RStudio data viewer to see the changes each time
ds <- read_csv(file = fname) 
ds <- read_csv(file = fname, col_names = FALSE) #Use when there are no column names...assumes data starts on line 1
ds <- read_csv(file = fname, col_names = colname) #Defines column names
ds <- read_csv(file = fname, col_names = colname, skip = 1) #Skip 1st row
ds <- read_csv(file = fname, col_names = colname, col_types = coltypes, skip = 1) #Reading in column types (aka treating all as characters based on Line 62 ("cccc") above)

