package main.kotlin.com.jce.vsm.model

interface ArticleInterface {
    val number:     Int
    val title:      String
    val content:    String
    val author:     String
    val bib:        String
    var match:      String? //Term within content with the highest IDF
    var rankingCoefficient: Double
    val termWeights: HashMap<String, Double>

    var tokens: HashMap<String, Int>

    fun tokenize(): HashMap<String, Int>


}

