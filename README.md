
## {cleaningtools}

<!-- badges: start -->

[![Contributor
Covenant](https://img.shields.io/badge/Contributor%20Covenant-2.1-4baaaa.svg)](code_of_conduct.md)
[![R-CMD-check](https://github.com/impact-initiatives/cleaningtools/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/impact-initiatives/cleaningtools/actions/workflows/R-CMD-check.yaml)
[![codecov](https://codecov.io/gh/impact-initiatives/cleaningtools/branch/master/graph/badge.svg?token=SOH3NGXQDU)](https://codecov.io/gh/impact-initiatives/cleaningtools)
<!-- badges: end -->

The `{cleaningtools}` package focuses on survey data cleaning process.
It allow to have a fully documented and reproducible cleaning process,
based on the generation of a standardized `cleaning and deletion log`.
With such type of process, Quality Assurance and Auditing can be easily
performed.

This tool support the implementation of IMPACT Initiatives / REACH
guidance: [Data Cleaning Guidelines for Structured
Data](https://www.reachresourcecentre.info/wp-content/uploads/2022/05/IMPACT_Data-Cleaning-Guidelines_FINAL_To-share-11.pdf)
& [Data Cleaning Minimum Standards
Checklist](https://www.reachresourcecentre.info/wp-content/uploads/2020/03/IMPACT_Memo_Data-Cleaning-Min-Standards-Checklist_28012020-1.pdf).

The workflow supported by the tool includes:

1.  Get your raw data and your form from your Kobo/ODK/ONA server.

2.  Define a **list of logical checks** based on the specific content of
    your form. This is basically an excel spreadsheet defining checks
    describing incompatible responses (`check_id`, `description`,
    `check_to_perform`, `columns_to_clean`) - such as
    “*primary_livelihood is rented but expenses less than 500000*” or
    “*access water and tank emptied*”.

3.  Pipe a list of **systematic checks** functions to apply on the data
    (*outliers, shortest path, personally identifiable information,
    duration…*), including the logical checks previously defined - each
    of the check will produce a specific log.

![](https://raw.githubusercontent.com/Edouard-Legoupil/cleaningtools/master/inst/clean_log.png)

4.  Assemble and export the **`cleaning log`** together in a dedicated
    excel spreadsheet (`create_xlsx_cleaning_log()`) so that the person
    responsible for the cleaning can manually make the decision on the
    cleaning action to perform among the following values:

| value             | Definition                       |
|-------------------|----------------------------------|
| `change_response` | Change the response to new.value |
| `blank_response`  | Remove and NA the response       |
| `remove_survey`   | Delete the survey                |
| `no_action_value` | No action to take                |

5.  Apply the manually review `cleaning log` on the raw data to obtain
    the **cleaned data**, aka `checked_dataset`

6.  Then **review** how the cleaning was applied through dedicated
    report `review_cleaning()` , `review_the_others_log`, `review_sf`
    for the sampling frame

Please check the package vignette tuto to review the content with more
details.

## Installation & Usage

You can install the development version from
[GitHub](https://github.com/) with:

``` r
install.packages("pak")  
pak::pkg_install("edouard-legoupil/cleaningtools")
```

The package comes with a parameterised report template to ease and
speed-up the full process.

![](https://raw.githubusercontent.com/Edouard-Legoupil/cleaningtools/master/inst/template.png)

Once users have a good understanding of the process above, create an
Rstudio projects, install the package, download your data and your form
within a dedicated sub-folder for instance `data-raw`, create an excel
file to add your `logical checks`, add if any the file defining your
`sampling plan`.

Then create a notebook using the `clean` notebook template included in
the package and start documenting all the parameters.

Once done you can run each of the code chunk one after the other. After
the first chapter, you should have a `cleaning log` file created within
your the same `data-raw` folder. Open it and manually set up the
cleaning actions for each of the checks.

Run then the last few chunks to apply the log and review the results…

Et Voila, you should have then the `cleaned_data` in your `data-raw`
folder

## Current Limitation

The package assumes that the survey data is a single frame, it does not
work out of the box with datalist, aka survey dataset that have more
than one dataframe

## Code of Conduct

Please note that the {cleaningtools} project is released with a
[Contributor Code of
Conduct](https://impact-initiatives.github.io/cleaningtools/CODE_OF_CONDUCT.html).
By contributing to this project, you agree to abide by its terms. For
developpers, check the `dev/function_documentation.Rmd` notebook created
with [{fusen}](https://thinkr-open.github.io/fusen/index.html)
