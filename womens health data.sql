RENAME TABLE womens_health_mood_disorders_with_pms TO womens_health;

SELECT *
FROM womens_health;

-- goal: identifying patient factors associated with higher pmdd severity to support early intervention strategies 
-- evaluating the relationship between lifestyle factors (healthy, unhealthy, moderate) + age + average severity score, maybe adding stress as a second variable 
-- evaluating the relationsip between treatment history, avg severity score + age 
-- evaluating the relationship between average severity score and menstrual cycle regularity across different age groups 

SELECT *
FROM womens_health;

-- evaluating the relationship between lifestyle factors (healthy, unhealthy, moderate) + age + average severity score,
--  adding stress as a second variable 

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
GROUP BY age_bracket;


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
GROUP BY age_bracket;

-- evaluating the relationship between average severity score and menstrual cycle regularity across different age groups 

-- TBD





-- Initial analysis, explaratory queries 
-- average severity for patients who have PMDD vs those who do not 

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



-- this query looks at stress levels and average severity score 

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



