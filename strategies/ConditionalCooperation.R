# ConditionalCooperation.R

# Submitted by Sanya Mahajan (Spring 2026)
#
# Description:
#
#   1. For the first 5 turns: always cooperate 
#   2. For the next 40 turns: 
#       - If the opponent cooperated last turn, cooperate with probability 0.9 and defect with probability 0.1
#       - If the opponent defected last turn, cooperate with probability 0.1 and defect with probability 0.9
#   3. For the last 5 turns: copy what the opponent did in the previous turn

ConditionalCooperation = function(ego_past, alter_past, ...) {

    dots = list(...)
    current_round = dots$current_round
    n_rounds = dots$n_rounds

    if (current_round <= 5) {

        # cooperate on first round
        return(1)

    } else if (current_round > 5 && current_round <= 45) {

        # conditional cooperation phase
        if (alter_past[current_round - 1] == 1) {

            # opponent cooperated last turn
            return(ifelse(runif(1) < 0.9, 1, 0))

        } else {

            # opponent defected last turn
            return(ifelse(runif(1) < 0.1, 1, 0))

        } 

    } else {

        # final 5 rounds: copy opponent's last move
        return(alter_past[current_round - 1])

    }

}

### EOF ###