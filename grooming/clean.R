#clean.R
#
#
# Zac

dat <- readRDS("data_raw/property_transfers.rds")

transfers <- dat %>% filter(Series_title_2 == "Home involved")

# select annual - PTSA
# select quarter is PTSQ 
transfers <- transfers %>% filter(Period == "2018.03", 
								 Series_title_4 == "No NZ citizens or resident visas",
								 str_detect(Series_reference, "PTSQ"))

saveRDS(transfers, "data_intermediate/transfers.rds")
														
transfers_akl_boards <-  transfers %>% filter( Units == "Percent" ,
											str_detect(Series_title_1, "Area")) %>% 
										filter(Series_title_1 != "Area outside region")														
														
transfers_akl_boards <- data.frame(transfers_akl_boards) %>% select(LBA = Series_title_1, type = Series_title_3, value = Data_value, Period)

transfers_akl_boards <- transfers_akl_boards %>% filter(LBA != "Area Outside Territorial Authority")

saveRDS(transfers_akl_boards, "data_intermediate/transfers_akl_boards.rds")
