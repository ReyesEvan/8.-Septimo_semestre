# Web Crawler for Retrieval of English-Derived Words

## Crawler V2
The `crawler.py` module produces a file named `englishHerkunftWords` which includes only german nouns that come from the english language along with its plural and some other information.

Unlike the previous project, this one takes a word as a seed and iterate over the links that the same dictionary provides


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
$ python src/crawler.py <word>
```

The first example will start with the first actual word in the german language *Aachen* and iterate from there.
The second way will ask for a german word, it will try to locate it within the dictionary and then it will start iterating the same way. If the word does not exist the program will abort immediately.

This version of the project includes a troubleshoot to detect and propose fixes when it encounters an obstacle. This change was required because it was mandatory for the program to always find the page in order for it to continue.