package main.kotlin.com.jce.vsm.model


//import main.kotlin.com.jce.vsm.model.ArticleInterface
// NOTE: IntelliJ says this import is unnecessary. Confirm @Siordia if using Code

class Article(
        override val number: Int,
        override val title: String,
        override val author: String,
        override val bib: String,
        override val content: String
): ArticleInterface {

    override var rankingCoefficient:    Double  = 0.0
    override var match:                 String? = null //Term within content with the highest IDF
    override val termWeights =          HashMap<String, Double>()

    override var tokens = HashMap<String, Int>()

    override fun tokenize(): HashMap<String, Int> {
        val allTokens = HashMap<String, Int>()

        for (word in this.termWeights.keys) {
            val match = content.split(word).size - 1
            allTokens[word] = match
        }

        return allTokens
    }


}