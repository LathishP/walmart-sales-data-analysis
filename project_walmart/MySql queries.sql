SELECT * FROM walmart_db.walmart;
SELECT count(*) FROM walmart;
SELECT distinct payment_method FROM walmart ;
SELECT payment_method ,count(*) FROM walmart group by payment_method ;
SELECT count(distinct branch) FROM walmart;
SELECT min(quantity) FROM walmart;

-- Buissness problems
-- Q1.find different payment method and number of transactions. number of quantity sold
SELECT 
    payment_method, 
    COUNT(*) AS no_payments, 
    SUM(quantity) AS no_qty_sold 
FROM walmart 
GROUP BY payment_method;

-- Q2: Identify the highest rated category in each branch. Display the branch, the category, and the average rating
SELECT *
FROM (
    SELECT 
        branch, 
        category, 
        AVG(rating) AS avg_rating,
        RANK() OVER(PARTITION BY branch ORDER BY AVG(rating) DESC) AS raank 
        FROM walmart 
    GROUP BY branch, category
) AS sq
WHERE raank = 1;

-- Q3: Identify the busiest day for each branch based on the number of transactions
SELECT * FROM (
    SELECT 
        branch,
        DAYNAME(STR_TO_DATE(date, '%d/%m/%Y')) AS day_name,
        COUNT(*) AS no_transactions,
        RANK() OVER(PARTITION BY branch ORDER BY COUNT(*) DESC) AS raank
    FROM walmart
    GROUP BY branch, day_name
) AS sq
WHERE raank = 1;

-- Q4: Calculate the total quantity of items sold per payment method. List the payment method and the total quantity
SELECT 
    payment_method, 
    SUM(quantity) AS no_qty_sold 
FROM walmart 
GROUP BY payment_method;

-- Q5: Determine the average, minimum, and the maximum rating of category for each city. List the city, average rating, minimum rating, and the maximum rating
SELECT 
    city, 
    category, 
    MIN(rating) AS min_rating, 
    MAX(rating) AS max_rating, 
    AVG(rating) AS avg_rating
FROM walmart 
GROUP BY city, category;

-- Q6: Calculate the total profit for each category by considering the total profit as unit price times quantity times profit margin. List the category and the total profit, ordered from highest to lowest profit
SELECT 
    category, 
    SUM(total) AS total_revenue,
    SUM(total * profit_margin) AS total_profit
FROM walmart 
GROUP BY category 
ORDER BY total_profit DESC;

-- Q7: Determine the most common payment method for each branch. Display the branch and the preferred method
WITH cte AS (
    SELECT 
        branch, 
        payment_method, 
        COUNT(*) AS total_transactions,
        RANK() OVER(PARTITION BY branch ORDER BY COUNT(*) DESC) AS raank
    FROM walmart 
    GROUP BY branch, payment_method
)
SELECT * FROM cte 
WHERE raank = 1;

-- Q8: Categorize sales into three groups: Morning, Afternoon, and Evening. Find out each shift and the number of invoices
SELECT 
    branch,
    CASE 
        WHEN HOUR(TIME(time)) < 12 THEN 'Morning'
        WHEN HOUR(TIME(time)) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END AS day_time,
    COUNT(*) AS count
FROM walmart 
GROUP BY branch, day_time 
ORDER BY branch, count DESC;

-- Q9: Identify the five branches with the highest decrease ratio in revenue compared to the last year 
WITH revenue_2022 AS (
    SELECT 
        branch, 
        SUM(total) AS revenue
    FROM walmart 
    WHERE YEAR(STR_TO_DATE(date, '%d/%m/%Y')) = 2022
    GROUP BY branch
),
revenue_2023 AS (
    SELECT 
        branch, 
        SUM(total) AS revenue
    FROM walmart 
    WHERE YEAR(STR_TO_DATE(date, '%d/%m/%Y')) = 2023
    GROUP BY branch
)
SELECT 
    ls.branch,
    ls.revenue AS last_year_revenue,
    cs.revenue AS current_year_revenue,
    ROUND(((ls.revenue - cs.revenue) / ls.revenue) * 100, 2) AS revenue_decrease_ratio
FROM revenue_2022 AS ls
JOIN revenue_2023 AS cs 
ON ls.branch = cs.branch
WHERE ls.revenue > cs.revenue
ORDER BY revenue_decrease_ratio DESC
LIMIT 5;

-- Q10: Calculate the month-over-month (MoM) revenue growth percentage
WITH monthly_revenue AS (
    SELECT 
        MONTH(STR_TO_DATE(date, '%d/%m/%Y')) AS month_num,
        YEAR(STR_TO_DATE(date, '%d/%m/%Y')) AS year_num,
        SUM(total) AS total_revenue
    FROM walmart
    GROUP BY year_num, month_num
),
revenue_with_lag AS (
    SELECT 
        year_num,
        month_num,
        total_revenue,
        LAG(total_revenue) OVER(ORDER BY year_num, month_num) AS prev_month_revenue
    FROM monthly_revenue
)
SELECT 
    year_num,
    month_num,
    total_revenue,
    prev_month_revenue,
    ROUND(((total_revenue - prev_month_revenue) / prev_month_revenue) * 100, 2) AS mom_growth_percentage
FROM revenue_with_lag;