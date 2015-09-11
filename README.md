# icdcoder
ICD-9 and ICD-10 code utility functions and datasets

## Overview
Utility functions to work with and between ICD-9 and ICD-10, along with datasets that provide the hierarchies for the ICD chapters,
comorbidities, and CMS GEMs (for conversions).  Includes functions to validate, get all codes within a range, all children of a code level, 
mappings to convert to/from icd9 and icd10 (CMS GEMs), and get comorbidities.  Comorbidities (Elixhauser and Charlson from Quan et al. (2005), 
and Royal College of Surgeons Charlson) are based upon the comorbidities.icd10 package (https://github.com/gforge/comorbidities.icd10), 
and the dataset for the hierarchy of icd9 codes is taken directly from the icd9 package (https://github.com/jackwasey/icd9).   <br />

## Installation

```R
library(devtools) 
devtools::install_github("wtcooper/icdcoder")
```



## Example Use

```R
require(devtools)
require(dplyr)
require(data.table)
require(icdcoder)

## Set up example dataset
dat = data.table(patient=c(1,1,1,1,2,2,2,2), icdVer=c(9,9,9,10,9,9,10,10), code=c("042", "0703333", "140", "A520", "2038", "40403", "C008",  "E1010"))

## Check if codes are valid (2nd icd9 code not)
isValidICD((dat %>% filter(icdVer==9))$code, "icd9")
isValidICD((dat %>% filter(icdVer==10))$code, "icd10")

## Get a range of values...it's inclusive
getICDRange("001","002", "icd9")  		# return 001-002
getICDRange("001","001999999", "icd9")  # eg non-inclusive endpoint
getICDRange("A00","A03", "icd10")  		# icd10 codes in range


## Get children under a hierarchy
getICDChildren("001", "icd9")			# similar to range above but doesn't include 001
getICDChildren("A01", "icd10")			

## Convert codes using the GEMs
convICD("0011", "icd9")
convICD("A001", "icd10")

# note: parent codes don't convert so will return NAs for invalid or parent codes
convICD((dat %>% filter(icdVer==9))$code, "icd9")
convICD((dat %>% filter(icdVer==10))$code, "icd10")


## Get comorbidities
getComorbids((dat %>% filter(icdVer==9))$code, "icd9")
getComorbids((dat %>% filter(icdVer==10))$code, "icd10")


## roll out Elixhauser comorbidities to dummy codes
d = getComorbids((dat %>% filter(icdVer==9))$code, "icd9", type="Elixhauser")
datComorbs = dat %>% 
    filter(icdVer==9) %>% 
    rename(icd9=code) %>%
    left_join(d, by="icd9") %>% 
    filter(!is.na(Elixhauser))

datComorbs %>% 
    group_by(patient) %>%
    select(Elixhauser) %>%
    table() %>%
    as.data.frame.matrix() 
  ```
