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
