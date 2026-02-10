# FRPM.R

# Submitted by Yusuf Khadir (Spring 2025)
#
# Description:
#
# 1. Always cooperate in the first five rounds of the competition. On the sixth round, determine the pattern to follow for 6-50 as follows:
# 2. If the opponent cooperated for all 5 initial rounds, then always cooperate.
# 3. If the opponent defected for all 5 initial rounds, then always defect.
# 4. Otherwise, loop the opponent's move pattern from the first five rounds but with a 20% chance of flipping the first play for each iteration. For example, if the opponent played CDCDD, then play RDCDD in a pattern for the rest of the game where R is 80% likely to be C and 20% to be D with each loop.

FRPM = function(ego_past, alter_past, ...) {

    dots = list(...)
    current_round = dots$current_round
    n_rounds = dots$n_rounds

    if (current_round <= 5) {

        # cooperate first round
        return(1)

    } else {

        p5 = alter_past[1:5]
        n_coop = sum(p5)

        if (n_coop == 5)
            return(1)

        if (n_coop == 0)
            return(0)

        shuffled_loop = if (runif(1) < .2) p5 else c(ifelse(p5[1] == 1, 0, 1), p5[2:5])
        return(shuffled_loop[(current_round - 1) %% 5 + 1])

    }
}

### EOF ###