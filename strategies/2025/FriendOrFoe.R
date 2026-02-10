# FriendOrFoe.R

# Submitted by Justin Gonzalez (Spring 2025)
#
# Description:
#
# 1. In the five rounds cooperate.
# 2. In rounds 6-10 cooperate with a probability of 0.4 and defect with a probability of 0.6.
# 3. For rounds 11-20 cooperate based on the probability of the first 10 rounds. If the opponent cooperated 60% or more continue cooperating. If less than 60% continue defecting. 
# 4. For rounds 21-30 if the opponent cooperated 75% or more continue cooperating. If less than 75% continue defecting.
# 5. For rounds 31-50 if the opponent cooperated 85% or more continue cooperating. If less than 85% continue defecting until the last round. 
FriendOrFoe = function(ego_past, alter_past, ...) {

    dots = list(...)
    current_round = dots$current_round
    n_rounds = dots$n_rounds

    if (current_round <= 5) {

        # cooperate first round
        return(1)

    } else if (current_round <= 10) {

        # cooperate with probability .4
        return(as.integer(runif(1) < .4))

    } else if (current_round <= 20) {

        # cooperate if opponent cooperated in first 10 rounds more than 60%
        est_p = mean(alter_past[1:10])
        return(as.integer(est_p >= .6))

    } else if (current_round <= 30)  {

        # proportion with which opponent cooperated
        est_p = mean(alter_past[1:(current_round - 1L)])
        # cooperate with prob est_p
        return(as.integer(est_p > .75))

    } else {

        # proportion with which opponent cooperated
        est_p = mean(alter_past[1:(current_round - 1L)])
        # cooperate with prob est_p
        return(as.integer(est_p > .85))

    }

}

### EOF ###