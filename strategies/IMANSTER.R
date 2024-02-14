# IMANSTER.R

# Submitted by Imani Rezaka (Spring 2024)
#
# Description:
#
#   1. Start with defection
#   2. Play tot for two tats

IMANSTER = function(ego_past, alter_past, ...) {

    dots = list(...)
    current_round = dots$current_round
    n_rounds = dots$n_rounds

    if (current_round == 1) {

        # defect on first round
        return(0)

    } else {

        # TIT for 2 TAT
        short_past = alter_past[c(current_round - 1:2)]

        if (sum(short_past) == 0) {

            return(0)

        } else {

            return(1)

        }


    }

}

### EOF ###