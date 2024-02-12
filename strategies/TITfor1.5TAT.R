#! TITfor1.5TAT.R

# Submitted by Joice Chen
#
# Rules:
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

# helper function
eval_response = function(alter_past, current_round, eval_period) {

    # get opponents past defections and cooperations for evaluation period
    past = alter_past[eval_period]

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

TITfor1.5TAT = function(ego_past, alter_past, ...) {

    dots = list(...)
    current_round = dots$current_round
    n_rounds = dots$n_rounds

    if (current_round == 1) {

        # cooperate in first round
        return(1)

    } else if (current_round > 1 && current_round <= 5) {

        # play TfT in first 5 rounds
        return(alter_past[current_round - 1])

    } else if (current_round >= 6 && current_round <= 15) {

        eval_response(alter_past = alter_past, current_round = current_round, eval_period = 1:5)

    } else if (current_round == 16) {

        # cooperate on round 16
        return(1)

    } else if (current_round >= 17 && current_round <= 20) {

        # play TfT in rounds 17-20
        return(alter_past[current_round - 1])

    } else if (current_round >= 21 && current_round <= 30) {

        # evaluate rounds 16-20 and play either TfT or Tf2T
        eval_response(alter_past = alter_past, current_round = current_round, eval_period = 16:20)

    } else if (current_round == 31) {

        # cooperate on round 31
        return(1)

    } else if (current_round >= 32 && current_round <= 35) {

        # play TfT in rounds 32-35
        return(alter_past[current_round - 1])

    } else if (current_round >= 36 && current_round <= 50) {

        # evaluate rounds 31-35 and play either TfT or Tf2T
        eval_response(alter_past = alter_past, current_round = current_round, eval_period = 31:35)

    } else {

        stop("something missing!")

    }

}

### EOF ###