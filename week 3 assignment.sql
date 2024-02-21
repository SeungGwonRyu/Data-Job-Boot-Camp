SELECT * FROM project.daily_play 

SELECT * FROM project.daily_sales 

SELECT * FROM project.raw_login_data 

SELECT * FROM project.raw_register_data 




-- recency
WITH target AS (
    SELECT
        WID,
        MAX(DATE(date)) AS last_purchase_date
    FROM
        project.daily_sales
    GROUP BY
        WID
)
SELECT
    t.WID,
    t.last_purchase_date,
    CASE
        WHEN DATE_DIFF(DATE '2023-09-30', t.last_purchase_date, DAY) <= 7 THEN '7일 이내 구매'
        WHEN DATE_DIFF(DATE '2023-09-30', t.last_purchase_date, DAY) <= 30 THEN '30일 이내 구매'
        ELSE '그 이상'
    END AS recency_segmentation
FROM
    target t
    
    
    
-- frequency
WITH target AS (
    SELECT
        WID,
        SUM(buy_count) AS total_buy_count
    FROM
        project.daily_sales
    GROUP BY
        WID
)
SELECT
    t.WID,
    t.total_buy_count,
    CASE
        WHEN t.total_buy_count >= 5 THEN '5회 이상 구매'
        WHEN t.total_buy_count BETWEEN 2 AND 4 THEN '2-4회 구매'
        ELSE '1회 구매'
    END AS frequency_segmentation
FROM
    target t;

    
    

    
    
    
-- monetary
WITH target AS (
    SELECT WID, SUM(revenue) AS total_revenue
    FROM project.daily_sales 
    GROUP BY WID
)
SELECT WID, total_revenue,
       CASE 
           WHEN total_revenue < 100000 THEN 'pay less'
           WHEN total_revenue >= 100000 AND total_revenue < 1000000 THEN 'pay middle'
           ELSE 'high pay' 
       END AS expenditure_segmentation
FROM target


WITH RecencyTarget AS (
    SELECT
        WID,
        MAX(DATE(date)) AS last_purchase_date
    FROM
        project.daily_sales
    GROUP BY
        WID
),
FrequencyTarget AS (
    SELECT
        WID,
        SUM(buy_count) AS total_buy_count
    FROM
        project.daily_sales
    GROUP BY
        WID
),
MonetaryTarget AS (
    SELECT
        WID,
        SUM(revenue) AS total_revenue
    FROM
        project.daily_sales 
    GROUP BY
        WID
)
SELECT
    R.WID,
    R.last_purchase_date,
    CASE
        WHEN DATE_DIFF(DATE '2023-09-30', R.last_purchase_date, DAY) <= 7 THEN '7일 이내 구매'
        WHEN DATE_DIFF(DATE '2023-09-30', R.last_purchase_date, DAY) <= 30 THEN '30일 이내 구매'
        ELSE '그 이상'
    END AS recency_segmentation,
    F.total_buy_count,
    CASE
        WHEN F.total_buy_count >= 5 THEN '5회 이상 구매'
        WHEN F.total_buy_count BETWEEN 2 AND 4 THEN '2-4회 구매'
        ELSE '1회 구매'
    END AS frequency_segmentation,
    M.total_revenue,
    CASE 
        WHEN M.total_revenue < 100000 THEN 'pay less'
        WHEN M.total_revenue >= 100000 AND M.total_revenue < 1000000 THEN 'pay middle'
        ELSE 'high pay' 
    END AS expenditure_segmentation
FROM
    RecencyTarget R
JOIN
    FrequencyTarget F ON R.WID = F.WID
JOIN
    MonetaryTarget M ON R.WID = M.WID;



