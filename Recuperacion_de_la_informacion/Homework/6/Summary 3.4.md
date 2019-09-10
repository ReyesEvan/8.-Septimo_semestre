# Document feeds

There are documents that are rarely updated

Since each published document has an associated time, published documentsfrom a single source can be ordered in a sequence called adocument feed. A docu-ment feed is particularly interesting for crawlers, since the crawler can easily findall the new documents by examining only the end of the feed.

A push feedalerts the subscriber to new documents.
A pull feed requires the subscriber to check periodically fornew documents;

RSS feeds are accessed just like a traditional web page, using HTTP GET re-quests to web servers that host them. Therefore, some of the crawling techniqueswe discussed before apply here as well, such as using HTTP HEAD requests todetect when RSS feeds change.

Advantages:
- Natural structure to data
- Implies some relationships between data items
- Easy to parse
- Detailed time information
- Single location to look for new data
