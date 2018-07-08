
setwd("P:/R&N/Networks/Housing Information & Modelling/housing_data/SNZ_foreign")

library(readr)

url <- "https://www.stats.govt.nz/assets/Uploads/Property-transfer-statistics/Property-transfer-statistics-March-2018-quarter/Download-data/property-transfer-statistics-march-2018-quarter.zip"
temp <- tempfile()
download.file(url, temp)
unzip(temp, "property-transfer-statistics-mar18qtr-tables-csv.csv")

dat <- read_csv("property-transfer-statistics-mar18qtr-tables-csv.csv")
unlink(temp)

saveRDS(dat, "data_raw/property_transfers.rds")

