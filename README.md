# ihs5_cleaning_github


## Introducing the Malawi’s IHS5 data cleaning process

Tang et al. (2021) and Adams et al. (2022) describe how to tidy, process, and transform HCES food consumption or acquisition data into usable metrics for estimating household-level apparent food consumption and micronutrient intake. We used the steps from Tang et al. and Adams et al. to analyse Malawi's IHS5 data.  This code repository was created to provide detailed instructions for cleaning and processing IHS5 data. The repository is divided into four sections. 

* `scripts` - R scripts for IHS5 data processing<br>
* `data` - Complementary data relating to the scripts(upon request)<br>
* `output` - The folder where final outputs from the script will be saved<br>

Below is a directory tree that outlines the structure of the repository:

```
├─ scripts/
│  ├─ ihs5_cleaning.Rmd
│  ├─ afe_calc.Rmd
├─ data(Upon Request)/
│  ├─ edible_portion.csv
│  ├─ Food groups.csv                       
│  ├─ Food Composition Table.csv
│  ├─ ihs4_factors.xls
│  ├─ ihs5_factors.csv
├─ output/ 

```
This file system is designed to preserve the protections on the dataset provided by The World Bank. Any additional files saved in the data folder (or changes made to the files in the data folder), as well as files in the inter-output and output folders, will not be uploaded to github. This behavior is controlled by the .gitignore files in the main repo folder, and in the inter-output and output folders, should you wish to alter it. 


## How to run the scripts 
The scripts are in R markdown format, and for efficiency and the desired output, they should be run in the order listed below: 

 1. *afe_calc*
 2. *ihs5_cleaning*

## Data-sources
The Malawi's Fifth Integrated Household Survey (IHS5) data can be requested using the link provided below: <br>

* [Malawi Fifth Integrated Household Survey 2019-2020](https://microdata.worldbank.org/index.php/catalog/3818) <br>

Once logged in, please click download on the 'Data in Stata format' option. Once downloaded, please unzip the file, and move it to the 'data' folder of this repository; e.g. "GitHub\ihs5_cleaning_github\data\MWI_2019_IHS-V_v06_M_Stata".
