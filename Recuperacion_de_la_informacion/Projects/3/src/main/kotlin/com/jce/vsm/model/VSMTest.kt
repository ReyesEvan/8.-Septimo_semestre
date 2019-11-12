package main.kotlin.com.jce.vsm.model

fun main(args: Array<String>) {
    val myVSM = VectorSpaceModel()
    val query = 1
    val results = 25
    val outputList = myVSM.search(myVSM.getQueries()[query] ?: error("whoops"))
    println("Searching Query $query and showing $results results")
    println("\nArticle :: Weight :: MatchdedWord")
    for (i in 1..results) {
        println("%7d :: %2.3f :: %s".format(outputList[i].number, outputList[i].rankingCoefficient, outputList[i].match))
    }
}