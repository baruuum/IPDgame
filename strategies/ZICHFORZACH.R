# ZICHFORZACH.R

# Zach Weiner (Spring 2026)
#
# Description:
#
#   1. Cooperate on first turn
#   2. Copy what the opponent did last turn
#   3. Defect on last turn

ZACH = function(ego_past, alter_past, ...) {

    dots = list(...)
    current_round = dots$current_round

    if (current_round == 1) {

        # cooperate in first round
        return(1)

    } else if (current_round < dots$n_rounds) {

        # copy opponents behavior of last round
        return(alter_past[current_round - 1])

    } else {

        # defect on last round
        return(0)

    }

}

### EOF ###