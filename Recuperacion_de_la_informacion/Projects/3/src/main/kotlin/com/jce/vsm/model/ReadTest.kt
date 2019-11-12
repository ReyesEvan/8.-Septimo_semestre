package main.kotlin.com.jce.vsm.model

fun main(args: Array<String>) {
    val myReader: Reader = Reader()
    val aNum=692
    val mA = myReader.articleList[aNum]
    println("${mA.number}\t${mA.title}")
    println("\n${mA.author}")
    println("\n${mA.bib}")
    println("\n${mA.content}")
}