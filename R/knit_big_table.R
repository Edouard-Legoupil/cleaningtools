# WARNING - Generated by {fusen} from dev/function_documentation.Rmd: do not edit by hand

#' Format table for quarto html output
#'
#' @param table_to_print A data frame to print
#' @param .height Height in the html output
#'
#' @return Table with some features for quarto html output
#' 
#' @keywords internal
#' @export
#' @examples
#' #knit_big_table(table_to_print)
 
knit_big_table <- function(table_to_print, .height = "500px") {
  table_to_print |>
    knitr::kable() |>
    kableExtra::kable_paper() |>
    kableExtra::scroll_box(height = .height)
}

