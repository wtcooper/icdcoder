

#' Checks if ICD9 code(s) are valid.  Values should be 
#' in the correct format, but this method will pad the 
#' string with leading zeros if the length is <3.
#' 
#' @param icd9 icd9 code
isValidICD9 <- function(icd9) {
	require(stringr)
	icd9=str_pad(gsub("\\.","",icd9), width=3, pad="0")
	icd9 %in% icdcoder::icd9Hierarchy$icd9
}




#' Checks if ICD10 code(s) are valid.  
#' 
#' @param icd10 icd10 code
isValidICD10 <- function(icd10) {
	icd10 = toupper(gsub("\\.","",icd10))
	icd10 %in% icdcoder::icd10Hierarchy$icd10 
}




#' Checks if ICD code(s) are valid.  
#' 
#' @param icd code(s)
#' @param icdVer icd version ("icd9" or "icd10")
#' @return logical(s)
#' @export
isValidICD <- function(icd, icdVer) {
	if (!(icdVer %in% c("icd9", "icd10"))) {
		cat("icdVer must be either 'icd9' or 'icd10'\n")
		return()
	}
	
	
	logi=NULL
	
	if (icdVer=="icd9") logi = isValidICD9(icd)
	if (icdVer=="icd10") logi = isValidICD10(icd)
	
	logi
}
