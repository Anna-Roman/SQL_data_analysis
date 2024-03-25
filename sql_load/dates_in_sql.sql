-- dates
SELECT job_posted_date
FROM job_postings_fact
LIMIT 10;

SELECT
    job_title_short AS title,
    job_location AS location,
    job_posted_date::DATE AS date
FROM
    job_postings_fact;

SELECT
    job_title_short AS title,
    job_location AS location,
    job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'EST' AS date_time
FROM
    job_postings_fact
LIMIT 5;

SELECT
    job_title_short AS title,
    job_location AS location,
    job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'EST' AS date_time,
    EXTRACT(MONTH FROM job_posted_date) AS date_month
FROM
    job_postings_fact
LIMIT 5;

SELECT
    job_title_short AS title,
    job_location AS location,
    job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'EST' AS date_time,
    EXTRACT(YEAR FROM job_posted_date) AS date_year
FROM
    job_postings_fact
LIMIT 5;

SELECT
    COUNT(job_id) AS job_count,
    EXTRACT(
        MONTH
        FROM job_posted_date
    ) AS month
FROM job_postings_fact
WHERE job_title_short = 'Data Engineer'
GROUP BY month
ORDER BY job_count;

SELECT *
FROM job_postings_fact
LIMIT 5;

SELECT
    count(job_id) AS count_id,
    job_schedule_type,
    AVG(salary_year_avg) AS AVG_year,
    AVG(salary_hour_avg) AS AVG_hour
FROM job_postings_fact
WHERE
    job_posted_date > '2023-06-01 00:00:00'
GROUP BY job_schedule_type;

SELECT
    COUNT(job_id) AS job_count,
    MIN(job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'EDT') AS date_time,
    EXTRACT(MONTH FROM job_posted_date) AS month
FROM job_postings_fact
WHERE job_posted_date >= '2023-01-01 04:00:00' 
GROUP BY month
ORDER BY month
LIMIT 100;