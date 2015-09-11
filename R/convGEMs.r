

#' Converts ICD9 codes to ICD10 codes
#' @return data.table of original codes and converted codes
convICD9to10 <- function(icd9) {
	require(stringr)
	require(dplyr)
	icd9=str_pad(gsub("\\.","",icd9), width=3, pad="0") 
	icd9=data.table(icd9=icd9)
	setkey(icd9, "icd9")
	icd9 %>% 
			dplyr::left_join(icdcoder::icd9to10GEMs, by="icd9") %>% 
			dplyr::select(-flag)
}


#' Converts ICD10 codes to ICD9 codes
#' @return data.table of original codes and converted codes
convICD10to9 <- function(icd10) {
	require(dplyr)
	
	icd10 = data.table(icd10=toupper(gsub("\\.","",icd10)))
	setkey(icd10, "icd10")
	icd10 %>% 
			dplyr::left_join(icdcoder::icd10to9GEMs, by="icd10") %>% 
			dplyr::select(-flag)
}




#' Uses the CMS GEMs (crosswalks/mappings) to convert between
#' ICD-9 and ICD-10.  
#' 
#' @param icd code(s)
#' @param icdVer icd version ("icd9" or "icd10")
#' @return data.table of original codes and converted codes
#' @export
convICD <- function(icd, icdVer) {
	if (!(icdVer %in% c("icd9", "icd10"))) {
		cat("icdVer must be either 'icd9' or 'icd10'\n")
		return()
	}
	
	conv=NULL
	
	if (icdVer=="icd9") conv = convICD9to10(icd)
	if (icdVer=="icd10") conv = convICD10to9(icd)
	
	conv
}
