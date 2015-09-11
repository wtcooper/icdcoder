context("Utility functions ")


test_that("test range of ICD9 ", {
			
			icd9St="001"
			icd9End = "002"
			range = getICDRange(icd9St, icd9End, "icd9")
			expect_equal(range, c("001", "0010","0011",  "0019", "002"))
		}
)


test_that("test range of ICD10 ", {
			
			icd10St="A010"
			icd10End = "A011"
			range = getICDRange(icd10St, icd10End, "icd10")
			expect_equal(range, c("A010","A0100","A0101","A0102","A0103","A0104","A0105","A0109","A011"))
		}
)

 

test_that("test get children of ICD10 code ", {
			icd10 = "C17"
			child10 = getICDChildren(icd10, "icd10")
			expect_equal(child10, c("C170", "C171","C172","C173","C178","C179"))
			
			icd10 = "O23.51"
			child10 = getICDChildren(icd10, "icd10")
			expect_equal(child10, c("O23511","O23512","O23513","O23519"))
			
		}
)




test_that("test get children of ICD9 code ", {
			icd9 = "026"
			child9 = getICDChildren(icd9, "icd9")
			expect_equal(child9, c("0260", "0261","0269"))
			
			icd9 = "722.3"
			child9 = getICDChildren(icd9, "icd9")
			expect_equal(child9, c("72230","72231","72232","72239"))
		}
)
