import random

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
    
    @return <list> - A list in which each element is an article of the file."""

    with open(file_path, encoding="utf8") as file:
        return file.readlines()

def compare_article(articles_path, word_list_path):
    """This function chooses 5 random articles from the article slist, 
    and computes the ratio of words that are derived from english.
    
    
    @param articles_path <str> - A string containig the path of the csv file where 
    the articles are stored.
    
    @param word_list_path <str> - A string containing the path of the word list that 
    contains a list of german words that are derived from the english

    @return <dict> - A dictionary with the form {article_index : ratio}.
    """

    english_derived_words = set(load_word_list(word_list_path))
    articles = load_articles(articles_path)
    ratios = dict()

    for _ in range(5):
        random_index = random.randint(0, len(articles))
        random_article = articles[random_index].split(";")[1]
        random_article_clean = random_article.replace("\n", "")
        random_article_clean = random_article_clean.split(" ")

        detected_words = [word for word in english_derived_words if word in random_article]
        ratio = len(detected_words)/len(random_article_clean)
        ratios.update({random_index: ratio})

    return ratios


if __name__ == "__main__":
    print(compare_article("resources/articles.csv", "resources/sample"))



