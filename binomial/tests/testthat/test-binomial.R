context("Check binomial")

test_that("check bin_choose fails with invalid args and returns correct result", {

  expect_error(bin_choose(5, 6),
               "k cannot be greater than n")
  expect_equal(bin_choose(5, 2),
               10)
  expect_equal(bin_choose(5, 1:3),
               c(5, 10, 10))
})

test_that("check bin_probability fails with invalid args and returns corrct results", {

  expect_error(bin_probability(6, 5, 0.3),
               "success cannot be greater than trials")
  expect_equal(bin_probability(2, 5, 0.5),
               0.3125)
  expect_equal(bin_probability(0:2, 5, 0.5),
               c(0.03125, 0.15625, 0.31250))
})

test_that("check bin_distribution fails with invalid args and returns correct results", {

  expect_error(bin_distribution(5, 2),
               "p has to be a number betwen 0 and 1")
  expect_equal(bin_distribution(5, 0.5)$success,
               0:5)
  expect_equal(bin_distribution(5, 0.5)$probability,
               c(0.03125, 0.15625, 0.31250, 0.31250, 0.15625, 0.03125))

})

test_that("check bin_cumulative fails with invalid args and returns correct results", {

  expect_error(bin_cumulative(-5, 2),
               "trial has to be a non-negative number")
  expect_equal(bin_cumulative(5, 0.5)$success,
               0:5)
  expect_equal(bin_cumulative(5, 0.5)$cumulative,
               c(0.03125, 0.18750, 0.50000, 0.81250, 0.96875, 1.00000))
})
