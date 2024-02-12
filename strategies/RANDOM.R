# RANDOM.R

# DEFAULT STRATEGY
#   1. randomly cooporate/defect

RANDOM = function(ego_past, alter_past, ...) {

    # randomly choose between cooperation and defection
    sample(c(1, 0), 1L)

}

### EOF ###