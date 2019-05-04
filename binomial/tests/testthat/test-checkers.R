context("Check checkers")

test_that("check_prob fails with invalid args",{

  expect_true(check_prob(0.3))
  expect_error(check_prob(2))
  expect_error(check_prob(-0.3),
               "p has to be a number betwen 0 and 1")
})

test_that("check_trials fails with invalid args", {

  expect_true(check_trials(10))
  expect_error(check_trials(-10))
  expect_error(check_trials(10.3),
               "trial should be an integer")
})

test_that("check_success fails with invalid args", {

  expect_true(check_success(3, 10))
  expect_error(check_success(-1, 10),
               "invalid success: should be non-negative")
  expect_error(check_success(6, 5),
               "success cannot be greater than trials")
})
