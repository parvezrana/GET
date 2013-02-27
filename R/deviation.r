#' Deviation of curves.
#'
#' @export
deviation <- function(curve_set, measure = 'max') {
    possible_measures <- c('max', 'int2', 'int')

    curve_set <- convert_envelope(curve_set)
    check_residualness(curve_set)

    if (length(measure) != 1L || !(measure %in% possible_measures)) {
        stop('measure must be exactly one of the following: ',
             paste(possible_measures, collapse = ', '))
    }

    if (measure %in% 'max') {
        res <- with(curve_set, list(obs = max(abs(obs)),
                                    sim = apply(abs(sim_m), 2, max)))
    } else if (measure %in% 'int') {
        res <- with(curve_set, list(obs = sum(abs(obs)),
                                    sim = apply(abs(sim_m), 2, sum)))
    } else if (measure %in% 'int2') {
        res <- with(curve_set, list(obs = sum(obs ^ 2L),
                                    sim = apply(sim_m ^ 2L, 2, sum)))
    }

    res <- create_deviation_set(res)
    res
}

#' Check the content validity of a potential deviation_set object.
check_deviation_set_content <- function(deviation_set) {
    possible_names <- c('obs', 'sim')

    n <- length(deviation_set)
    if (n < 1L) {
        stop('deviation_set must have some elements.')
    }
    if (!is.list(deviation_set)) {
        stop('deviation_set must be a list.')
    }

    name_vec <- names(deviation_set)
    if (length(name_vec) != n) {
        stop('Every element of deviation_set must be named.')
    }
    if (!all(name_vec %in% possible_names)) {
        stop('deviation_set should contain exactly these elements: ',
             paste(possible_names, collapse = ', '))
    }

    obs <- deviation_set[['obs']]
    if (length(obs) != 1L) {
        stop('deviation_set[["obs"]] must be a scalar.')
    }
    if (!is.vector(obs)) {
        stop('deviation_set[["obs"]] must be a vector.')
    }
    if (!all(is.numeric(obs)) || !all(is.finite(obs))) {
        stop('deviation_set[["obs"]] must have a finite numeric value.')
    }

    sim <- deviation_set[['sim']]
    if (length(sim) < 1L) {
        stop('deviation_set[["sim"]] must have at least one value.')
    }
    if (!is.vector(sim)) {
        stop('deviation_set[["sim"]] must be a vector.')
    }
    if (!all(is.numeric(sim)) || !all(is.finite(sim))) {
        stop('deviation_set[["sim"]] must have only finite numeric values.')
    }

    deviation_set
}

#' Check the object.
#' @export
check_deviation_set <- function(deviation_set) {
    if (!inherits(deviation_set, 'deviation_set')) {
        stop('deviation_set must have class "deviation_set".')
    }
    check_deviation_set_content(deviation_set)
    deviation_set
}

#' Create a deviation set out of a list in the right form.
create_deviation_set <- function(deviation_set) {
    check_deviation_set_content(deviation_set)
    class(deviation_set) <- 'deviation_set'
    deviation_set
}

#' Check class.
#' @export
is.deviation_set <- function(x) inherits(x, 'deviation_set')
