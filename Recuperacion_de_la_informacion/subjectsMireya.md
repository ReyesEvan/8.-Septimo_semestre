# XML Retrieval

## Challenges in XML Retrieval
1. **What to retrieve?** Users do not expect full documents
2. **Indexing units.** To index by leaves? Largest elements? Every single element?
3. **Nested elements.** Nested elements are usually not useful. Discard if so (users don't care, assesors don't judge them relevant)

## Vector space model for XML retrieval
**Dimensions of a vector:** vocabulary terms -> lexicalized trees

**Lexicalized tree**: to split an XML doc into each possibly path (context) without overlapping

**Context resemble:** used to measure similarity between a *query* and a *context*

$CR(c_q, c_d)$ `=` 	${(1+|c_q|)/(1+|c_d|)}$ `if` $c_q$ `matches` $c_d$`;` `otherwise: `$0$

The **query** ***matches*** the **context** if you may turn the former into the latter by inserting additional nodes.

For the final score of a document it is used the huge function of `SimNoMerge(q, d)`

*NoMerge* -> the contexts are kept apart from each other

## INEX

Provides: 
1. Reference collections
2. Set of queries
3. Relevance judgements

**CAS:** contain explicit references to the XML structure. Limit the context to be retrieved.

**CO:** do not consider structure. It is a challenge because any element might be prone to be retrieved if it fulfills the query

## Component coverage
*Evaluates whether the element retrieved is «structurally» correct. Neither **too low or too high**.* 

- (**E**)xact coverage. Information is the main topic. Component has a *meaningful unit of information*
- Too (**S**)mall coverage. Information is the main topic. Component has is not *meaningful*
- Too (**L**)arge coverage. Information is not the main topic.
- (**N**)o coverage. Not a topic.

## Topical relevance
*Evaluates whether the element is structurally ...*

0. Nonrelevant
1. Marginally relevant
2. Fairly relevant
3. Highly relevant

**2S** -> ***fairly relevant** component that is **too small***
**3E** -> ***highly relevant** component with **exact coverage***

# Text classification

*Organization of information for better understanding and interpretations of data*

## Machine learning

Algorithms that **learn patterns** and use them to **make predictions**.

### Types of machine learning algorithms
1. Supervised learning -> it is provided labeled information and a function to learn from it.
2. Unsupervised learning -> no training data is provided.
3. Combines a fraction of labeled and unlabeled data

## Unsupervised algorithms

1. Clustering
It means to group a given set of data points into *clusters* by assigning each point to one of them, where points in each cluster are similar and points among clusters are dissimilar.

### K-means

This is an iterative algorithm for group $N$ points into $k$ clusters

***In:***
- $k$ a set of clusters
- $N$ data points

***Out:***
The $N$ data points assigned to the $k$ clusters

The algorithm works as follows:

1. The $k$ centroids are placed randomly among the data points
2. Each data point is assigned to its *closest* centroid
3. The centroids are updated by moving them to the *mean* of the points in its group.
4. Repeat 2. and 3. until a designed condition is fulfilled 

2. Naive text classification

This method tries to assign each of the given documents to a labeled class based on the match of its terms.

***In:***
- $D$ a collection of documents
- $C$ a collection of classes with their labels 

1. Represent the documents and classes as *weighted term* vectors with the VSM method
2. For each pair of (d, c) calculate its similitude with the formula:
$sim(d, c)= (d · c)/(||d|| × ||c||)
3. Assign to $d$ the $c$ with the highest similitude
3. Assign to $d$ the $c$ with the highest similitude
3. Assign to $d$ the $c$ with the highest similitude

## Supervised algorithms 
