This is a Axelrod-type computer tournament where players play the iterated prisoner's dilemma against each other. 

New strategies can be added as `.R` files into the `./strategies` directory. 

Running the `run.R` file will run the tournament. The current rules are

1. each player plays against each other as well as a copy of themselves in a `n_rounds = 50` move iterated prisoners dilemma
2. the whole tournament is run `n_iter = 5` times to reduce stochastic variability
3. The payoff structure is:
    - mutual cooperation: 3 points
    - mutual defection: 1 point,
    - temptation to defect: 5 points,
    - sucker's payoff: 0
