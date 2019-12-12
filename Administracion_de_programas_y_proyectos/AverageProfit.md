# Average profit

## Exercise 1

*How many batches do I need to buy?*

| I              | $         |
| -------------- | --------- |
| Batch size     | 500 units |
| Batch cost     | $ 10,000  |
| Fixed cost     | $ 25,000  |
| Unit price     | $ 200     |
| Inventory cost | $ 100     |

| Demand | Probability |
| ------ | ----------- |
| 400    | 20 %        |
| 600    | 50 %        |
| 800    | 30 %        |

### 1 batch - 500 units

#### First scenario 

$400 * 200 - 25,000 - 10,000 - 100 * 100 = 35,000$

$35,000 * 0.2 = 7,000$

#### Second scenario

$500 * 200 - 25,000 - 10,000 = 65,000$

$65,000 * 0.8 = 52,000$

### 2 batches - 1000 units

#### First scenario
$400 * 200 - 25000 - 20000 - 600 * 100= -25000$

$-25000 * 0.2 = -5000$

#### Second scenario
$600 * 200 - 25000 - 20000 - 400 * 100= 35000$
$35000 * 0.5 = 17500$

#### Third scenario
800 * 200 - 25000 - 20000 - 200 * 100= 95000
95000 * 0.3 = 28500