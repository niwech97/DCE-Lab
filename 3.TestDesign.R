################################################################################

#                         TESTING DESIGN TECHNIQUES                            #       

################################################################################

# In order to test my design abilities, I have decided that I will find some 
# papers that perform DCE's and in either a seperate paper or the appendix of 
# that paper they include the questionnaires that they used. Hopefully in the 
# intro or methodology they will specify the conditions of the DCE they performed
# as well as the attributes and levels they included in the DCE design. After
# extracting the relevant information (DCE design factors, attributes, and levels)
# I will be able to create my own DCE design based on that information. I can 
# use their DCE design to compare against mine and I can check to see if I did it
# the same way they did it. 

# After a surprisingly long time searching, it appears that most DCE's don't 
# include a full questionnaire or even the full choice sets used. Regardless, I
# have been able to find a couple of papers that explicitly state their criteria
# for success within the DCE design, the attributes and levels used, and an 
# example of their choice sets. From this I can make a DCE design meeting their 
# stated criteria and check to see if one of my choice pairs matches with their 
# choice pair example. Not perfect, but a start!

#Criteria for success:
#Attributes are in a table in the data folder
#2 alternatives per choice set
#no opt out option
#unlabeled
#OMED design
#mix and match method

#(#ed out because didn't end up working)
#Attempt 1                                                                       ------------------
# t.design<- rotation.design(
#   attribute.names = list(
#     Type of Professional Administering vaccination 
#     = c("Practice Nurse at local GP","Community Nurse at local clinic",
#         "Health Visitor in the community at local clinic",
#         "Health Visitor at neonatal visits at home",
#         "Community nurse in vaccination bus stationed at schools"), 
#     How information about vaccinations is provided prior to the appointment
#     = c("Written plus verbal information","Email plus written information",
#         "Electronic multimedia plus verbal information"),
#     How information is visually provided
#     = c("Numbers","Charts/pictures","Numbers and charts/pictures"),
#     Availability of appointments
#     = c("Working hours(9-5)",
#         "Working hours (9-5), plus out of hours (weekday evenings and saturday 9-5)"),
#     Type of Parental Award 
#     = c("No Reward","Cash reward for complete vaccination",
#         "Additional child care benefits for complete vaccinations"),
#     Parental reward value
#     = c("0","70","140","210","280")
#     Which parents receive the reward 
#     = c("Targeted Reward","Universal Reward","Current practice")
#     Wating time at appointments
#     = c("30minutes","60 minutes","120 minutes")),
#   nalternatives = 2,
#   nblocks = 1,
#   randomize=TRUE,
#   seed= 412020)
# 
# t.design

#First attempt did not work, there appear to be error messages for every line...
#I wonder if it has to do with how I formatted the lines. I tried to make it look
#pretty by keeping the = signs all lined up by putting them on another line, but
#it may have messed up the format of the function. I will try below without the 
#pretty formatting. 

#(#ed out because didn't end up working)
#Ugly attempt:                                                                   ------------------------

# t.design2<- rotation.design(
#   attribute.names = list(
#     Type of Professional Administering vaccination = c("Practice Nurse at local GP","Community Nurse at local clinic",
#         "Health Visitor in the community at local clinic",
#         "Health Visitor at neonatal visits at home",
#         "Community nurse in vaccination bus stationed at schools"), 
#     How information about vaccinations is provided prior to the appointment = c("Written plus verbal information","Email plus written information",
#         "Electronic multimedia plus verbal information"),
#     How information is visually provided = c("Numbers","Charts/pictures","Numbers and charts/pictures"),
#     Availability of appointments = c("Working hours(9-5)",
#         "Working hours (9-5), plus out of hours (weekday evenings and saturday 9-5)"),
#     Type of Parental Award  = c("No Reward","Cash reward for complete vaccination",
#         "Additional child care benefits for complete vaccinations"),
#     Parental reward value = c("0","70","140","210","280")
#     Which parents receive the reward = c("Targeted Reward","Universal Reward","Current practice")
#     Wating time at appointments = c("30minutes","60 minutes","120 minutes")),
#   nalternatives = 2,
#   nblocks = 1,
#   seed= 412020)
# 
# t.design2

#huh I really don't know why this isn't working, I definitely expected it to. 
#Perhaps it has to do with the length of the terms. I will try another pretty 
#design but with shorter attribute and level names.

#(#ed out because didn't end up working)
#Pretty again but short attempt:                                                 -----------

# t.design3<- rotation.design(
#   attribute.names = list(
#     Professional Type 
#     = c("Practice Nurse at local GP","Community Nurse at local clinic",
#         "Health Visitor in the community at local clinic",
#         "Health Visitor at neonatal visits at home",
#         "Community nurse in vaccination bus stationed at schools"), 
#     Information modality
#     = c("Written plus verbal information","Email plus written information",
#         "Electronic multimedia plus verbal information"),
#     Information Visuals
#     = c("Numbers","Charts/pictures","Numbers and charts/pictures"),
#     Appointment availability
#     = c("Working hours(9-5)",
#         "Working hours (9-5), plus out of hours (weekday evenings and saturday 9-5)"),
#     Parental Award 
#     = c("No Reward","Cash reward for complete vaccination",
#         "Additional child care benefits for complete vaccinations"),
#     Parental reward value
#     = c("0","70","140","210","280")
#     Which parents receive the reward 
#     = c("Targeted Reward","Universal Reward","Current practice")
#     Wating time at appointments
#     = c("30minutes","60 minutes","120 minutes")),
#   nalternatives = 2,
#   nblocks = 1,
#   seed= 412020)
# 
# t.design3


#Still this code didn't run. I wonder if there are too many attributes and levels
#I am going to try again but with a smaller set of attributes and levels and then 
#I can see if I can build it up to where it should be. 

#(#ed out because didn't end up working)
#Shorter and less attempt:                                                       ------
# 
# t.design4<- rotation.design(
#   attribute.names = list(
#     How information is visually provided
#     = c("Numbers","Charts/pictures","Numbers and charts/pictures"),
#     Availability of appointments
#     = c("Working hours(9-5)",
#         "Working hours (9-5), plus out of hours"),
#     Type of Parental Award 
#     = c("No Reward","Cash reward for complete vaccination",
#         "Additional child care benefits for complete vaccinations"))
#   nalternatives = 2
#   nblocks = 1
#   seed= 412020)
# 
# t.design4

#Still didn't work... very confused... definitely getting frustrated, the code 
#above almost perfectly replicates the code I used in practicing R with the difference 


#After taking a break and coming back, I noticed that my first iteration included
#only one word attributes, so I figured I would try that. 

#First successful attempt:                                                       -----

t.design5<- rotation.design(
  attribute.names = list(
    Information
    = c("Numbers","Charts/pictures","Numbers and charts/pictures"),
    Availability
    = c("Working hours(9-5)",
        "Working hours (9-5), plus out of hours"),
    Award 
    = c("No Reward","Cash reward for complete vaccination",
        "Additional child care benefits for complete vaccinations")),
  nalternatives = 2,
  nblocks = 1,
  seed= 412020)

t.design5

#OMG I THINK I GOT IT TO WORK, WAHOOO!!!! I think the key was dropping the 
#attribute names down to a single word. This is restrictive and kind of a bummer,
#but based on the design and questionnaire I can always just edit after the fact. 

#lets make sure a questionnaire works!

questionnaire(choice.experiment.design = t.design5)

# It worked, and whats more is it spat out the right number of questions! 
# I am a little worried that when I scale up that part might change... I  hope not!


#Attempt to scale up to full size:                                               --------

t.design6<- rotation.design(
  attribute.names = list(
    Professional 
    = c("Practice Nurse at local GP","Community Nurse at local clinic",
        "Health Visitor in the community at local clinic",
        "Health Visitor at neonatal visits at home",
        "Community nurse in vaccination bus stationed at schools"), 
    Information
    = c("Written plus verbal information","Email plus written information",
        "Electronic multimedia plus verbal information"),
    Visuals
    = c("Numbers","Charts/pictures","Numbers and charts/pictures"),
    Availability
    = c("Working hours(9-5)",
        "Working hours (9-5), plus out of hours (weekday evenings and saturday 9-5)"),
    Award 
    = c("No Reward","Cash reward for complete vaccination",
        "Additional child care benefits for complete vaccinations"),
    Value
    = c("0","70","140","210","280"),
    Reward 
    = c("Targeted Reward","Universal Reward","Current practice"),
    Wating
    = c("30 minutes","60 minutes","120 minutes")),
  nalternatives = 2,
  nblocks = 1,
  randomize = TRUE,
  seed= 412020)

t.design6


# Okay, it worked 99%, but it spat out 12150 questions. Going back to the paper,
# this isn't actually that surprising as they used another type of design to 
# narrow the questions that they actually asked. They did however mention that 
# had they not used this additional design type they would have had 12150 questions
# This D-efficient design was apparently computed using special design software,
# so I don't feel too bad about not being able to replicate that in R.
# I will put it into a questionnaire for fun, but for the most part I will call 
# this 6th attempt a success and I will move on to analysis!

#questionnaire(choice.experiment.design = t.design6)

# Because it took a couple of minutes and clearly pushed the limits of my computer,
# I have #ed the code so you can run it if you want, but there is by no means a
# necessity to do so. 



#time to learn analysis!