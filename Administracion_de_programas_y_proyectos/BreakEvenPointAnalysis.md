# Break-even point analysis

$Revenue = Price(Q)$

$TotalCost = FixedCost + VariableCost(Q)$

$Profit = Revenue - TotalCost$

## Exercise 1
*How many pieces do I need to sell to break even?*

| Task               | Price         |
| ------------------ | ------------- |
| Rent               | $ $30k/month$ |
| Raw material       | $ $100/piece$ |
| Salaries           | $ $20k/month$ |
| Selling price      | $ $700/piece$ |
| Manufacturing cost | $ $300/piece$ |


$TotalCost = FixedCost[30k + 20k] + VariableCost(Q) [100 + 300]$

$TotalCost = 50,000 + 400Q$

$Profit [0] = Price(Q) [700Q] - TotalCost [50,000 + 400Q]$

$700Q = 50,000 + 400(Q)$

$50,000 + 400Q - 700Q = 0$

$50,000 - 300Q = 0$

$50,000 = 300Q$

$Q = 167$
*//it is round to ceil because you cannot produce a fraction of a product*

***Break even point* means the minimum amount of sold pieces required to reach the investment.**


## Exercise 2

*How many pieces fo I need to sell to make a 50,000 profit?*

$50,000 = Price(Q) - (FixedCost + VariableCost(Q))$

$50,000 = 700Q - (50,000 + 400Q)$

$50,000 = 300Q - 50,000$

$50,000 + 50,000 = 300Q$

$100,000 = 300Q$

$Q = 100,000/300 = 334$

---

So far, we have assumed that every manufactured piece is sold. However, this ain't generally true.
For this example, we are assuming that 15 % of the manufactured pieces won't make it to the market because of quality control stuff.

## Exercise 3

*How many units do I need to sell to break even?*

| Task               | Price         |
| ------------------ | ------------- |
| Rent               | $ $30k/month$ |
| Raw material       | $ $100/piece$ |
| Salaries           | $ $20k/month$ |
| Selling price      | $ $700/piece$ |
| Manufacturing cost | $ $300/piece$ |
| Quality control    | $5\%$        |

$K$: Units you sell

$Q$: Units you make

$700Q*0.95 - (50,000 + 400Q) = 0$
//it is multiplied by 0.95 because five percent of the produced items are not sold

$665Q - 50,000 - 400Q = 0$

$265Q = 50,000$

$Q = 50,000/265$

$Q = 189$

$K = 188.67 * 0.95$

$K = 180$

## Exercise 4
*Now make 80,000 profit*

$700Q*0.95 - (50,000 + 400Q) = 80,000$

$665Q - 50,000 - 400Q = 80,000$

$265Q = 130,000$

$Q = 130,000/265$

$Q = 491$

$K = 490.56 * 0.95 = 467$