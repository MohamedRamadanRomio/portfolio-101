DIRTEY HOSPITAL DATASET PROJECT: (Patient_records sheet)

1)we try to standardize the id column as it's our key column for joining later 
  first we made all the (PT-****) capital letters (UPPER), then we checked rows that don't contain PT- at first and we add it and then we checked rows that miss (-) after the (PT) and we added it so the standard formula is (PT-****) "PT-" & Text.PadStart([Column], 4, "0").
  second we want to fill nulls the pattern is (PT-1***) and the next is (PT-1*** + 1 ) and like that that's how we filled the nulls and we fixed duplicates in the same manner keeping the pattern.

2)in patient name columns there are null values ( 8 values) and some duplicates we should get a confirmation first before making the decision either we should impute them or leave them or delete but for now i leave them as every patients has a unique ID. 

3) we categorized age column to (male, female, unknown) 
 we checked if the patient is duplicated using multi columns confirmation and we used that to fill the null in gender and when it was null and not duplicated in data we set it to unknown

4) age was categorized into only numbers removing any characters from it ( 53 years to 53) we did it manually as using power query here was more time and effort consuming as they only were a few values to clean here
and then we imputed nulls and outliers like (150 y/o) to average according to gender (male:55, female:52, unknown:50 y/o)

5) to standardize birth date to format (YYYY-MM-DD) we will use power query but we will extract values in a helper column to work on them, we changed the format of the column to date format(fixed ~77% dates) but some values appeared as error. so we put the errors as null
in a large dataset it's preferred to leave them as a null but in smaller dataset you can manually humanly try to decode the formulas the power query couldn't.
N.B for large dataset +100,000 if the date of birth column matters some patter recognition and code automation could be done to fix as values as possible

6) nationality was standardized using filter to consider the different pattern of inputs and different countries and then standardized every country for one format 

7) phone number column was changed to either a number or blank (null)

8) for diagnosis column (N/A) were set to null but (Unknown) and (?) were categorized to unknown as the diagnose could have a valid value of unknown as they couldn't reach a specific diagnosis.
Different inputs of disease names were standardized from out medical view (AMI, MI, Myocardial infarction are all the same).
Worth mentioning here there were (lung infection, pneumonia and TB) they all could be considered as lung infection but it would be misleading as lung infection is a broad kind of diseases so it's better not to standardize them all as one thing but we still can flag pneumonia and TB as also a lung infection.

9) for blood pressure some inputs were systolic , diastolic and systolic/diastolic so we extracted values from systolic/diastolic to fill the values in the other columns and the concatenated values from systolic & diastolic to impute blanks in systolic/diastolic 
some rows have diastolic BP greater than systolic BP which is implausible (we flagged them)
N.B imputation for null values done using mean average.

10) for imputation glucose column we used two subgroups one for patients with T2DM (avg=201) and one for non-diabetic (avg=192).
zero were set to null as it's medically implausible 

11) cleaning BMI columns we detected implausible values (BMI <10 , BMI>80) which is realistically not possible and were set to null as they probably data error and then were imputed with mean average 

12) smoking column was standardized to (Smoker/EX-Smoker/Not-Smoker/unknown)
 
13) outcome were standardized to (Died, Discharged, Left Against Medical Advice, Transferred, Pending, Unknown)

14) phone number column was first cleaned from spaces and special characters or special starts (+ , -, 00 , 5) and was standardized to a formula (+966 & Number)

==========================================================================================================================================

Lab_Results sheet

1) Patient id format was standardized to (PT-1xxx), and blank were flagged red 

2) test name had different inputs for the same test so we standardized them for one easy understandable input 

3) result column (N/A) value were set to null 

4) order by column was standardized for one format (Dr. Name) and Unknown were set to blank 

5) unit column data like (-- and N/A) were set to blank 

==========================================================================================================================================

Medication_Log sheet 

1) Drug names were standardized 

2) Dose input cleaned and standardized for one formula ("Dose" & mg) dose for mg for all (The data AI generated for training purposes so dosages are not correct ( Insulin dose were flagged as it's not measured in gram or even milligram its International Unit(IU))

3)Frequency was standardized to an understandable non-medical term (Once daily = QD, Twice daily = BID, Three times daily = TID, Four times daily = QID, PRN = As needed)

4) route (iv = intravenous, IM= intramuscular, PO= oral, SC= subcutaneous 
