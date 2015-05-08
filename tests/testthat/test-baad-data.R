context("baad.data")

test_that("versions", {
  v <- baad_versions("global")
  expect_that("ecology" %in% v, is_true())
  ## TODO: not going to scale well...
  expect_that(match("ecology", v), equals(4))

  v <- baad_versions("github")
  expect_that("ecology" %in% v, is_false())
  expect_that(numeric_version(v), not(throws_error()))
})


test_that("ecology version", {
  d <- baad_data("ecology")
  expect_that(storr:::hash_object(d),
              equals("7c59e15a5d56752775e8f8e9748e3556"))
  expect_that(d, is_a("list"))
  expect_that(d$data, is_a("data.frame"))

  expect_that("ecology" %in% baad_versions("local"), is_true())

  v <- baad_versions("github")
  res <- list()
  for (i in v) {
    res[[i]] <- baad_data(i)
    expect_that(res[[i]]$data,       is_a("data.frame"))
    expect_that(res[[i]]$dictionary, is_a("data.frame"))
    expect_that(res[[i]]$bib,        is_a("bibentry"))
  }

  expect_that(baad_versions("local"),
              equals(baad_versions("global")))

  st <- baad_storr()
  expect_that(st$exists("ecology"), is_true())
  baad_delete("ecology")
  expect_that(st$exists("ecology"), is_false())
  baad_delete()

  expect_that(st$list(), equals(character(0)))
  expect_that(baad_versions("local"), equals(character(0)))
})
