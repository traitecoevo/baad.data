context("baad.data")

test_that("versions", {
  v <- baad_data_versions(FALSE)
  expect_true("1.0.0" %in% v)
  expect_equal(match("1.0.0", v), 4)
})

test_that("ecology version", {
  path <- tempfile()
  d <- baad_data("1.0.0", path)
  expect_equal(storr:::hash_object(d),
               "7c59e15a5d56752775e8f8e9748e3556")
  expect_is(d, "list")
  expect_is(d$data, "data.frame")
  expect_true(file.exists(path))

  expect_identical(baad_data("1.0.0", path), d)

  expect_true("1.0.0" %in% baad_data_versions(TRUE, path))

  v <- baad_data_versions(FALSE, path)
  res <- list()
  for (i in v) {
    res[[i]] <- baad_data(i, path)
    expect_is(res[[i]]$data,   "data.frame")
    expect_is(res[[i]]$dictionary, "data.frame")
    expect_is(res[[i]]$bib,        "bibentry")
  }

  expect_equal(baad_data_versions(TRUE, path),
              baad_data_versions(FALSE, path))

  baad_data_del("1.0.0", path)
  expect_false("1.0.0" %in% baad_data_versions(TRUE, path))
  baad_data_del(NULL, path)
  expect_false(file.exists(path))
})
