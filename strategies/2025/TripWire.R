# TripWire.R

# Submitted by D'Andra Nicole (Spring 2025)
#
# Description:
#
# 1. Start with cooperating
# 2. If opponent defects in first three turns, defect on turns 4-6; otherwise keep cooperating
# 3. From turn 7 onwards, play TITFORTAT
#

TripWire = function(ego_past, alter_past, ...) {

    dots = list(...)
    current_round = dots$current_round
    n_rounds = dots$n_rounds

    if (current_round <= 3) {

        return(1)

    } else if (current_round <= 6) {

        if (sum(alter_past[1:3] == 0))
            return(0)

        return(1)

    } else {

        return(alter_past[current_round - 1])

    }

}

### EOF ###