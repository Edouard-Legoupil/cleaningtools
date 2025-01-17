# WARNING - Generated by {fusen} from dev/function_documentation.Rmd: do not edit by hand

#' Format and filter Choices for 'select_one' Questions
#'
#' This function returns a dataframe containing 'select_one' questions
#' from the `tool` dataframe with their corresponding choices in the `choices` dataframe.
#'
#' @param choices A dataframe containing the choices sheet from the Kobo tool
#'        Expected to have at least the columns `list_name` and `name`.
#'
#' @param tool A dataframe containing the survey sheet from the Kobo tool
#'        Expected to have at least the columns `type` and `name`.
#'
#' @return A dataframe containing 'select_one' questions with their corresponding choices.
#'         The dataframe has columns from both the `tool` and `choices` dataframes.
#'
#' @export
#' @examples
#' #formatted_choices <- create_formatted_choices(choices, tool)
create_formatted_choices <- function(choices, tool) {
  list.choices <- choices %>%
    dplyr::filter(!is.na(list_name)) %>%
    dplyr::group_by(list_name) %>%
    dplyr::mutate(
      choices = paste(name, collapse = ";\n"),
      choices.label = paste(!!rlang::sym(names(choices)[3]), collapse = ";\n")
    ) %>%
    dplyr::summarise(choices = choices[1], choices.label = choices.label[1])

  select.questions <- tool %>%
    dplyr::select(type, name) %>%
    dplyr::mutate(
      q.type = as.character(lapply(type, function(x) {
        return(stringr::str_split(x, " ")[[1]][1])
      })),
      list_name = as.character(lapply(type, function(x) {
        x.1 <- stringr::str_split(x, " ")[[1]]
        if (length(x.1) == 1) {
          return(NA)
        } else {
          return(x.1[2])
        }
      }))
    ) %>%
    dplyr::filter(q.type == "select_one") %>%
    dplyr::filter(!is.na(list_name) & list_name != "NA" & list_name != "group" & list_name != "repeat") %>%
    dplyr::left_join(list.choices, by = "list_name") %>%
    dplyr::filter(!is.na(choices))

  return(select.questions)
}
