RENAME TABLE womens_health_mood_disorders_with_pms TO womens_health;

SELECT *
FROM womens_health;

-- understand the dataset 
-- goal: understanding drivers of symptom severity for women diagnosed with PMDD
		-- how do lifestyle factors impact symptom severity across different age groups?
		-- how are lifestyle factors associated with menstrual cycle regularity, and how does cycle regularity relate to symptom severity?
		-- how do stress levels and lifestyle factors interact to influence symptom severity across age groups?
		-- average severity by PMDD diagnosis 

-- first let's take a look at those two columns
SELECT 
Severity_of_Symptoms AS sos,
PMDD_Diagnosis as PMDD
FROM womens_health
ORDER BY sos DESC;

-- we can see that there is option for 'yes' or 'no' for PMDD diagnois and the severity score goes from 1-9 
-- now let's calculate the average score of severity symptoms for patients who have PMDD diagnosis vs those who don't
SELECT 
ROUND(AVG (Severity_of_Symptoms),2) AS sos,
PMDD_Diagnosis AS PMDD
FROM womens_health
WHERE PMDD_Diagnosis = 'No'
GROUP BY PMDD;

-- from this query, we see that the severity of symptoms for patients diagnosed with PMDD is a 4.98
-- now let's look at the average severity score for patients who DO have a PMDD diagnosis 
SELECT 
ROUND(AVG (Severity_of_Symptoms), 2) AS sos,
PMDD_Diagnosis AS PMDD
FROM womens_health
WHERE PMDD_Diagnosis = 'Yes'
GROUP BY PMDD;
-- from this, we see that the average severity score for patients who have a PMDD diagnosis is 5.22, a little higher than those who do not, 
-- higher by 0.24
-- based off of this we can try and find different association based on average severity


-- let's take a look at average severity by stress levels for patients diagnosed with PMDD 
SELECT *
FROM womens_health;

-- let's pull data from the two columns severity of symptoms and stress levels 
-- we can calculate the avg severity of symptoms for each stress level 
SELECT 
ROUND(AVG(CASE WHEN Stress_Levels = 1 THEN Severity_of_Symptoms END),2) AS avg_sl_1,
ROUND(AVG(CASE WHEN Stress_Levels = 2 THEN Severity_of_Symptoms END),2) AS avg_sl_2,
ROUND(AVG(CASE WHEN Stress_Levels = 3 THEN Severity_of_Symptoms END),2) AS avg_sl_3,
ROUND(AVG(CASE WHEN Stress_Levels = 4 THEN Severity_of_Symptoms END),2) AS avg_sl_4, 
ROUND(AVG(CASE WHEN Stress_Levels = 5 THEN Severity_of_Symptoms END),2) AS avg_sl_5,
ROUND(AVG(CASE WHEN Stress_Levels = 6 THEN Severity_of_Symptoms END),2) AS avg_sl_6,
ROUND(AVG(CASE WHEN Stress_Levels = 7 THEN Severity_of_Symptoms END),2) AS avg_sl_7,
ROUND(AVG(CASE WHEN Stress_Levels = 8 THEN Severity_of_Symptoms END),2) AS avg_sl_8,
ROUND(AVG(CASE WHEN Stress_Levels = 9 THEN Severity_of_Symptoms END),2) AS avg_sl_9
FROM womens_health
ORDER BY Stress_Levels;

-- this query gives us the avg severity of symptoms for the different stress levels, there is no distinctive pattern.
-- we see that the highest stress level of 9 has an average of 5 for severity of symotoms but so does stress level 2
-- we see that that stress level 7 has the highest severity of symptoms of 5.37


-- this is another and BETTER WAY of writing above query, but above query gives us across, good practice for case statements
-- this would be preferred query however 

SELECT 
Stress_Levels,
ROUND(AVG(Severity_of_Symptoms),2) as avg_severity
FROM womens_health
GROUP BY Stress_Levels
ORDER BY Stress_Levels;

-- we can now group this by age-level to give us more information 

SELECT *
FROM womens_health;

-- lets create age brackets to get a clearer idea since there are several ages represented 

SELECT 
CASE 
	WHEN Age < 18 THEN 'Under 18'
    WHEN Age BETWEEN 18 AND 21 THEN '18-21'
    WHEN Age BETWEEN 21 AND 25 THEN '21-25'
    WHEN Age BETWEEN 25 AND 30 THEN '25-30'
    WHEN Age BETWEEN 30 AND 35 THEN '30-35'
    WHEN Age BETWEEN 35 AND 40 THEN '35-40'
    ELSE 'Over 35'
END AS age_bracket,
ROUND(AVG(Severity_of_Symptoms),2) as avg_severity,
Stress_Levels
FROM womens_health
WHERE PMDD_Diagnosis = 'Yes'
GROUP BY Stress_Levels, age_bracket
ORDER BY Stress_Levels, age_bracket;

-- we can perhaps interpret these results through graphs since going through each stress level is a lot of numbers to keep track of 
-- group by meaning:  put everyone with the same stress level for examples in one group (group by stress level)

-- lets take a look at our other factors to consider 
-- how do lifestyle factors impact symptom severity across different age groups?
		-- how are lifestyle factors associated with menstrual cycle regularity, and how does cycle regularity relate to symptom severity?
		-- how do stress levels and lifestyle factors interact to influence symptom severity across age groups?
        
-- let's start with: how do lifestyle factors impact symptom severity across different age groups?

-- we can simply add lifestyle factor to the above query
SELECT * 
FROM womens_health;

SELECT Lifestyle_Factors 
FROM womens_health;
-- we can see that lifestyle factors has three categories
-- healthy, moderate and unhealthy
-- we are unsure of how this is defined so we can take results with a grain of salt 

SELECT 
CASE 
	WHEN Age < 18 THEN 'Under 18'
    WHEN Age BETWEEN 18 AND 21 THEN '18-21'
    WHEN Age BETWEEN 21 AND 25 THEN '21-25'
    WHEN Age BETWEEN 25 AND 30 THEN '25-30'
    WHEN Age BETWEEN 30 AND 35 THEN '30-35'
    WHEN Age BETWEEN 35 AND 40 THEN '35-40'
    ELSE 'Over 35'
END AS age_bracket,
ROUND(AVG(Severity_of_Symptoms),2) as avg_severity,
Stress_Levels,
Lifestyle_Factors
FROM womens_health
WHERE PMDD_Diagnosis = 'Yes'
GROUP BY Stress_Levels, age_bracket, Lifestyle_Factors
ORDER BY Stress_Levels, age_bracket, Lifestyle_Factors;

-- since this is a lot of data to view at once, we can go further to check each lifestyle factor and its associated stress and sos

SELECT 
CASE 
	WHEN Age < 18 THEN 'Under 18'
    WHEN Age BETWEEN 18 AND 21 THEN '18-21'
    WHEN Age BETWEEN 21 AND 25 THEN '21-25'
    WHEN Age BETWEEN 25 AND 30 THEN '25-30'
    WHEN Age BETWEEN 30 AND 35 THEN '30-35'
    WHEN Age BETWEEN 35 AND 40 THEN '35-40'
    ELSE 'Over 35'
END AS age_bracket,
ROUND(AVG(Severity_of_Symptoms),2) as avg_severity,
Stress_Levels, 
Lifestyle_Factors
FROM womens_health
WHERE PMDD_Diagnosis = 'Yes' AND Lifestyle_Factors = 'Unhealthy'
GROUP BY Stress_Levels, age_bracket
ORDER BY Stress_Levels, age_bracket;

-- maybe we can narrow this down further to look at the highest and lowest stress level so 1 and 9 for each lifestyle factor

SELECT 
CASE 
	WHEN Age < 18 THEN 'Under 18'
    WHEN Age BETWEEN 18 AND 21 THEN '18-21'
    WHEN Age BETWEEN 21 AND 25 THEN '21-25'
    WHEN Age BETWEEN 25 AND 30 THEN '25-30'
    WHEN Age BETWEEN 30 AND 35 THEN '30-35'
    WHEN Age BETWEEN 35 AND 40 THEN '35-40'
    ELSE 'Over 35'
END AS age_bracket,
ROUND(AVG(Severity_of_Symptoms),2) as avg_severity,
Stress_Levels, 
Lifestyle_Factors
FROM womens_health
WHERE PMDD_Diagnosis = 'Yes' AND Lifestyle_Factors = 'Unhealthy' AND Stress_Levels = '1'
GROUP BY Stress_Levels, age_bracket
ORDER BY Stress_Levels, age_bracket;


-- let's look at unhealthy and highest severity score of 9 

SELECT 
CASE 
	WHEN Age < 18 THEN 'Under 18'
    WHEN Age BETWEEN 18 AND 21 THEN '18-21'
    WHEN Age BETWEEN 21 AND 25 THEN '21-25'
    WHEN Age BETWEEN 25 AND 30 THEN '25-30'
    WHEN Age BETWEEN 30 AND 35 THEN '30-35'
    WHEN Age BETWEEN 35 AND 40 THEN '35-40'
    ELSE 'Over 35'
END AS age_bracket,
ROUND(AVG(Severity_of_Symptoms),2) as avg_severity,
Stress_Levels, 
Lifestyle_Factors
FROM womens_health
WHERE PMDD_Diagnosis = 'Yes' AND Lifestyle_Factors = 'Unhealthy' AND Stress_Levels = '9'
GROUP BY Stress_Levels, age_bracket
ORDER BY Stress_Levels, age_bracket;

-- moderate and stress level of 1 

SELECT 
CASE 
	WHEN Age < 18 THEN 'Under 18'
    WHEN Age BETWEEN 18 AND 21 THEN '18-21'
    WHEN Age BETWEEN 21 AND 25 THEN '21-25'
    WHEN Age BETWEEN 25 AND 30 THEN '25-30'
    WHEN Age BETWEEN 30 AND 35 THEN '30-35'
    WHEN Age BETWEEN 35 AND 40 THEN '35-40'
    ELSE 'Over 35'
END AS age_bracket,
ROUND(AVG(Severity_of_Symptoms),2) as avg_severity,
Stress_Levels, 
Lifestyle_Factors
FROM womens_health
WHERE PMDD_Diagnosis = 'Yes' AND Lifestyle_Factors = 'Moderate' AND Stress_Levels = '1'
GROUP BY Stress_Levels, age_bracket
ORDER BY Stress_Levels, age_bracket;

-- moderate and stress level of 9 
SELECT 
CASE 
	WHEN Age < 18 THEN 'Under 18'
    WHEN Age BETWEEN 18 AND 21 THEN '18-21'
    WHEN Age BETWEEN 21 AND 25 THEN '21-25'
    WHEN Age BETWEEN 25 AND 30 THEN '25-30'
    WHEN Age BETWEEN 30 AND 35 THEN '30-35'
    WHEN Age BETWEEN 35 AND 40 THEN '35-40'
    ELSE 'Over 35'
END AS age_bracket,
ROUND(AVG(Severity_of_Symptoms),2) as avg_severity,
Stress_Levels, 
Lifestyle_Factors
FROM womens_health
WHERE PMDD_Diagnosis = 'Yes' AND Lifestyle_Factors = 'Moderate' AND Stress_Levels = '9'
GROUP BY Stress_Levels, age_bracket
ORDER BY Stress_Levels, age_bracket;

-- healthy with stress level of 1
SELECT 
CASE 
	WHEN Age < 18 THEN 'Under 18'
    WHEN Age BETWEEN 18 AND 21 THEN '18-21'
    WHEN Age BETWEEN 21 AND 25 THEN '21-25'
    WHEN Age BETWEEN 25 AND 30 THEN '25-30'
    WHEN Age BETWEEN 30 AND 35 THEN '30-35'
    WHEN Age BETWEEN 35 AND 40 THEN '35-40'
    ELSE 'Over 35'
END AS age_bracket,
ROUND(AVG(Severity_of_Symptoms),2) as avg_severity,
Stress_Levels, 
Lifestyle_Factors
FROM womens_health
WHERE PMDD_Diagnosis = 'Yes' AND Lifestyle_Factors = 'healthy' AND Stress_Levels = '1'
GROUP BY Stress_Levels, age_bracket
ORDER BY Stress_Levels, age_bracket;


-- healthy with stress level of 9 
SELECT 
CASE 
	WHEN Age < 18 THEN 'Under 18'
    WHEN Age BETWEEN 18 AND 21 THEN '18-21'
    WHEN Age BETWEEN 21 AND 25 THEN '21-25'
    WHEN Age BETWEEN 25 AND 30 THEN '25-30'
    WHEN Age BETWEEN 30 AND 35 THEN '30-35'
    WHEN Age BETWEEN 35 AND 40 THEN '35-40'
    ELSE 'Over 35'
END AS age_bracket,
ROUND(AVG(Severity_of_Symptoms),2) as avg_severity,
Stress_Levels, 
Lifestyle_Factors
FROM womens_health
WHERE PMDD_Diagnosis = 'Yes' AND Lifestyle_Factors = 'healthy' AND Stress_Levels = '9'
GROUP BY Stress_Levels, age_bracket
ORDER BY Stress_Levels, age_bracket;

-- from this we can interpret the following:
-- 






-- how are lifestyle factors associated with menstrual cycle regularity, and how does cycle regularity relate to symptom severity?
-- how do stress levels and lifestyle factors interact to influence symptom severity across age groups?