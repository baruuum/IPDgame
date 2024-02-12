# THEPROF.R

THEPROF = function(ego_past, alter_past, ...) {

    dots = list(...)
    current_round = dots$current_round
    n_rounds = dots$n_rounds

    if (current_round == 1) {

        return(1)

    } else if (current_round == n_rounds) {

        return(0)

    } else {

        if (current_round > 10) {

            past = ego_past[-length(ego_past)]

            after_coop = which(past == 1) + 1
            after_defect = which(past == 0) + 1

            p_coop = mean(alter_past[after_coop])
            p_defe = mean(alter_past[after_defect])

            if (abs(p_coop - p_defe) < .5) {

                u = runif(1)
                if (u < .75) 
                    return(0)

            }

        }

        return(alter_past[current_round - 1])

    }

}
