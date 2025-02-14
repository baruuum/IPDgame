# FairPlay.R

# Submitted by Kate Dunn (Spring 2025)
#
# Description:
#
# 1. Start with cooperation.
# 2. If opponent has cheated 6 consecutive times in any point within the 50 rounds, defect except for rounds 25 and 40. In these rounds, go to 3. below
# 3. If opponent is cheating more than 30% of the time, after 15 rounds, switch to tit for tat. If number falls back under 30% or if the current round is prior to the 15th, go to 4.
# 4. Default strategy:
#   a. if stuck in cooperate/defect-loop, defined as CDCD or DCDC where C denotes cooperate and D defect, cheat once and then cooperate
#   b. if not in a cooperate/defect-loop, 
#       i. if the opponent has cheated in the previous round, but not the round prior to it (i.e., one-time cheat), cheat once
#       ii. if the opponent has cheated 2 or more times in the previous 3 rounds, cheat regardless of the whether the opponent has cooperated in the previous round (notice that this happens only if the opponent's pattern is DDC, which implies that there was a "double-defect" at the start of the last three rounds)
#       iii. otherwise cooperate

FairPlay = function(ego_past, alter_past, ...) {

    dots = list(...)
    current_round = dots$current_round
    n_rounds = dots$n_rounds

    if (current_round == 1)
        return(1)

    cheat_sum = sum(alter_past[1:(current_round - 1)] == 0)
    cheat_prop = cheat_sum / (current_round - 1)
    
    if (current_round >= 6) {

        ego_past5 = ego_past[current_round - 1:5]


    }

    if (current_round >= 7) {

        # get longest consecutive run of 0s
        cons = rle(alter_past[1:(current_round - 1)])
        zerovals = which(cons$value == 0)
        max_cons = if(length(zerovals) > 0) max(cons$lengths[zerovals]) else 0            

        if (max_cons >= 6 && current_round %in% c(25, 40) == FALSE)
            return(0)

    }

    if (current_round >= 15 & cheat_prop > .3) {

        return(alter_past[current_round - 1])

    } else if (current_round >= 6 && all(ego_past5[1:4] == c(1, 0, 1, 0))) {

        return(0)

    } else if (current_round >= 6 && all(ego_past5[1:4] == c(0, 1, 0, 1))) {

        if (ego_past5[5] == 0)
            return(1)

        return(0)

    } else {

        if (alter_past[current_round - 1] == 0)
            return(0)
        
        if (current_round >= 3 && sum(alter_past[current_round - 1:3] == 0) >= 2)
            return(0)

        return(1)

    }
        
}

### EOF ###