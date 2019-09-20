# PERT
## Project Evaluation Review Technique

CPM was a deterministic technique, it considered that all the activities' times are fixed; real life is not like that.
PERT assumes a probabilistic method.

In PERT, for each activity are given three times: a minimum time, a maximum time and a regular time

With these three data, a triangular distribution is obtained, but is hard to manage. To address this issue the mean (μ) and the standard deviation (σ) are calculated to transform it into a **normal distribution**.

$μ = (Min + 4 * Reg + Max) / 6$

$σ = sqrt((Min^2 + Max^2 + Reg^2) - (Min * Max + Reg * Min + Reg * Max) / 36)$

### Example

| Activity |  Min  |  Max  |  Reg  | Predecessor |    M |
| :------: | :---: | :---: | :---: | :---------: | ---: |
|    A     |   3   |  11   |   7   |      -      |    7 |
|    B     |   2   |  10   |   6   |      A      |    6 |
|    C     |   4   |   9   |   5   |      A      | 5.50 |
|    D     |   7   |  14   |   9   |    B, C     |  9.5 |

The probability of completing A in 7 days or less P(A <=7) is 50 %


To get probabilities other than the mean one, Z-tables are used, but to get to use them, the normal distribution must be in the form of **standard normal distribution**, i.e., with a mean of 0 and a standard deviation of 1.

We are searching for the probability of finishing activity A in 5 days or less, but our normal distribution has a μ = 7 and a σ = 1.33. so it is required to perform a transformation. In these cases a *Z* value is obtained.

$Z = (X - μ) / σ$

Where X is the value we are trying to obtain. In this case:

$Z = (5 - 7) / 1.33 = -1.50$

Now that the Z value has been gotten the Z-tables can be used. To get the probability is located the cell within the previous value.
In order to obtain probabilities contrary to the ones listed in the table, the complement is calculated.

### Whole project probabilities

To get the mean of the whole project, the mean of the critical activities is obtained
To get the standard deviation of the whole project, the standard deviations of the critical activities are summed

In order to obtain probabilities about the whole project, is required that the mean and the standard deviation of the whole project are obtained first.
