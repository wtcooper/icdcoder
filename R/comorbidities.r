

#' Modified version of dplyr's select that uses string arguments
s_select = function(.data, ...) {
  eval.string.dplyr(.data,"select", ...)
}


#' Internal function used by s_filter, s_select etc.
eval.string.dplyr = function(.data, .fun.name, ...) {
  args = list(...)
  args = unlist(args)
  code = paste0(.fun.name,"(.data,", paste0(args, collapse=","), ")")
  df = eval(parse(text=code,srcfile=NULL))
  df  
}



#' Get comorbidities for a list of ICD9 codes 
#' @param icd9 icd9 code
#' @return data.table of icd9 codes and their comorbities
getComorbidsICD9 <- function(icd9) {
	require(stringr)
	require(dplyr)
	
	icd9=str_pad(gsub("\\.","",icd9), width=3, pad="0") 
	icd9=data.table(icd9=icd9)
	setkey(icd9, "icd9")
	icd9 %>% 
			dplyr::left_join(icdcoder::icd9Comorbidities, by="icd9") 
}


#' Get comorbidities for a list of ICD10 codes 
#' @param icd10 icd10 code
#' @return data.table of icd10 codes and their comorbities
getComorbidsICD10 <- function(icd10) {
	require(dplyr)
	
	icd10 = data.table(icd10=toupper(gsub("\\.","",icd10)))
	setkey(icd10, "icd10")
	icd10 %>% 
			dplyr::left_join(icdcoder::icd10Comorbidities, by="icd10") 
}




#' Get comorbidities for a list of ICD codes.
#' 
#' @param icd code
#' @param icdVer icd version ("icd9" or "icd10")
#' @param types types of comorbidities (default = c("Elixhauser","Charlson","CharlsonRCS")) 
#' @return data.table of icd codes and the type(s) of comorbidities
#' @export
getComorbids <- function(icd, icdVer, types=c("Elixhauser","Charlson","CharlsonRCS")) {
	
	if (!(icdVer %in% c("icd9", "icd10"))) {
		cat("icdVer must be either 'icd9' or 'icd10'\n")
		return()
	}
	
	cds=NULL
	
	# note: need to convert here to data.frame() since running distinct() on a key'ed data.table()
	#  will select the first key and that's it; this has been flagged in dplyr multiple times
	#  but still not fixed to provide consisent behavior with data.frame vs data.table
	if (icdVer=="icd9") {
		cds = getComorbidsICD9(icd) %>% 
				s_select(c(icdVer,types)) %>% 
				data.frame() %>% 
				dplyr::distinct() %>% 
				data.table()
	}
	if (icdVer=="icd10") {
		cds = getComorbidsICD10(icd) %>% 
				s_select(c(icdVer,types)) %>% 
				data.frame() %>% 
				dplyr::distinct() %>% 
				data.table()
	}
	
	cds
}




