#! TITfor1.5TAT.R

# Submitted by Joice Chen (Spring 2024)
#
# Description:
#
#   1. Rounds 1-5: Start with cooperation and play Tit for Tat
#   2. Rounds 6-15: Based on rounds 1-5,
#       if opponent play D more or equal to C, play tit for tat
#       if opponent play C more than D, tit for two tats
#   3. Round 16: Cooperate
#   4. Round 17-20: Tit for tat
#   5. Rounds 21-30: If opponent play D more or equal to C in rounds 16-20, play tit for tat; If opponent play C more than D in rounds 16-20, play tit for two tats
#   6. Round 31: Cooperate
#   7. Rounds 32-35: Tit for tat
#   8. Round 36-50: if opponent play D more than or equal to C in rounds 31-35, play tit for tat for the rest of the game; If opponent play C more than D in rounds 31-35, play tit for two tats for the rest of the game
# 
# Notes:
#   Code was generealized so it works also for more than 50 moves

TITfor1.5TAT = function(ego_past, alter_past, ...) {

    # helper functions
    test_response = function(alter_past, current_round, test_period) {

        if (current_round == test_period[1]) {

            # cooperate in first round of period
            return(1)

        } else if (current_round > test_period[1] && current_round <= test_period[5]) {

            # play TfT in the next 4 rounds
            return(alter_past[current_round - 1])

        }

    }

    eval_response = function(alter_past, current_round, test_period) {

        # get opponents past defections and cooperations for evaluation period
        past = alter_past[test_period]

        # past cooperations/defections in evaluation period (note: cooperation is coded as 1, defection as 0)
        past_c = sum(past)
        past_d = sum(1 - past)

        if (past_d >= past_c) {

            # if more D than C, TfT
            return(alter_past[current_round - 1])

        } else {

            # if more C than D, Tf2T
            short_past = alter_past[c(current_round - 1:2)]

            if (sum(short_past) == 0) {

                return(0)

            } else {

                return(1)

            }

        }

    }

    dots = list(...)
    current_round = dots$current_round
    n_rounds = dots$n_rounds

    # period of test-eval
    n_period = 15

    # remainder
    n_cycles = floor(n_rounds / n_period)
    n_remainder = n_rounds %% n_period

    # get response matrix
    dt = data.table::data.table(
        round = seq_len(n_rounds),
        phase = c(rep(c(rep("test_response", 5), rep("eval_response", 10)), n_cycles), rep("eval_response", n_remainder)),
        cycle = c(rep(1:n_cycles, each = n_period), rep(n_cycles, n_remainder))
    )
    dt[, tstart := min(round), by = cycle]
    dt[, tend:= min(round) + 4, by = cycle]

    # get response
    this = dt[round == current_round]

    return(get(this[[2]])(alter_past, this[[1]], this[[4]]:this[[5]]))

}

### EOF ###