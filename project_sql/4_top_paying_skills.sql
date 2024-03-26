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

/*Breakdown of the results.
Top paying skills are used in areas like:
Software Development and Engineering: 
Skills like Golang, Solidity, and GitLab are commonly used in 
software development and engineering roles, particularly in 
blockchain development, version control, and collaboration.

Data Analysis and Machine Learning: 
Skills like TensorFlow, PyTorch, Keras, and MXNet are essential for 
data analysts and machine learning engineers working on building and 
training machine learning models for data analysis and prediction tasks.

Infrastructure Management and DevOps: 
Skills like Terraform, Puppet, Ansible, and VMware are crucial for 
managing data infrastructure, automating deployment processes, 
and ensuring efficient operations, often in DevOps roles.

Data Storage and Processing: 
Skills like Cassandra, Couchbase, and Apache Kafka are utilized in
managing large-scale data storage, processing, and streaming applications, 
often in data engineering roles.

Workflow Automation and Collaboration: 
Tools like Apache Airflow, Atlassian (Jira, Confluence), 
and Notion are used for workflow automation, project management, 
and collaboration among data teams and across departments.

Version Control and Documentation: 
Skills like SVN, GitLab, and Bitbucket are essential for version control 
and collaboration on code and data projects, ensuring proper documentation 
and tracking of changes.*/