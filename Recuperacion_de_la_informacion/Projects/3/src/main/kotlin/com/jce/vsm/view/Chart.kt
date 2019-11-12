package main.kotlin.com.jce.vsm.view

import javafx.scene.chart.LineChart
import javafx.scene.chart.NumberAxis
import main.kotlin.com.jce.vsm.controller.VSMController
import main.kotlin.com.jce.vsm.model.VectorSpaceModel
import tornadofx.*
import kotlin.random.Random

class Chart : View("Chart View") {
    private val currentWidth  = primaryStage.widthProperty()
    private val currentHeight = primaryStage.heightProperty()
    private val controller: VSMController by inject()
    private val vsm = VectorSpaceModel()

    var chart: LineChart<Number, Number> by singleAssign()

    private var chartsCounter = 1

    override val root = borderpane {
        top = anchorpane {
            button {
                translateXProperty().bind(currentWidth?.times(0.02))
                translateYProperty().bind(currentHeight?.times(0.01))

                prefWidthProperty().bind(currentWidth?.times(0.2))
                prefHeightProperty().bind(currentWidth?.times(0.05))

                icon = imageview("back.png") {
                    isPreserveRatio = true
                    fitHeightProperty().bind(this@button.prefHeightProperty().times(0.8))
                }

                setOnAction {
                    controller.switchScene(this@Chart, Home())
                }
            }
            button {
                translateXProperty().bind(currentWidth?.times(0.67))
                translateYProperty().bind(currentHeight?.times(0.01))

                prefWidthProperty().bind(currentWidth?.times(0.1))
                prefHeightProperty().bind(currentWidth?.times(0.05))

                icon = imageview("clear.png") {
                    isPreserveRatio = true
                    fitHeightProperty().bind(this@button.prefHeightProperty().times(0.8))
                }

                setOnAction {
                    chart.data.clear()
                    chartsCounter = 1
                }
            }
            button {
                translateXProperty().bind(currentWidth?.times(0.78))
                translateYProperty().bind(currentHeight?.times(0.01))

                prefWidthProperty().bind(currentWidth?.times(0.2))
                prefHeightProperty().bind(currentWidth?.times(0.05))

                icon = imageview("again.png") {
                    isPreserveRatio = true
                    fitHeightProperty().bind(this@button.prefHeightProperty().times(0.8))
                }

                setOnAction {
                    val (precision, recall) = vsm.generateRandomPrecisionRecall(1400, 10)
                    controller.fillChart(chart, chartsCounter++, recall, precision)
                }
            }
        }

        center {
            chart = linechart("Precision - recall relation", NumberAxis(), NumberAxis())
        }

        bottom {
            style { padding = box(0.em, 0.em, 1.em, 0.em) }

            button {
                translateXProperty().bind(currentWidth?.times(0.4))

                prefWidthProperty().bind(currentWidth?.times(0.2))
                prefHeightProperty().bind(currentWidth?.times(0.05))

                icon = imageview("snapshot.png") {
                    isPreserveRatio = true
                    fitHeightProperty().bind(this@button.prefHeightProperty().times(0.8))
                }

                setOnAction {
                    controller.exportAsSnapshot(chart)
                }
            }
        }
    }

    init {
        val (precision, recall) = vsm.generateRandomPrecisionRecall(1400, 10)
        controller.fillChart(chart, chartsCounter++, recall, precision)
    }
}
