################################################################################

#                       LEARNING ANALYSIS TECHNIQUES                           #       

################################################################################

# So I just finished the testing design about 20 minutes ago, and I am reading 
# through the textbook and more or less think I can get the code, but am 
# struggling with understanding the statistics behind it. I am going to keep 
# going through the textbook to try to understand how it does the analysis, and 
# after I understand I will write the code. 

# Okay I think I understand most of it, hopefully the rest will click when I 
# perform an analysis either in this learning script or the practicing scripts

# Writing more script did not help me to understand the statistics. A BIG part 
# I kept getting stuck on was the Random Utility Theory (RUT) that this analysis
# is based off of. RUT Is the idea that an individual that is presented with a 
# set of options will chose the option that has the highest utility. This utility
# can be broken down into two discrete components. The 1st component is known as
# the systematic component for utility and it is understood to be the culmination
# of utility from all known factors both regarding the individual and the decision
# itself. The second component is a random component that cannot be calculated.
# It can however be estimated based off of the systematic component. This estimation
# is where much of the difficult and confusing analysis happens. On the flipside 
# the systematic component (essentially the known factors) can be calculated by
# creating a matrix and putting this in dialogue with the dataset through a 
# conditional logit function. We are using a conditional logit function instead 
# of a binomial logit function because we have more than 2 choices (we have a 
# choice pair (2), and an opt out choice for a total of 3)


#---------------------------Creating a Matrix--------------------------------
# In order to analyze our dataset (not yet created), first we must create a design
# matrix to organize the dataset into a usable format for the clogit() function

# an important note is that this function can account for continuos or 
# categorical cariables as well as account for opt out options and more

# With that in mind lets create a matrix such that:
# We use rd (created in LearningDesign.R)
# an opt out option is present and visible
# Each alternative has 3 attributes, X and Y are categorical and Z is continuous

dm.rd<-make.design.matrix(
  choice.experiment.design = rd,
  optout=TRUE,
  categorical.attributes = c("X","Y"),
  continuous.attributes = c("Z"),
  unlabeled = TRUE,
  common = NULL,
  binary = FALSE)

dm.rd

# This matrix shows the order of the questions/options including an opt out option 
# every 3rd line. 
# The first 3 columns like previously refer to the block#, question#,
# and option# with 3 being the opt out choice. 
# 
# The next four columns are binary.
# ASC refers to whether it is an alternative or the opt out option. X2 and X3 
# refer to the possible levels existing in attribute X for that treatment, a 0 
# in both X2 and X3 means X1 (a nonexistant column that would have referred to
# the first level in attribute X) would have a 1. The same for Y2 and Y3. 
# 
# Z is the last column and as this is our continuous variable, the number 
# refers to the value of the variable. 

#-----------------------------Making a Dataset---------------------------------------------------------------
# Now that the matrix design is in there, we need to make a dataset

# the function we will use is 
# make.dataset(respondent.dataset = ,
#              design.matrix = ,
#              choice.indicators = ,
#              detail = FALSE)
# 
# The respondent dataframe I have to make. Each row will be a single respondent 
# containing, an ID#, block#, and their responses in multiple columns 

res <- data.frame(ID = c(1:30), BLOCK = rep(c(1:3), times = 10), 
                  q1 = c(2, 2, 2, 1, 2, 1, 1, 2, 1, 3, 2, 1, 3, 2, 1, 2, 2, 1, 1, 2, 1, 1, 2, 1, 3, 2, 1, 3, 2, 1),
                  q2 = c(1, 2, 3, 1, 2, 2, 1, 2, 1, 3, 2, 2, 3, 2, 1, 1, 2, 1, 1, 2, 2, 1, 2, 1, 1, 2, 1, 3, 2, 1),
                  q3 = c(2, 1, 2, 1, 1, 2, 1, 3, 1, 1, 1, 2, 1, 3, 2, 1, 1, 2, 3, 2, 3, 3, 2, 1, 1, 2, 2, 1, 3, 3))

# Now that our dataframe of responses has been made we can make the dataset to 
# analyze

ds<-make.dataset(respondent.dataset = res,
                 design.matrix = dm.rd,
                 choice.indicators = c("q1","q2","q3"))

ds

# It works, but its huge so lets look a at a subsection.

ds[1:10,]

# Okay, so the above code works, but its readout is a little confusing without 
# proper explanation. Essentially the new columns to decode are: 
# RES: for some reason this corresponds to TRUE if and only if the respondent 
# chose the second option... strange but fine. 
# ASC is one we haven't seen in a bit,if ASC is 1 its a real option, if it is 0 
# it is the opt out option. 
# All but the last variable we have seen before and is again the attribute X 
# level 1 is yes if X2 and X3 are 0. 
# Same with Y, but Z is continuous, so the level is stated.
# STR is the last new column, it essentially provides a unique ID for each 
# row, or for each answer a respondent gave. This is necessary for the clogit() 
# function which it appears will do most of the analysis. 

#----------------------------Conditional Logit-----------------------------------------------------
# This next section uses the clogit function that is used in Conditional Logit 
# Model Analysis. 

# In order to use clogit() there are two arguements that must be used:
# the forumla     (This is the part I am most confused on.) FIGURED IT OUT
# the data

#setting the formula
# to simplify things, we will call our formula fm, I took this script straight
# from the textbook, and did not understand the first many times through but this 
# is what is going on in this code and why:
# The first thing to realize is that this is not the formula that is run in CL
# it is a "formula" because it is a combination of variables in a specific order
# with specific context, but it is not how the function analyzes the data. 
# That being said, the left of the ~ denotes the dependent variable, while the
# right side is all of the independent variables that the dependent variable is 
# being analyzed against. (I explain the arguements below)

fm <- RES ~ASC +X2 + X3+Y2 + Y3+Z+ strata(STR)

#setting the cl
# this is just done to store the results in an object
cl <- clogit(fm,data = ds)


#next we put it all together and call cl
fm <- RES ~ASC +X2 + X3+Y2 + Y3+Z+ strata(STR)
cl <- clogit(fm, data = ds)
cl

# It worked, after a bit of help from Thor(thanks Thor). After a number of days
# struggling with textbooks and other resources I figured it out! Lets try to
# break it down: The RES is the choice that the respondent made, and the formula
# ~ notation means that it wants to compare this choice (TRUE or FALSE) to the
# levels involved (ASC,X2,X3,etc.). The last piece of this formula uses the
# strata() function to identify a stratification variable that is used to keep
# track of the unique ID for that choice (STR).

cl
# Lets break down the readout from cl: there are 6 columns, the first column is
# the attribute or level the second column is the estimated coefficient value as
# given by the formula, the third column is the exponential function of the
# estimated coeffecient, the fourth is the standard error of the estimated
# coefficient the last two are the z scores and p scores of the estimation under
# the null hypothesis

# Keep in mind in the README these estimated coefficients are sometimes called
# Dummy Variables. It is just a placeholder until the coefficient can be
# estimated

# What does any of that mean in terms of RUT?:
# Well, the clogit function only returns the estimatated coefficients of the 
# random component of RUT, but it does still say something about the systematic
# component. A positive value (of the estimated coefficient) of an independent 
# variable means that an increase in the value of that variable in an alternative
# also increases the systematic components utility for the alternative. ie. X2
# has a positive estimated coefficient, if in another alternative X2 is deemed 
# more valuable, there will be a similarly positive increase to the systematic 
# components utility for the alternative. 

# apparently there is more that is done in this function but it only spits out 
# this summary. Additionally, we can pull out a variance matrix that can tell us 
# more about the variance between the levels/attributes.
# keep in mind this whole time Z is shown as a continuous variable
# we pull variance information with this call:
cl$var


# after creating these estimated coeffecients, we can perform a goodness of fit 
# test using the gofm()function.
gofm(cl)

# At first I was very confused as to what exactly we are fitting to this data,
# but now I understand that we are assuming a normal distribution. By testing a
# goodness of fit of our data to a normal distribution, we will be able to see
# how close or far from that normal distribution, our data is.

# This code spits out a ton of statistics information that I do not yet understand
# It seems there are definitions in earlier chapters that I'll go back to read

# Essentially this code takes the estimated model that we created (cl), and 
# evaluates the statistical significance of it using both logistic regression 
# and likelihood ratios. 


# next in the analysis we can find a willingness to pay metric for each variable
# we do that using the mwtp() function and defining our monetary vs nonmonetary 
# variables

mwtp.cl<-mwtp(output = cl,
              monetary.variables = c("Z"),
              nreplications = 1000,
              confidence.level = 0.95,
              method = "kr",
              seed=123)
mwtp.cl

# Okay this is the point where I realized I am getting the code and it is not 
# helping me get the statistics. I think I need to spend some time this weekend 
# reading earlier chapters in the textbook. I will call it here with the code for
# now, even though I could go farther, I dont think it will help me until I 
# have a better understanding of these measures and methods. 

# Now that I have a better understanding, this MWTP (measure for willingness to pay),
# is a metric on its own that gives insight into the value that individuals are 
# placing on specific levels. 

# To test the difference between MWTP of two levels we can use the mded function


MWTP_x2 <- mwtp.cl$mwtps[, "X2"]
MWTP_x3 <- mwtp.cl$mwtps[, "X3"]
mded.cl <- mded(distr1 = MWTP_x3, distr2 = MWTP_x2)


mded.cl 
