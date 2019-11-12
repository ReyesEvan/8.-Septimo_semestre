package main.kotlin.com.jce.vsm.view

import javafx.scene.control.Button
import javafx.scene.control.ComboBox
import javafx.scene.image.ImageView
import main.kotlin.com.jce.vsm.controller.VSMController
import tornadofx.*

class Home : View("VSM Search Engine") {
    private val currentWidth    = primaryStage.widthProperty()
    private val currentHeight   = primaryStage.heightProperty()

    private val controller: VSMController by inject()

    var homeLogo:           ImageView by singleAssign()
    var querySelector:      ComboBox<Pair<Int, String>> by singleAssign()
    var precisionRecall:    Button by singleAssign()
    var startSearch:        Button by singleAssign()

    override val root = anchorpane {
        homeLogo = imageview("isotype.png")
        querySelector = combobox(controller.selectedQuery)
        precisionRecall = button()
        startSearch = button("Search")
    }

    init {
        with(homeLogo) {
            xProperty().bind(currentWidth?.times(0.3))
            yProperty().bind(currentWidth?.times(0.1))

            fitWidthProperty().bind(currentWidth?.times(0.6))
            fitHeightProperty().bind(currentHeight?.times(0.3))
            isPreserveRatio = true
        }

        with(querySelector) {
            translateXProperty().bind(currentWidth?.times(0.1))
            translateYProperty().bind(homeLogo.yProperty()
                    .add(homeLogo.fitHeightProperty())
                    .add(currentHeight?.times(0.04)))

            prefWidthProperty().bind(currentWidth?.times(0.8))
            prefHeightProperty().bind(currentWidth?.times(0.05))

            items = controller.getQueries()
        }

        with(startSearch) {
            translateXProperty().bind(currentWidth?.times(0.4))
            translateYProperty().bind(querySelector.translateYProperty()
                    .add(querySelector.prefHeightProperty()
                    .add(currentHeight?.times(0.05))))

            prefWidthProperty().bind(currentWidth?.times(0.2))
            prefHeightProperty().bind(currentWidth?.times(0.05))

            usePrefHeight = true

            icon = imageview("search.png") {
                fitHeightProperty().bind(startSearch.prefHeightProperty())
                fitWidthProperty().bind(startSearch.prefWidthProperty().times(0.2))
                isPreserveRatio = true
            }

            isDefaultButton = true
            setOnAction {
                controller.switchScene(this@Home, Results())
                controller.fillResults()
            }

            enableWhen {
                controller.selectedQuery.booleanBinding { it != null }
            }

        }

        with(precisionRecall) {
            translateXProperty().bind(currentWidth?.times(0.78))
            translateYProperty().bind(currentHeight?.times(0.03))

            prefWidthProperty().bind(currentWidth?.times(0.2))
            prefHeightProperty().bind(currentWidth?.times(0.05))

            usePrefHeight = true

            icon = imageview("chart.png") {
                fitHeightProperty().bind(startSearch.prefHeightProperty())
                fitWidthProperty().bind(startSearch.prefWidthProperty().times(0.2))
            }

            setOnAction {
                controller.switchScene(this@Home, Chart())
            }
        }

    }
}
