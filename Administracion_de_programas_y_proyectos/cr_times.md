# C times

## Key points
- Perform an activity on less time is more expensive
- Only make sense to reduce the time for the critical activities since they are the ones that may reduce the total time for the project

| Activity | Predecessor | Time | Minimum time | Cost      | Increase per unit of time | Daily cost | New daily cost | New activity cost | Total increment |
| -------- | ----------- | ---- | ------------ | --------- | ------------------------- | ---------- | -------------- | ----------------- | --------------- |
| A        | -           | 3    | 3            | $ 30,000  | -                         |            | -              | -                 | -               |
| B        | -           | 5    | 4            | $ 100,000 | % 70                      | $ 20,000   | $ 34,000       | $ 136,000         | $ 36,000        |
| C        | A, B        | 7    | 5            | $ 77,000  | % 80                      | $ 11,000   | $ 19,800       | $ 118,800         | $ 41,800        |
| D        | A, B        | 4    | 4            | $ 100,000 | % 80                      |            | -              | -                 | -               |
| E        | C           | 3    | 3            | $ 45,000  | -                         |            | -              | -                 | -               |
| F        | D           | 6    | 4            | $ 72,000  | % 75                      |            | -              | -                 | -               |
| G        | E, F        | 2    | 2            | $ 30,000  | -                         |            | -              | -                 | -               |
| H        | E, F        | 7    | 5            | $ 98,000  | % 80                      | $ 14,000   | $ 25,200       | $ 151,200         | $ 53,200        |

- *Daily cost:*
  `Cost / Time`
- *New daily cost:*
  `Cost * (Increase per unit time / 100 + 1)`
- *New activity cost:*
  `New daily cost * Time - (Amount of days to reduce)`
- *Total increment:*
  `New activity cost - Original costs`

  **The critical activity with the least `Total Increment` should be chose for decrement one day in**

**Original total time:** 23 days
**Original total cost:** $ 552,000

**Total time after reducing one day:** 22 days
**Total cost for reducing one day:** $ 588,000

**Total times after reducing two days:** 21 days
**Total cost for reducing two days:** $ 625,400


| Activity | Predecessor | Time | Minimum time | Cost      | Increase per unit of time | Daily cost | New daily cost | New activity cost | Total increment |
| -------- | ----------- | ---- | ------------ | --------- | ------------------------- | ---------- | -------------- | ----------------- | --------------- |
| A        | -           | 3    | 3            | $ 30,000  | -                         |            | -              | -                 | -               |
| B        | -           | 4    | 3            | $ 136,000 | 70                        | $ 34,000   | $ 57800        | $ 173,400         | $ 37,400        |
| C        | A, B        | 7    | 5            | $ 77,000  | 80                        | $ 11,000   | $ 19,800       | $ 118,800         | $ 41,800        |
| D        | A, B        | 4    | 4            | $ 100,000 | 80                        |            | -              | -                 | -               |
| E        | C           | 3    | 3            | $ 45,000  | -                         |            | -              | -                 | -               |
| F        | D           | 6    | 4            | $ 72,000  | 75                        |            | -              | -                 | -               |
| G        | E, F        | 2    | 2            | $ 30,000  | -                         |            | -              | -                 | -               |
| H        | E, F        | 7    | 5            | $ 98,000  | 80                        | $ 14,000   | $ 25,200       | $ 151,200         | $ 53,200        |


## Multiple critical paths example:

    Critical paths = {
        {B, C, E, H},
        {B, D. F, H}
    }

If there are two critical paths, you have to:
1. Check for the cost on activities on both critical paths (B, H)
   Because if a day is reduced in any of these activities, both critical paths are benefited
2. Check on all the possible combinations for activities exclusive for each path {(C + D), (C + F), (E + D), (E + F)}
    Because if two activities, one exclusive of each path, are reduced, then the time for both paths are benefited again

*Note: multiple critical paths are an often pattern*