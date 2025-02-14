This is a Axelrod-type computer tournament where players play the iterated prisoner's dilemma against each other. 

### Past Winning Strategies

- Spring, 2024: GOB (submitted by Gracelynn Osei-Bosompem)
- Spring, 2025: Vincent (submitted by James Mars)

(Note: so far, no strategy was able achieve higher scores than `THEPROF`)

### Strategies 

New strategies can be added as `.R` files into the `./strategies` directory. 

1. The strategies should functions with the same name as the file (e.g., if the file name is `RANDOM.R`, the function's name should be `RANDOM`)
2. The general signature of the function is `f(ego_past, alter_past, ...)` where
    1. `ego_past` is the history of ego and
    2. `alter_past` is the history of alter with
    3. cooperation being coded as `1` and defection as `0`
3. Currently, the only additional arguments passed via the `...` in the `roundrobin.R` tournament-style are (although other arguments could be added as well) 
    1. `n_rounds`: total moves that are played between the players
    2. `current_round`: which move the current one is

### Games

The game that players play are located in the  `./games` directory, currently it contains the file(s):

1. `IPD.R` (iterated prisoner's dilemma)


### Tournaments 

Other tournament structures can be added into the `./tournaments` directory (e.g., playing on a grid or network). Currently, the directory contains the file(s):

2. `roundrobin`


### Current Rules 

Running the `run.R` file will run the tournament. The current rules are

1. each player plays against each other as well as a copy of themselves in a `n_rounds = 50` move iterated prisoners dilemma
2. the whole tournament is run `n_iter = 5` times to reduce stochastic variability
3. The payoff structure is:
    - mutual cooperation: 3 points
    - mutual defection: 1 point,
    - temptation to defect: 5 points,
    - sucker's payoff: 0

### Dependencies

- `data.table (>= 1.14.9)`
