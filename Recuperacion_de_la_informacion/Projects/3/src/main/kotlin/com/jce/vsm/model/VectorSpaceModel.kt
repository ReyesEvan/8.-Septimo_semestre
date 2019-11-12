package main.kotlin.com.jce.vsm.model



class VectorSpaceModel() {
    val reader = Reader()

    fun getQueries(): Map<Int, String> = reader.queryMap //TODO: Missing override modifier when applying interface

    fun getQueryVector(query: String): HashMap<String, Double> {
        val queryVector = HashMap<String, Double>()
        val splitted = query.split("[ \n,-]".toRegex())

        for (word in splitted) {
            queryVector.put(word, reader.globalDictionary[word] ?: 0.0)
        }

        return queryVector
    }

    fun getSimilarityCoefficient(documentID: Int, query: String): Double {
        val document = reader.articleList.find { it.number == documentID }!!
        val queryVector = this.getQueryVector(query)
        var documentWeight = 0.0
        val tokenFreqMap = document.tokens

        for (term in document.termWeights.keys) {
            val freq = tokenFreqMap[term]!!
            documentWeight += (document.termWeights[term]!! * freq) * (queryVector[term] ?: 0.0)
        }
        return documentWeight
    }

    fun getRankedList(articles: List<Article>): List<Article> {
        return articles.sortedWith(compareByDescending(Article::rankingCoefficient)).reversed()
    }

    fun generateRandomPrecisionRecall(numberOfArticles: Int = 50, numberOfQueries: Int): Pair<List<Double>, List<Double>>{
//        val randomQueryIds = generateRandomQueries(numberOfQueries)
        val randomQueryIds = generateRandomQueries(numberOfQueries)
        var avgPrecisions = List(numberOfArticles) {0.0}.toMutableList()
        var avgRecalls = List(numberOfArticles) {0.0}.toMutableList()

        for (queryID in randomQueryIds) {
            var retrievedRelevantDocs = 0
            val rankedDocList = search(reader.queryMap[queryID]!!).take(numberOfArticles)


            (0..rankedDocList.size).zip(rankedDocList).forEach {
                if (reader.relMap[queryID]!!.contains(it.second.number))
                    retrievedRelevantDocs++

                avgPrecisions[it.first] += retrievedRelevantDocs/(it.first.toDouble()+1)
                avgRecalls[it.first] += retrievedRelevantDocs/reader.relMap[queryID]!!.size.toDouble()

            }
        }

        avgPrecisions = avgPrecisions.map { d -> d/numberOfArticles }.toMutableList()
        avgRecalls = avgRecalls.map { d -> d/numberOfArticles }.toMutableList()

        return Pair(avgPrecisions.toList(), avgRecalls.toList())
    }

    private fun generateRandomQueries(numberOfqueries: Int): List<Int>  {
        return  (1..numberOfqueries).map { reader.queryMap.keys.filter{it < 225}.random() }
    }


    fun search(query: String):List<ArticleInterface> {
        val orderedList = mutableListOf<Pair<ArticleInterface,Double>>()
        reader.articleList.forEach { article ->
            orderedList.add(Pair(article, getSimilarityCoefficient(article.number, query)))
        }
        orderedList.sortByDescending { it.second }
        val finalList = mutableListOf<ArticleInterface>()

        orderedList.forEach {articlePair ->
            finalList.add(articlePair.first)
            articlePair.first.rankingCoefficient = articlePair.second
            var max = 0.0
            reader.articleDict[articlePair.first.number]!!.forEach { term ->
                if (query.split(Regex("[\\n\\s]")).contains(term)) {
                    if (reader.globalDictionary[term]!! > max) {
                        max = reader.globalDictionary[term]!!
                        articlePair.first.match = term
                    }
                }
            }
        }
        return finalList.toList()
    }


}

