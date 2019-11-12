package main.kotlin.com.jce.vsm.app

import javafx.scene.image.Image
import javafx.stage.Stage
import main.kotlin.com.jce.vsm.view.*
import tornadofx.*

class Main: App(Home::class) {
    override fun start(stage: Stage) {
        super.start((stage))
        stage.width = 800.0
        stage.height = 600.0
        stage.icons += Image("icon.png")
        importStylesheet("/Style.css")
    }
}

fun main(args: Array<String>) {
    launch<Main>(args)
}