# roundrobin.R

# round robin tournament
roundrobin = function(strategies, n_rounds, payoff, verbose, pause = 0) {

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
                rr = paste0("DRAW!")
            }

            message(w[1], " vs. ", w[2], " ... ", rr)

        }

        if (verbose && pause > 0) 
            Sys.sleep(pause)

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
