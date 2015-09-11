context("Comorbidity functions ")


test_that("test comorbidities for icd9  ", {
			
			icd9 = c("042", "07033", "140", "2038", "40403" )
			com9Elix= getComorbids(icd9, "icd9", types="Elixhauser")$Elixhauser
			expect_equal(com9Elix, c("HIV","LIVER","SOLID.TUMOR",NA,"CHF","HTN.COMP","RENAL"))
			
			com9Char= getComorbids(icd9, "icd9", types="Charlson")$Charlson
			expect_equal(com9Char, c("HIV","MILD.LIVER","MALIGNANCY","MALIGNANCY","CHF","RENAL"))
		}
)




test_that("test comorbidities for icd10 ", {
			
			icd10 = c("A520", "C008", "E1010", "I6200" )
			com10Elix= getComorbids(icd10, "icd10", types="Elixhauser")$Elixhauser
			expect_equal(com10Elix, c("VALVE","SOLID.TUMOR","DM.UNCOMP",NA))
			
			com10Char= getComorbids(icd10, "icd10", types="Charlson")$Charlson
			expect_equal(com10Char, c(NA, "MALIGNANCY", "DM","CVD"))
		}
)
