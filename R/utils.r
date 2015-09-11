

#' Get's all ICD-9 codes within a range (inclusive).
#' 
#' @param icd9St start of range
#' @param icd9End end of range
getRangeICD9 <- function(icd9St, icd9End) {
	require(stringr)
	icd9St=str_pad(gsub("\\.","",icd9St), width=3, pad="0")
	icd9End=str_pad(gsub("\\.","",icd9End), width=3, pad="0")
	
	icd9Cds = icdcoder::icd9Hierarchy$icd9
	icd9Cds[icd9Cds>=icd9St & icd9Cds<=icd9End]
}



#' Get's all ICD-10 codes within a range (inclusive).
#' 
#' @param icd9St start of range
#' @param icd9End end of range
getRangeICD10 <- function(icd10St, icd10End) {
	icd10St=toupper(gsub("\\.","",icd10St))
	icd10End=toupper(gsub("\\.","",icd10End))
	
	icd10Cds = icdcoder::icd10Hierarchy$icd10
	icd10Cds[icd10Cds>=icd10St & icd10Cds<=icd10End]
}






#' Get's all ICD codes within a range (inclusive)
#' 
#' @param icdSt code start
#' @param icdEnd code end
#' @param icdVer icd version ("icd9" or "icd10")
#' @return vector of icd codes
#' @export
getICDRange <- function(icdSt, icdEnd, icdVer) {
	if (length(icdSt)>1 | length(icdEnd)>1) {
		cat("getChildren() can only handle a single code...exiting\n")
		return()
	}
	if (!(icdVer %in% c("icd9", "icd10"))) {
		cat("icdVer must be either 'icd9' or 'icd10'\n")
		return()
	}
	
	cds=NULL
	
	if (icdVer=="icd9") cds = getRangeICD9(icdSt, icdEnd)
	if (icdVer=="icd10") cds = getRangeICD10(icdSt, icdEnd)
	
	cds
}





#' Get's all children for a single icd9 code (i.e., those under the
#' current hierarchy)
#' 
#' @param icd9 icd9 code
getChildrenICD9 <- function(icd9) {
	require(stringr)
	icd9=str_pad(gsub("\\.","",icd9), width=3, pad="0")
	icd9Cds = icdcoder::icd9Hierarchy$icd9
	
	regexPat = paste("^",icd9, sep="")
	children = icd9Cds[str_detect(icd9Cds, pattern=regexPat)]
	children[-which(icd9 %in% children)]
}


#' Get's all children for a single icd10 code (i.e., those under the
#' current hierarchy)
#' 
#' @param icd10 icd10 code
getChildrenICD10 <- function(icd10) {
	require(stringr)
	icd10=toupper(gsub("\\.","",icd10))
	icd10Cds = icdcoder::icd10Hierarchy$icd10
	
	regexPat = paste("^",icd10, sep="")
	children = icd10Cds[str_detect(icd10Cds, pattern=regexPat)]
	children[-which(icd10 %in% children)]
}





#' Get's all children for a single icd10 code (i.e., those under the
#' current hierarchy)
#' 
#' @param icd code
#' @param icdVer icd version ("icd9" or "icd10")
#' @return vector of icd codes
#' @export
getICDChildren <- function(icd, icdVer) {
	if (length(icd)>1) {
		cat("getChildren() can only handle a single code...exiting\n")
		return()
	}
	if (!(icdVer %in% c("icd9", "icd10"))) {
		cat("icdVer must be either 'icd9' or 'icd10'\n")
		return()
	}
	
	
	cds=NULL
	
	if (icdVer=="icd9") cds = getChildrenICD9(icd)
	if (icdVer=="icd10") cds = getChildrenICD10(icd)
	
	cds
}
