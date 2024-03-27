# Introdaction 
Dive into the data job market! Focusing on data engineer and data analyst roles. This project explores top-paying jobs, in demand skills and where high demand meets high salary.  
  
SQL queries? Check them out here: [project_sql folder](/project_sql/).  
# Background 
This project was born from a desire to pinpoint top-paid and in-demand skills and to help with finding optimal job.

Data hails from [SQL Course](https://www.lukebarousse.com/sql). It's packed with insights on job titles, salaries, locations, and essential skills.  

### The questions I wanted to answer through my SQL queries were:
1. What are the top-paying data engineer and data analyst jobs?
2. What skills are required for these top-paying jobs?
3. What skills are most in demand for data engineer and data analysts?
4. Which skills are associated with higher salaries?
5. What are the most optimal skills to learn?  

# Tools I Used  
- **SQL:** The backbone of data analysis, allows to query the database and unearth critical insights.
- **PostgreSQL:** The chosen database management system.
- **Visual Studio Code:** Database management and executing SQL queries.
- **GitHub:** Essential for version control and sharing the SQL scripts and analysis.  

# The Analysis  
Each query for this project aimed at investigating specific aspects of the job market. Here’s how I approached each question:  
### 1. Top Paying Data Engineer and Data Analyst Jobs  
To identify the highest-paying roles, I filtered Data Engineer positions in a first query and Data Analyst positions in a second one by average yearly salary and location, focusing on remote jobs. This query highlights the high paying opportunities in the field.  
```sql
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
    job_location = 'Anywhere' AND
    salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC
LIMIT 10;

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
    job_title_short = 'Data Analyst' AND
    job_location = 'Anywhere' AND
    salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC
LIMIT 10;
```
Here's the breakdown of the top Data Analyst jobs in 2023:  
- Wide Salary Range: Top 10 paying data analyst roles span from $184000 to $650000, indicating significant salary potential in the field.
- Diverse Employers: Companies like SmartAsset, Meta, and AT&T are among those offering high salaries, showing a broad interest across different industries.
- Job Title Variety: There's a high diversity in job titles, from Data Analyst to Director of Analytics, reflecting varied roles and specializations within data analytics.  
The breakdown of the top Data Engineer jobs in 2023:  
- Salary Range: Top 10 paying data engineer roles span from $242000 to $325000.  
- Company Distribution: Various companies are hiring for data engineering roles, including Engtal, Durlston Partners, Twitch, AI Startup, Signify Technology, Movable Ink, Handshake, and Meta.
- Variety in Job Titles: There is a variety of job titles, suggesting different levels of experience and responsibilities within the field of data engineering. This includes roles such as Director of Engineering, Staff Data Engineer, and Data Engineering Manager.  
### 2. Skills for Top Paying Jobs  
To understand what skills are required for the top-paying jobs, I joined the job postings with the skills data, providing insights into what employers value for high-compensation roles.  
Skills for the top-paying Data Engineer jobs:  
```sql
WITH top_paying_jobs AS (

    SELECT
        job_id,
        job_title,
        salary_year_avg,
        job_posted_date,
        name AS company_name
    FROM
        job_postings_fact
    LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
    WHERE
        job_title_short = 'Data Engineer' AND
        job_location = 'Anywhere' AND
        salary_year_avg IS NOT NULL
    ORDER BY
        salary_year_avg DESC
    LIMIT 10
    )
SELECT 
    top_paying_jobs.*,
    skills
FROM top_paying_jobs
INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY 
    salary_year_avg DESC
```  

Skills for the top 10 highest paying Data Engineer jobs:  
- Python is the most in demand, it was mentioned 7 times. 
- Next one is Spark, it was mentioned 5 times. 
- Other skills like SQL or Pandas show up less frequently.  
  
Skills for the top-paying Data Analyst jobs:
```sql
WITH top_paying_jobs AS (

    SELECT
        job_id,
        job_title,
        salary_year_avg,
        job_posted_date,
        name AS company_name
    FROM
        job_postings_fact
    LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
    WHERE
        job_title_short = 'Data Analyst' AND
        job_location = 'Anywhere' AND
        salary_year_avg IS NOT NULL
    ORDER BY
        salary_year_avg DESC
    LIMIT 10
    )
SELECT 
    top_paying_jobs.*,
    skills
FROM top_paying_jobs
INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY 
    salary_year_avg DESC
```

Skills for the top 10 highest paying Data Analyst jobs in 2023:

- SQL is leading with a bold count of 8.
- Python follows closely with a bold count of 7.
- Tableau is also highly sought after, with a bold count of 6.  

I also wanted to look at the jobs located in Finland.  
```sql
WITH top_paying_jobs AS (

    SELECT
        job_id,
        job_title,
        salary_year_avg,
        job_posted_date,
        name AS company_name
    FROM
        job_postings_fact
    LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
    WHERE
        job_title_short = 'Data Engineer' AND
        job_location = 'Finland' AND
        salary_year_avg IS NOT NULL
    ORDER BY
        salary_year_avg DESC
    LIMIT 10
    )
SELECT 
    top_paying_jobs.*,
    skills
FROM top_paying_jobs
INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY 
    salary_year_avg DESC
```
There are only 3 job postings for Data Engineer located in Finland.
Skills like kafka, kubernetes, python, snowflake, spark were mentioned in 2 out of the three postings.
Other skills like azure, databricks, go, power bi, sql, terraform were mentioned once.  

![Skills for jobs located in Finland](pic\skills_fi.png)

### 3. In-Demand Skills for Data Engineer and Data Analysts   
These queries helped identify the skills most frequently requested in job postings, directing focus to areas with high demand.  
```sql
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
```

Top 5 skills for Data Engineers are: SQL, Python, AWS, Azure, Spark.  
|   Skills  | Demand Count |
|:---------:|:------------:|
|   SQL     |    113375    |
|  Python   |    108265    |
|   AWS     |     62174    |
|   Azure   |     60823    |
|   Spark   |     53789    |

Top 5 skills for Data Analysts are: SQL, Excel, Python, Tableau and Power BI.  
|   Skills   | Demand Count |
|:----------:|:------------:|
|    SQL     |     92628    |
|   Excel    |     67031    |
|   Python   |     57326    |
|  Tableau   |     46554    |
|  Power BI  |     39468    |  

### 4. Skills Based on Salary   
Exploring the average salaries associated with different skills revealed which skills are the highest paying.  
```sql
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
```

|   Skills      | Avg Salary  |
|:-------------:|:-----------:|
|     SVN       |  $400,000.00|
|   Solidity    |  $179,000.00|
|   Couchbase   |  $160,515.00|
|   DataRobot   |  $155,485.50|
|    Golang     |  $155,000.00|
|    Mxnet      |  $149,000.00|
|    Dplyr      |  $147,633.33|
|    VMware     |  $147,500.00|
|   Terraform   |  $146,733.83|
|    Twilio     |  $138,500.00|

Breakdown of the reults for Data Analyst roles.  
Top paying skills are used in areas like:  
- Software Development and Engineering.
- Data Analysis and Machine Learning. 
- Infrastructure Management and DevOps.
- Data Storage and Processing.
- Workflow Automation and Collaboration.
- Version Control and Documentation.

```sql
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
```

|   Skills       | Avg Salary  |
|:--------------:|:-----------:|
|     Node       |  $181,861.78|
|    Mongo       |  $179,402.54|
|    ggplot2     |  $176,250.00|
|   Solidity     |  $166,250.00|
|     Vue        |  $159,375.00|
|  CodeCommit    |  $155,000.00|
|    Ubuntu      |  $154,455.00|
|    Clojure     |  $153,662.60|
|   Cassandra    |  $150,255.30|
|     Rust       |  $147,770.73|

Breakdown of the results for Data Engineer roles.  
Top paying skills are used in areas like:  
- Backend Development.
- Data Visualization and Analysis.
- Cloud Computing and Infrastructure.
- Big Data Technologies.
- Machine Learning and AI.
- Security and Compliance.
- Development and Operations (DevOps).
- Frontend Development.

### 5. Most Optimal Skills to Learn   
Combining insights from demand and salary data, this query aimed to pinpoint skills that are both in high demand and have high salaries, offering a strategic focus for skill development.  

For Data Analist roles:
```sql
SELECT
    skills_dim.skill_id,
    skills_dim.skills,
    COUNT(skills_job_dim.job_id) AS demand_count,
    ROUND(AVG(job_postings_fact.salary_year_avg),2) AS avg_salary
FROM
    job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst' AND
    salary_year_avg IS NOT NULL
GROUP BY
    skills_dim.skill_id
HAVING
    COUNT(skills_job_dim.job_id) > 10
ORDER BY
    avg_salary DESC,
    demand_count DESC
LIMIT 25;
```

| Skill ID |   Skills   | Demand Count | Avg Salary  |
|:--------:|:----------:|:------------:|:-----------:|
|    98    |   Kafka    |      40      | $129,999.16 |
|   101    |  PyTorch   |      20      | $125,226.20 |
|    31    |    Perl    |      20      | $124,685.75 |
|    99    | TensorFlow |      24      | $120,646.83 |
|    63    | Cassandra  |      11      | $118,406.68 |
|   219    | Atlassian  |      15      | $117,965.60 |
|    96    |  Airflow   |      71      | $116,387.26 |
|     3    |   Scala    |      59      | $115,479.53 |
|   169    |   Linux    |      58      | $114,883.20 |
|   234    | Confluence |      62      | $114,153.12 |

*Table of the most optimal skills for data analyst sorted by salary*  

Here's a breakdown of the most optimal skills for Data Analysts in 2023:  

Moderate Demand:  
The demand counts for the listed skills range from 11 (Cassandra) to 71 (Airflow), indicating moderate levels of demand in the job market.

Diverse Range of Technologies:  
The listed skills represent a diverse range of technologies and tools, including data processing frameworks (Kafka, Airflow), machine learning libraries (PyTorch, TensorFlow), programming languages (Perl, Scala), collaboration software (Atlassian, Confluence), and operating systems (Linux).
Varied Average Salaries:

Popular Data Processing Tools:  
Data processing tools such as Kafka and Airflow exhibit relatively high demand counts, indicating their importance in building and managing data pipelines and workflows.

Machine Learning Frameworks:  
Machine learning frameworks like PyTorch and TensorFlow also demonstrate moderate demand, reflecting the growing importance of machine learning and AI technologies in various industries.

Collaboration Software:  
Skills related to collaboration software such as Atlassian and Confluence also show moderate demand, suggesting the significance of effective team collaboration and project management tools in modern workplaces.

For Data Engineer roles:
```sql
SELECT
    skills_dim.skill_id,
    skills_dim.skills,
    COUNT(skills_job_dim.job_id) AS demand_count,
    ROUND(AVG(job_postings_fact.salary_year_avg),2) AS avg_salary
FROM
    job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Engineer' AND
    salary_year_avg IS NOT NULL
GROUP BY
    skills_dim.skill_id
HAVING
    COUNT(skills_job_dim.job_id) > 10
ORDER BY
    avg_salary DESC,
    demand_count DESC
LIMIT 25;
```

| Skill ID |   Skills      | Demand Count | Avg Salary  |
|:--------:|:-------------:|:------------:|:-----------:|
|   154    |     Node      |      29      | $181,861.78 |
|    24    |    Mongo      |     120      | $179,402.54 |
|    63    |  Cassandra    |     269      | $150,255.30 |
|    39    |     Rust      |      15      | $147,770.73 |
|    31    |     Perl      |      39      | $145,539.92 |
|   136    |   Angular     |      42      | $143,318.96 |
|    3     |    Scala      |     794      | $143,161.07 |
|    98    |    Kafka      |     872      | $143,085.77 |
|   105    |    GDPR       |      38      | $142,368.74 |
|    6     |    Shell      |     365      | $141,724.61 |

*Table of the most optimal skills for data engineer sorted by salary*  

Here's a breakdown of the most optimal skills for Data AEngineers in 2023:  

Skill Diversity:  
The listed skills represent a diverse range of technologies and tools, including backend frameworks (Node, Mongo), databases (Cassandra), programming languages (Perl, Rust, Scala), data processing tools (Kafka), frontend frameworks (Angular), and compliance standards (GDPR).

Demand Distribution:  
Demand counts vary significantly across the listed skills, ranging from as low as 15 (Rust) to as high as 872 (Kafka). This indicates differences in the popularity and adoption of these technologies within the job market.

High-Demand Skills:  
Skills such as Scala (demand count: 794) and Kafka (demand count: 872) stand out with exceptionally high demand counts, suggesting their widespread adoption and relevance in various industries, particularly in data engineering and stream processing.

Specialized Skills:  
Some skills, like GDPR (General Data Protection Regulation), represent specialized knowledge areas related to regulatory compliance in data handling and privacy, which are becoming increasingly important in the era of data governance and privacy laws.

# What I learned  

**Writing Complex Queries:** Improved the skill of SQL, merging tables and using WITH clauses for temp table maneuvers.  
**Data Aggregation:** Got cozy with GROUP BY and got better with aggregate functions like COUNT() and AVG().  
**Analytical Thinking:** Leveled up my real-world puzzle-solving skills, turning questions into insightful SQL queries.  

# Conclusions  

### Insights ###

1. Top-Paying Data Engineer and Data Analyst Jobs offer a wide range of salaries.  
2. The skill for the highest paying Data Engineer jobs is Python. The skill for the highest paying Data Analyst jobs is SQL.  
3. The most In-Demand Skills for Data Engineer and Data Analysts is SQL.  
4. Skills with Higher Salaries are Specialized skills, such as SVN for Data Analyst and Node for Data Engineer.   
5. The Most Optimal Skills to Learn first are Python and SQL and after that it is safe to learn some specialized skills.  

**Closing Thoughts**  
This project enhanced my SQL skills and provided valuable insights into the data engineer and data analyst job market. The findings from the analysis serve as a guide to prioritizing skill development and job search efforts. Aspiring data professionals can better position themselves in a competitive job market by focusing on high-demand, high-salary skills. This exploration highlights the importance of continuous learning and adaptation to emerging trends in the field of data analytics.



