# Bykov's R - Platform topics
# Developed with help from https://www.r-bloggers.com/using-text-mining-to-find-out-what-rdatamining-tweets-are-about/

# Check your working directory
getwd()
# If necessary, set your working directory
# setwd("/home/...")

# If necessary, install packages
install.packages("NLP")
install.packages("tm")
install.packages("SnowballC")
install.packages("RColorBrewer")
install.packages("wordcloud")

# Load packages
library("NLP")
library("tm")
library("SnowballC")
library("RColorBrewer")
library("wordcloud")

# Check if the package has been loaded
search()

# build a corpus, which is a collection of text documents
myCorpus <- Corpus(DirSource("/home/"))

# Replacespecial characters from the text with space
toSpace <- content_transformer(function (x , pattern ) gsub(pattern, " ", x))
myCorpus <- tm_map(myCorpus, toSpace, "/")
myCorpus <- tm_map(myCorpus, toSpace, "@")
myCorpus <- tm_map(myCorpus, toSpace, "\\|")

# Clean the text
# Set lower case
myCorpus <- tm_map(myCorpus, tolower)
# Remove Russian common stopwords
myCorpus <- tm_map(myCorpus, removeWords, stopwords("russian"))
# Remove punctuations
myCorpus <- tm_map(myCorpus, removePunctuation)
# Eliminate extra white spaces
myCorpus <- tm_map(myCorpus, stripWhitespace)

# Text stemming
myCorpus <- tm_map(myCorpus, stemDocument)

# Build a term-document matrix with function TermDocumentMatrix()
myDtm <- TermDocumentMatrix(myCorpus, control = list(minWordLength = 1))
m <- as.matrix(myDtm)
v <- sort(rowSums(m),decreasing=TRUE)
d <- data.frame(word = names(v),freq=v)
head(d, 10)

# Generate the Word cloud with 'wordcloud'
set.seed(1234)
wordcloud(words = d$word, freq = d$freq, min.freq = 1,
          max.words=200, random.order=FALSE, rot.per=0.35, 
          colors=brewer.pal(8, "Dark2"))

# Show 50 most frequent words
head(d,50)
