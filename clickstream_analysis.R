library("clickstream")
library("arulesSequences")

## Load Data
cls <- readClickstreams(file = "path_to_file", sep = ",", header = F)
cls
summary(cls)

## Fitting Markov Chain
mc <- fitMarkovChain(clickstreamList = cls, order = 3)
options(digits = 2)

##compute transition probabilities
mc
options(digits = 7)
summary(mc)

##plot transition diagram and heatmap
plot(mc)
hmPlot(mc)

##clustering
set.seed(42)
clusters <- clusterClickstreams(clickstreamList = cls, order = 1, centers = 2)
clusters
#To produce the  clustering plot of the post in the code of function clusterClickstreams
#add tthe following in line 17:
#  ggplot(transitionData, aes(StatesChanged,id, colour=fit$cluster))+geom_point()
summary(clusters)

#Predict clicks
pattern <- new("Pattern", sequence = c("Action14", "Action4"))
resultPattern <- predict(mc, startPattern = pattern, dist = 1) # set dist = n to predict n steps ahead
resultPattern

##cSPACE data mining
frequencyDF <- frequencies(cls)
frequencyDF
trans <- as.transactions(cls)
sequences <- as(cspade(trans, parameter = list(support = 0)), "data.frame")
sequences
