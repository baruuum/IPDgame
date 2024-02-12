#!/usr/bin/env Rscript

### Tournament of iterated prisoner's dilemma

## ------------------------------------------------------------------
## Setup
## ------------------------------------------------------------------

library("data.table")

setwd("/Users/bp522/Dropbox/####_teaching_materials/_Cornell/SOC3490/SOC3490_2024_Spring/readings/week4/game")

set.seed(12345)

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
strategies = gsub("(.+)\\.R", "\\1", dir("strategies"))

# load all strategies
for (s in strategies)
    source(file.path("strategies", paste0(s, ".R")))

# load tournament structure
source(file.path("tournaments", "roundrobin.R"))

## ------------------------------------------------------------------
## Run Tournament
## ------------------------------------------------------------------


results = lapply(seq_len(n_iter), function(w) {

    message("\n\nIteration ", w, " of tournament ---------------------")
    roundrobin(strategies, n_rounds, payoff, verbose = TRUE)

})

tot_payoff = rbindlist(lapply(results, `[[`, "total_payoff"))[
    , .(Total_score = sum(Payoff)), by = "Strategy" 
][
    order(-Total_score)
]

message("\n\n\n\nScore Board:")
print(tot_payoff)
