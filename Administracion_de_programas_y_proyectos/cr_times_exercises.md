| Activity | Predecessor | Time | Minimum time | Cost     | Increase per unit of time | Daily cost   | New daily cost | New activity cost | Total increment |
| -------- | ----------- | ---- | ------------ | -------- | ------------------------- | ------------ | -------------- | ----------------- | --------------- |
| A*       | -           | 3    | 1            | $ 10,000 | 95                        | $ 3,333.33   | $6500          | $ 13000           | $ 3000          |
| B*       | A           | 6    | 1            | $ 30,000 | 80                        | $ 5,000      | $9000          | $ 45000           | $ 15000         |
| C        | A           | 4    | 1            | $ 28,000 | 77                        |              |                |                   |                 |
| D*       | B, C        | 7    | 1            | $ 27,000 | 85                        | $ 3,857.1428 | $7136          | $ 42804           | $ 15816         |
| E        | B, C        | 3    | 1            | $ 30,000 | 90                        |              |                |                   |                 |
| F*       | D, E        | 8    | 1            | $ 64,000 | 90                        | $ 8,000      | $15200         | $ 106400          | $ 42400         |
| G*       | F           | 6    | 1            | $ 30,000 | 85                        | $ 5,000      | $9250          | $ 46250           | $ 16250         |
| H*       | F           | 6    | 1            | $ 36,000 | 80                        | $ 6,000      | $10800         | $ 54000           | $ 18000         |
| I*       | G, H        | 7    | 1            | $ 49,000 | 80                        | $ 7,000      | $12600         | $ 75600           | $ 26600         |
| I        | G, H        | 4    | 1            | $ 24,000 | 75                        |              |                |                   |                 |


## Critical paths: 
{A, B, D, F, G, I}
{A, B, D, F, H, I}

For C to become a critical activity, B's time has to be reduced to end at the same time than C (2 days).
The cost of B in 6 days is $ 30,000
The cost of B in 5 days is $ 45,000
The cost of B in 4 days is $ 64,800

The total cost of reducing B 2 days was $ 34,800 (the difference among the costs in 6 and 4 days, respectively)