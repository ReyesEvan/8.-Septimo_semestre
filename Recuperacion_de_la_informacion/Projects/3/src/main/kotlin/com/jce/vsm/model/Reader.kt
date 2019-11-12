package main.kotlin.com.jce.vsm.model
import java.io.File
import kotlin.math.log


class Reader {

    val globalDictionary: HashMap<String, Double>
    val queryMap: HashMap<Int, String>
    val queryDict: HashMap<Int, Set<String>>
    val articleList: List<ArticleInterface>
    val articleDict: HashMap<Int, Set<String>>
    val relMap: HashMap<Int, List<Int>>

    init {
        queryMap = readQueries()
        queryDict = createQueryDict()
        articleList = readArticles()
        articleDict = createArticleDict()
        relMap = readRel()
        globalDictionary = genGlobalDict()

        // Finish init of articles
        articleList.forEach { article ->
            articleDict[article.number]!!.forEach {
                article.termWeights[it] = globalDictionary[it]!!
            }
            article.tokens = article.tokenize()
        }

    }


    private fun readQueries(): HashMap<Int, String> {

        val queries = HashMap<Int, String>()                                                                            // Holds query in ID, STRING format while processing
        val queryRegex = Regex("^\\.I (\\d*\$)\\n^.W\$\\n(^[\\w\\s/,-]+\\.\$)",  RegexOption.MULTILINE)        // Regex format of content we want to filter, with capture groups for both id and content

        //val queryDoc = String(Files.readAllBytes(Path.of("target/classes/cran/cran.qry")))
        var queryDoc = File("target/classes/cran/cran.qry").readText(Charsets.UTF_8)
        // parse queries
        queryDoc = queryDoc.replace("-", " ")
        queryDoc = queryDoc.replace(",", " ")
        queryDoc = queryDoc.replace("'", "")
        queryDoc = queryDoc.replace("/", "")

        // Find all matches of our regex in the document
        //val matches = queryRegex.findAll(".I 001\n.W\nwhat similarity laws must be obeyed when constructing aeroelastic models\nof heated high speed aircraft .\n.I 002\n.W\nwhat are the structural and aeroelastic problems associated with flight\nof high speed aircraft .\n.I 004\n.W\nwhat problems of heat conduction in composite slabs have been solved so\nfar .\n.I 008\n.W\ncan a criterion be developed to show empirically the validity of flow\nsolutions for chemically reacting gas mixtures based on the simplifying\nassumption of instantaneous local chemical equilibrium .\n.I 009\n.W\nwhat chemical kinetic system is applicable to hypersonic aerodynamic\nproblems .\n.I 010\n.W\nwhat theoretical and experimental guides do we have as to turbulent\ncouette flow behaviour .\n.I 012\n.W\nis it possible to relate the available pressure distributions for an\nogive forebody at zero angle of attack to the lower surface pressures of\nan equivalent ogive forebody at angle of attack .\n.I 013\n.W\nwhat methods -dash exact or approximate -dash are presently available\nfor predicting body pressures at angle of attack.")
        val matches = queryRegex.findAll(queryDoc)




        // Add matched substrings to our query map
        for (match in matches.toList()) {
            val(id, content) = match.destructured
            queries[id.toInt()] = content

        }

        return queries
    }

    private fun createQueryDict(): HashMap<Int, Set<String>> {
        val queryDict = HashMap<Int, Set<String>>()
        for ((k, v) in queryMap) {
            val tempSet = mutableSetOf<String>()
            //print("$k:${queryMap[k]}\n")
            val queryString = queryMap[k]!!.replace(".","")
            tempSet.addAll(queryString.split(Regex("\\s")).distinct())
            tempSet.removeAll(setOf(" ", "\n", ""))
            //print("${tempSet.toString()}\n")
            queryDict[k] = tempSet.toSet()
        }
        return queryDict
    }


    private fun readArticles(): List<ArticleInterface> {

        val articles = mutableListOf<ArticleInterface>()

        val articleStrings = mutableListOf<String>()
        val articleRegex = Regex("(?:^\\.I (\\d*$))[\\s\\S]+?(?:\\n^\\.X$)", RegexOption.MULTILINE)
        //val articleRegex = Regex("(?:^\\.I (\\d*\$))(?:\\n^\\.T\$\\n(^[\\w\\s/,-]+\\.\$))?(?:\\n^\\.A\$\\n(^[\\w ,./-]+\\.\$))?(?:\\n^\\.B\$\\n(^[\\w\\s/,.-]+\\.\$))?(?:\\n^\\.W\$\\n(^[\\w\\s.,/-]+\$))?(?:\\n^\\.X\$)", RegexOption.MULTILINE)

        //var articleDoc = File("target/classes/cran/cran.allX").readText(Charsets.UTF_8)
        var articleDoc = File("target/classes/cran/cran.all.1400").readText(Charsets.UTF_8)

        // add delimiters for Regex parsing
        articleDoc = articleDoc.replace(".I", ".X\n.I")
        articleDoc = "$articleDoc\n.X\n"
        // parse articles
        articleDoc = articleDoc.replace("-", " ")
        articleDoc = articleDoc.replace("-", " ")
        articleDoc = articleDoc.replace(",", " ")
        articleDoc = articleDoc.replace("'", "")
        articleDoc = articleDoc.replace("/", "")

        // Find all matches of our regex in the document
        val matches = articleRegex.findAll(articleDoc)


        // Add matched substrings to our article list
        for ((i, match) in matches.toList().withIndex()) {
            //val(id) = match.destructured
            articleStrings.add(i,match.value)
        }


        for ((index,article) in articleStrings.withIndex()) {
            var match: MatchResult?
            match = Regex("(?<=.I )(\\d*)").find(article)
            val i: Int = match?.destructured?.component1()?.toInt() ?: -1
            match = Regex("(?<=\\.T)([\\w\\s.]+?)(?=\\.\\p{Lu})").find(article)
            val t = match?.destructured?.component1() ?: " "
            match = Regex("(?<=\\.A)([.\\w\\s]+?)(?=\\.\\p{Lu})").find(article)
            val a = match?.destructured?.component1() ?: " "
            match = Regex("(?<=\\.B)([\\w\\s.]+?)(?=\\.\\p{Lu})").find(article)
            val b = match?.destructured?.component1() ?: " "
            match = Regex("(?<=\\.W)([\\w\\s.]+?)(?=\\.\\p{Lu})").find(article)
            val w = match?.destructured?.component1() ?: " "

            articles.add(index, Article(i, t, a, b, w))
        }

        return articles.toList()
    }

    private fun createArticleDict(): HashMap<Int, Set<String>> {
        val articleDict = HashMap<Int, Set<String>>()
        for (article in articleList) {
            val tempSet = mutableSetOf<String>()
            val tokenString = "${article.title}${article.content}\n".replace(".", "")
            tempSet.addAll(tokenString.split(Regex("\\s")).distinct())
            tempSet.removeAll(setOf(" ", "\n", "", "\r"))
            //print("${tempSet.toString()}\n")
            articleDict[article.number] = tempSet.toSet()
        }
        return articleDict
    }


    private fun readRel(): HashMap<Int, List<Int>> {

        val relMap = HashMap<Int, MutableList<Int>>()
        val relMapF = HashMap<Int, List<Int>>()

        val articleDoc = File("target/classes/cran/cranqrel").readText(Charsets.UTF_8)
        val relRegex = Regex("^(\\d+) (\\d+) (\\d+)\\s?\$", RegexOption.MULTILINE)

        val matches = relRegex.findAll(articleDoc)

        for (match in matches) {
            val(query, rel, weight) = match.destructured
            if (relMap[query.toInt()] == null) relMap[query.toInt()] = mutableListOf()
            relMap[query.toInt()]!!.add(rel.toInt())
        }

        for (q in relMap) {
            //convert relMap Mutable List to List
            relMapF[q.key] = q.value.toList()
        }

        return relMapF
    }


    private fun genGlobalDict():HashMap<String,Double> {
        val globalDict = HashMap<String, Double>()
        val globalSet = mutableSetOf<String>()
        val numberOfDocuments = articleList.size

        for (entry in queryDict) {
            for (term in entry.value) {
                globalSet.add(term)
            }
        }

        for (entry in articleDict) {
            for (term in entry.value) {
                globalSet.add(term)
            }
        }

        for (term in globalSet.distinct()) {
            globalDict[term] = log( numberOfDocuments.toDouble()/countDocsWith(term), 10.0)
        }


        return globalDict
    }

    private fun countDocsWith(term:String):Int {

        var count = 0
        for ((i, article) in articleDict) {
            if (article.contains(term)) count++
        }

        return count
    }
}//end Reader class
