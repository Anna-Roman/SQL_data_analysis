/*
Question: What are the most in-demand skills for data engineer and data analyst?
- Identify top 5 in-demand skilss using whole dataset, 
not only remote jobs or located in Finland like in previous query.
*/

SELECT 
    skills,
    COUNT(skills_job_dim.job_id) AS demand_count
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Engineer'
GROUP BY 
    skills
ORDER BY
    demand_count DESC
LIMIT 5;


SELECT 
    skills,
    COUNT(skills_job_dim.job_id) AS demand_count
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst'
GROUP BY 
    skills
ORDER BY
    demand_count DESC
LIMIT 5;

/*
Top 5 skills for Data Engineers are: SQL, Python, AWS, Azure, Spark.
SQL is leading with 113375 counts and Python following with 108265 counts.

Top 5 skills for Data Analysts are: SQL, Excel, Python, Tableau and Power BI.
SQL is leading with 92628 counts and Excel following with 67031 counts. 
*/