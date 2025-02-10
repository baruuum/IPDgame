# GOB.R

# Submitted by Gracelynn Osei-Bosompem (Spring 2024)
#
# Description:
#
#   1. begin with cooperating
#   2. after second defection always defect
#   3. only cooperate again after third cooperation is observed

GOB = function(ego_past, alter_past, ...) {

    dots = list(...)
    current_round = dots$current_round

    if (current_round == 1)
        return(1)

    n_defect = sum(1 - alter_past[1:(current_round - 1)])

    if (n_defect >= 2) {

        last_defect = max(which(alter_past[1:(current_round - 1)] == 0))

        if (sum(alter_past[last_defect:(current_round - 1)]) >= 3) {

            return(1)

        } else {

            return(0)

        }

    } else {

        return(1)

    }



}

### EOF ###