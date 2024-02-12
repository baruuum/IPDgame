# IPD.R

# iterated prisoner's dilemma
IPD = function(s1, s2, payoff, n_rounds) {

    p1 = numeric(n_rounds)
    p2 = numeric(n_rounds)

    h1 = integer(n_rounds)
    h2 = integer(n_rounds)

    for (current_round in 1:n_rounds) {

        r1 = get(s1)(h1, h2, current_round = current_round, n_rounds = n_rounds)
        r2 = get(s2)(h2, h1, current_round = current_round, n_rounds = n_rounds)

        h1[current_round] = r1
        h2[current_round] = r2

        if (r1 == 1 && r2 == 1) {

            p1[current_round] = p2[current_round] = payoff[1]

        } else if (r1 == 0 && r2 == 0) {

            p1[current_round] = p2[current_round] = payoff[2]

        } else if (r1 == 1 && r2 == 0) {

            p1[current_round] = payoff[4]
            p2[current_round] = payoff[3]

        } else if (r1 == 0 && r2 == 1) {

            p1[current_round] = payoff[3]
            p2[current_round] = payoff[4]

        } else {

            stop("something wrong (the_game)")
        }


    }

    return(
        list(
            player1 = list(payoff = p1, history = h1, strategy = s1),
            player2 = list(payoff = p2, history = h2, strategy = s2)
        )
    )

}
