# GameOn.R

# Submitted by Myka Melville (Spring 2025)
#
# Description:
#
# 1. For the first 10 plays "cooperate"
# 2. For the next 20 plays only "defect" on the second play after a previous player's defection (Example: if a player defects on play 12, I would defect on play 14)
# 3. For the 19 plays, "defect" with a probability of .3 and "cooperate" with a probability of .7
# 4. On the last move choose "defect"

GameOn = function(ego_past, alter_past, ...) {

    dots = list(...)
    current_round = dots$current_round

    if (current_round <= 10) {

        return(1)

    } else if (current_round <= 30) {

        # copy opponents behavior of last round
        if (alter_past[current_round - 2] == 0)
            return(0)

        return(1)

    } else if (current_round <= 49) {

        return(as.integer(runif(1) < .7))

    } else {

        return(0)
        
    }

}

### EOF ###