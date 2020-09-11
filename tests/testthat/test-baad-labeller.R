dictionary <- baad_data()$dictionary

test_that("Returns expression",{

    expect_equal(class(baad_labeller(dictionary = dictionary,
                  variable = "r.st",
                  as_expression = TRUE)),
                  "expression")
})

test_that("Returns character",{

    expect_equal(class(baad_labeller(dictionary = dictionary,
                                               variable = "r.st",
                                               as_expression = FALSE)),
                           "character")
})

test_that("Returns expression with superscript",{

    expect_equal(baad_labeller(dictionary = dictionary,
                                               variable = "r.st",
                                               as_expression = TRUE),
                 base::parse(text = paste0("Wood~Density~(kg/m**3)"))
    )
})

test_that("Returns label with - for NA unit",{

    expect_equal(suppressWarnings(baad_labeller(dictionary = dictionary,
                                         variable = "pft",
                                         as_expression = FALSE)),
                           "Pft (-)")
})

test_that("Returns label with - for NA unit",{
    
    expect_warning(baad_labeller(dictionary = dictionary,
                                                variable = "pft",
                                                as_expression = FALSE),
                 regexp = "Unit in dictionary is missing (NA). Setting to '-'.",
                 fixed = TRUE)
})
