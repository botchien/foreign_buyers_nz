
setwd("P:/R&N/Networks/Housing Information & Modelling/housing_data/SNZ_foreign")

source(".Rprofile")

library(readr)
library(dplyr)
library(tidyr)
library(lubridate)
library(stringr)

library(sf)
library(leaflet)

library(rmarkdown)

source("grooming/data_grab.R")

source("grooming/clean.R")

source("analysis/create_chloropeth.R")


rmarkdown::render("output/foreign_buyer_summary.Rmd")
