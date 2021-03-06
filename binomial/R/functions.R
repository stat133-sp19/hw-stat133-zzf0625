# a private auxiliary function check_prob() to test if an input prob is a valid probability value (i.e. 0 ≤ p ≤ 1)
check_prob <- function(prob) {
  if (!is.numeric(prob)) {
    stop('invalid prob input: should be a number')
  }
  if (prob < 0 | prob > 1) {
    stop('p has to be a number betwen 0 and 1')
  }
  return (TRUE)
}

# a private auxiliary function check_trials() to test if an input trials is a valid value for number of trials (i.e. n is a non-negative integer)
check_trials <- function(trials) {
  if (!is.numeric(trials)) {
    stop('invalid trial input: should be a number')
  }
  if (!trials%%1 == 0) {
    stop('trial should be an integer')
  }
  if (trials < 0) {
    stop('trial has to be a non-negative number')
  }
  return (TRUE)
}

#a private auxiliary function check_success() to test if an input success is a valid value for number of successes (i.e. 0 ≤ k ≤ n).
check_success <- function(success, trials) {
  if (!is.numeric(success)) {
    stop('invalid success input: should be a number')
  }
  if (prod(success%%1 == 0) != 1) {
    stop('invalid success: should be a integer')
  }
  if (prod(success >= 0) != 1) {
    stop('invalid success: should be non-negative')
  }
  if(prod(success <= trials) != 1) {
    stop('success cannot be greater than trials')
  }
  return (TRUE)
}


# a private auxiliary function aux_mean() that take two arguments: trials and prob, and return the corresponding value from the computed summary measure
aux_mean <- function(trials, prob){
  return(trials*prob)
}

# a private auxiliary function aux_variance() that take two arguments: trials and prob, and return the corresponding value from the computed summary measure
aux_variance <- function(trials, prob) {
  return (trials*prob*(1-prob))
}

# a private auxiliary function aux_mode() that take two arguments: trials and prob, and return the corresponding value from the computed summary measure
aux_mode <- function(trials, prob){
  m <- trials*prob + prob
  if(m%%1 == 0){
    return (c(m, m-1))
  }
  return (floor(m))
}

# a private auxiliary function aux_skewness() that take two arguments: trials and prob, and return the corresponding value from the computed summary measure
aux_skewness <- function(trials, prob) {
  sd <- sqrt(trials*prob*(1-prob))
  return ((1-2*prob)/sd)
}

# a private auxiliary function aux_kurtosis() that take two arguments: trials and prob, and return the corresponding value from the computed summary measure
aux_kurtosis <- function(trials, prob) {
  var <- trials*prob*(1-prob)
  a <- prob*(1-prob)
  return((1-6*a)/var)
}


#' @title Binomial Choose Function
#' @description calculates the number of combinations in which k successes can occur in n trials.
#' @param n the numeric vector of total trials
#' @param k the numeric vector of success
#' @return computed combinations
#' @export
#' @examples
#' bin_choose(10, 3)
bin_choose <- function(n, k){
  if (prod(k <= n) !=1) {
    stop('k cannot be greater than n')
  }
  b <- factorial(k)*factorial(n-k)
  return (factorial(n)/b)
}

#' @title Binomial Probability Function
#' @description calculates the number of combinations in which k successes can occur in n trials
#' @param success the numeric vector of success
#' @param trials the numeric vector of total trials
#' @param prob the numeric vector of probability for success of one single trial
#' @return computed probabilities
#' @export
#' @examples
#' bin_probability(3, 10, 0.5)
bin_probability <- function(success, trials, prob){
  if (!check_trials(trials)) {
    stop('invalid trials value')
  }
  if (!check_prob(prob)) {
    stop('invalid probability value')
  }
  if (!check_success(success, trials)) {
    stop('invalid success value')
  }
  c <- bin_choose(trials, success)
  d <- prob^success * (1-prob)^(trials-success)
  return (c*d)
}

#' @title Binomial Distribution Function
#' @description output a data frame with the probability distribution: sucesses in the first column, probability in the second column
#' @param trials the numeric vector of total trials
#' @param prob the numeric vector of probability for success of one single trial
#' @return the returned output: a data.frame with two classes: c("bindis", "data.frame")
#' @export
#' @examples
#' bin_distribution(10, 0.5)
bin_distribution <- function(trials, prob){
  success <- 0:trials
  probability <- bin_probability(success, trials, prob)
  dat1 <- data.frame(cbind(success, probability))
  class(dat1) <- c("bindis","data.frame")
  return (dat1)
}

#a plotting method function: plot.bindis() that graphs a barplot to display the probability histogram of a binomial distribution object "bindis"
#' @export
plot.bindis <- function(x, ...) {
  prob <- x$probability
  names(prob) <- x$success
  barplot(prob, xlab = "successes", ylab = "probability", main = "Binomial Distribution Barplot")
}

#' @title Binomial Cumulative Function
#' @description output a data frame with both the probability distribution and the cumulative probabilities: sucesses in the first column, probability in the second column, and cumulative in the third column
#' @param trials the numeric vector of total trials
#' @param prob the numeric vector of probability for success of one single trial
#' @return the returned output: a data.frame with two classes: c("bincum", "data.frame")
#' @export
#' @examples
#' bin_cumulative(10, 0.3)
bin_cumulative <- function(trials, prob) {
  dat2 <- bin_distribution(trials, prob)
  dat2$cumulative <- cumsum(dat2$probability)
  class(dat2) <- c("bincum", "data.frame")
  return(dat2)
}

#a plotting method function: plot.bincum() that graphs the cumulative distribution in ab object "bincum"
#' @export
plot.bincum <- function(x, ...) {
  x1 <- x$success
  y <- x$cumulative
  plot(x1, y, xlab = "successes", ylab = "probability", main = "Binomial Cumulative Distribution", type = "o")
}

#' @title Binomial Variable Function
#' @description output an object of class "binvar" with both the probability distribution and the cumulative probabilities: sucesses in the first column, probability in the second column, and cumulative in the third column
#' @param trials the numeric vector of total trials
#' @param prob the numeric vector of probability for success of one single trial
#' @return returned object of a list with named elements: trials and prob
#' @export
#' @examples
#' bin_variable(10, 0.3)
bin_variable <- function(trials, prob){
  if (!check_trials(trials)) {
    stop('invalid trials value')
  }
  if(!check_prob(prob)) {
    stop('invalid probability value')
  }
  list <- list(trials = trials, prob = prob)
  class(list) <- "binvar"
  return(list)
}

#a method function print.binvar() to be able to nicely print the content of an object "binvar"
#' @export
print.binvar <- function(x, ...){
  cat('Binomial Variable:')
  cat('\n\nParameters')
  cat('\n - number of trials: ')
  cat(x$trials)
  cat('\n - prob of success : ')
  cat(x$prob)
  invisible(x)
}

#a method function summary.binvar() to get a full summary description of an object "summary.binvar"
#' @export
summary.binvar <- function(obj, ...){
  t <- obj$trials
  p <- obj$prob
  mean <- aux_mean(t, p)
  var <- aux_variance(t, p)
  mode <- aux_mode(t, p)
  ske <- aux_skewness(t, p)
  kur <- aux_kurtosis(t, p)
  list <- list(trials = t, prob = p, mean = mean, varianec = var, mode = mode, skewness = ske, kurtosis = kur)
  class(list) <- "summary.binvar"
  return(list)
}

#a method function print.binvar() to be able to nicely print the content of an object "summary.binvar"
#' @export
print.summary.binvar <- function(obj, ...){
  cat('Binomial Variable:')
  cat('\n\nParameters')
  cat('\n- number of trials: ')
  cat(obj$trials)
  cat('\n- prob of success : ')
  cat(obj$prob)
  cat('\n\nMeasures')
  cat('\n- mean    : ')
  cat(obj$mean)
  cat('\n- variance: ')
  cat(obj$var)
  cat('\n- mode    : ')
  cat(obj$mode)
  cat('\n- skewness: ')
  cat(obj$skewness)
  cat('\n- kurtosis: ')
  cat(obj$kurtosis)
  invisible(obj)
}

#' @export
bin_mean <- function(trials, prob){
  if (!check_trials(trials)) {
    stop('invalid trials value')
  }
  if (!check_prob(prob)) {
    stop('invalid probability value')
  }
  return(aux_mean(trials, prob))
}

#' @export
bin_variance <- function(trials, prob){
  if (!check_trials(trials)) {
    stop('invalid trials value')
  }
  if (!check_prob(prob)) {
    stop('invalid probability value')
  }
  return(aux_variance(trials, prob))
}

#' @export
bin_mode <- function(trials, prob){
  if (!check_trials(trials)) {
    stop('invalid trials value')
  }
  if (!check_prob(prob)) {
    stop('invalid probability value')
  }
  return(aux_mode(trials, prob))
}

#' @export
bin_skewness <- function(trials, prob){
  if (!check_trials(trials)) {
    stop('invalid trials value')
  }
  if (!check_prob(prob)) {
    stop('invalid probability value')
  }
  return(aux_skewness(trials, prob))
}

#' @export
bin_kurtosis <- function(trials, prob){
  if (!check_trials(trials)) {
    stop('invalid trials value')
  }
  if (!check_prob(prob)) {
    stop('invalid probability value')
  }
  return(aux_kurtosis(trials, prob))
}
