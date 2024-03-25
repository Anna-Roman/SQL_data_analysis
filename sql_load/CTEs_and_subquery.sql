-- CTEs 
WITH company_job_count AS (
    SELECT
        company_id,
        COUNT(*) AS total_jobs
    FROM
        job_postings_fact
    GROUP BY
        company_id
        )

SELECT company_dim.name AS company_name,
    company_job_count.total_jobs
FROM company_dim
LEFT JOIN company_job_count
    ON company_job_count.company_id = company_dim.company_id
ORDER BY total_jobs DESC


--skills subquery
SELECT skills, count_skills
FROM skills_dim
LEFT JOIN 
    (
    SELECT 
        COUNT(skill_id) AS count_skills
    FROM 
        skills_job_dim
    GROUP BY 
        skill_id 
    ORDER BY skill_id DESC
    LIMIT 5
    )
    ON skills_dim.skill_id = skill_id