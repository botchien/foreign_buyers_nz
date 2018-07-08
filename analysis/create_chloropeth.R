# create_map
#
#
#
# Zac


p <- readRDS("data_intermediate/transfers_akl_boards.rds")


p <- data.frame(transfers_akl_boards)

p <- p %>% spread(type, value)

local_boards <- st_read("data_raw/statsnzcommunity-board-2018-clipped-generalised-SHP/community-board-2018-clipped-generalised.shp")
local_boards <- local_boards %>% filter(str_detect(CB2018_V_1, 'Local Board Area' ))

local_boards <- local_boards %>% rename(LBA = CB2018_V_1)

local_boards <- local_boards %>% st_transform(4326)

local_boards_foreign <- local_boards %>% left_join(p)

local_boards_foreign <- local_boards_foreign %>% filter(!(LBA %in% c("Great Barrier Local Board Area")))



range(local_boards_foreign$Buyers, na.rm = T)

bins <- c(0, 2.5, 5, 7.5, 10, 12.5, 15, Inf)
pal <- colorBin("Reds", domain = local_boards_foreign$Buyers, bins = bins)

labels <- sprintf(
  "<strong>%s</strong><br/>%g &percnt;",
  local_boards_foreign$LBA, local_boards_foreign$Buyers
) %>% lapply(htmltools::HTML)



chloropeth <- leaflet(data = local_boards_foreign) %>%
  addProviderTiles(providers$CartoDB.Positron,
	group = "Street") %>% 
  addPolygons(
    fillColor = ~pal(Buyers),
    weight = 2,
    opacity = 1,
    color = "black",
    dashArray = "3",
    fillOpacity = 0.7,
    highlight = highlightOptions(
      weight = 5,
      color = "#666",
      dashArray = "",
      fillOpacity = 0.7,
      bringToFront = TRUE),
    label = labels,
    labelOptions = labelOptions(
      style = list("font-weight" = "normal", padding = "3px 8px"),
      textsize = "15px",
      direction = "auto")) %>%
  addLegend(pal = pal, values = ~Buyers, opacity = 0.7, title = "Foreign Buyer %",
    position = "bottomright")  
  
saveRDS(chloropeth, file.path("data_intermediate", 'chloropeth.rds'))  

#
#
#
#

# p2 <- readRDS("data_intermediate/transfers.rds")
# p2 <-  p2 %>% filter( Units == "Percent" ,
# 											Group == "Affiliation by territorial authority and local boards") %>% 
# 										filter(!(Series_title_1 %in% c("New Zeland", "Area Outside Territorial Authority")))		
# p2 <- data.frame(p2) %>% select(TA = Series_title_1, type = Series_title_3, value = Data_value, Period)
# 
# 
# local_boards <- st_read("data_raw/statsnzcommunity-board-2018-clipped-generalised-SHP/community-board-2018-clipped-generalised.shp")
# local_boards <- local_boards %>% filter(str_detect(CB2018_V_1, 'Local Board Area' ))
# 
# local_boards <- local_boards %>% rename(LBA = CB2018_V_1)
# 
# local_boards <- local_boards %>% st_transform(4326)
# 
# TA <- st_read("data_raw/statsnzterritorial-authority-2018-clipped-generalised-SHP/territorial-authority-2018-clipped-generalised.shp")


#
#
#
#



 