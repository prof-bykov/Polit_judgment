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
> myCorpus <- Corpus(DirSource("/home/"))

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
                                                                   word freq
это                                                                 это  353
парк                                                               парк  324
очень                                                             очень  228
деревьев                                                       деревьев  205
наталья                                                         наталья  185
идеи                                                               идеи  181
города                                                           города  164
добрый                                                           добрый  156
природы                                                         природы  155
спасибо                                                         спасибо  147

москвы                                                           москвы  145
время                                                             время  140
территории                                                   территории  140
деревья                                                         деревья  135
елена                                                             елена  124
лес                                                                 лес  124
также                                                             также  121
можете                                                           можете  119
татьяна                                                         татьяна  119
день                                                               день  111

экологии                                                       экологии  106
парке                                                             парке  104
александра                                                   александра  103
httpscrowdspacemosrustagestypegener httpscrowdspacemosrustagestypegener  102
которые                                                         которые  102
среды                                                             среды  102
анна                                                               анна  100
парка                                                             парка  100
проекта                                                         проекта   98
здравствуйте                                               здравствуйте   97

москве                                                           москве   96
оопт                                                               оопт   96
городе                                                           городе   95
ксения                                                           ксения   95
место                                                             место   95
предлагай                                                     предлагай   95
жителей                                                         жителей   87
ирина                                                             ирина   87
вячеслав                                                       вячеслав   83
свои                                                               свои   82

просто                                                           просто   80
именно                                                           именно   78
комментарий                                                 комментарий   77
природные                                                     природные   77
какие                                                             какие   75
будут                                                             будут   73
плещенко                                                       плещенко   73
нужно                                                             нужно   72
парки                                                             парки   72
отдыха                                                           отдыха   70



