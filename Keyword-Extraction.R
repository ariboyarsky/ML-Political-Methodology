library(tm)
library(RKEA)
library(SnowballC)
library(RTextTools)
library(wordcloud)

corporaDir <- paste(getwd(), "/corpora/", sep = "")

# create set S
corpora <- Corpus(DirSource(corporaDir), readerControl = list(language="en"))
corpora <- Corpus(VectorSource(corpora[1:2]))
corpora <- tm_map(corpora, content_transformer(tolower))
corpora <- tm_map(corpora, removeWords, stopwords('english'))
corpora <- tm_map(corpora, removeWords, c("mr", "mrs", "carter", "reagan", "democrat", "republican", "believe", "trust", "ready", "pledge", "message"))
corpora <- tm_map(corpora, removeNumbers)


# create set I
keywords <- list(c("tax", "right", "poor", "peace", "justice"),
                 
                 c( "tax", "war", "spend"))

tmpdir <- tempfile()

dir.create(tmpdir)

model <- file.path(tmpdir, "polorizationModel")

createModel(corpora[1:2], keywords, model)

#  extract set T
extractKeywords(corpora,createModel(corpora[1:2], keywords, model))
## Word Cloud
corpora <- Corpus(VectorSource(corpora[1:2]))
corpora <- tm_map(corpora, removeWords, stopwords('english'))
col=brewer.pal(6,"Dark2")
wordcloud(corpora[1:2], min.freq = 10, scale = c(5,2), rot.per = 0.25, random.color = T, max.words = 45, random.order = F, colors = col)
