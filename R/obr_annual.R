#' Fetch Outturn and OBR forecast of inflation measures
#'
#' @description function
#'
#' @param indicator OBR indicator, e.g., "CPI"
#' @param long Long (T) or wide (F) format
#'
#' @importFrom dplyr mutate mutate_all select rename full_join "%>%" filter across left_join
#' @importFrom tidyr drop_na fill pivot_longer
#' @importFrom readxl read_excel
#' @importFrom utils download.file tail
#' @importFrom rlang .data
#'
#' @return A \code{data.frame} containing a time series
#'
#' @examples
#' obr_annual("CPI", long = FALSE)
#' obr_annual(c("CPI", "RPI"), long = TRUE)
#'
#' @export

obr_annual <- function(indicator, long = FALSE){

  tmp <- obr_download()

  results <- data.frame(year = numeric(),
                        Forecast = character())

  for (ind in indicator) {
    # Read the relevant sheet
    x <- read_excel(tmp, sheet = paste0(ind), skip = 3)
    names(x)[1] <- "Date"
    x <- x %>%
      mutate(across(-.data$Date, ~as.numeric(.))) %>%
      drop_na(.data$Date)

    out <- tryCatch(x[1:which(grepl("Outturn", x$Date)), ], error = function(e) e)

    if(any(class(out) == "error") != TRUE){
      x <- x[1:which(grepl("Outturn", x$Date)), ]
    }

    y <- x %>%
      pivot_longer(-.data$Date, names_to = "year", values_to = paste0(ind)) %>%
      filter(grepl("Outturn", .data$Date)) %>%
      mutate(year = as.numeric(substr(.data$year, 1, 4))) %>%
      drop_na()

    # Fill so have latest data
    x <- fill(x, -.data$Date, .direction = "down")

    # Format data
    x <- utils::tail(x, 1) %>% # take just the last row
      pivot_longer(-.data$Date, names_to = "year", values_to = paste0(ind)) %>%
      select(-.data$Date) %>%
      drop_na() %>%
      mutate(year = substr(.data$year, 1, 4)) %>%
      mutate_all(as.numeric)

    x <- suppressMessages(left_join(x, y)) %>%
      rename(Forecast = .data$Date) %>%
      mutate(Forecast = ifelse(is.na(.data$Forecast), "forecast", "outturn"))

    results <- full_join(results, x, by = c("year", "Forecast"))

    results$Forecast <- factor(results$Forecast, levels = c("outturn", "forecast"))
  }

  if(long == T){
    results <- tryCatch(
      {
        results %>%
          pivot_longer(cols = -c(.data$year, .data$Forecast),
                       names_to = "Indicator",
                       values_to = "Value")
      },
      error = function(e){results}
    )
  }

  return(results)
}


