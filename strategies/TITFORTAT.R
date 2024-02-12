# TITFORTAT.R

TITFORTAT = function(ego_past, alter_past, ...) {

    dots = list(...)
    current_round = dots$current_round 

    if (current_round == 1) {

        return(1)

    } else {

        return(alter_past[current_round - 1])

    }

}
