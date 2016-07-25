context("baad.data")

test_that("versions", {
  v <- baad_data_versions(FALSE)
  expect_true("1.0.0" %in% v)
  expect_equal(match("1.0.0", v), 4)

  curr <- baad_data_version_current(FALSE)
  expect_true(numeric_version(curr) >= numeric_version("1.0.0"))
  expect_true(curr %in% v)
})

test_that("ecology version", {
  path <- tempfile()
  d <- baad_data("1.0.0", path)

  # Note, checking data component here because entire objects
  # was behaving differently on different platforms, due to
  # presence of bad line endings.
  # See https://github.com/traitecoevo/baad.data/issues/6
  expect_equal(storr:::hash_object(d[["data"]]),
               "16e346bcc5a49c10a3974b6ac149749f")

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

  d <- baad_data("1.0.0")
  path <- rappdirs::user_data_dir(file.path("datastorr", "tmp.rds"))
  saveRDS(d, path)
  expect_true(file.exists(path))
  cat(path)
})
