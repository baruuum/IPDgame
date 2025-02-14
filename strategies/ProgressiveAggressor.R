# ProgressiveAggressor.R

# Submitted by James Spokes (Spring 2025)
#
# Description:
#
# 1. Turns 1-10:
#     Always Cooperate
# 2. Turns 11-25:
#     Cooperate if they cooperated in the previous round
#     If the previous turn was defection, defect at the probability given by ((total number of defections/2)/total number of turns)
# 3. Turns 26-40:
#     If they have defected 75% of the time or more at this point, always defect otherwise follow the bullet below until the 75% threshold is reached
#     If the previous turn was defection, defect at the probability given by 1-((total number of defections/2)/total number of turns), otherwise cooperate
# 4. Turns 41-50: Full Defection Mode
#     Defect every turn, no matter what.
#

ProgressiveAggressor = function(ego_past, alter_past, ...) {

    dots = list(...)
    current_round = dots$current_round
    n_rounds = dots$n_rounds

    if (current_round <= 10) {

        # cooperate 
        return(1)

    } else if (current_round <= 25) {
        
        p1 = alter_past[current_round - 1]
        
        if (p1 == 1)
            return(1)

        # no of past defects
        pd = sum(alter_past[1:(current_round - 1)] == 0)
        return(as.integer(runif(1) < pd / (2 * (current_round - 1))))

    } else if (current_round <= 40) {

        p_defect = sum(alter_past[1:(current_round - 1)] == 0) / (current_round - 1)
        
        if (p_defect > .75)
            return(0)
        
        if (alter_past[current_round - 1] == 0)
            return(0)

        return(as.integer(runif(1), 1 - p_defect / 2))

    } else {

        # defect
        return(0)

    }

}

### EOF ###