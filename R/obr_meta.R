#' Fetch available indicators
#'
#' @description Function to check available indicators
#'
#' @importFrom dplyr "%>%" filter mutate select ends_with
#' @importFrom purrr quietly
#' @importFrom readxl excel_sheets read_excel
#' @importFrom tidyr unnest drop_na
#' @importFrom stringr str_extract
#' @importFrom rlang .data
#'
#' @return A \code{data.frame} containing available indicators
#'
#' @examples
#' obr_annual("CPI")
#'
#' @export


obr_meta <- function(){

  tmp <- obr_download()

  # Sheet names to use as id
  z <- excel_sheets(tmp)

  # B1 - to use as name
  x <- excel_sheets(tmp) %>%
    qmap(read_excel, range = "B1", col_names = FALSE, path = tmp)
  x <- x$result

  # A2 - to use as units
  y <- excel_sheets(tmp) %>%
    qmap(read_excel, range = "A2", col_names = FALSE, path = tmp)
  y <- y$result

  # Combine
  q <- cbind(z, x, y) %>%
    as.data.frame() %>%
    unnest(cols = c(x, y),
           names_repair = "unique",
           keep_empty = TRUE)

  # Name columns
  names(q) <- c("id", "name", "units")

  # Clean up
  q <- q %>%
    filter(!grepl('(2)', .data$id)) %>%
    mutate(units2 = str_extract(.data$name, "(?<=\\().+?(?=\\))"),
           name2 = str_extract(.data$name, ".*(?= \\(.*\\))")) %>%
    mutate(name = ifelse(is.na(.data$name2), .data$name, .data$name2),
           units = ifelse(is.na(.data$units), .data$units2, .data$units)) %>%
    select(-ends_with("2")) %>%
    drop_na()

  return(q)

}

