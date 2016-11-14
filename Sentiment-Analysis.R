library(tm)
library(ggmap)
library(dplyr)
library(plyr)
library(wordcloud)

corporaDir <- paste(getwd(), "/corpora/", sep = "")

# create set S
corpora <- Corpus(DirSource(corporaDir), readerControl = list(language="en"))
corpora <- Corpus(VectorSource(corpora[1:2]))
corpora <- tm_map(corpora, content_transformer(tolower))
corpora <- tm_map(corpora, removeWords, stopwords('english'))
# create word clous
col=brewer.pal(6,"Dark2")
wordcloud(corpora[2], min.freq=5, scale=c(5,2),rot.per = 0.25,
          random.color=T, max.word=45, random.order=F,colors=col)


