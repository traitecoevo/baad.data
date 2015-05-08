# baad.data

[![Build Status](https://travis-ci.org/traitecoevo/baad.data.png?branch=master)](https://travis-ci.org/traitecoevo/baad.data)

# Usage:


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

## Installation

**Option 1, using [`drat`](https://github.com/eddelbuettel/drat)**

(install `drat` with `install.packages("drat")`)

```r
drat:::add("traitecoevo")
install.packages("baad.data")
```

**Option 2, using `devtools::install_github`**

(install `devtools` with `install.packages("devtools")`)

```r
devtools::install_github(c("richfitz/storr", "traitecoevo/baad"))
```
