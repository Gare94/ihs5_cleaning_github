# ihs5_cleaning_github


## Introducing the Malawi’s IHS5 data cleaning process

Tang et al. (2021) and Adams et al. (2022) describe how to tidy, process, and transform HCES food consumption or acquisition data into usable metrics for estimating household-level apparent food consumption and micronutrient intake. We used the steps from Tang et al. and Adams et al. to analyse Malawi's IHS5 data.  This code repository was created to provide detailed instructions for cleaning and processing IHS5 data. The repository is divided into four sections. 

* `scripts` - Series of R scripts for IHS5 data processing<br>
* `data` - Complementary data relating to the scripts<br>
* `inter-output` - The folder where intermediate outputs between scripts will be saved<br>
* `output` - The folder where final outputs from the script will be saved<br>

Below is a directory tree that outlines the structure of the repository:

```
├─ scripts/
│  ├─ 1_ihs5_cleaning.Rmd
│  ├─ 1B_ihs5_cleaning.Rmd
│  ├─ 2_ihs5_nsu_conversion.Rmd
│  ├─ 3_afeIHS5.Rmd
│  ├─ 4_ihs5_outliers.Rmd
│  ├─ 5_fgMatch.Rmd
│  ├─ 6_fctMatchFinal.Rmd
├─ data/
│  ├─ FAO.12fg.csv
│  ├─ edible_portion_clean.csv                           
│  ├─ fct_ihs5_vv2.1.csv
│  ├─ hme.final.csv
│  ├─ ihs4factors_v5.xls
│  ├─ ihs5.ame.factors.csv
│  ├─ ihs5.ame.spec.csv
│  ├─ ihs5factor.other(23).csv
│  ├─ ihs5factors_clean.csv
├─ inter-output/ 
├─ output/ 

```
This file system is designed to preserve the protections on the dataset provided by The World Bank. Any additional files saved in the data folder (or changes made to the files in the data folder), as well as files in the inter-output and output folders, will not be uploaded to github. This behavior is controlled by the .gitignore files in the main repo folder, and in the inter-output and output folders, should you wish to alter it. 


## How to run the scripts 
The scripts are in R markdown format, and for efficiency and the desired output, they should be run in the order listed below: 

 1. *1_ihs5_cleaning*
 2. *1B_ihs5_cleaning*
 3. *2_ihs5_nsu_conversion*
 4. *3_afeIHS5*
 5. *4_ihs5_outliers*
 6. *5_fgMatch*
 7. *6_fctmatchFinal*

## Data-sources
The Malawi's Fifth Integrated Household Survey (IHS5) data can be requested using the link provided below: <br>

* [Malawi Fifth Integrated Household Survey 2019-2020](https://microdata.worldbank.org/index.php/catalog/3818) <br>

Once logged in, please click download on the 'Data in Stata format' option. Once downloaded, please unzip the file, and move it to the 'data' folder of this repository; e.g. "GitHub\ihs5_cleaning_github\data\MWI_2019_IHS-V_v06_M_Stata".
