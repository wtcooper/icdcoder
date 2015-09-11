require(dplyr)



## This calculates datasets based on the comorbidity information within the 
##  comorbidities.icd10 R package at https://github.com/gforge/comorbidities.icd10
## The comorbidities.icd10 uses a nice regex approach, so I borrowed their approach
##  in order to calculate the two comorbidity dataset (icdXXComorbidities) included 
##  in the icdcoder package
## This is provided if someone wants to add their own comorbidity definitions.


## Pass the code list (see below - the regex definitions), a colName (e.g., "Elixhauser")
##  and the icdVer
getCds <- function (codeList, colName, icdVer) {
	require(stringi)
	
	cdDF = NULL
	## Loop through each comorbidity and get the regex definitions
	for (i in 1:length(codeList)) {
		nm = names(codeList)[i]
		## Get the regex definitions  
		regExCds = paste(codeList[[i]][[icdVer]], collapse="|")
		## Get the dataset of all codes in the icdcoder package  
		hierDF = get(paste(icdVer,"Hierarchy", sep=""), envir=as.environment("package:icdcoder"))
		## Get the codes using stringi::stri_detect_regex  
		cds = hierDF[,get(icdVer)][stri_detect_regex(hierDF[,get(icdVer)], pattern=regExCds)]
		
		if(is.null(cdDF)) cdDF = data.frame(icd = cds, nm = nm, stringsAsFactors=FALSE)
		else cdDF = rbind(cdDF, data.frame(icd = cds, nm = nm, stringsAsFactors=FALSE))
	}
	names(cdDF) = c(icdVer, colName)
	cdDF
}




############
## Elixhausers
## From https://github.com/gforge/comorbidities.icd10/blob/master/R/cmrbdt.finder.regex.elixhauser.R 
##  on 9/10/2015
############


elixhausers <- list(US = list())

#Congestive heart failure
elixhausers$US[['CHF']] <-
		list(icd10 = c('^I099', '^I1(10|3[02])',
						'^I255', '^I4(2[056789]|3)', '^I50', '^P290'),
				icd9 = c('^39891', '^402(01|11|91)',
						'^404(01|03|[19][13])', '^42(5[456789]|8)'))

# Cardiac arrhythmias
elixhausers$US[['ARRHYTHMIA']] <-
		list(icd10 = c('^I44[123]', '^I456', '^I459',
						'^I4[789]', '^R00[018]', '^T821',
						'^Z[49]50'),
				icd9 = c('^426([079]|1[023])',
						'^427[012346789]', # Maybe '^427[^5]' is faster
						'^7850',
						'^9960[14]',
						'^V450', '^V533'))

# Valvular disease
elixhausers$US[['VALVE']] <-
		list(icd10 = c('^A520', '^I0[5678]',
						'^I09[18]', '^I3[456789]',
						'^Q23[0123]', '^Z95[234]'),
				icd9 = c('^0932', '^39[4567]', '^424',
						'^746[3456]', '^V422', '^V433'))

# Pulmonary circulation disorders
elixhausers$US[['PULM.CIRC']] <-
		list(icd10 = c('^I2([67]|8[089])'),
				icd9 = c('^415[01]', '^416',
						'^417[089]'))

elixhausers$US[['PVD']] <-
		list(icd10 = c('^I7([01]|3[189]|71|9[02])', '^K55[189]', '^Z95[89]'),
				icd9 = c('^0930', '^4373', '^44([01]|3[123456789])', '^4471',
						'^557[19]', '^V434'))

# Hypertension, uncomplicated
elixhausers$US[['HTN.UNCOMP']] <-
		list(icd10 = c('^I10'),
				icd9 = c('^401'))

# Hypertension, complicated
elixhausers$US[['HTN.COMP']] <-
		list(icd10 = c('^I1[1235]'),
				icd9 = c('^40[2345]'))

# Paralysis
elixhausers$US[['PARALYSIS']] <-
		list(icd10 = c('^G041', '^G114', '^G8(0[12]|[12]|3[012349])'),
				icd9 = c('^3341', '^34([23]|4[01234569])'))

# Other neurological disorders
elixhausers$US[['NEURO.OTHER']] <-
		list(icd10 = c('^G1[0123]', '^G2[012]', '^G25[45]',
						'^G31[289]',
						'^G3[2567]',
						'^G4[01]', '^G93[14]',
						'^R470', '^R56'),
				icd9 = c('^3319', '^332[01]',
						'^333[45]',
						'^33([45]|62)',
						'^34([015]|8[13])',
						'^78[04]3'))

# Chronic pulmonary disease
elixhausers$US[['CHRONIC.PULM']] <-
		list(icd10 = c('^I27[89]', '^J4[01234567]', '^J6([01234567]|84)', '^J70[13]'),
				icd9 = c('^416[89]', '^49', '^50([012345]|64|8[18])'))


# Diabetes, uncomplicated
# Slightly different from charlsons
elixhausers$US[['DM.UNCOMP']] <-
		list(icd10 = c('^E1[01234][019]'),
				icd9 = c('^250[0123]'))

# Diabetes, complicated
# Slightly different from charlsons
elixhausers$US[['DM.COMP']] <-
		list(icd10 = c('^E1[01234][2345678]'),
				icd9 = c('^250[456789]'))

# Hypothyroidism
elixhausers$US[['HYPOTHYROID']] <-
		list(icd10 = c('^E0[0123]', '^E890'),
				icd9 = c('^2409', '^24([34]|6[18])'))

# Renal failure
# Differs from Charlsons
elixhausers$US[['RENAL']] <-
		list(icd10 = c('^I120', '^I131', '^N1[89]', '^N250', '^Z49[012]', '^Z940', '^Z992'),
				icd9 = c('^403[019]1', '^404[019][23]', '^58([56]|80)',
						'^V4(20|51)', '^V56'))


# Liver disease
elixhausers$US[['LIVER']] <-
		list(icd10 = c('^B18', '^I8(5|64)', '^I982', '^K7(0|1[13457]|[234]|6[023456789])', '^Z944'),
				icd9 = c('^070([23][23]|[45]4|[69])', '^456[012]',
						'^57([01]|2[2345678]|3[3489])', '^V427'))


# Peptic ulcer disease excluding bleeding
elixhausers$US[['PUD']] <-
		list(icd10 = c('^K2[5678][79]'),
				icd9 = c('^53[1234][79]'))


# AIDS/HIV
elixhausers$US[['HIV']] <-
		list(icd10 = c('^B2[0124]'),
				icd9 = c('^04[234]'))

# Lymphoma
elixhausers$US[['LYMPHOMA']] <-
		list(icd10 = c('^C8[123458]',
						'^C96', '^C90[02]'),
				icd9 = c('^20[012]', '^2030', '^2386'))

# Metastatic cancer
elixhausers$US[['METS']] <-
		list(icd10 = c('^C7[789]', '^C80'),
				icd9 = c('^19[6789]'))

# Solid tumor without metastasis
elixhausers$US[['SOLID.TUMOR']] <-
		list(icd10 = c('^C[01]', '^C2[0123456]',
						'^C3[01234789]', '^C4[01356789]', '^C5[012345678]',
						'^C6', '^C7[0123456]', '^C97'),
				icd9 = c('^1[456]', '^17[012456789]', '^18', '^19([012345])'))


# Rheumatoid arthritis/collagen vascular diseases
elixhausers$US[['RHEUM']] <-
		list(icd10 = c('^L94[013]', '^M0[568]', '^M12[03]',
						'^M3(0|1[0123]|[2345])', '^M4(5|6[189])'),
				icd9 = c('^446', '^7010', '^71(0[0123489]|12|4|93)',
						'^72([05]|8(5|89)|930)'))

# Coagulopathy
elixhausers$US[['COAG']] <-
		list(icd10 = c('^D6[5678]',
						'^D69[13456]'),
				icd9 = c('^286', '^2871', '^287[345]'))

# Obesity
elixhausers$US[['OBESITY']] <-
		list(icd10 = c('^E66'),
				icd9 = c('^2780'))

# Weight loss
elixhausers$US[['WT.LOSS']] <-
		list(icd10 = c('^E4[0123456]', '^R634', '^R64'),
				icd9 = c('^26[0123]', '^7832', '^7994'))

# Fluid and electrolyte disorders
elixhausers$US[['LYTES']] <-
		list(icd10 = c('^E222', '^E8[67]'),
				icd9 = c('^2536', '^276'))

# Blood loss anemia
elixhausers$US[['ANEMIA.LOSS']] <-
		list(icd10 = c('^D500'),
				icd9 = c('^2800'))

# Deficiency anemia
elixhausers$US[['ANEMIA.DEF']] <-
		list(icd10 = c('^D50[89]', '^D5[123]'),
				icd9 = c('^280[123456789]', '^281'))

# Alcohol abuse
elixhausers$US[['ETOH']] <-
		list(icd10 = c('^F10', '^E52', '^G621', '^I426',
						'^K292', '^K70[039]',
						'^T51', '^Z502',
						'^Z714', '^Z721'),
				icd9 = c('^2652', '^291[12356789]',
						'^303[09]', '^3050', '^3575',
						'^4255', '^5353', '^571[0123]', '^980', '^V113'))

# Drug abuse
elixhausers$US[['DRUGS']] <-
		list(icd10 = c('^F1[12345689]',
						'^Z715', '^Z722'),
				icd9 = c('^292', '^304', '^305[23456789]', '^V6542'))

# Psychoses
elixhausers$US[['PSYCHOSES']] <-
		list(icd10 = c('^F2[0234589]',
						'^F3([01]2|15)'),
				icd9 = c('^2938',
						'^296[0145]4',
						'^29[578]'))


# Depression
elixhausers$US[['DEPRESSION']] <-
		list(icd10 = c('^F204',
						'^F31[345]', '^F3[23]',
						'^F341', '^F4[13]2'),
				icd9 = c('^296[235]',
						'^30(04|9)', '^311'))



elixDF_icd10 = getCds(elixhausers$US, "Elixhauser", "icd10") 
elixDF_icd9 = getCds(elixhausers$US, "Elixhauser", "icd9") 






############
## Charlson
## From https://github.com/gforge/comorbidities.icd10/blob/master/R/cmrbdt.finder.regex.charlson.R 
##  on 9/10/2015
############

# Based on Quan et al 2005
charlsons_v2 <- list(US=list())
charlsons_v2$US[['MI']] <-
		list(icd10 = c('^I2([12]|52)'),
				icd9 = c('^41[02]'))

charlsons_v2$US[['CHF']] <-
		list(icd10 = c('^I099', '^I1(10|3[02])', '^I255', '^I4(2[056789]|3)', '^I50', '^P290'),
				icd9 =  c('^39891', '^402(01|11|91)', '^404(01|03|[19][13])', '^42(5[456789]|8)'))

charlsons_v2$US[['PVD']] <-
		list(icd10 = c('^I7([01]|3[189]|71|9[02])', '^K55[189]', '^Z95[89]'),
				icd9 = c('^0930', '^4373', '^44([01]|3[123456789]|71)', '^557[19]', '^V434'))

charlsons_v2$US[['CVD']] <-
		list(icd10 = c('^G4[56]', '^H340', '^I6'),
				icd9 = c('^36234', '^43[012345678]'))

charlsons_v2$US[['DEMENTIA']] <-
		list(icd10 = c('^F0([0123]|51)', '^G3(0|11)'),
				icd9 = c('^29(0|41)', '^3312'))

charlsons_v2$US[['COPD']] <-
		list(icd10 = c('^I27[89]', '^J4[01234567]', '^J6([01234567]|84)', '^J70[13]'),
				icd9 = c('^416[89]', '^49', '^50([012345]|64|8[18])'))

charlsons_v2$US[['RHEUM']] <-
		list(icd10 = c('^M0[56]', '^M3(15|[234]|5[13]|60)'),
				icd9 = c('^4465', '^71(0[01234]|4[0128])', '^725'))

charlsons_v2$US[['PUD']] <-
		list(icd10 = c('^K2[5678]'),
				icd9 = c('^53[1234]'))

charlsons_v2$US[['MILD.LIVER']] <-
		list(icd10 = c('^B18', '^K7(0[01239]|1[3457]|[34]|6[023489])', '^Z944'),
				icd9 = c('^070([23][23]|[45]4|[69])', '^57([01]|3[3489])', '^V427'))

charlsons_v2$US[['DM']] <-
		list(icd10 = c('^E1[01234][01689]'),
				icd9 = c('^250[012389]'))

charlsons_v2$US[['DM.COMP']] <-
		list(icd10 = c('^E1[01234][23457]'),
				icd9 = c('^250[4567]'))

charlsons_v2$US[['PLEGIA']] <-
		list(icd10 = c('^G041', '^G114', '^G8(0[12]|[12]|3[012349])'),
				icd9 = c('^3341', '^34([23]|4[01234569])'))

charlsons_v2$US[['RENAL']] <-
		list(icd10 = c('^I120', '^I131', '^N0(3[234567]|5[234567])', '^N1[89]', '^N250', '^Z49[012]', '^Z940', '^Z992'),
				icd9 = c('^403[019]1', '^404[019][23]', '^58(2|3[01234567]|[56]|80)', '^V4(20|51)', '^V56'))

charlsons_v2$US[['MALIGNANCY']] <-
		list(icd10 = c('^C[01]', '^C2[0123456]', '^C3[01234789]', '^C4[01356789]', '^C5[012345678]', '^C6', '^C7[0123456]', '^C8[123458]', '^C9[01234567]'),
				icd9 = c('^1[456]', '^17[012456789]', '^18', '^19[012345]', '^20[012345678]', '^2386'))

charlsons_v2$US[['SEVERE.LIVER']] <-
		list(icd10 = c('^I8(5[09]|64)', '^I982', '^K7(04|[12]1|29|6[567])'),
				icd9 = c('^456[012]', '^572[2345678]'))

charlsons_v2$US[['METASTASIS']] <-
		list(icd10 = c('^C7[789]', '^C80'),
				icd9 = c( '^19[6789]'))

charlsons_v2$US[['HIV']] <-
		list(icd10 = c('^B2[0124]'),
				icd9 = c('^04[234]'))


charlDF_icd10 = getCds(charlsons_v2$US, "Charlsons", "icd10") 
charlDF_icd9 = getCds(charlsons_v2$US, "Charlsons", "icd9") 



#################
## Armitage
## From https://github.com/gforge/comorbidities.icd10/blob/master/R/cmrbdt.finder.regex.RCS_charlson.R 
##  on 9/10/2015
#################

# Based on Armitage JN, van der Meulen JH.
# -- Identifying co-morbidity in surgical patients using
# --- administrative data with the Royal College of Surgeons Charlson Score.
# -- British Journal of Surgery. 2010 Maj 1;97(5):772-781.

rcs_charlsons <- list(US = list())
rcs_charlsons$US[['MI']] <-
		list(icd10 = c('^I2([123]|52)'),
				icd9 = c('^41[02]'))

rcs_charlsons$US[['CHF']] <-
		list(icd10 = c('^I1[13]', '^I255', '^I4[23]', '^I50', '^I517'),
				icd9 = c('^39891', '^402(01|11|91)', '^404(01|03|[19][13])', '^42(5[456789]|8)'))

rcs_charlsons$US[['PVD']] <-
		list(icd10 = c('^I7[0123]', '^I77[01]', '^K55[189]', '^R02', '^Z95[89]'),
				icd9 = c('^0930', '^4373', '^44([01]|3[123456789]|71)', '^557[19]', '^V434'))

rcs_charlsons$US[['CEVD']] <-
		list(icd10 = c('^G4[56]', '^I6'),
				icd9 = c('^36234', '^43[012345678]'))

rcs_charlsons$US[['DEM']] <-
		list(icd10 = c('^A810','^F0([0123]|51)', '^G3[01]'),
				icd9 = c('^29(0|41)', '^3312'))

rcs_charlsons$US[['COPD']] <-
		list(icd10 = c('^I26', '^I27', '^J4[01234567]', '^J6([01234567]|84)', '^J70[13]'),
				icd9 = c('^416[89]', '^49', '^50([012345]|64|8[18])'))

rcs_charlsons$US[['Rheum']] <-
		list(icd10 = c('^M0[569]', '^M120', '^M3(15|[23456])'),
				icd9 = c('^4465', '^71(0[01234]|4[0128])', '^725'))

rcs_charlsons$US[['LD']] <-
		list(icd10 = c('^B18', '^I85', '^I864', '^I982', '^K7([01]|2[19]|6)', '^R162', '^Z944'),
				icd9 = c('^070([23][23]|[45]4|[69])', '^456[012]', '^572[2345678]', '^57([01]|3[3489])', '^V427'))

rcs_charlsons$US[['DIAB']] <-
		list(icd10 = c('^E1[01234]'),
				icd9 = c('^250'))

rcs_charlsons$US[['PARA']] <-
		list(icd10 = c('^G114', '^G8[123]'),
				icd9 = c('^3341', '^34([23]|4[01234569])'))

rcs_charlsons$US[['RD']] <-
		list(icd10 = c('^I1[23]', '^N0[13578]', '^N1(7[12]|[89])', '^N25', '^Z49', '^Z940', '^Z992'),
				icd9 = c('^403[019]1', '^404[019][23]', '^58(2|3[01234567]|[56]|80)', '^V4(20|51)', '^V56'))

rcs_charlsons$US[['CANCER']] <-
		list(icd10 = c('^C[01]', '^C2[0123456]', '^C3[01234789]', '^C4[01356789]', '^C5[012345678]', '^C6', '^C7[0123456]', '^C8[0123458]', '^C9[01234567]'),
				icd9 = c('^1[456]', '^17[012456789]', '^18',
						'^19[012345678]', '^20[012345678]',
						'^2386'))

rcs_charlsons$US[['METASTASIS']] <-
		list(icd10 = c('^C7[789]'),
				icd9 = c( '^19([678]|91)'))

rcs_charlsons$US[['HIV']] <-
		list(icd10 = c('^B2[0124]'),
				icd9 = c('^04[234]'))


rec_charlDF_icd10 = getCds(rcs_charlsons$US, "CharlsonsRCS", "icd10") 
rec_charlDF_icd9 = getCds(rcs_charlsons$US, "CharlsonsRCS", "icd9") 



## Set up the final datasets

icd10Comorbidities = elixDF_icd10 %>% full_join(charlDF_icd10) %>% full_join(rec_charlDF_icd10)
icd10Comorbidities[,2:4] = apply(icd10Comorbidities[,2:4], 2, toupper)


icd9Comorbidities = elixDF_icd9 %>% full_join(charlDF_icd9) %>% full_join(rec_charlDF_icd9)
icd9Comorbidities[,2:4] = apply(icd9Comorbidities[,2:4], 2, toupper)
