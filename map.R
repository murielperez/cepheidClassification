library(dplyr)
library(readr)

index <- read.table("index.txt", stringsAsFactors = FALSE)

function.to.map <- function(route, period){
    data <- read.table(route)
    time <- data[, 1]
    mag  <- data[, 2]
    phase <- ((time - min(time)) / period)%%1
    y0 <- approx(x = phase,
                 y = mag,
                 n = 50,
                 method = "constant")
    return(y0$y)   
}


data <- mapply(function.to.map,
               index$route,
               index$period) %>%
    t %>%
    data.frame
data$route <- rownames(data)

data <- as_data_frame(data)
data <- inner_join(data, index, by = "route") %>%
    dim

print.data.frame(head(data))

write.table(data, "featuresData.txt")
