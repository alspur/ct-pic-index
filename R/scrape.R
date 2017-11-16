# scrape.R

library(tidyverse)
library(readxl)

# create link to 2017 PIC index spreadsheet
data_url <- "http://www.ct.gov/opm/lib/opm/igp/pic/fy_2017_pic_index_for_website.xlsx"

# download xlsx file
download.file(data_url, "data/pic_index_2017.xlsx")

# read data
pic_index_2017 <- read_excel("data/pic_index_2017.xlsx", sheet = 
                               2,range = "A5:O174")

# rename columns
colnames(pic_index_2017) <- c("pic_rank", "town", "pop",
                              "pci", "pci_pts", 
                              "aenglc", "aenglc_pts",
                              "emr", "emr_pts", "afdc", "afdc_pct",
                              "afdc_pts", "unempl_rt",
                              "unempl_pts", "total_pts")

pic_index_2017_clean <- pic_index_2017 %>%  
  mutate(afdc_pct = afdc_pct / 100,
         unempl_rt = unempl_rt / 100)

# save data as r data file
saveRDS(pic_index_2017_clean, "data/pic_index_2017.rda")
