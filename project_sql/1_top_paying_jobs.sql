/*
Question: What are the top-paying data engineer jobs?
- Identifythe top 10 highest-paying Data Engineer roles that are available remotely.
- Focuses on job postings with specified salaries (remove nulls).
*/

SELECT
    job_id,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date,
    name AS company_name
FROM
    job_postings_fact
LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE
    job_title_short = 'Data Engineer' AND
    (job_location = 'Anywhere' OR job_location = 'Finland') AND
    salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC
LIMIT 10;