# SlowToAngerQuickToForgive.R

# Submitted by Annalysse Melendez (Spring 2026)
#
# Description:
#
# Rounds 1–5: Initial trust-building
#   - For rounds 1, 2, 3, 4, and 5: I always Cooperate (C), regardless of what the opponent does.
#
# From round 6 onward: Core behavior Starting in round 6, my move depends on the opponent’s recent behavior. I keep track of:
#   - The opponent’s move in the immediately previous round (round ).
#   - The opponent’s moves in the two previous rounds (rounds and ).
#   - A punishment flag that, once triggered, means I defect for the rest of the game.
#
# For each round where :
#   - If the punishment flag is ON:
#       - I Defect (D) in round .
#       - The punishment flag, once turned on, stays on for all remaining rounds.
#   - If the punishment flag is OFF, check the last two moves of the opponent:
#       - If the opponent defected in both of the last two rounds (i.e., opponent played D at and D at ):
#           - I Defect (D) in round .
#           - I turn the punishment flag ON, meaning I will defect for all remaining rounds (permanent breakdown of trust).
#   - If the punishment flag is OFF and the opponent did not defect twice in a row:
#       - If the opponent defected in the immediately previous round (D at , but not D at both and ):
#           - I Defect (D) in round (one-step retaliation).
#           - I do not turn on the punishment flag in this case.
#       - Otherwise (if the opponent cooperated in the previous round):
#           - I Cooperate (C) in round .

SlowToAngerQuickToForgive = function(ego_past, alter_past, ...) {

    dots = list(...)
    current_round = dots$current_round
    n_rounds = dots$n_rounds

    if (current_round <= 5) {

        # cooperate on first round
        return(1)

    }  

    # punlishment flag
    pat2 = embed(alter_past[4:(current_round - 1)], 2)[, 2:1, drop = FALSE]
    past_double_defect = any(apply(pat2, 1, function(x) all(x == c(0, 0))))

    # if there is a past double defect, punishment flag is on (and will remain on), and defect
    if (past_double_defect) {

        return(0)

    } else {

        if (alter_past[current_round - 1] == 0) {

            # if opponent defected in the immediately previous round, defect (one-step retaliation)
            return(0)

        } else {

            # otherwise, cooperate
            return(1)

        }

    }

}

### EOF ###