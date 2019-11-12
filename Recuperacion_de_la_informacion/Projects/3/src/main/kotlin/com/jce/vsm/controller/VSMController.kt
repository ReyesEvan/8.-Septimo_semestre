package main.kotlin.com.jce.vsm.controller

import javafx.collections.ObservableList
import javafx.embed.swing.SwingFXUtils
import javafx.scene.SnapshotParameters
import javafx.scene.chart.Chart
import javafx.scene.chart.LineChart
import main.kotlin.com.jce.vsm.model.VectorSpaceModel
import main.kotlin.com.jce.vsm.view.*
import tornadofx.*
import java.io.File
import javax.imageio.ImageIO
import kotlin.math.max
import kotlin.math.min

class VSMController: Controller() {
    val selectedQuery = objectProperty<Pair<Int, String>>()

    private val resultsView: Results by inject()
    private val vsm = VectorSpaceModel()

    fun switchScene(from: View, to: View) {
        from.replaceWith(to::class, transition = ViewTransition.Metro(1.5.seconds))
    }

    fun getQueries(): ObservableList<Pair<Int, String>> = vsm.getQueries().toList().toObservable()

    fun fillResults() {
        val articles = vsm.search(selectedQuery.value.second)

        resultsView.results.apply {
            children.clear()
            separator()
            for (article in articles.filter { it.rankingCoefficient > 0 }) {
                this += find<Result>(mapOf(Result::article to article))
                separator()
            }
        }
    }

    fun getSurroundingText(text: String, match: String, surroundsLength: Int = 10): Pair<String, String> {
        var previousTerms = ""
        var consequentTerms = ""

        val terms = text.split("[ \n,-]".toRegex())
        val index = terms.indexOf(match)

        if (index != -1) {
            previousTerms = terms.slice(max(0, index - surroundsLength) until index).joinToString(" ")
            consequentTerms = terms.slice(index+1..min(terms.size-1, index + surroundsLength)).joinToString(" ")
        }

        return Pair(previousTerms, consequentTerms)
    }

    fun fillChart(chart: LineChart<Number, Number>, chartsCounter: Int, l1: List<Number>, l2: List<Number>) {
        chart.apply {
            series("P/R $chartsCounter") {
                for ((precision, recall) in l1 zip l2)
                    data(precision, recall)
            }
        }
    }

    fun exportAsSnapshot(chart: Chart) {
        println("Generating snapshot...")
        val image = chart.snapshot(SnapshotParameters(), null)
        val file = File("chart.png")
        try {
            ImageIO.write(SwingFXUtils.fromFXImage(image, null), "png", file)
        } catch (exception: Throwable) {
            println("There was a problem exporting your image")
            println("Please review the path and options")
        }
        println("Snapshot successfully generated!")
    }
}