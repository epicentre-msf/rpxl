
<!-- README.md is generated from README.Rmd. Please edit that file -->

# rpxl: Read password-protected Excel files

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
[![R-CMD-check](https://github.com/epicentre-msf/rpxl/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/epicentre-msf/rpxl/actions/workflows/R-CMD-check.yaml)
[![Codecov test
coverage](https://codecov.io/gh/epicentre-msf/rpxl/branch/main/graph/badge.svg)](https://app.codecov.io/gh/epicentre-msf/rpxl?branch=main)
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
`install_python()` function in reticulate. See also [Using Python with
the RStudio
IDE](https://support.posit.co/hc/en-us/articles/1500007929061-Using-Python-with-the-RStudio-IDE)
for more information on configuring RStudio to use Python.

``` r
reticulate::install_python()
```

Finally, use the `rpxl::install_rpxl()` function to install the required
Python dependencies.

``` r
library(rpxl)
install_rpxl()
```

## Usage

``` r
library(rpxl)
```

Read password-protected .xlsx files with function `rp_xlsx()`, a wrapper
to `read_xlsx()` in the [readxl](https://readxl.tidyverse.org/) package.

``` r
path_xlsx <- system.file("extdata", "xltest.xlsx", package = "rpxl")
df <- rp_xlsx(path_xlsx, password = "1234")
```

Read password-protected .xlsb files with function `rp_xlsb()`, a wrapper
to `read_xlsb()` in the [readxlsb](https://github.com/velofrog/readxlsb)
package. Note that `read_xlsb()` requires the worksheet to be explicitly
specified (either with argument ‘sheet’ or ‘range’), whereas
`read_xlsx()` defaults to sheet 1.

``` r
path_xlsb <- system.file("extdata", "xltest.xlsb", package = "rpxl")
df <- rp_xlsb(path_xlsb, password = "1234", sheet = 1)
```

To decrypt a password-protected Excel file and save it under a different
filename (without immediately reading it into R), you can use the
function `decrypt_wb()`. The function returns the path to the decrypted
file, which defaults to a temporary file created with `tempfile()`, but
could alternatively be user-specified.

``` r
path_decrypted <- decrypt_wb(path_xlsx, password = "1234")
```

The decrypted file can then be read into R in a separate step.

``` r
df <- readxl::read_xlsx(path_decrypted)
```

You may want to explicitly delete the decrypted file afterwards, if its
contents are sensitive. Otherwise, if it’s a temporary file created with
`tempfile()`, it will be automatically deleted when the current R
session is closed.

``` r
file.remove(path_decrypted)
```
