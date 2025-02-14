This is a Axelrod-type computer tournament where players play the iterated prisoner's dilemma against each other. 

### Past Winning Strategies

- Spring, 2024: GOB (submitted by Gracelynn Osei-Bosompem)
- Spring, 2025: Vincent (submitted by James Mars)

(Note: so far, no strategy was able achieve higher scores than `THEPROF`)

### Current Rules 

The current rules of the iterated prisoner's dilemma are as follows:

1. Each player plays against each other as well as a copy of themselves in a `n_rounds = 50` move iterated prisoners dilemma
2. The whole tournament is run `n_iter = 5` times to reduce stochastic variability
3. The payoff structure is:
    - mutual cooperation: 3 points
    - mutual defection: 1 point,
    - temptation to defect: 5 points,
    - sucker's payoff: 0
4. Three strategies are added by default: `TITFORTAT`, `RANDOM`, and `THEPROF`

### Log of past tournaments

[Spring 2024](https://github.com/baruuum/IPDgame/blob/main/log2024Spring.log)

