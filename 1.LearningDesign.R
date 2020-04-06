################################################################################

#                         LEARNING DESIGN TECHNIQUES                           #       

################################################################################

# If you haven't already, read the read.me document in the folder to understand 
# the purpose, design aspects, and terminology used in DCE design. 

#--------------------------Creating Choice Sets--------------------------------
# To start I will attempt to create a choice set using the mix and match method.
# The following conditions must be met for success:
#  There will be two treatment options 
#  3 attributes with 3 levels each (X(X1,X2,X3),Y(Y1,Y2,Y3),Z(10,20,30)
#  There will be an opt out option 
#  The choice sets will be split into 3 blocks 
#  Seed is set to 123

rd<-rotation.design(
  attribute.names=list(X=c("X1","X2","X3"),
                       Y=c("Y1","Y2","Y3"),
                       Z=c("10","20","30")),
  nalternatives = 2,
  nblocks = 3,
  seed = 123
)


rd
# It worked! but I dont quite understand how to read it...
# It seems to be split into 3 main sections
# In the first section:
#    the first two columns refer to the order and grouping of questions
#    ALT refers to the option #
#    the last three refer to the levels of each attribute for that option for 
#       that choice set
#In the second section:
#    Okay this clearly relates to which questions the participants should answer,
#       but I really don't understand how yet...
#    Okay solved it, this is additional information that will inform the order
#       of questions asked (3 variations to avoid order bias)
#In the third section:
#    This is just some basic info that we input into the function,
#       # of blocks, # of questions in the blocks, # of options, # of attributes


#-----------------------Creating the Questionnaire--------------------------
#Now that the Choice sets have been designed with the appropriate attributes and
#levels, we can create the questionnaire.

q.rd<-questionnaire(choice.experiment.design = rd)

# Wow another first try success!
# This function spits out the exact questions that should be asked within each
# block. Each question is a choice between two options that are characterized by 
# the attributes and levels specified, typically a respondent will be asked
# to respond to only one block of questions. 

# This is clearly a super simple way to create a questionnaire that can be 
# edited in a word processor to make a distributable questionnaire.


#----------------------------Alternative Design------------------------------------------------------------------
# In addition to the mix and match (rotational) design that was used in my
# first attempt at creating a choice set, there is another design known as LMA 
# (refer to read.me if you have questions), this is a less common design, but I 
# will learn it and practice it anyway.

# Using the same criteria as the first time I will change the design to LMA

# To refresh here are the criteria:
#  There will be two treatment options 
#  3 attributes with 3 levels each (X(X1,X2,X3),Y(Y1,Y2,Y3),Z(10,20,30)
#  There will be an opt out option 
#  The choice sets will be split into 3 blocks 
#  Seed is set to 123

lma<-Lma.design(
  attribute.names=list(X=c("X1","X2","X3"),
                       Y=c("Y1","Y2","Y3"),
                       Z=c("10","20","30")),
  nalternatives = 2,
  nblocks = 3,
  seed = 123
)
lma

# we get a very similar readout, but that is not where the major differences 
# will be. It will mostly be shown in the questionnaire that is made

q.lma<-questionnaire(choice.experiment.design = lma)


# As we can see the blocks are in larger chunks, and the alternatives in the 
# first block are all the same. This is part of the LMA design and purposeful.
# moving on to practice!