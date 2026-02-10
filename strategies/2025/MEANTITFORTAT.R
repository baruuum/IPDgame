# MEANTITFORTAT.R

# Submitted by Mariana Meriles (Spring 2025)
#
# Description:
#
#   1. Cooperate on first round
#   2. Defect on second round
#   3. Thereafter, copy what the opponent did last turn
#

MEANTITFORTAT = function(ego_past, alter_past, ...) {

    dots = list(...)
    current_round = dots$current_round

    if (current_round == 1) {

        return(1)

    } else if (current_round == 2) {

        return(0)

    } else {

        # copy opponents behavior of last round
        return(alter_past[current_round - 1])

    }

}

### EOF ###