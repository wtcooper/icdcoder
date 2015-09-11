context("Conversion functions ")


test_that("test conversion from icd9 to icd10 ", {
			
			icd9 = c("2","01480", "001.9", "390", "391", "13413431")
			icd10s = convICD(icd9, "icd9")$icd10
			expect_equal(icd10s, c("A009",NA, "A1832","A1839",  NA, "I00", NA))
		}
)



test_that("test conversion for icd10 to icd9 ", {
			icd10 = c("C17.0", "c170", "K60.5", "k604", "11fawa3")
			icd9s = convICD(icd10, "icd10")$icd9
			expect_equal(icd9s, c(NA, "1520", "1520", "5651", "5651"))
		}
)





