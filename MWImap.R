
#Trial Script for spatial analysis 

library(sf)
library(tidyverse)
library(tmap)
library(readxl)

#Areas to aggregate over 
MWI_Districts <- st_read("./mwi_bnd_admin2/mwi_bnd_admin2.shp", crs = 4326) #By District from Malawi NSO
MWI_LivelihoodZones <- st_read("./MW_LHZ_2015/MW_LHZ_2015.shp", crs = 4326) # By Livelihood zones

SHPs <- list(MWI_LivelihoodZones, MWI_Districts)

#Lake Malawi (currently not in use)
MWI_lake <- st_read("./mwi_bnd_admin2/mwi_bnd_admin2.shp", crs = 4326) %>% filter(OBJECTID == '23')

# Copying CRS from MWI shapefile
WGS84_CRS <- st_crs(MWI_LivelihoodZones)

# Loading IHS5 csv and converting to sf object
df <- read.csv("./ihs5_afe_inad.csv", header = T) %>% 
  st_as_sf(coords = c("Longitude_modified", "Latitude_modified"),crs = WGS84_CRS)

for (SHP in SHPs){
  
  #Load the additional IHS5 files with Iron(Fe)
  if ("LZCODE" %in% colnames(SHP)){
    Fe_LHZ <- read_excel("./Prev_Fe_inad(LHZ).xlsx",sheet = 1, col_names = TRUE) %>% as.data.frame()
    SHP <- merge(x = SHP, y = Fe_LHZ, by.x = "LZCODE",by.y="LZCODE",all.x = TRUE)
    output_map_name <- "./MWI_LivelihoodZones.png"
  } else if ("NAME_2" %in% colnames(SHP)){
    Fe_D <- read_excel("./Prev_Fe_inad(DISTRICT).xlsx",sheet = 1, col_names = TRUE) %>% as.data.frame()
    SHP <- merge(x = SHP, y = Fe_D, by.x="NAME_2", by.y="MWI_NAME_2",all.x = TRUE)
    output_map_name <- "./MWI_Districts.png"
  }
  
  
  plot(SHP[,1],reset = FALSE, col = "grey")
  plot(df, add = TRUE,col="blue")
  
  #Full list of micronutrients to loop through and compute percentage Inadequacies
  MNs <- list("Ca","VC" ,"VB2" ,"VB12","Zn", "VE", "Se", "VB3") # iron not included since its already calculated
  
  for (m in MNs){
    m.name <- paste0("afe.",m) #Full column name structure
    #Creating column names from the list provided
    m.name.InAd.count <- paste0(m.name,".Inad.count")
    m.name.Ad.count <- paste0(m.name,".Ad.count")
    m.name.Tot.count <- paste0(m.name,".Tot.count")
    m.name.perc.InAd <- paste0(m.name,"_%InAd")
    
    #Filtering the points provided on the Inade/ade factors
    x <- df %>% filter(eval(as.name(paste0("afe.",m))) == "Inadequate") #This works
    y <- df %>% filter(eval(as.name(paste0("afe.",m))) == "Adequate") #This works
    
    #Counting points in each aggregation area
    SHP[,m.name.InAd.count] <- i <- lengths(st_intersects(SHP,x)) #Count number of Inadequate points in each sub-unit
    SHP[,m.name.Ad.count] <- a <- lengths(st_intersects(SHP,y)) # Storing the counts in the SHP and a vector is more efficient
    SHP[,m.name.Tot.count] <- t <- lengths(st_intersects(SHP,df))
    
    #Calculating the Inadequacy percentage  
    SHP[,m.name.perc.InAd] <- round(100*i/t) # Calculate Inadequacy percentage
  }  
  
  #Universal pallet for all maps, A change here will be effected in the loop as well.
  my.palette = "viridis" 
  my.breaks <- seq(30,100,10)
  
  #Function that create maps
  mapcreator <- function(sf_file, micronutrient,f.breaks,f.my.pallete) {
    column_name <- paste0("afe.",micronutrient,"_%InAd")
    title <- paste0(micronutrient,"_%InAd")
    tm_shape(sf_file) +
      tm_polygons(column_name,
                  palette = my.palette,
                  style='fixed', 
                  breaks=my.breaks,
                  title = title ,legend.show = FALSE) +
      tm_layout(title="",frame = FALSE) +
      tm_scale_bar(color.dark = "black",
                   position = c("left", "bottom")) + 
      tm_compass(type = "4star", size = 2.5, fontsize = 0.5,
                 color.dark = "black", text.color = "black",
                 position = c("right", "top"))
  }
  
  
  #Create maps of all micronutrients using the function above
  calcium_map <- mapcreator(sf_file=SHP,
                            micronutrient = "Ca",
                            f.breaks = my.breaks,
                            f.my.pallete = my.palette)
  vitC_map <- mapcreator(sf_file=SHP,
                         micronutrient = "VC",
                         f.breaks = my.breaks,
                         f.my.pallete = my.palette)
  ribo_map <- mapcreator(sf_file=SHP,
                         micronutrient = "VB2",
                         f.breaks = my.breaks,
                         f.my.pallete = my.palette)
  vitB12_map <- mapcreator(sf_file=SHP,
                           micronutrient = "VB12",
                           f.breaks = my.breaks,
                           f.my.pallete = my.palette)
  zinc_map <- mapcreator(sf_file=SHP,
                         micronutrient = "Zn",
                         f.breaks = my.breaks,
                         f.my.pallete = my.palette)
  iron_map <- mapcreator(sf_file = SHP,
                         micronutrient = "iron",
                         f.breaks = my.breaks,
                         f.my.pallete = my.palette)
  vitE_map <- mapcreator(sf_file=SHP,
                         micronutrient = "VE",
                         f.breaks = my.breaks,
                         f.my.pallete = my.palette)
  Sel_map <- mapcreator(sf_file=SHP,
                        micronutrient = "Se",
                        f.breaks = my.breaks,
                        f.my.pallete = my.palette)
  niac_map <- mapcreator(sf_file=SHP,
                         micronutrient = "VB3",
                         f.breaks = my.breaks,
                         f.my.pallete = my.palette)
  
  #Create universal legend from one of the maps
  legend_map <- tm_shape(SHP) +
    tm_polygons("afe.Se_%InAd",
                palette = my.palette ,
                style='fixed', 
                breaks=my.breaks,
                title = "Prev. of inadequacy (%)") +
    tm_layout(title="Legend",legend.only = TRUE) 
  
  #Combine all the maps on one layout
  combined_maps <- tmap_arrange(calcium_map,
                                iron_map,
                                zinc_map,
                                vitB12_map,
                                ribo_map,
                                vitC_map,
                                vitE_map,
                                Sel_map,
                                niac_map,
                                legend_map,
                                ncol = 3,
                                nrow = 3)
  
  #Export the maps to file
  tmap_save(tm=combined_maps,filename = output_map_name)
}


################################################################################################
################################################################################################
################################################################################################


 


