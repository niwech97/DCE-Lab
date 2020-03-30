################################################################################

#                              MAIN SCRIPT                                     #

################################################################################

#----------------------------TABLE OF CONTENTS----------------------------------

# - Overview
# - Packages downloaded
# - Libraries
# - Data Download 
# - Workflow 
# - Source the rest of the code

################################################################################

#---------------------------------OVERVIEW--------------------------------------

#The following contents within this main directory include the packages, 
#libraries, dataset and the workflow that is used in this analysis. For the 
#purpose of this analysis the scripts should be run in the folling order to gain 
#replicatory results:

#   MainScript:(This included data organization with the overview of the 
#                 workflow used in this project)
#
#  1. LearningDesign: (This script was used to learn how to design a DCE
#                      through the use of 2 academic papers and one online guide)
#
#  2. PracticingDesign: (This includes our creation of our own attributes and 
#                        the design I created from them)
#
#  3. TestingDesign: (This includes the design I created from attributes 
#                     provided to us in an academic paper)
#    
#  4. LearningAnalysis:(This script was used to learn how to analyze a DCE
#                      through the use of 2 academic papers and one online guide)
#
#  5. PracticingAnalysis:(This script includes an analysis on a dataset I created)
#
#  6. TestAnalysis:
#
#
#

#------------------------------PACKAGE DOWNLOAD---------------------------------

# This is a list of the packages used for the design
if(!require(readr)){
  install.packages("DCchoice",
                   repos = c("http://www.bioconductor.org/packages/release/bioc",
                             "https://cran.rstudio.com/"),
                   dep = TRUE)
  
}

if(!require(readr)){
  install.packages(
    c("apollo", "crossdes", "DoE.base", "Ecdat", "gmnl", "lmtest", "mded", 
      "mlogit", "support.CEs", "support.BWS", "support.BWS2"),
    repos = c("https://cran.rstudio.com/"),
    dep = TRUE)
}



if(!require(readr)){
  install.packages("readr")
}
if(!require(ggplot2)){
  install.packages("ggplot2")
}
if(!require(dplyr)){
  install.packages("dplyr")
}

#---------------------------------LIBRARIES-------------------------------------

# Load the packages in the libraries 

#load libraries
library(support.CEs)
library(survival)
library(stats)
library(mded)

library(readr)
library(ggplot2)
library(dplyr)

#------------------------------BUILD DIRECTORY----------------------------------
#Set our working directory 

working.dir <- getwd()

# Create the folders I will use
output.folders <- c("0.Data","1.Learn.tech","2.Pract.tech","3.Test.tech")

# Check to see if the folders exist in the working directory and if they don't, 
# use the following loop. 
# The following loop checks the output.folders list and checks to see 
# if the folders exist in the working directory. If they don't it will create 
# them. 

# Make the folders using this loop code 
for(i in 1:length(output.folders)) 
  if(file.exists(output.folders[i]) == FALSE) 
    dir.create(output.folders[i])

#-------- Pathways----------

# The following is a directory of the pathways to each of our output folders

#Path to 0.Data
path.d <- paste(working.dir,"/",output.folders[1],"/",sep="")

# Path to 1.Learn.tech
path.l <- paste(working.dir,"/",output.folders[2], "/", sep="")

# Path to 2.Pract.tech
p.path <- paste(working.dir,"/",output.folders[3], "/", sep="")

# Path to 3.Test.tech
t.path <- paste(working.dir,"/",output.folders[4], "/", sep="")



#--------------------------------DATA DOWLOAD-----------------------------------

# The following are the raw data files used in the practicing techniques section 
# of this analysis:



# The following are the datasets I used for the testing techniques section of 
# this analysis:



#-----------------------------------WORKFLOW------------------------------------

# In our working directory I created 4 pathways to different folders with 
# specific outputs 

#           - 1. Learn.tech  -> the path to this folder is: path.l
#                 (This folder contains the scripts and outputs I produced from 
#                 learning the techniques)
#
#           - 2. Pract.tech -> the path to this folder is: path.p
#                 (This folder contains the scripts and outputs I produced from 
#                  our test dataset)
#
#           - 3. Test.tech -> the path to this folder is: path.t
#                 (This folder contains the outputs I produced from our real 
#                 dataset)
#
#           - 0. Data.sets -> the path to this folder is: path.d
#                 (This folder contains the raw data used in our learning, 
#                 practicing and testing techniques sections)

#-----------Source the other scripts----------- 

source("1.LearningDesign.R")
source("2.PracticingDesign.R")
source("3.TestDesign.R")
source("4.LearningAnalysis.R")
source("5.PracticingAnalysis.R")
source("6.TestAnalysis.R")



#################################END MAIN SCRIPT################################
