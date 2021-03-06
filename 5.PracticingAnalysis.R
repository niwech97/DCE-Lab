################################################################################

#                       PRACTICING ANALYSIS TECHNIQUES                         #       

################################################################################
# Because the other analysis was so complex I did not understand it 100% I want
# to perform another simpler analysis that I can understand 100%. I found the
# following analysis methdology a paper that is uploaded into the supporting
# documents known as "Statistical Methods for the Analysis of Discrete Choice
# Experiments: A Report of the ISPOR Conjoint Analysis Good Research Practices
# Task Force"


# This analysis is quite simple, but first lets call in our Matrix that we used
# in the learning analysis script. The reason we are calling this matrix in is
# so that when we call in our respondent data, we can make a dataset of all
# responses per choice option. If this doesn't make sense you will see in just a
# moment.


dm.rd


# Next we want to call in our respondent data:
res <- data.frame(ID = c(1:30), BLOCK = rep(c(1:3), times = 10), 
                  q1 = c(2, 2, 2, 1, 2, 1, 1, 2, 1, 3, 2, 1, 3, 2, 1, 2, 2, 1, 1, 2, 1, 1, 2, 1, 3, 2, 1, 3, 2, 1),
                  q2 = c(1, 2, 3, 1, 2, 2, 1, 2, 1, 3, 2, 2, 3, 2, 1, 1, 2, 1, 1, 2, 2, 1, 2, 1, 1, 2, 1, 3, 2, 1),
                  q3 = c(2, 1, 2, 1, 1, 2, 1, 3, 1, 1, 1, 2, 1, 3, 2, 1, 1, 2, 3, 2, 3, 3, 2, 1, 1, 2, 2, 1, 3, 3))


# Now that we have both the data and the matrix it corresponds to we can create 
# a dataset that tracks the options an individual was asked and their response.

ds<-make.dataset(respondent.dataset = res,
                 design.matrix = dm.rd,
                 choice.indicators = c("q1","q2","q3"))

ds

# Thanks to this dataset we can see when a participant chose an option what the 
# levels of that option are. 

# The goal for our analysis is to have a metric of utility or worth for each 
# level. We will do this by creating a simple ratio of times an option with a 
# specific level was chosen over the number of times that level was present in 
# any option. 

# My first idea for this is try and use a counter function to create an object C
# (for chosen) in which the counter function counts how many times a chosen 
# response includes each level. I would then create another function that counts 
# how many times that level is present in an option and code that into object P. 

# I can then create a simple C/P equation and find a value that corresponds to
# the utility of each level. 

#First step is to find the number of times each variable was used total. I 
# realized there will be 2 tricky variables to find that for because in ds,
# level X1 is only known to be present when X2 and X3 read 0 or not present. 
# I think I will have to do this by adding the times X2 and X3 are present, 
# subtracting that from the total number of rows, from there I subtract 1/3 of 
# the row number because every 3rd row is an opt out option. The remainder will
# be the number of X3's present. 


x2p<-xtabs(~X2,ds)
x3p<-xtabs(~X3,ds)
y2p<-xtabs(~Y2,ds)
y3p<-xtabs(~Y3,ds)
zp<-xtabs(~Z,ds)
x2p
x3p
y2p
y3p
zp

# After doing this I realized that because we used an OMED design, each level is
# by design present the same number of times. I only needed to do this once, but
# I also can bypass the equation needed to find X1 and Y1 as all levels are 
# present exactly 60 times. 

# Now I have to find the number of times each varable was present in a chosen 
# option. One option is to extract all rows that are TRUE in the RES column and 
# perform the same xtabs function however I will need the additional piece to 
# find the X1's and Y1's, however I think actually I can add the RES column into 
# something that xtabs function tabulates. Lets try that first. 

x2c<-xtabs(~X2+RES,ds)
x3c<-xtabs(~X3+RES,ds)
y2c<-xtabs(~Y2+RES,ds)
y3c<-xtabs(~Y3+RES,ds)
zc<-xtabs(~Z+RES,ds)
x2c
x3c
y2c
y3c
zc

# This piece worked! I still need a way to get the X1 and X2 numbers, but adding
# [2,2] will return the chosen number of that level. Z is a little different as 
# it includes all 3 levels within it, but we can seperate that out later. 
x2c[2,2]
x3c[2,2]
y2c[2,2]
y3c[2,2]
zc[2:4,2]

# I think that by using the which function I should be able to extract the rows
# in which the respondent chose that option, and the option did not include the
# levels x2 or x3, and it was not an opt out option and therefore must have
# included level x1. I can do the same for y1

x1c<-ds[which(ds$RES=='TRUE' & ds$X2=='0' & ds$X3=='0' & ds$ASC=='1'),]

y1c<-ds[which(ds$RES=='TRUE' & ds$Y2=='0' & ds$Y3=='0' & ds$ASC=='1'),]


# This worked fantastically, I will be adding the which function to my library. 

# Lets simplify all of the relevant objects to just the number we actually care 
# about. we can also simplify all present objects to just one (p) with a value 
# of 60

p<-60
x1c<-length(x1c)
x2c<-x2c[2,2]
x3c<-x3c[2,2]
y1c<-length(y1c)
y2c<-y2c[2,2]
y3c<-y3c[2,2]
z1c<-zc[2,2]
z2c<-zc[3,2]
z3c<-zc[4,2]

# Now we can check to make sure there is only the one correct value
p
x1c
x2c
x3c
y1c
y2c
y3c
z1c
z2c
z3c

# Now to complete the analysis we will put each chosen object over p to find a 
# ratio that describes its relative utility against the other levels.
x1<-x1c/p
x2<-x2c/p
x3<-x3c/p
y1<-y1c/p
y2<-y2c/p
y3<-y3c/p
z1<-z1c/p
z2<-z2c/p
z3<-z3c/p

# Lets check it

x1
x2
x3
y1
y2
y3
z1
z2
z3

# It works! From this we can see that x3,y2,and z3 are the most influential 
# level within their attributes. However, we can also see that y2 is far more 
# influential than any other level in any attribute and as such this is what
# might be identified as the most important level to include in a new product/ 
# medication/treatment or whatever the DCE is for.