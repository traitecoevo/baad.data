# baad.data

[![Build Status](https://travis-ci.org/traitecoevo/baad.data.png?branch=master)](https://travis-ci.org/traitecoevo/baad.data)

![baad logo](https://github.com/dfalster/baad/raw/master/extra/baad.png)

Please see [the main baad repo](https://github.com/dfalster/baad) for more information about baad; this repo and package is a simple tool to access the data there.

## Usage:


```r
baad <- baad.data::baad_data()
```

Then access the data with:

```r
head(baad$data)
```

To download a specific version:

```r
baad_090 <- baad.data::baad_data("0.9.0")
```

## Contents

The database contains the following elements

- `data`: amalgamated dataset (table), with columns as defined in `dictionary`
- `dictionary`: a table of variable definitions
- `metadata`: a table with columns "studyName","Topic","Description", containing written information about the methods used to collect the data
- `methods`: a table with columns as in data, but containing a code for the methods used to collect the data. See [config/methodsDefinitions.csv](config/methodsDefinitions.csv) for codes.
- `references`: as both summary table and bibtex entries containing the primary source for each study
- `contacts`: table with contact information and affiliations for each study

## Installation

**Option 1, using [`drat`](https://github.com/eddelbuettel/drat)**

(install `drat` with `install.packages("drat")`)

```r
drat:::add("traitecoevo")
install.packages("baad.data")
```

(versions of R before 3.2.0 may require `install.packages("baad.data", type="source")` here)

(not currently working!)

**Option 2, using `devtools::install_github`**

(install `devtools` with `install.packages("devtools")`)

```r
devtools::install_github(c(
    "richfitz/datastorr",
    "traitecoevo/baad.data"))
```

## Acknowledgements

We are extremely grateful to everyone who has contributed data. We would also like to acknowledge the following funding sources for supporting the data compilation. D.S. Falster, A. Vårhammer and D.R. Barneche were employed on an ARC discovery grant to Falster (DP110102086) and a UWS start-up grant to R.A. Duursma. R.G. FitzJohn was supported by the Science and Industry Endowment Fund (RP04-174). M.I. Ishihara was supported by the Environmental Research and Technology Development Fund (S-9-3) of the Ministry of the Environment, Japan.
