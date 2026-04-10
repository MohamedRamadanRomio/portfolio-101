SELECT count(Age) from heart_attack WHERE Age is null 
UPDATE heart_attack SET Age = (SELECT AVG(Age)FROM heart_attack) WHERE Age is null
select count(sex) from heart_attack where sex is null 
UPDATE heart_attack SET Sedentary_Hours_Per_Day = (SELECT AVG(Sedentary_Hours_Per_Day) FROM heart_attack) WHERE Sedentary_Hours_Per_Day is null
select avg(Sleep_Hours_per_Day) from heart_attack
UPDATE heart_attack SET Sleep_Hours_Per_Day = (SELECT AVG(Sleep_Hours_Per_Day) FROM heart_attack) WHERE Sleep_Hours_Per_Day is null 
select avg(Income) from heart_attack
UPDATE heart_attack set Income = (SELECT AVG(Income) FROM heart_attack) WHERE Income is null 

DELETE FROM heart_attack WHERE Sex is null
DELETE FROM heart_attack WHERE Diabetes is null 
DELETE FROM heart_attack WHERE Family_History is null

SELECT distinct(BMI) FROM heart_attack order by BMI DESC
UPDATE heart_attack SET BMI = (SELECT AVG(BMI) FROM heart_attack) WHERE BMI = 160
SELECT distinct(Age) FROM heart_attack order by Age DESC
DELETE FROM heart_attack WHERE Age = 400

SELECT COUNT(Blood_Pressure) from heart_attack where Blood_Pressure is null
DELETE FROM heart_attack WHERE Blood_Pressure is null 

ALTER TABLE heart_attack
ADD Systolic INT, Diastolic INT
UPDATE heart_attack SET
       Systolic= CAST(SUBSTRING(Blood_Pressure, 1 , CHARINDEX('/', Blood_Pressure) -1) AS INT),
       Diastolic= CAST(SUBSTRING(Blood_Pressure,CHARINDEX('/', Blood_Pressure) +1) AS INT)
ALTER TABLE heart_attack
DROP column Blood_Pressure

UPDATE heart_attack SET
       Exercise_Hours_Per_Week = (SELECT ROUND(Exercise_Hours_Per_Week,2)),
       Sedentary_Hours_Per_Day = (SELECT ROUND(Sedentary_Hours_Per_Day,2)),
       BMI = (SELECT ROUND(BMI,1))

SELECT DISTINCT(Sex) FROM heart_attack
UPDATE heart_attack SET Sex = LOWER(Sex)
UPDATE heart_attack SET Sex = 'male' where Sex = 'm'

ALTER TABLE heart_attack
ADD BMI_Category VARCHAR(20)
UPDATE heart_attack SET BMI_Category = CASE
       WHEN BMI <18.5 THEN 'Under Weight'
       WHEN BMI >18.4 AND BMI <25 THEN 'Normal'
       WHEN BMI >24.9 AND BMI <30 THEN 'Over Weight'
       WHEN BMI >29.9 THEN 'Obese'
       ElSE 'Unknown'
  END
 
  ALTER TABLE heart_attack
  ADD BP_Category VARCHAR(20)
  UPDATE heart_attack SET BP_Category = CASE 
         WHEN Systolic < 90 OR Diastolic < 60 THEN 'Hypotension'
         WHEN Systolic > 139 OR Diastolic > 89 THEN 'Hypertension'
         WHEN Systolic BETWEEN 120 AND 139 OR Diastolic BETWEEN 80 AND 89 THEN 'Elevated'
         WHEN Systolic BETWEEN 90 AND 119 AND Diastolic BETWEEN 60 AND 79 THEN 'Normal'
         ELSE 'Unknown' 
  END 

SELECT DISTINCT(BP_Category) from heart_attack
select Diastolic from heart_attack order by Diastolic ASC
-----------------------------------------------------------------------
            --WRONG QUERY-- 
SELECT DISTINCT(Diet) FROM heart_attack 
UPDATE heart_attack SET Diet=
       CASE WHEN Diet = 'Healty' THEN 'Healthy'
            WHEN Diet = 'Unhelthy' THEN 'Unhealthy'
            ELSE 'Unknown'
        END 
-----------------------------------------------------------------------

-- Diet column messed up, will fix it with join from the original table
UPDATE A
SET A.Diet = B.Diet
FROM heart_attack AS A
JOIN [heart_attack_prediction (1)] AS B
ON A.Patient_ID = B.Patient_ID

SELECT DISTINCT(Diet) FROM heart_attack
UPDATE heart_attack SET Diet= 'Healthy' WHERE Diet= 'Healty'
UPDATE heart_attack SET Diet= 'Unhealthy' WHERE Diet= 'Unhelthy'

ALTER TABLE heart_attack 
ADD Age_Category VARCHAR(20)
UPDATE heart_attack SET Age_Category = CASE 
       WHEN Age <=34 THEN 'Young Adult'
       WHEN Age between 35 AND 49 THEN 'Middle Age'
       WHEN Age >49 THEN 'Old Age'
       ELSE 'Unknown'
END

select Age_Category, count(*) AS TOTAL_WITH_RISK from heart_attack where Heart_Attack_Risk = 1 group by Age_Category
select BMI_Category, count(*) AS TOTAL_WITH_RISK from heart_attack where Heart_Attack_Risk = 1 group by BMI_Category order by TOTAL_WITH_RISK DESC

select BP_Category, count(*) AS TOTAL_WITH_RISK from heart_attack where Heart_Attack_Risk = 1 group by BP_Category
select BP_Category,count(*) * 100 / sum(count(*)) over () AS 'Risk_Percent "%"'
from heart_attack
where Heart_Attack_Risk = 1
group by BP_Category 
-- Clearly Hypertension is a Risk Factor as long as Old Age and Obesity

select Heart_Attack_Risk, AVG(Cholesterol) AS AVG_Cholesterol, ROUND(STDEV(Cholesterol),2) AS STDEV_Cholesterol
from heart_attack 
group by Heart_Attack_Risk
order by Heart_Attack_Risk DESC
-- cholesterol alone isn't a relible indicator of the outcome despite playing a role but it needs to be combine with other tests
-- or you can categorize cholesterol into high risk and low risk for cleaner correlation with heart attack risk

select * from heart_attack