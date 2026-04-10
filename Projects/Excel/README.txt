Diabetes Excel project:

1) First we set 0 values to null in columns where 0 can't be a value and could only be null 

For example in insulin column insulin could only be 0 in some cases of type 1 DM So if the value is 0 and the outcome is  (non-Diabetic)
then it's a null not a real value 

2) checked for duplicates there were none 

3) second we filtered the columns to see unrealistic values 
for example the blood pressure column from the given range (1-122) it's probably diastolic blood pressure and it's nearly impossible for 
diastolic blood pressure to be under 20 mmHg, we checked pregnancies in relation to age as it was impossible for and excluded under age 
and unrealistic number of pregnancies in relation to age (like 17 pregnancies at 47)

4) columns with nearly impossible diastolic BP were checked manually to delete rows with other wrong values in addition to BP (In larger 
dataset formulas will be used) 

5) we checked the columns manually using filters and removed rows with more than one clinically impossible or unrealistic value

6) The rest with only one wrong medically wrong value we set to average and not removed (median was considered but mean was used)
N.B for insulin column nulls were filled according to the outcome, the average were calculated for patients with diabetes and for
patients without and imputed null accordingly with two different values (AVG for diabetic = 70, for non-diabetic=87)
N.B this method of imputing might underestimate the insulin level if the patient has Type 2 DM (Hyperinsulinemia occurs early)

7) After minimizing the wrong data as possible there is still some medically nearly impossible values which left to be handled accordingly later
------------------------------------------------------------------------------------------------------------------------------------------
8) After cleaning the data we start to categorize the data like glucose into low, borderline and high risk (Glucose level in blood alone is not diagnostic for diagnosis additional test might be needed as OGTT, fasting and HbA1c)

9)GDM risk column was added as pregnancy is a diabetogenic state and GDM increase the risk of type 2 diabetes after pregnancy so the number of pregnancies is high risk factor for diabetes (Nullipara: she never gave birth before)
------------------------------------------------------------------------------------------------------------------------------------------
10) after standardizing and categorizing the data, started making pivot tables 

11) First table (from left to right) shows the relation between age group and the incidence of DM in this dataset and it shows the the increasingly DM incidence in young adults because of change in lifestyle and bad food habits (obesity epidemic)

12) Second table shows the relation between BMI and DM and clearly shows the increased risk with increased BMI (78.82% with DM in this dataset are obese)

13)Third table shows the relation between number of pregnancies and the outcome of DM (The column we added as GDM risk) and high risk groups (>6 pregnancies) showed higher incidence of DM as expected and Nullipara (never gave birth) Showed the least incidence of DM

14) Fourth table shows the difference in signs between diabetic and non-diabetic people (diabetic have higher Glucose, higher BMI, BP)





