# baad.data

[![Build Status](https://travis-ci.org/traitecoevo/baad.data.png?branch=master)](https://travis-ci.org/traitecoevo/baad.data)

![baad logo](https://github.com/dfalster/baad/raw/master/extra/baad.png)

Please see [the main baad repo](https://github.com/dfalster/baad) for more information about baad; this repo and package is a simple tool to access the data there.

# Usage:


```r
baad <- baad.data::baad_data()
```

Then access the data with:

```r
head(baad$data)
```

or

```
head(baad.data:::data())
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

(versions of R before 3.2.0 may require `install.packages("baad.data", type="source")` here)

**Option 2, using `devtools::install_github`**

(install `devtools` with `install.packages("devtools")`)

```r
devtools::install_github(c("richfitz/storr", "traitecoevo/baad"))
```
