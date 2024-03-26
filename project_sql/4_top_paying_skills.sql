/*
Question: What are the top skills based on salary?
- Look at the average salary associated with each skill for Data Analyst positions
- Focuses on roles with specified salaries, regardless of location
*/

SELECT 
    skills,
    ROUND(AVG(salary_year_avg),2) AS avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst' AND
    salary_year_avg IS NOT NULL
GROUP BY 
    skills
ORDER BY
    avg_salary DESC
LIMIT 25;

SELECT 
    skills,
    ROUND(AVG(salary_year_avg),2) AS avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Engineer' AND
    salary_year_avg IS NOT NULL
GROUP BY 
    skills
ORDER BY
    avg_salary DESC
LIMIT 25;

/*Breakdown of the results for Data Analyst roles.
Top paying skills are used in areas like:
Software Development and Engineering.
Data Analysis and Machine Learning. 
Infrastructure Management and DevOps.
Data Storage and Processing.
Workflow Automation and Collaboration.
Version Control and Documentation.

Breakdown of the results for Data Engineer roles.
Top paying skills are used in areas like:
Backend Development.
Data Visualization and Analysis.
Cloud Computing and Infrastructure.
Big Data Technologies.
Machine Learning and AI.
Security and Compliance.
Development and Operations (DevOps).
Frontend Development.
*/

