
<!-- README.md is generated from README.Rmd. Please edit that file -->
LWFBrook90R: Run the LWF-BROOK90 hydrological model from within R.

Motivation
==========

In hydrology, many R-packages exist that deal with pre- and post-processing of input data and results of hydrological process models. In addition, many ready-to-use algorithms exist in R providing automatic calibration, sensitivity analysis, and parallelisation techniques. In order to make the vast resources of R directly available to the 1D-SVAT model [LWF-BROOK90](https://www.lwf.bayern.de/boden-klima/wasserhaushalt/index.php), *LWFBrook90R* was developed. The Fortran model code is integrated into the package as dynamic library and compiles when the package is installed. *LWFBrook90R* features the following functionality in one function call to the package core function `runLWFB90()`:

-   create model input objects from climate driving data, model control options and parameters,
-   execute the LWF-BROOK90 model code,
-   read and return the created output files.

The model control options thereby let you select different functions for defining aboveground stand dynamics, phenology, and root length density depth distributions. Additionally, a set of convenience functions are available to set up the required lists of model control options and parameters, and to derive soil hydraulic parameters from soil physical properties using pedotransfer-functions. Furthermore, wrapper-functions for `runLWFB90()` are, available facilitating parallel multi-run simulations and multi-site simulations.

Installation
============

Before installing the *LWFBrook90R* R-package, be sure to download and install the following packages:

``` r
install.packages("data.table")
install.packages("vegperiod")
install.packages("sirad")
install.packages("foreach")
install.packages("doSNOW")
```

Now you can install *LWFBrook90R*. The package is available on GitHub and can be installed using the *devtools*-package:

``` r
if (!requireNamespace("devtools")) {
    install.packages("devtools")
  }
devtools::install_github(repo = "pschmidtwalter/LWFBrook90R")
```

Basic usage
===========

Load LWFBrook90R

``` r
library(LWFBrook90R)
```

Load sample meteo and soil data

``` r
data("slb1_meteo")
data("slb1_soil")
```

Set up lists containing default model control options and model parameters

``` r
options.b90 <- setoptions_LWFB90()
param.b90 <- setparam_LWFB90()
```

Set new start and end dates in model control options

``` r
options.b90$startdate <- as.Date("2002-01-01")
options.b90$enddate <- as.Date("2003-12-31")
```

Derive soil hydraulic properties from soil physical properties using a pedotransfer function

``` r
soil <- cbind(slb1_soil, hydpar_puh2(clay = slb1_soil$clay,
                                     silt = slb1_soil$silt,
                                     sand = slb1_soil$sand,
                                     bd = slb1_soil$bd,
                                     oc.pct = slb1_soil$c_org))
```

Run LWF-Brook90 with the created input and store the results in b90.results.slb1

``` r
b90.results.slb1 <- runLWFB90(project.dir = "example_run_b90/",
                            param.b90 = param.b90,
                            options.b90 = options.b90,
                            soil = soil,
                            climate = slb1_meteo)
```

Status
======

R-Code
------

The package works as intended and is fully documented. However, there are some points to be accomplish in the near future:

-   \[x\] enable use of Clapp-Horneberg hydraulics in addition to the default Mualem-van Genuchten
-   \[x\] Use of sub-day resolution precipitation interval data.
-   \[x\] implement Goodness-of-fit measures with respect to observations that can be returned on top / instead of actual simulation results.
-   \[ \] Run the `check` with Travis.

Fortran-Code
------------

-   \[x\] Use of sub-day resolution precipitation interval data.
-   \[x\] Model output results tested against the output from the original b90.exe commandline tool.
-   \[x\] Cleaning up `declared but not used` variables
-   \[x\] Optional writing of model log-file that contains the former commandline-feed.

Authors
=======

Paul Schmidt-Walter, Volodymyr Trotsiuk, Klaus Hammel, Martin Kennel, Tony Federer. Tony Federer's original Brook90 Fortran 77 code was enhanced by Klaus Hammel and Martin Kennel around the year 2000 and distributed as LWF-Brook90 Fortran program together with in MS Access User Interface. In 2019, Volodymyr Trotsiuk converted the code to Fortran 95 and implemented the connection to R. Paul Schmidt-Walter created the R functions for input data generation, model execution and result processing.

License
=======

GPL-3

Notes
-----

All changes made to the Fortran code of LWF-Brook90R should be returned to
