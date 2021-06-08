

#Cleaning top 15 known units labeled as 'Other'

hh_q <- c("cons","purc","prod","gift")
j <- "_unitA" 
k <- "_unit_oth"

for (i in hh_q){
  q <- paste0(i, j) # original variable
  y <- paste0(i, k) # modified variable

  <- ihs5%>%
    mutate(
      !!sym(q) := case_when(
       str_detect(!!sym(y), "KILOGRAM") ~ "1",
       str_detect(!!sym(y), "PAIL") ~ "4",
       str_detect(!!sym(y), "PAIL (SMALL)")~ "4A"
      )
    )
}


ihs5 %>% mutate(cons_unitA = case_when(
  cons_unit_oth == "KILOGRAM" ~ "1",
  cons_unit_oth == "PAIL" ~ "4",
  cons_unit_oth == "PAIL (SMALL)"~ "4A",
  cons_unit_oth == "PAIL (MEDIUM)" ~ "4B",
  cons_unit_oth == "PAIL (LARGE)" ~ "4C",
  cons_unit_oth == "PLATE"~ "6B",
  cons_unit_oth == "BATCHES|BUNDLE" ~ "8",
  cons_unit_oth == "BUNCH SMALL" ~ "8A",
  cons_unit_oth == "PIECE|MANGO" ~ "9",
  cons_unit_oth == "HEAP"~ "10",
  cons_unit_oth == "SMALL HEAP|HEAP(SMALL)" ~ "10A", 
  cons_unit_oth == "HEAP (MEDIUM)" ~ "10B",
  cons_unit_oth == "LARGE HEAP" ~ "10C",
  cons_unit_oth == "LITRE" ~ "15",
  (cons_unit_oth == "BOTTLE (SMALL)" & item_code == "803") ~ "15"
  cons_unit_oth == "GRAMS|G" ~ "18",
  cons_unit_oth == "MILLILITRE" ~ "19",
  cons_unit_oth == "SATCHET|TUB|TBE|SA HETS" ~ "22", 
  cons_unit_oth == "SATCHET (SMALL)|SMALL SACHET|SMALL SARCHET" ~ "22A",
  cons_unit_oth == "MEDIUM SACHET|MEDIAM SACHET" ~ "22B", 
  cons_unit_oth == "LARGE  SATCHET|SACHET  LARGE" ~ "22C",
  cons_unit_oth == "TINA"~ "25",
  cons_unit_oth == "TINA FLAT|SMALL TINA FLAT" ~ "25A",
  cons_unit_oth == "HEAP TINA|TINA HEAPED|HEAP TINA|TINA (HEAPED)" ~ "25B",
  cons_unit_oth == "5L BUCKET" ~ "26",
  cons_unit_oth == "BASIN"~ "27D",
  cons_unit_oth == "1000G PACKET" ~ "37",
  cons_unit_oth == "25 GRAM SATCHET" ~ "41",
  cons_unit_oth == "CLUSTER" ~ "44",
  cons_unit_oth == "PACKET UNSPECIFIED" ~ "51",
  cons_unit_oth == "PACKET (SMALL)|SMALL PACKET|SMALL  PACKET|SMALL PACKAGE|SMALL POCKET|SMALL PACKET GOLD TEA|SMALL TABLE SALT PACKETS" ~ "54",
  cons_unit_oth == "PACKET LARGE|BIG PACKET" ~ "55",
  cons_unit_oth == "TABLE SPOON" ~ "59",
  cons_unit_oth == "PACKET" ~  "60",
  cons_unit_oth == "SMALL TIN" ~ "71", 
       TRUE ~ cons_unitA))

