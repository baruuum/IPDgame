# SOLVER.R

# Submitted by Sophie Chiang (Spring 2026)
#
# Description:
#
#   1. Turn 1: Cooperate
#   2. Turns 2-38: 
#       - If opponent cooperated last turn, cooperate
#       - If opponent defected last turn, defect
#       - If opponent defects two turns in a row, defect every turn until the opponent cooperates two turns in a row. Then go back to normal (the past two bullets)
#       - If the opponent’s last 6 moves were exactly D,C,D,C,D,C or C,D,C,D,C,D, then defect for the rest of the game.
#   3.  Turns 39-50:
#       - Defect by default. BUT if opponent has never defected twice in a row in the game and has cooperated for the last 3 turns entering turn 39, cooperate for the rest of the game
#       - If opponent defects at any point, defect for the rest of the game.
SOLVER = function(ego_past, alter_past, ...) {

    dots = list(...)
    current_round = dots$current_round
    n_rounds = dots$n_rounds

    # cooperate on first round, unconditionally
    if (current_round == 1) {

        return(1)

    } 


## ------------------------------------------------------------------
## Triggers 
## ------------------------------------------------------------------

    # check for patterns that take precedence over others
    global_trigger = FALSE
    local_trigger = FALSE
    local_trigger_2 = FALSE

    if (current_round > 2 & current_round <= 38) {

        # history
        pvec = alter_past[1:(current_round - 1)]
        
        pat2 = embed(pvec, 2)[, 2:1, drop = FALSE]
        double_defect = which(apply(pat2, 1, function(x) all(x == c(0, 0))))

        if (length(double_defect) == 0) {

            local_trigger = FALSE

        } else {

            last_double_defect = max(double_defect)
            
            if (last_double_defect %in% c(current_round - 1, current_round - 2)) {

                local_trigger = TRUE

            } else {

                # check if opponent has cooperated two turns in a row since last double defect
                pat2_after = embed(pvec[last_double_defect:(current_round - 1)], 2)[, 2:1, drop = FALSE]
                coop_after = which(apply(pat2_after, 1, function(x) all(x == c(1, 1))))

                if (length(coop_after) > 0) {
                    local_trigger = FALSE
                } else {
                    local_trigger = TRUE    
                }

            }
            
        }

        # check for global trigger
        if (current_round > 6) {

            patterns = list(c(0, 1, 0, 1, 0, 1), c(1, 0, 1, 0, 1, 0))
            pat6 = embed(pvec, 6)[, 6:1, drop = FALSE]
            global_trigger = any(apply(pat6, 1, function(x) all(x == patterns[[1]]) | all(x == patterns[[2]])))

        }

        if (current_round > 38) {

            # check if opponent has cooperated for the last 3 turns entering turn 39 & never defected twice in a row
            if (all(alter_past[(current_round - 3):(current_round - 1)] == 1) & !any(apply(embed(alter_past, 2)[, 2:1, drop = FALSE], 1, function(x) all(x == c(0, 0))))) {

                local_trigger_2 = TRUE

            }

        }

    }

## ------------------------------------------------------------------
## Strategy (conditional)
## ------------------------------------------------------------------

    if (global_trigger) { 

        # if condition 2.d is triggered, defect
        return(0)

    } 
        
    if (current_round >= 2 && current_round <= 38) {

        if (local_trigger) {

            # if condition 2.c is triggered, defect
            return(0)

        } else {
            
            # otherwise, play titfortat
            return(alter_past[current_round - 1])

        }

    } 

    if (current_round > 38) {

        if (local_trigger_2 & all(alter_past[39:(current_round - 1)] == 1)) {

            return(1)

        }

        return(0)

    }

}

### EOF ###