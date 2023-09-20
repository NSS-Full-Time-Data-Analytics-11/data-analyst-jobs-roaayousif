SELECT *
FROM data_analyst_jobs;

--1.How many rows are in the data_analyst_jobs table?S 1793

SELECT COUNT(*)
FROM data_analyst_jobs;

--2.Write a query to look at just the first 10 rows. What company is associated with the job posting on the 10th row?
--ExxonMobile

SELECT company 
FROM data_analyst_jobs
LIMIT 10;

--3.How many postings are in Tennessee? 21

SELECT COUNT(location)
FROM data_analyst_jobs 
WHERE location = 'TN';


---3a. How many are there in either Tennessee or Kentucky? 27

SELECT COUNT(location)
FROM data_analyst_jobs
WHERE (location = 'TN') OR (location = 'KY');

--4. How many postings in Tennessee have a star rating above 4? 3

SELECT COUNT(*)
FROM data_analyst_jobs
WHERE (location = 'TN') AND (star_rating > '4');

--5. How many postings in the dataset have a review count between 500 and 1000? 151 

SELECT COUNT(*)
FROM data_analyst_jobs
WHERE review_count BETWEEN 500 AND 1000;

--6. Show the average star rating for companies in each state. The output should show the state as `state` and the average rating for the state as `avg_rating`. Which state shows the highest average rating?
-- NE 

SELECT DISTINCT location AS state,
	 ROUND(AVG(star_rating), 2) AS avg_rating
FROM data_analyst_jobs
WHERE star_rating IS NOT NULL
GROUP BY location
ORDER BY avg_rating DESC;

--7. Select unique job titles from the data_analyst_jobs table. How many are there? 881

SELECT COUNT(DISTINCT title)
FROM data_analyst_jobs;

--8. How many unique job titles are there for California companies? 230


SELECT COUNT(DISTINCT title)
FROM data_analyst_jobs
WHERE location = 'CA';

--9. Find the name of each company and its average star rating for all companies that have more than 5000 reviews across all locations. 
--How many companies are there with more that 5000 reviews across all locations? 40

SELECT company, AVG(star_rating) AS avg_star_rating
FROM data_analyst_jobs
WHERE review_count > 5000 and company IS NOT NULL
GROUP BY company;

SELECT COUNT(DISTINCT company)
FROM data_analyst_jobs
WHERE review_count > 5000 AND company IS NOT NULL;

--10. Add the code to order the query in #9 from highest to lowest average star rating. 
--Which company with more than 5000 reviews across all locations in the dataset has the highest star rating? 
--AmeriCorps
--What is that rating? 4.4001

SELECT DISTINCT company, ROUND(AVG(star_rating), 2) AS avg_star_rating
FROM data_analyst_jobs
WHERE review_count > 5000
GROUP BY company
ORDER BY avg_star_rating DESC;

--11. Find all the job titles that contain the word ‘Analyst’. How many different job titles are there? 774
SELECT COUNT( DISTINCT title)
FROM data_analyst_jobs
WHERE title ILIKE '%Analyst%';

--12. How many different job titles do not contain either the word ‘Analyst’ or the word ‘Analytics’? 4
--What word do these positions have in common? Tableau

SELECT title
FROM data_analyst_jobs
WHERE title NOT ILIKE '%Analyst%' AND title NOT ILIKE '%Analytics%';

--You want to understand which jobs requiring SQL are hard to fill. Find the number of jobs by industry (domain) that require SQL and have been posted longer than 3 weeks. 
 --- Disregard any postings where the domain is NULL. 
 --- Order your results so that the domain with the greatest number of `hard to fill` jobs is at the top. 
 -- - Which three industries are in the top 4 on this list? How many jobs have been listed for more than 3 weeks for each of the top 4?



SELECT domain, COUNT(title) AS number_of_jobs
FROM data_analyst_jobs
WHERE SKILL ILIKE '%SQL%' AND days_since_posting > 21 AND domain IS NOT NULL
GROUP BY domain
ORDER BY number_of_jobs DESC