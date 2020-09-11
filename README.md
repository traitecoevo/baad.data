# baad.data

[![Build Status](https://travis-ci.org/the-Hull/baad.data.svg?branch=master)](https://travis-ci.org/the-Hull/baad.data)
[![Build status](https://ci.appveyor.com/api/projects/status/7c5rt43610obsv5a?svg=true)](https://ci.appveyor.com/project/dfalster/baad-data)
[![Coverage Status](https://coveralls.io/repos/github/traitecoevo/baad.data/badge.svg?branch=master)](https://coveralls.io/github/traitecoevo/baad.data?branch=master)

This package provides access to the [Biomass And Allometry Database (BAAD)](https://github.com/dfalster/baad/). The BAAD contains data on the construction of woody plants across the globe. These data were gathered from over 170 published and unpublished scientific studies, most of which was not previously available in the public domain. It is our hope that making these data available will improve our ability to understand plant growth, ecosystem dynamics, and carbon cycling in the world's woody vegetation. The dataset is described further in the publication

Falster, DS , RA Duursma, MI Ishihara, DR Barneche, RG FitzJohn, A Vårhammar, M Aiba, M Ando, N Anten, MJ Aspinwall, JL Baltzer, C Baraloto, M Battaglia, JJ Battles, B Bond-Lamberty, M van Breugel, J Camac, Y Claveau, L Coll, M Dannoura, S Delagrange, J-C Domec, F Fatemi, W Feng, V Gargaglione, Y Goto, A Hagihara, JS Hall, S Hamilton, D Harja, T Hiura, R Holdaway, LS Hutley, T Ichie, EJ Jokela, A Kantola, JW G Kelly, T Kenzo, D King, BD Kloeppel, T Kohyama, A Komiyama, J-P Laclau, CH Lusk, DA Maguire, G le Maire, A Mäkelä, L Markesteijn, J Marshall, K McCulloh, I Miyata, K Mokany, S Mori, RW Myster, M Nagano, SL Naidu, Y Nouvellon, AP O'Grady, KL O'Hara, T Ohtsuka, N Osada, OO Osunkoya, PL Peri, AM Petritan, L Poorter, A Portsmuth, C Potvin, J Ransijn, D Reid, SC Ribeiro, SD Roberts, R Rodríguez, A Saldaña-Acosta, I Santa-Regina, K Sasa, NG Selaya, SC Sillett, F Sterck, K Takagi, T Tange, H Tanouchi, D Tissue, T Umehara, H Utsugi, MA Vadeboncoeur, F Valladares, P Vanninen, JR Wang, E Wenk, R Williams, F de Aquino Ximenes, A Yamaba, T Yamada, T Yamakura, RD Yanai, and RA York (2015) BAAD: a Biomass And Allometry Database for woody plants. *Ecology* **96**:1445–1445. [10.1890/14-1889.1](http://doi.org/10.1890/14-1889.1)

At time of publication, the BAAD contained 258526 measurements collected in 175 different studies, from 20950 individuals across 674 species. Details about individual studies contributed to the BAAD are given are available in these [online reports](https://github.com/dfalster/baad/wiki).

## Using BAAD

The data in BAAD are released under the [Creative Commons Zero](https://creativecommons.org/publicdomain/zero/1.0/) public domain waiver, and can therefore be reused without restriction. To recognise the work that has gone into building the database, we kindly ask that you cite the above article, or when using data from only one or few of the individual studies, the original articles if you prefer.

This package provides an easy interface for accessing the BAAD in your R project. versions of the dataset are drawn from our [github releases](https://github.com/dfalster/baad/releases), using the package [datastorr](https://github.com/richfitz/datastorr) to provide relevant infrastructure.

With the `baad.data` package installed, loading the data is as easy as:

```r
baad <- baad.data::baad_data()
```
Then access the data with:

```r
head(baad$data)
```

On first run, the package will download the requested version to your computer, and then save this for future reuse. Next time you run it, the data should load almost instantly.

To download a specific version of the BAAD:

```r
baad_090 <- baad.data::baad_data("0.9.0")
```

To see what is the latest version of the BAAD is:

```r
baad.data::baad_data_version_current()
```

To see all versions of the BAAD that are available:

```r
baad.data::baad_data_versions()
```

## Installation

You can install the package from github using the devtools package:

```
install.packages("devtools")
devtools::install_github("richfitz/datastorr")
devtools::install_github("traitecoevo/baad.data")
```

## Contents of the BAAD

The database contains the following elements

- `data`: amalgamated dataset (table), with columns as defined in `dictionary`
- `dictionary`: a table of variable definitions
- `metadata`: a table with columns "studyName","Topic","Description", containing written information about the methods used to collect the data
- `methods`: a table with columns as in data, but containing a code for the methods used to collect the data. See [config/methodsDefinitions.csv](config/methodsDefinitions.csv) for codes.
- `references`: as both summary table and bibtex entries containing the primary source for each study
- `contacts`: table with contact information and affiliations for each study

## Acknowledgements

We are extremely grateful to everyone who has contributed data. We would also like to acknowledge the following funding sources for supporting the data compilation. D.S. Falster, A. Vårhammer and D.R. Barneche were employed on an ARC discovery grant to Falster (DP110102086) and a UWS start-up grant to R.A. Duursma. R.G. FitzJohn was supported by the Science and Industry Endowment Fund (RP04-174). M.I. Ishihara was supported by the Environmental Research and Technology Development Fund (S-9-3) of the Ministry of the Environment, Japan.
