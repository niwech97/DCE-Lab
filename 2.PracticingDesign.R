################################################################################

#                       PRACTICING DESIGN TECHNIQUES                           #       

################################################################################

# Okay! I just finished learning how to design DCE's in mix and match designs as 
# well as LMA and rotational design. The research that I am interested in almost
# exclusively use mix and match designs and as such that is what I will practice.

#Practice plan:
      #Design a mix and match DCE OMED 
        #Make up levels and attributes that may be used in a DCE I would propose
      #Create a questionnaire

#----------------------------DCE PRACTICE DESIGN-------------------------------------------------------

# The first thing we want to do is identify the hypothetical situation we might
# look into. My curiousity lies in identifying the important choice factors
# in medical decisions specifcally the cultural influence when examining two 
# potential medical solutions; one coming from Western Medicine (WM), and another 
# coming from Traditional Chinese Medicine (TCM), or any other traditional medicine.
# To make this situation more specific, lets choose a specific medical issue and
# from there we can find the TCM recommended treatment and the WM recommended 
# treatment. 
# Headaches are an incredibly common issue, so it was easy to find treatment guides
# for both TCM and WM.
# TCM often prescribes a combination of an herbal remedy and acupuncture, but I
# will simplify this to just the acupuncture
# WM often prescribes pain medications like Aspirin and Ibuprofen.

# To identify the attributes and levels, we would normally perform pilot studies,
# literature reviews, focus groups, and interviews to narrow down a list of 
# relevant attributes and their levels. I obviously am in no postion  to do all 
# of that so instead I will make them up. For practicing purposes I am wanting 
# to create both categorical and continuous variables to be used. I will list 
# the attributes and levels below

# ATTRIBUTES: levels
# COST: (USD) .30, .50, 100, 60
# MODALITY: pill, 30 minute acupuncture massage
# ONSET OF RELIEF: 1-2 weeks, 20 minutes
# LENGTH OF TREATMENT: every 6 hours for 1-3 days, once a week for 4-10 weeks
# DURATION OF RELIEF (from each treatment session): 3-6 hours, up to 10 weeks
# CULTURAL SUPPORT: Friends and family actively also use the treatment, Friends 
#                   and family believe the treatment works, Friends and family 
#                   have no faith in the treatment, Friends and family actively
#                   believe the treatment to be dangerous. 


# (All of the above information was found using basic google searches, or made up)

# Now that we have our attributes and levels, we need to finalize our design 
# choices by deciding on the number of alternatives per choice set, and whether 
# we want to include an opt out option. 

# Lets set our criteria for success to be:
# 2 treatment options
# no opt out option (to mimick the situation of a serious medical issue)
# All attributes and levels specified above must be used
# seed set to current date (3312020)

p.design<- rotation.design(
  attribute.names = list(
    COST     = c("0.3","0.5","60","100"), #in USD
    MODALITY = c("pill","30 minute acupuncture massage"),
    ONSET    = c("20 minutes","1-2 weeks"),
    LENGTH   = c("every 6 hours for 1-3 days","once a week for 4-10 weeks"),
    DURATION = c("3-6 hours","up to 10 weeks"),
    CULTURE  = c("active support","passive support","no support",
                 "negative support")),
  nalternatives = 2,
  nblocks = 1,
  randomize = TRUE,
  seed= 3312020)

p.design
# Hey it worked! Unfortunately some of my levels take up so much space you need 
# to fullscreen the console to see the whole design in one block rather than 
# sending some of the attributes below the rest, but thats a small defeat in the
# face of it. Lets see how the Questionnaire turns out!

#--------------------------DCE PRACTICE QUESTIONNAIRE---------------------------

p.questionnaire<- questionnaire(choice.experiment.design = p.design)

# This is great, with a bit of editing I would be happy to use this as a real 
# questionnaire!

# one thing that I notice is that while I would obviously have an explanation of 
# each attribute and its levels for the participants to read beforehand, there 
# are little things that I would change like adding (USD) to COST and perhaps 
# change the name of LENGTH to SESSIONS. I will make those changes below.             
#



#(#ed out because didn't end up working)

#p.design2<- rotation.design(
#  attribute.names = list(
#    COST(USD)= c("0.3","0.5","60","100"), #in USD
#    MODALITY = c("pill","30 minute acupuncture massage"),
#    ONSET    = c("20 minutes","1-2 weeks"),
#    SESSION  = c("every 6 hours for 1-3 days","once a week for 4-10 weeks"),
#    DURATION = c("3-6 hours","up to 10 weeks"),
#    CULTURE  = c("active support","passive support","no support",
#                 "negative support")),
#  nalternatives = 2,
#  nblocks = 1,
#  seed= 3312020)

# p.design2

# And here we have my first mistake! It appears that if I put USD in parens it 
# treats COST as a function. I can see two potential simple solutions to this
# option 1: switch parens for quotes and see what happens
# option 2: leave it and fix it in a word processor during additional formatting

# lets try to fix it in R using option 1 and see what happens

#(#ed out because didn't end up working)

# p.design3<- rotation.design(
#   attribute.names = list(
#     COST"USD"= c("0.3","0.5","60","100"), #in USD
#     MODALITY = c("pill","30 minute acupuncture massage"),
#     ONSET    = c("20 minutes","1-2 weeks"),
#     SESSION  = c("every 6 hours for 1-3 days","once a week for 4-10 weeks"),
#     DURATION = c("3-6 hours","up to 10 weeks"),
#     CULTURE  = c("active support","passive support","no support",
#                  "negative support")),
#   nalternatives = 2,
#   nblocks = 1,
#   seed= 3312020)
# 
# p.design3

# Still didnt work, thats fine I am pleased with what we did get, and we can 
# always fix it in a word processor after the fact before I send it out.

# Moving on to testing script!
