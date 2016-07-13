library("readr")
library("dplyr")

data <- read_fwf(file = "datafileNoHeader.txt",
                 fwf_empty("datafileNoHeader.txt"))

data2 <- select(data,
                field = X7,
                id = X8,
                period = X9,
                subtype = X10) %>%
    mutate(subtype = sub("i", "", subtype),
           type = substr(subtype, 1, 1))

write.table(data2, file = "cleanedDataFile.txt")
