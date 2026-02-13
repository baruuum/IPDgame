# TheCasualDefector.R

# Submitted by Cassidy Mitchell (Spring 2025)
#
# Description:
#
#   1. First turn, always cooperate.
#   2. For even rounds 2-40 (2, 4, 6,... 38, 40), copy the most previous move of the opponent.
#   3. For odd rounds 3-39 (3, 5, 7,... 37, 39), always defect.
#   4. For rounds 41-46, cooperate with probability equal to the proportion of previous turns at which the opponent cooperated.
#   5. For rounds 46-50, always defect.

TheCasualDefector = function(ego_past, alter_past, ...) {

    dots = list(...)
    current_round = dots$current_round
    n_rounds = dots$n_rounds

    if (current_round == 1) {

        # cooperate first round
        return(1)

    } else if (current_round %% 2 == 0 && current_round <= 40) {

        # titfortat
        return(alter_past[current_round - 1])

    } else if (current_round %% 2 == 1 && current_round <= 40) {

        # defect
        return(0)

    } else if (current_round > 40 && current_round <= 45)  {

        # proportion with which opponent cooperated
        est_p = mean(alter_past[1:(current_round - 1L)])
        # cooperate with prob est_p
        return(as.integer(runif(1) < est_p))

    } else {

        # defect
        return(0)

    }

}

### EOF ###