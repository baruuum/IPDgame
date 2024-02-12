#roundrobin.R

the_game = function(s1, s2, payoff, n_rounds) {

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

roundrobin = function(strategies, n_rounds, payoff, verbose) {

    n = length(strategies)
    encounters = lapply(
        c(
            combn(n, 2, simplify = FALSE),
            lapply(seq_len(n), function(w) rep(w, 2L))
        ),
        function (w) {

            strategies[w]

        }
    )

    results = lapply(encounters, function(w) {

        res = the_game(w[1], w[2], payoff, n_rounds)

        if (verbose) {

            p1 = sum(res$player1$payoff)
            p2 = sum(res$player2$payoff)

            if (p1 > p2) {
                rr = paste0(w[1], " WINS!")
            } else if (p2 > p1) {
                rr = paste0(w[2], " WINS!")
            } else {
                rr = "DRAW!"
            }

            message(w[1], " vs. ", w[2], " ... ", rr)

        }

        return(res)

    })

    summary = do.call("rbind", encounters)
    summary = cbind(
        summary,
        do.call("rbind", lapply(
            results, function(w) {
                c(sum(w$player1$payoff), sum(w$player2$payoff))
            })
        )
    )

    total_payoff = as.data.table(rbind(summary[, c(1, 3)], summary[, c(2, 4)]))
    total_payoff = total_payoff[, sum(as.numeric(V2)), by = V1]
    setnames(total_payoff, c("Strategy", "Payoff"))
    total_payoff = total_payoff[order(-Payoff)]

    summary = as.data.table(summary)
    setnames(summary, c("Strategy1", "Strategy2", "Payoff1", "Payoff2"))

    return(
        list(
            encounters = encounters, results = results, summary = summary, total_payoff = total_payoff
        )
    )

}
