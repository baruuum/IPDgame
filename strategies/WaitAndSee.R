# WaitAndSee.R

# Submitted by Brooks Balkan (Spring 2025)
#
# Description:
#
# 1. Cooperate on the first two turns
# 2. Defect if the opponent defects twice in a row
# 3. Return to cooperate if opponent cooperates after defection
# 

WaitAndSee = function(ego_past, alter_past, ...) {

    dots = list(...)
    current_round = dots$current_round
    n_rounds = dots$n_rounds

    if (current_round <= 2) {

        # cooperate first two rounds
        return(1)

    } else {

        # no of cooperations in alter's last two moves
        p2 = sum(alter_past[current_round - 1:2])

        if (p2 == 0)
            return(0)

        return(1)

    }

}

### EOF ###