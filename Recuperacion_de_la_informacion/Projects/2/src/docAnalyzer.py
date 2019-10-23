import random
import sys

def load_word_list(file_path):
    """This function reads a file of words and returns a list with
    all of them.
    
    @param file_path <str> - A string containing the path of the file that contains all the words.

    @return <list> - A list in which each element is a term."""
    with open(file_path, "r") as file:
        content = file.read()
        return content.split("\n")

def load_articles(file_path):
    """This function reads the articles csv file and returns a list with all the
    articles.
    
    @param file_path <str> - A string containing the path of the csv file.
    
    @return <double> - A the ratio of english derived words in the document to document total words."""

    with open(file_path, encoding="utf8") as file:
        return file.readlines()

def compare_article(articles_path, word_list_path, index):
    english_derived_words = set(load_word_list(word_list_path))
    articles = load_articles(articles_path)

    article = articles[index].split(";")[1]
    clean_article = article.replace("\n", "")
    clean_article = clean_article.split(" ")

    detected_words = [word for word in english_derived_words if word in set(clean_article)]
    ratio = len(detected_words)/len(clean_article)

    return ratio

def compare_random_articles(articles_path, word_list_path, num_of_articles):
    """This function chooses n random articles from the article slist, 
    and computes the ratio of words that are derived from english.
    
    
    @param articles_path <str> - A string containig the path of the csv file where 
    the articles are stored.
    
    @param word_list_path <str> - A string containing the path of the word list that 
    contains a list of german words that are derived from the english

    @param num_of_articles <int> - An Int specifying the number of random articles to compare.

    @return <dict> - A dictionary with the form {article_index : ratio}.
    """
    english_derived_words = set(load_word_list(word_list_path))
    articles = load_articles(articles_path)
    ratios = dict()

    for _ in range(num_of_articles):
        random_index = random.randint(0, len(articles))
        random_article = articles[random_index].split(";")[1]
        random_article_clean = random_article.replace("\n", "")
        random_article_clean = random_article_clean.split(" ")

        detected_words = [word for word in english_derived_words if word in set(random_article_clean)]
        ratio = len(detected_words)/len(random_article_clean)
        ratios.update({random_index: ratio})

    return ratios



if __name__ == "__main__":

    articles = "resources/articles.csv"
    word_list = "resources/englishHerkunftWordsFinal"

    if len(sys.argv) == 2:
        word_list = sys.argv[1]
    

    while(True):
        selection = input("\nSelect an option:\n1. Enter document number\n2. Choose random articles\n3. Exit\n")

        if selection == "1":
            number = int(input("Enter a document number (0-10273):\t"))
            ratio = compare_article(articles, word_list, number)
            print(f"The proportion of english derived words in the document is: {ratio}")

        elif selection == "2":
            number = int(input("Enter the number of random articles to compare:\t"))
            ratios = compare_random_articles(articles, word_list, number)

            for result in ratios:
                ratio = ratios.get(result)
                print(f"The document #{result} has a ratio of:\t{ratio} derived words from english. ")
        elif selection == "3":
            sys.exit()




