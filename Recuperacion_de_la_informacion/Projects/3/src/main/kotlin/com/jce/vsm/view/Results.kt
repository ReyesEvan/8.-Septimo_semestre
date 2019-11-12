package main.kotlin.com.jce.vsm.view

import javafx.scene.Cursor
import javafx.scene.control.Button
import javafx.scene.control.ComboBox
import javafx.scene.image.ImageView
import javafx.scene.layout.VBox
import main.kotlin.com.jce.vsm.controller.VSMController
import tornadofx.*

class Results : View("Search results") {
    private val currentWidth  = primaryStage.widthProperty()
    private val currentHeight = primaryStage.heightProperty()

    private val controller: VSMController   by inject()

    var resultsLogo:        ImageView           by singleAssign()
    var querySelector:      ComboBox<Pair<Int, String>>    by singleAssign() // TODO: Change to String
    var searchAgain:        Button              by singleAssign()
    var clearResults:        Button              by singleAssign()
    var precisionRecall:    Button              by singleAssign()
    var results:            VBox                by singleAssign()

    override val root = borderpane {
        top = anchorpane {
            resultsLogo = imageview("logo.png")
            querySelector = combobox(controller.selectedQuery)
            searchAgain = button()
            clearResults = button()
            precisionRecall = button()
        }

        center {
            scrollpane {
                results = vbox {
                    spacing = 10.0
                }
            }
        }
    }

    init {
        with(resultsLogo) {
            fitHeightProperty().bind(currentHeight?.times(0.08))
            fitWidthProperty().bind(currentWidth?.times(0.15))
            isPreserveRatio = true
            setOnMouseClicked {
                controller.switchScene(this@Results, Home())
            }
            style {
                cursor = Cursor.HAND
            }
        }

        with(querySelector) {
            translateXProperty().bind(currentWidth?.times(0.18))

            prefWidthProperty().bind(currentWidth?.times(0.58))
            prefHeightProperty().bind(currentHeight?.times(0.075))

            items = controller.getQueries()
        }

        with(searchAgain) {
            translateXProperty().bind(currentWidth?.times(0.78))

            prefWidthProperty().bind(currentWidth?.times(0.06))
            prefHeightProperty().bind(currentHeight?.times(0.07))

            icon = imageview("search.png") {
                fitHeightProperty().bind(searchAgain.prefHeightProperty().times(0.8))
                isPreserveRatio = true
            }

            setOnAction {
                controller.fillResults()
            }

            enableWhen {
                controller.selectedQuery.booleanBinding { it != null  }
            }
        }

        with(clearResults) {
            translateXProperty().bind(currentWidth?.times(0.85))

            prefWidthProperty().bind(currentWidth?.times(0.06))
            prefHeightProperty().bind(currentHeight?.times(0.07))

            icon = imageview("clear.png") {
                fitHeightProperty().bind(searchAgain.prefHeightProperty().times(0.8))
                isPreserveRatio = true
            }

            setOnAction {
                results.children.clear()
                controller.selectedQuery.set(null)
            }
        }

        with(precisionRecall) {
            translateXProperty().bind(currentWidth?.times(0.92))

            prefWidthProperty().bind(currentWidth?.times(0.06))
            prefHeightProperty().bind(currentHeight?.times(0.07))

            icon = imageview("chart.png") {
                fitHeightProperty().bind(precisionRecall.prefHeightProperty().times(0.8))
                isPreserveRatio = true
            }

            setOnAction {
                controller.switchScene(this@Results, Chart())
            }
        }
    }
}


