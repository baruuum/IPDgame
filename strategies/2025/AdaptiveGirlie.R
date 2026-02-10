# AdaptiveGirlie.R

# Submitted by Fatou Sowe (Spring 2025)
#
# Description:
#
# 1. Rounds 1-5: Cooperate to build trust.
# 2. Rounds 6-15:
#     Defect every round if the opponent has defected at least twice in the previous 5 rounds. 
#     Otherwise, keep cooperating.
# 3. Rounds 16-35: Switch to probabilistic cooperation:
#     If my opponent’s cooperation rate is above 0.7, cooperate 90% of the time and defect 10%.
#     If my opponent’s cooperation rate is below 0.7, cooperate 40% of the time and defect 60%.
# 4. Rounds 36-39:
#     If my opponent defected more than once in the previous 5 rounds, defect all rounds. 
#     If not, cooperate all rounds.
# 5. Rounds 40-44:
#     If my opponent defected more than once in the previous 5 rounds, defect.
#     If not, cooperate.
# 6. Rounds 45-50:
#     If my opponent has cooperated at least 7 times in the previous 10 rounds, cooperate.
#     If not, defect every round. 
#

AdaptiveGirlie = function(ego_past, alter_past, ...) {

    dots = list(...)
    current_round = dots$current_round
    n_rounds = dots$n_rounds

    if (current_round <= 5) {

        # cooperate 
        return(1)

    } else if (current_round <= 15) {
        
        if (sum(alter_past[1:5] == 0) >= 2)
            return(0)
        
        return(1)

    } else if (current_round <= 35) {

        p_coop = sum(alter_past[1:(current_round - 1)] == 1) / (current_round - 1)
        
        if (p_coop > .7)
            return(ifelse(runif(1) < .9, 1, 0))
        
        return(ifelse(runif(1) < .4, 1, 0))

    } else if (current_round <= 39) {

        if (sum(alter_past[31:35] == 0) > 1)
            return(0)

        return(1)

    } else if (current_round <= 44) {

        if (sum(alter_past[35:39] == 0) > 1)
            return(0)

        return(1)

    } else {

        if (sum(alter_past[35:44] == 1) >= 7)
            return(1)

        return(0)

    }

}

### EOF ###