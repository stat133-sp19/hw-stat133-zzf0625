context("Check summary measures")

test_that("function aux_mean returns correct results", {

  expect_equal(aux_mean(10, 0.3),
               3)
  expect_equal(aux_mean(5, 0.3),
               1.5)
  expect_equal(aux_mean(10, 0.5),
               5)
})

test_that("function aux_variance returns correct results", {

  expect_equal(aux_variance(10, 0.3),
               2.1)
  expect_equal(aux_variance(5, 0.3),
               1.05)
  expect_equal(aux_variance(10, 0.5),
               2.5)
})

test_that("function aux_mode returns correct results", {

  expect_equal(aux_mode(10, 0.3),
               3)
  expect_equal(aux_mode(5, 0.3),
               1)
  expect_equal(aux_mode(10, 0.5),
               5)
})

  test_that("function aux_skewness returns correct results", {

    expect_equal(aux_skewness(10, 0.3),
                 0.276)
    expect_equal(aux_skewness(5, 0.3),
                 0.39)
    expect_equal(aux_skewness(10, 0.5),
                 0)
})

  test_that("private function aux_kurtosis produces correct results", {

    expect_equal(aux_kurtosis(10, 0.3),
                 -0.124)
    expect_equal(aux_kurtosis(5, 0.3),
                 -0.248)
    expect_equal(aux_kurtosis(10, 0.5),
                 -0.2)
})
