#! THEPROF.R

# Submitted by Barum Park
#
# Rules:
#   1. Cooporate on first round
#   2. Defect on last round
#   3. After the 10th round, try to guess whether the oponent is RANDOM (i.e., unresponsive to my past behavior). If so, defect with p = .75
#   4. Otherwise play TITFORTAT

THEPROF = function(ego_past, alter_past, ...) {

    dots = list(...)
    current_round = dots$current_round
    n_rounds = dots$n_rounds

    if (current_round == 1) {

        # cooperate on first round
        return(1)

    } else if (current_round == n_rounds) {
        
        # defect on last round
        return(0)

    } else {

        # after the first round
        if (current_round > 10) {

            # attempt to assess responsiveness of opponent
            past = ego_past[-length(ego_past)]

            after_coop = which(past == 1) + 1
            after_defect = which(past == 0) + 1

            # calculate conditional prob of cooperating depending on ego's past behavior
            p_coop = mean(alter_past[after_coop])
            p_defe = mean(alter_past[after_defect])

            if (abs(p_coop - p_defe) < .5) {
                
                # if opponent appears unresponsive, defect with prob .75
                u = runif(1)
                if (u < .75)
                    return(0)

            }

        }

        # otherwise (i.e., if opponent appears to be responsive) play titfortat
        return(alter_past[current_round - 1])

    }

}

### EOF ###