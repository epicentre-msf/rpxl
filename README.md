
<!-- README.md is generated from README.Rmd. Please edit that file -->

# rpxl: Read password-protected Excel files

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
[![R-CMD-check](https://github.com/patrickbarks/xltest17/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/patrickbarks/xltest17/actions/workflows/R-CMD-check.yaml)
<!-- badges: end -->

Uses the Python library
[msoffcrypto-tool](https://pypi.org/project/msoffcrypto-tool/) to
decrypt password protected Excel files (either .xlsx or .xlsb), which
can then be read into R with e.g. the
[readxl](https://readxl.tidyverse.org/) or
[readxlsb](https://github.com/velofrog/readxlsb) R packages.

## Installation

Install from GitHub with:

``` r
# install.packages("remotes")
remotes::install_github("epicentre-msf/rpxl")
```

Next, make sure Python is installed on your system. You can use the
[reticulate](https://rstudio.github.io/reticulate/index.html) R package
for this, which will already be installed alongside rpxl.

``` r
reticulate::py_available(initialize = TRUE)
```

If you don’t already have Python installed, it can be downloaded from
www.python.org/downloads, or installed directly from R using the
`install_python()` function in reticulate.

``` r
reticulate::install_python()
```

Finally, use the `install_rpxl()` function to install the required
Python dependencies.

``` r
library(rpxl)
install_rpxl()
```

## Usage

``` r
library(rpxl)
```

Read password-protected *.xlsx* files with function `rpxlsx()`, a
wrapper to `read_xlsx()` in the [readxl](https://readxl.tidyverse.org/)
package.

``` r
path_xlsx <- system.file("extdata", "xltest.xlsx", package = "rpxl")
rpxlsx(path_xlsx, password = "1234")
```

    ## # A tibble: 3 × 3
    ##       x ext   protected
    ##   <dbl> <chr> <chr>    
    ## 1     1 xlsx  yes      
    ## 2     2 xlsx  yes      
    ## 3     3 xlsx  yes

Read password-protected *.xlsb* files with function `rpxlsb()`, a
wrapper to `read_xlsb()` in the
[readxlsb](https://github.com/velofrog/readxlsb) package. Note that
`read_xlsb()` requires the worksheet to be explicitly specified (either
with argument ‘sheet’ or ‘range’), whereas `read_xlsx()` defaults to
sheet 1.

``` r
path_xlsb <- system.file("extdata", "xltest.xlsb", package = "rpxl")
rpxlsb(path_xlsb, sheet = 1L, password = "1234")
```

    ##   x  ext protected
    ## 1 1 xlsb       yes
    ## 2 2 xlsb       yes
    ## 3 3 xlsb       yes

To decrypt a password-protected Excel file and save it under a different
filename (without immediately reading it into R), you can use the
function `rpxl_decrypt()`. The function returns the path to the
decrypted file, which defaults to a temporary file created with
`tempfile()`, but could alternatively be user-specified.

``` r
path_decrypted <- rpxl_decrypt(path_xlsx, password = "1234")
```

The decrypted file can then be read into R in a separate step.

``` r
readxl::read_xlsx(path_decrypted)
```

    ## # A tibble: 3 × 3
    ##       x ext   protected
    ##   <dbl> <chr> <chr>    
    ## 1     1 xlsx  yes      
    ## 2     2 xlsx  yes      
    ## 3     3 xlsx  yes

You may want to explicitly delete the decrypted file afterwards, if its
contents are sensitive. Otherwise, if it’s a temporary file created with
`tempfile()`, it will be automatically deleted when the current R
session is closed.

``` r
file.remove(path_decrypted)
```

    ## [1] TRUE
