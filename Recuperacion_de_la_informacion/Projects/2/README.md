# Web Crawler for Retrieval of English-Derived Words

## Crawler
The *crawler.py* module produces a file named **englishHerkunftWords** based on the list of german words in the file **words** or any other specified by the user that are derived from the english.

## Dependencies
This project depends on two external dependencies: an HTML parser and the w3lib library

To install these dependencies is enough to run:

```shell
$ cd german-web-crawler
# pip install -r requirements
```

## Execution

This project supports two ways of start the execution:

```shell
$ cd german-web-crawler
$ python src/crawler.py
```
and
```shell
$ cd german-web-crawler
$ python src/crawler.py <file>
```

The first example will look for a file in `german-web-crawler/resources/words` and iterate over it.
The second way will ask for a file located in the path specified and iterate over that one

## Document Analyzer
This module uses the **englishHerkunftWordsFinal** document and the **articles.csv** file to obtain the ratio of words in the articles that are derived from the english language.

To run:

    python src/docAnalyzer.py
