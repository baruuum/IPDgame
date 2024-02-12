# Hesitant.R

# Submitted by Eric Sutton
# Description:
#
#   1. For the first and second turn, always cooperate
#   2. After the second turn, copy the previous move of the opponent up to and including round 49, but not 50
#   3. On round 50: always defect

Hesitant = function(ego_past, alter_past, ...) {

    dots = list(...)
    current_round = dots$current_round
    n_rounds = dots$n_rounds

    if (current_round == 1 || current_round == 2) {

        # cooperate on first two rounds
        return(1)

    } else if (current_round == n_rounds) {

        # defect on last round
        return(0)

    } else {

        # copy opponents behavior of last round
        return(alter_past[current_round - 1])

    }

}

### EOF ###