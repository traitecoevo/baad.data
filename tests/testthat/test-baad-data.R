context("baad.data")

test_that("versions", {
  v <- baad_data_versions(FALSE)
  expect_that("1.0.0" %in% v, is_true())
  expect_that(match("1.0.0", v), equals(4))
})

test_that("ecology version", {
  path <- tempfile()
  d <- baad_data("1.0.0", path)
  expect_that(storr:::hash_object(d),
              equals("7c59e15a5d56752775e8f8e9748e3556"))
  expect_that(d, is_a("list"))
  expect_that(d$data, is_a("data.frame"))
  expect_that(file.exists(path), is_true())

  expect_that(baad_data("1.0.0", path), is_identical_to(d))

  expect_that("1.0.0" %in% baad_data_versions(TRUE, path), is_true())

  v <- baad_data_versions(FALSE, path)
  res <- list()
  for (i in v) {
    res[[i]] <- baad_data(i, path)
    expect_that(res[[i]]$data,       is_a("data.frame"))
    expect_that(res[[i]]$dictionary, is_a("data.frame"))
    expect_that(res[[i]]$bib,        is_a("bibentry"))
  }

  expect_that(baad_data_versions(TRUE, path),
              equals(baad_data_versions(FALSE, path)))

  baad_data_del("1.0.0", path)
  expect_that("1.0.0" %in% baad_data_versions(TRUE, path), is_false())
  baad_data_del(NULL, path)
  expect_that(file.exists(path), is_false())
})
