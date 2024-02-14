# KINDNESS.R

# Submitted by Anya Coretta English
# Description:
#
#   1. For the first round, cooperate
#   2. After the first round, cooperate until the opponent defects for the first time
#   3. After that, play TITFORTAT

KINDNESS = function(ego_past, alter_past, ...) {

    dots = list(...)
    current_round = dots$current_round
    n_rounds = dots$n_rounds

    if (current_round == 1) {

        # cooperate on first two rounds
        return(1)

    } else {

        # 1 if alter ever defected after first round, 0 otherwise
        alter_ever_defect = sum(1 - alter_past[2:(current_round - 1)])

        if (alter_ever_defect == 0) {

            return(1)

        } else {

            # copy opponents behavior of last round
            return(alter_past[current_round - 1])

        }

    }

}

### EOF ###