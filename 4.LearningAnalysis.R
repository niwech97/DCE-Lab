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



# First we want to call in the design matrix that we made in learning design

dm.rd

# Now that the matrix design is in there, we need to make a dataset

# the function we will use is 
make.dataset(respondent.dataset = ,
             design.matrix = ,
             choice.indicators = ,
             detail = FALSE)

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
# proper explanation. I will include a screenshot of a helpful figure in the 
# supporting materials document, but essentially the new columns to decode are: 
# RES: for some reason this corresponds to TRUE if and only if the respondent 
# chose the second option... strange but fine. ASC is one we haven't seen in a bit,
# if ASC is 1 its a real option, if it is 0 it is the opt out option. All but the
# last variable we have seen before and is again the attribute X level 1 is yes 
# if X2 and X3 are 0. Same with Y, but Z is continuous, so the level is stated.
# STR is the last new column, it essentially provides a unique ID for each 
# row, or for each answer a respondent gave. This is necessary for the clogit() 
# function which it appears will do most of the analysis. 

# This next section uses the clogit function that is used in Conditional Logit 
# Model Analysis. 

# In order to use clogit() there are two arguements that must be used:
# the forumla     This is the part I am most confused on.
# the data

#setting the formula
fm <- RES ~ASC +x2 + x3+y2 + y3+Z+ strata(STR)

#setting the cl
cl <- clogit(fm,data = ds)


#next we put it all together and call cl
fm <- RES ~ASC +X2 + X3+Y2 + Y3+Z+ strata(STR)
cl <- clogit(fm, data = ds)
cl

# It worked, after a bit of help from Thor(thanks Thor), but I still feel like I 
# don't totally understand its readout or forumula. Lets try to break it down:
# As best I can figure through reading the textbook, the RES is the choice that 
# the respondent made, and the formula ~ notation means that it wants to compare 
# this choice (TRUE or FALSE) to the levels involved (ASC,X2,X3,etc.) and it wants
# to keep track of the unique ID for that choice (STR). I think this makes sense,

# STT: the left side of the ~ denotes the independent variable, and the right 
# denotes the dependent variables
cl
# Lets break down the readout from cl:
# there are 6 columns, the first column is the attribute or level
# the second column is the estimated coefficient value as given by the formula
# the thir column is the exponential function of the estimated coeffecient
# fourth is the standard error of the estimated coefficient
# the last two are the z scores and p scores of the estimation under the null 
# hypothesis

# apparently there is more that is done in this function but it only spits out 
# this summary. Additionally, we can pull out a variance matrix that can tell us 
# more about the variance between the levels/attributes.
# keep in mind this whole time Z is shown as a continuous variable
# we pull variance information with this call:
cl$var


# after creating these estimated coeffecients, we can performa a goodness of fit 
# test using the gofm()function.
gofm(cl)

# This code spits out a ton of statistics information that I do not yet understand
# It seems there are definitions in earlier chapters that I'll go back to read


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
