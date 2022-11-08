#' Date of the latest available data
#'
#' @description Find the date of the latest available data
#'
#' @importFrom dplyr "%>%"
#' @importFrom xml2 read_html
#' @importFrom rvest html_nodes html_text
#' @importFrom stringr str_extract
#'
#' @return A date
#'
#' @examples
#' obr_date()
#'
#' @export

obr_date <- function(){

  date <- (
    read_html("https://obr.uk/data/") %>%
    html_nodes("div.meta") %>%
    html_text()
  )[[2]]

  return(str_extract(date, "[^–]+"))

}

#' Download the latest OBR data
#'
#' @description Download the latest Excel workbook of OBR data
#'
#' @importFrom utils download.file
#'
#' @return The location of the downloaded Excel workbook

obr_download <- function(){
  # URL of data
  url <- "https://obr.uk/download/historical-official-forecasts-database/"

  # Create temp file path
  tmp <- tempfile("temp", fileext = ".xlsx")

  # Download the data
  download.file(url, destfile = tmp, mode = "wb", quiet = TRUE)

  return(tmp)
}

#' Quiet purrr::map function
#'
#' @description Wrapper for purrr::map
#'
#' @param ... Arguments passed to purrr::map
#'
#' @importFrom purrr quietly map
#'
#' @return A function

qmap <- quietly(.f = map)

