package main.kotlin.com.jce.vsm.model

import javafx.collections.ObservableList

interface VectorSpaceModelInterface {
    /**
     * Returns the collection of Articles that satisfies the given query.
     * Which must be ordered by its rankingCoefficient
     */
    fun search(query: String): ObservableList<ArticleInterface>

    fun getQueries(): Map<Int, String>
}