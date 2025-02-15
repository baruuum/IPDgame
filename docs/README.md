
<br>

## Past Winning Strategies

- Spring, 2024: [**GOB**](https://github.com/baruuum/IPDgame/blob/main/strategies/2024/GOB.R) (submitted by Gracelynn Osei-Bosompem, Sociology)
- Spring, 2025: [**Vincent**](https://github.com/baruuum/IPDgame/blob/main/strategies/Vincent.R) (submitted by James Mars, Economics & Sociology)

<br>

## Rules of the Game

The rules of the iterated prisoner's dilemma are as follows:

1. Each player plays against each other as well as a copy of themselves in a `n_rounds = 50` move iterated prisoners dilemma
2. The whole tournament is run `n_iter = 5` times to reduce stochastic variability
3. The payoff structure is:
    - mutual cooperation: 3 points
    - mutual defection: 1 point,
    - temptation payoff: 5 points,
    - sucker's payoff: 0
4. Three strategies are added by default: `TITFORTAT`, `RANDOM`, and `THEPROF`. If no strategy is able to win against `THEPROF`, `TITFORTAT`, or `RANDOM`, these strategies are iteratively excluded and the tournament rerun. (Unfortunately, no strategy was able to achieve a higher score than `THEPROF` so far.)

<br>

## Scoreboard of Past Tournaments

[Spring 2024](https://github.com/baruuum/IPDgame/blob/main//logs/log2024Spring.log) <br>
[Spring 2025](https://github.com/baruuum/IPDgame/blob/main//logs/log2025Spring.log)

