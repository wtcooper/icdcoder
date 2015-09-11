context("Validation functions ")


test_that("validation function for icd9 ", {
			icd9 = c("001", "391.0", "001.9", "390", "391", "13413431")
			check = isValidICD(icd9, "icd9")
			expect_equal(check, c(T,T,T,T,T,F))
		}
)


test_that("validation function for icd10 ", {
			icd10 = c("C17.0", "c170", "K60.5", "k604", "11fawa3")
			check = isValidICD(icd10, "icd10")
			expect_equal(check, c(T,T,T,T,F))
		}
)





