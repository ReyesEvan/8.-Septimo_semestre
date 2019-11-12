package main.kotlin.com.jce.vsm.view

import javafx.scene.paint.Color
import javafx.scene.text.FontWeight
import javafx.scene.text.Text
import javafx.scene.text.TextFlow
import main.kotlin.com.jce.vsm.controller.VSMController
import main.kotlin.com.jce.vsm.model.Article
import tornadofx.*

class Result: Fragment("Result") {
    val article: Article by param()

    private var titleTextFlow: TextFlow by singleAssign()
    private var matchTextFlow: TextFlow by singleAssign()
    private var rankingText: Text by singleAssign()

    val controller: VSMController by inject()

    override val root = borderpane {
        top {
            titleTextFlow = textflow {
                text("ID: ${article.number}") {
                    addClass("article-id")
                }
                text(article.title) {
                    addClass("article-title")
                    id = "at"
                }
            }
        }
        center {
            matchTextFlow = textflow()
        }
        bottom {
            rankingText = text("Ranking coefficient: ${article.rankingCoefficient}") { style { fontSize = 8.px } }
        }
        translateXProperty().bind(primaryStage.widthProperty().times(0.05))
    }

    init {
        val (previousText, consequentText) = controller.getSurroundingText(article.content, article.match ?: "")

        with(matchTextFlow) {
            text("(...) $previousText ")
            text(article.match) {
                addClass("article-match")
            }
            text(" $consequentText (...)\n")

            style { fontSize = 12.px }
            prefWidthProperty().bind(primaryStage.widthProperty().times(0.9))
        }
    }
}
