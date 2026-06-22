RENAME TABLE womens_health_mood_disorders_with_pms TO womens_health;

SELECT *
FROM womens_health;

-- goal: identifying patient factors associated with higher pmdd severity to support early intervention strategies 
-- evaluating the relationship between lifestyle factors (healthy, unhealthy, moderate) + age + average severity score, maybe adding stress as a second variable 
-- evaluating the relationsip between treatment history (Medication, Therapy, both), avg severity score + age 
-- evaluating the relationship between average severity score and menstrual cycle regularity (Irregular, Regular) across different age groups 



SELECT *
FROM womens_health;

-- evaluating the relationship between lifestyle factors (healthy, unhealthy, moderate) + age + average severity score,

SELECT
ROUND(AVG (Severity_of_Symptoms),2) as SOS,
CASE 
	WHEN Age < 18 THEN 'Under 18'
    WHEN Age BETWEEN 18 AND 21 THEN '18-21'
    WHEN Age BETWEEN 21 AND 25 THEN '21-25'
    WHEN Age BETWEEN 25 AND 30 THEN '25-30'
    WHEN Age BETWEEN 30 AND 35 THEN '30-35'
    WHEN Age BETWEEN 35 AND 40 THEN '35-40'
    ELSE 'Over 35'
END AS age_bracket
FROM womens_health
WHERE PMDD_Diagnosis = "Yes" AND Lifestyle_Factors = "Moderate"
GROUP BY age_bracket
ORDER BY SOS desc;

-- for patients with PMDD symptoms that have a moderate lifestyle, the age group that is most affected is 35-40 with 6.15 average severity score 

SELECT
ROUND(AVG (Severity_of_Symptoms),2) as SOS,
CASE 
	WHEN Age < 18 THEN 'Under 18'
    WHEN Age BETWEEN 18 AND 21 THEN '18-21'
    WHEN Age BETWEEN 21 AND 25 THEN '21-25'
    WHEN Age BETWEEN 25 AND 30 THEN '25-30'
    WHEN Age BETWEEN 30 AND 35 THEN '30-35'
    WHEN Age BETWEEN 35 AND 40 THEN '35-40'
    ELSE 'Over 35'
END AS age_bracket
FROM womens_health
WHERE PMDD_Diagnosis = "Yes" AND Lifestyle_Factors = "Unhealthy"
GROUP BY age_bracket
ORDER BY SOS desc;

-- for patients with PMDD symptoms that have an unhealthy lifestyle, the age group that is most affected is 21-25 yr olds with 6.71 average severity score 


SELECT
ROUND(AVG (Severity_of_Symptoms),2) as SOS,
CASE 
	WHEN Age < 18 THEN 'Under 18'
    WHEN Age BETWEEN 18 AND 21 THEN '18-21'
    WHEN Age BETWEEN 21 AND 25 THEN '21-25'
    WHEN Age BETWEEN 25 AND 30 THEN '25-30'
    WHEN Age BETWEEN 30 AND 35 THEN '30-35'
    WHEN Age BETWEEN 35 AND 40 THEN '35-40'
    ELSE 'Over 35'
END AS age_bracket
FROM womens_health
WHERE PMDD_Diagnosis = "Yes" AND Lifestyle_Factors = "Healthy"
GROUP BY age_bracket
ORDER BY SOS desc;

-- for patients with PMDD symptoms that have a healthy lifestyle, the age group that is most affected is 21-25 yr olds with 6.29 average severity score 



-- evaluating the relationsip between treatment history, avg severity score + age 

SELECT *
FROM womens_health;


SELECT
ROUND(AVG (Severity_of_Symptoms),2) as SOS,
CASE 
	WHEN Age < 18 THEN 'Under 18'
    WHEN Age BETWEEN 18 AND 21 THEN '18-21'
    WHEN Age BETWEEN 21 AND 25 THEN '21-25'
    WHEN Age BETWEEN 25 AND 30 THEN '25-30'
    WHEN Age BETWEEN 30 AND 35 THEN '30-35'
    WHEN Age BETWEEN 35 AND 40 THEN '35-40'
    ELSE 'Over 35'
END AS age_bracket
FROM womens_health
WHERE PMDD_Diagnosis = "Yes" and Treatment_History = "None"
GROUP BY age_bracket
ORDER BY SOS desc;

-- for patients with PMDD symptoms BUT no treatment history, the age group that is most affected is 21-25 yr olds with 6.75 average severity score 


SELECT
ROUND(AVG (Severity_of_Symptoms),2) as SOS,
CASE 
	WHEN Age < 18 THEN 'Under 18'
    WHEN Age BETWEEN 18 AND 21 THEN '18-21'
    WHEN Age BETWEEN 21 AND 25 THEN '21-25'
    WHEN Age BETWEEN 25 AND 30 THEN '25-30'
    WHEN Age BETWEEN 30 AND 35 THEN '30-35'
    WHEN Age BETWEEN 35 AND 40 THEN '35-40'
    ELSE 'Over 35'
END AS age_bracket
FROM womens_health
WHERE PMDD_Diagnosis = "Yes" and Treatment_History = "Both"
GROUP BY age_bracket
ORDER BY SOS desc;

-- for patients with PMDD symptoms with both medication and therapy in their  treatment history, the age group that is most affected is 21-25 yr olds with 7.33 average severity score 
-- this could be explained that women in this age bracket experiencing high symptoms are more likely to get on medication/treatment 

SELECT
ROUND(AVG (Severity_of_Symptoms),2) as SOS,
CASE 
	WHEN Age < 18 THEN 'Under 18'
    WHEN Age BETWEEN 18 AND 21 THEN '18-21'
    WHEN Age BETWEEN 21 AND 25 THEN '21-25'
    WHEN Age BETWEEN 25 AND 30 THEN '25-30'
    WHEN Age BETWEEN 30 AND 35 THEN '30-35'
    WHEN Age BETWEEN 35 AND 40 THEN '35-40'
    ELSE 'Over 35'
END AS age_bracket
FROM womens_health
WHERE PMDD_Diagnosis = "Yes" and Treatment_History = "Medication"
GROUP BY age_bracket
ORDER BY SOS desc;

-- for patients with PMDD symptoms taking medication, the age group that is most affected is 35-40 yr olds with 6.50 average severity score 

SELECT
ROUND(AVG (Severity_of_Symptoms),2) as SOS,
CASE 
	WHEN Age < 18 THEN 'Under 18'
    WHEN Age BETWEEN 18 AND 21 THEN '18-21'
    WHEN Age BETWEEN 21 AND 25 THEN '21-25'
    WHEN Age BETWEEN 25 AND 30 THEN '25-30'
    WHEN Age BETWEEN 30 AND 35 THEN '30-35'
    WHEN Age BETWEEN 35 AND 40 THEN '35-40'
    ELSE 'Over 35'
END AS age_bracket
FROM womens_health
WHERE PMDD_Diagnosis = "Yes" and Treatment_History = "Therapy"
GROUP BY age_bracket
ORDER BY SOS desc;

-- for patients with PMDD symptoms with a treatment history of therapy, the age group that is most affected is 25-30 yr olds with 6.33 average severity score 



-- evaluating the relationship between average severity score and menstrual cycle regularity across different age groups 

SELECT *
FROM womens_health;


SELECT
ROUND(AVG (Severity_of_Symptoms),2) as SOS,
CASE 
	WHEN Age < 18 THEN 'Under 18'
    WHEN Age BETWEEN 18 AND 21 THEN '18-21'
    WHEN Age BETWEEN 21 AND 25 THEN '21-25'
    WHEN Age BETWEEN 25 AND 30 THEN '25-30'
    WHEN Age BETWEEN 30 AND 35 THEN '30-35'
    WHEN Age BETWEEN 35 AND 40 THEN '35-40'
    ELSE 'Over 35'
END AS age_bracket
FROM womens_health
WHERE PMDD_Diagnosis = "Yes" and Menstrual_Cycle_Regularity = "Irregular"
GROUP BY age_bracket
ORDER BY SOS desc;

-- for patients with PMDD symptoms with irregular cycles, the age group that is most affected is 21-25 yr olds with 6.33 average severity score 
-- which is consistent with what we have been seeing 21-25 being the most affected by PMDD
-- this can be explained by the irregular cycles having a higher chance of having PMDD



SELECT *
FROM womens_health;


SELECT
ROUND(AVG (Severity_of_Symptoms),2) as SOS,
CASE 
	WHEN Age < 18 THEN 'Under 18'
    WHEN Age BETWEEN 18 AND 21 THEN '18-21'
    WHEN Age BETWEEN 21 AND 25 THEN '21-25'
    WHEN Age BETWEEN 25 AND 30 THEN '25-30'
    WHEN Age BETWEEN 30 AND 35 THEN '30-35'
    WHEN Age BETWEEN 35 AND 40 THEN '35-40'
    ELSE 'Over 35'
END AS age_bracket
FROM womens_health
WHERE PMDD_Diagnosis = "Yes" and Menstrual_Cycle_Regularity = "Regular"
GROUP BY age_bracket
ORDER BY SOS desc;

-- for patients with PMDD symptoms with irregular cycles, the age group that is most affected is 35-40  yr olds with 5.35 average severity score 
-- this could be explained by ... 







