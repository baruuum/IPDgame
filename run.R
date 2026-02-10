#!/usr/bin/env Rscript

### Tournament of iterated prisoner's dilemma

## ------------------------------------------------------------------
## Setup
## ------------------------------------------------------------------

library("data.table")

set.seed(42)

# number of rounds
n_rounds = 50

# number of iterations
n_iter = 5

# pay off structure
payoff = c(
    mutual_cooperation = 3,
    mutual_defection   = 1,
    temptation         = 5,
    sucker             = 0
)

# strategies
strategies = gsub("(.+)\\.R", "\\1", grep(".+\\.R", dir("strategies"), value = TRUE))

# load all strategies
for (s in strategies)
    source(file.path("strategies", paste0(s, ".R")))

past_years = grep("[0-9]{4}", dir("strategies"), value = TRUE)
for (yy in past_years) {

    past_strategies = gsub("(.+)\\.R", "\\1", grep(".+\\.R", dir(file.path("strategies", yy)), value = TRUE))

    for (s in past_strategies)
        source(file.path("strategies", yy, paste0(s, ".R")))
    
    strategies = c(strategies, past_strategies)
        
}

stopifnot(all(!duplicated(strategies)))
n_strategies = length(strategies)

# load tournament structure
source(file.path("tournaments", "roundrobin.R"))
source(file.path("games", "IPD.R"))

# select game
the_game = IPD

if (!exists("the_game"))
    stop("Need to define 'the_game'!")



## ------------------------------------------------------------------
## Run Tournament
## ------------------------------------------------------------------

results = lapply(seq_len(n_iter), function(w) {

    message("\n\nIteration ", w, " of tournament --------------------------\n")
    res = roundrobin(strategies, n_rounds, payoff, verbose = TRUE, pause = .001)

    Sys.sleep(1)

    return(res)

})

tot_payoff = rbindlist(lapply(results, `[[`, "total_payoff"))[
    , .(Average_Score = mean(Payoff)), by = "Strategy"
][
    order(-Average_Score)
]

message("\n\n\nScore Board:")
print(tot_payoff)
message("\n")
message("All temptation: ", payoff["temptation"] * n_rounds * n_strategies)
message("All mutual cooperation: ", payoff["mutual_cooperation"] * n_rounds * n_strategies)
message("All mutual defection: ", payoff["mutual_defection"] * n_rounds * n_strategies)

### EOF ###