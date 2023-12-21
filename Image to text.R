# Install required packages if needed
if (!requireNamespace("tesseract", quietly = TRUE)) {
  install.packages("tesseract")
}
if (!requireNamespace("magick", quietly = TRUE)) {
  install.packages("magick")
}

# Load required packages
library(tesseract)
library(magick)

### PART 1 ###
### For converting single image
# Define the work directory or folder path containing the image (this is optional)
setwd("YOUR/WORK/DIRETORY")

# Define the image file name (you may define the file path instead)
image_file <- "FILENAME.jpg"

# Read the image
image <- image_read(image_path)

# Preprocess the image
image <- image_convert(image, type = "Grayscale") %>%
  image_deskew() %>%
  image_resize("1000x") #Optional for resizing the image 

# Extract text from the image
text <- ocr(image)

# Print the extracted text for checking
cat(text)

# Convert the extracted text to text file
converted_file_name <- gsub(".jpg", ".txt", image_file) # Edit the original file name 
converted_folder <- "converted" #Define the save folder name for saving the text file
dir.create("converted", showWarnings = TRUE) #Create the save folder
save_file_path <- file.path(converted_folder, converted_file_name)
write.table(text, file = save_file_path , sep = "")


### PART 2 ### 
### For converting bulk images
# Define the folder path containing the images
setwd("YOUR/WORK/DIRETORY")

# list all the images
image_list <- list.files(path = ".", pattern = ".jpg", full.names = F)
converted_folder <- "converted" #Set the converted folder name for saving text file
dir.create("converted", showWarnings = TRUE) #Create the save folder

# For loop for processing all image at once
for (image in image_list){
  image_file <- print(image)
  image_file
  image <- image_read(image)
  image <- image_convert(image, type = "Grayscale") %>%
    image_deskew() %>%
    image_resize("1000x") #Optional for resizing the image 
  text <- ocr(image)
  converted_file_name <- gsub(".jpg", ".txt", image_file) # Edit the original file name 
  save_file_path <- file.path(converted_folder, converted_file_name)
  write.table(text, file = save_file_path , sep = "")
}
