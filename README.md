# Getting_and_Cleaning_Data_Assignment
Final Assignment for "Getting and Cleaning Data"

The file "run_analysis.r" takes the raw data given in the assignment and creates a tidy data set, according to both the assignment instructions and Hadley Wickham's paper "Tidy Data", referenced frequently throughout the course.

First, the raw data set was downloaded.

Then, the files containing data for the train and test groups were unzipped and imported to R, and combined into a single data frame (thus satisfying STEP 1)

Then, the file containing the names of the measures was unzipped and importanted. Any measurements containing "mean" or "std" were extracted into a separate vector. 
  (NOTE: this included measures of "meanFreq()" in addition to "mean()" and "std()". The assignment instructions    were unclear regarding whether "meanFreq()" was desired, so I opted to include it. In later analysis, it would be far easier to exclude "meanFreq()" than to attempt to add it back in) 
This separate vector was used to extract columns representing measures of mean and standard deviation from the combined dataset (thus satisfying STEP 2).

Then, descriptive column names were added to the dataset, using the names from the previously unzipped file (thus satisfying STEP 4).

Then, files containing subject IDs and activity IDs were unzipped and importanted, and added to the dataset. Using the separate "activity_labels" file, the activity IDs were replaced with descriptive names (thus satisfying STEP 3)

Finally, the resulting dataset was used to create a second tidy data set, displaying the mean value for each measurement by subject and activity ID. This second dataset also abides by the principles of tidy data, as described in Hadly Wickham's paper "Tidy Data" (thus satisfying STEP 5).

A full description of this second tidy data set (saved in this repo as "tidydata2.txt") can be found in the Codebook.
