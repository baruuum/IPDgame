# RANDOM.R

# DEFAULT STRATEGY (added Spring 2024)
#
# Description:
#
#   1. randomly cooperate/defect

RANDOM = function(ego_past, alter_past, ...) {

    # randomly choose between cooperation and defection
    sample(c(1, 0), 1L)

}

### EOF ###