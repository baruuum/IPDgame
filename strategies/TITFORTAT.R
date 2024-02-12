# TITFORTAT.R

# DEFAULT STRATEGY
#   1. Cooperate on first turn
#   2. Copy what the opponent did last turn

TITFORTAT = function(ego_past, alter_past, ...) {

    dots = list(...)
    current_round = dots$current_round 

    if (current_round == 1) {

        # cooperate in first round
        return(1)

    } else {

        # copy opponents behavior of last round
        return(alter_past[current_round - 1])

    }

}

### EOF ###