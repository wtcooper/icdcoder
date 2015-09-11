#' ICD-9 codes with descriptions and hierarchy (major, chapters, and subchapters), taken
#' directly from R's icd9 package:
#'
#'   Jack O. Wasey (2015). icd9: Tools for Working with ICD-9 Codes, and
#' 		Finding Comorbidities. R package version 1.2.  https://github.com/jackwasey/icd9
#' 
#' 
#' @format A data.table with 17561 rows and 7 variables:
#' \describe{
#'   \item{icd9}{icd9 code}
#'   \item{descShort}{short description}
#'   \item{descLong}{long description}
#'   \item{threedigit}{the 3 digit icd9 code}
#'   \item{major}{description at the level of threedigit}
#'   \item{subchapter}{second level hierarchy (e.g., 001-009)}
#'   \item{chapter}{first level hierarchy (e.g., 001-139)}
#' }
#' @source \url{https://github.com/jackwasey/icd9}
"icd9Hierarchy"




#' ICD-10 codes with descriptions and hierarchy (major, chapters, and subchapters), using
#' same format (column names) as from R's icd9 package:
#'
#'   Jack O. Wasey (2015). icd9: Tools for Working with ICD-9 Codes, and
#' 		Finding Comorbidities. R package version 1.2.  https://github.com/jackwasey/icd9
#' 
#' 
#' @format A data.table with 91737 rows and 7 variables:
#' \describe{
#'   \item{icd10}{icd10 code}
#'   \item{descShort}{short description}
#'   \item{descLong}{long description}
#'   \item{threedigit}{the 3 digit icd10 code}
#'   \item{major}{description at the level of threedigit}
#'   \item{subchapter}{second level hierarchy (e.g., A00-A09)}
#'   \item{chapter}{first level hierarchy (e.g., A00-B99)}
#' }
#' @source \url{https://www.cms.gov/Medicare/Coding/ICD10/2016-ICD-10-CM-and-GEMs.html}
"icd10Hierarchy"


#' Crosswalk/mappings from CMS to convert between ICD9 and ICD10.  Note: see the 
#' GEMs guide from CMS for appropriate use -- these are not to be considered 
#' direct mappings, but will provide any range from one to many to many to one
#' mappings.
#' 
#' 
#' @format A data.table with 23947 rows and 3 variables:
#' \describe{
#'   \item{icd9}{icd9 code}
#'   \item{icd10}{icd10 code}
#'   \item{flag}{flag describing the type of mapping (see Guide in url GEMs download)}
#' }
#' @source \url{https://www.cms.gov/Medicare/Coding/ICD10/2016-ICD-10-CM-and-GEMs.html}
"icd9to10GEMs"


#' Crosswalk/mappings from CMS to convert between ICD10 and ICD9.  Note: see the 
#' GEMs guide from CMS for appropriate use -- these are not to be considered 
#' direct mappings, but will provide any range from one to many to many to one
#' mappings.
#' 
#' 
#' @format A data.table with 79192 rows and 3 variables:
#' \describe{
#'   \item{icd9}{icd10 code}
#'   \item{icd10}{icd9 code}
#'   \item{flag}{flag describing the type of mapping (see Guide in url GEMs download)}
#' }
#' @source \url{https://www.cms.gov/Medicare/Coding/ICD10/2016-ICD-10-CM-and-GEMs.html}
"icd10to9GEMs"


#' ICD-9 comorbidity codes for Elixhauser, Charlson, and the
#' Royal College of Surgeons Charlson score.  Definitions to define
#' the comorbidities were borrowed from the R comorbidities.icd10 package
#' at https://github.com/gforge/comorbidities.icd10.  
#' 
#' 
#' @format A data.table with 2084 rows and 4 variables:
#' \describe{
#'   \item{icd9}{icd9 code}
#'   \item{Elixhauser}{Charlson comorbidity based on Deyo and enhanced by Quan}
#'   \item{Charlsons}{Elixhauser comorbidity enhanced by Quan}
#'   \item{CharlsonsRCS}{Royal College of Surgeons Charlson}
#' }
#' @source \url{ https://github.com/gforge/comorbidities.icd10}
"icd9Comorbidities"

#' ICD-10 comorbidity codes for Elixhauser, Charlson, and the
#' Royal College of Surgeons Charlson score.  Definitions to define
#' the comorbidities were borrowed from the R comorbidities.icd10 package
#' at https://github.com/gforge/comorbidities.icd10.  
#' 
#' 
#' @format A data.table with 4589 rows and 4 variables:
#' \describe{
#'   \item{icd10}{icd10 code}
#'   \item{Elixhauser}{Charlson comorbidity based on Deyo and enhanced by Quan}
#'   \item{Charlsons}{Elixhauser comorbidity enhanced by Quan}
#'   \item{CharlsonsRCS}{Royal College of Surgeons Charlson}
#' }
#' @source \url{ https://github.com/gforge/comorbidities.icd10}
"icd10Comorbidities"

