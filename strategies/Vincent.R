# Vincent.R

# Submitted by James Mars (Spring 2025)
#
# Description:
#
# 1. Cooperate in the first round
# 2. For rounds 2-20: TITFORTAT
# 3. Round 21-45: if opponent has cheated less than 8 times switch to simpleton rules (if you cooperate back, i do same thing as last move, even if it mistake. if you cheat back, i do opposite thing as last move, even if it mistake) if opponent cheats 8 times or more then continue with tit for tat
# 4. Round 46-50: cheat every time
#

Vincent = function(ego_past, alter_past, ...) {

    dots = list(...)
    current_round = dots$current_round
    n_rounds = dots$n_rounds

    if (current_round == 1) {

        # cooperate first two rounds
        return(1)

    } else if (current_round <= 20) {

        return(alter_past[current_round - 1])

    } else if (current_round <= 45) {

        past_cheats = sum(alter_past[1:(current_round - 1)] == 0)
        
        if (past_cheats >= 8) 
            return(alter_past[current_round - 1])

        if (alter_past[current_round - 1] == 1) {
            
            return(ego_past[current_round - 1])

        } else {
            
            return(ifelse(ego_past[current_round - 1] == 1, 0, 1))

        }

    } else {

        return(0)

    }

}

### EOF ###