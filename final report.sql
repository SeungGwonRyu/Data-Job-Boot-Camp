SELECT * FROM project.daily_play 

SELECT * FROM project.daily_sales 

SELECT * FROM project.raw_login_data 

SELECT * FROM project.raw_register_data  


--USER_COUNT 접속 유저 수 
SELECT 
CASE WHEN EXTRACT(YEAR FROM date) = 2022 AND EXTRACT(MONTH FROM date) IN (1,2,3) THEN '22-Q1'
	 WHEN EXTRACT(YEAR FROM date) = 2022 AND EXTRACT(MONTH FROM date) IN (4,5,6) THEN '22-Q2'
     WHEN EXTRACT(YEAR FROM date) = 2022 AND EXTRACT(MONTH FROM date) IN (7,8,9) THEN '22-Q3'
     WHEN EXTRACT(YEAR FROM date) = 2022 AND EXTRACT(MONTH FROM date) IN (10,11,12) THEN '22-Q4'
     WHEN EXTRACT(YEAR FROM date) = 2023 AND EXTRACT(MONTH FROM date) IN (1,2,3) THEN '23-Q1'
     WHEN EXTRACT(YEAR FROM date) = 2023 AND EXTRACT(MONTH FROM date) IN (4,5,6) THEN '23-Q2'
     WHEN EXTRACT(YEAR FROM date) = 2023 AND EXTRACT(MONTH FROM date) IN (7,8,9) THEN '23-Q3'
 	 END quater
, COUNT(*) user_count
FROM project.daily_play 
GROUP BY 1


--revenue 매출 
SELECT
CASE WHEN EXTRACT(YEAR FROM date) = 2022 AND EXTRACT(MONTH FROM date) IN (1,2,3) THEN '22-Q1'
	 WHEN EXTRACT(YEAR FROM date) = 2022 AND EXTRACT(MONTH FROM date) IN (4,5,6) THEN '22-Q2'
     WHEN EXTRACT(YEAR FROM date) = 2022 AND EXTRACT(MONTH FROM date) IN (7,8,9) THEN '22-Q3'
     WHEN EXTRACT(YEAR FROM date) = 2022 AND EXTRACT(MONTH FROM date) IN (10,11,12) THEN '22-Q4'
     WHEN EXTRACT(YEAR FROM date) = 2023 AND EXTRACT(MONTH FROM date) IN (1,2,3) THEN '23-Q1'
     WHEN EXTRACT(YEAR FROM date) = 2023 AND EXTRACT(MONTH FROM date) IN (4,5,6) THEN '23-Q2'
     WHEN EXTRACT(YEAR FROM date) = 2023 AND EXTRACT(MONTH FROM date) IN (7,8,9) THEN '23-Q3'	
END quater
, sum(revenue) revenue
FROM project.daily_sales 
GROUP BY 1

--pu(paying user) 구매 유저 수  
SELECT
CASE WHEN EXTRACT(YEAR FROM date) = 2022 AND EXTRACT(MONTH FROM date) IN (1,2,3) THEN '22-Q1'
	 WHEN EXTRACT(YEAR FROM date) = 2022 AND EXTRACT(MONTH FROM date) IN (4,5,6) THEN '22-Q2'
     WHEN EXTRACT(YEAR FROM date) = 2022 AND EXTRACT(MONTH FROM date) IN (7,8,9) THEN '22-Q3'
     WHEN EXTRACT(YEAR FROM date) = 2022 AND EXTRACT(MONTH FROM date) IN (10,11,12) THEN '22-Q4'
     WHEN EXTRACT(YEAR FROM date) = 2023 AND EXTRACT(MONTH FROM date) IN (1,2,3) THEN '23-Q1'
     WHEN EXTRACT(YEAR FROM date) = 2023 AND EXTRACT(MONTH FROM date) IN (4,5,6) THEN '23-Q2'
     WHEN EXTRACT(YEAR FROM date) = 2023 AND EXTRACT(MONTH FROM date) IN (7,8,9) THEN '23-Q3'
 END quater
, COUNT(*) PU
FROM project.daily_sales 
GROUP BY 1

--PUR(PAYING USER RATE)
SELECT p.quater, p.paying_user / a.active_user pur
FROM 
	(SELECT 
CASE WHEN EXTRACT(YEAR FROM date) = 2022 AND EXTRACT(MONTH FROM date) IN (1,2,3) THEN '22-Q1'
	 WHEN EXTRACT(YEAR FROM date) = 2022 AND EXTRACT(MONTH FROM date) IN (4,5,6) THEN '22-Q2'
     WHEN EXTRACT(YEAR FROM date) = 2022 AND EXTRACT(MONTH FROM date) IN (7,8,9) THEN '22-Q3'
     WHEN EXTRACT(YEAR FROM date) = 2022 AND EXTRACT(MONTH FROM date) IN (10,11,12) THEN '22-Q4'
     WHEN EXTRACT(YEAR FROM date) = 2023 AND EXTRACT(MONTH FROM date) IN (1,2,3) THEN '23-Q1'
     WHEN EXTRACT(YEAR FROM date) = 2023 AND EXTRACT(MONTH FROM date) IN (4,5,6) THEN '23-Q2'
     WHEN EXTRACT(YEAR FROM date) = 2023 AND EXTRACT(MONTH FROM date) IN (7,8,9) THEN '23-Q3'
 	 END quater
, COUNT(*) active_user
FROM project.daily_play 
GROUP BY 1) a 
INNER JOIN
	(SELECT
CASE WHEN EXTRACT(YEAR FROM date) = 2022 AND EXTRACT(MONTH FROM date) IN (1,2,3) THEN '22-Q1'
	 WHEN EXTRACT(YEAR FROM date) = 2022 AND EXTRACT(MONTH FROM date) IN (4,5,6) THEN '22-Q2'
     WHEN EXTRACT(YEAR FROM date) = 2022 AND EXTRACT(MONTH FROM date) IN (7,8,9) THEN '22-Q3'
     WHEN EXTRACT(YEAR FROM date) = 2022 AND EXTRACT(MONTH FROM date) IN (10,11,12) THEN '22-Q4'
     WHEN EXTRACT(YEAR FROM date) = 2023 AND EXTRACT(MONTH FROM date) IN (1,2,3) THEN '23-Q1'
     WHEN EXTRACT(YEAR FROM date) = 2023 AND EXTRACT(MONTH FROM date) IN (4,5,6) THEN '23-Q2'
     WHEN EXTRACT(YEAR FROM date) = 2023 AND EXTRACT(MONTH FROM date) IN (7,8,9) THEN '23-Q3'
 END quater
, COUNT(*) paying_user
FROM project.daily_sales 
GROUP BY 1) p
ON a.quater = p.quater

--arppu 구매 유저 1인당평균 매출 
SELECT
CASE WHEN EXTRACT(YEAR FROM date) = 2022 AND EXTRACT(MONTH FROM date) IN (1,2,3) THEN '22-Q1'
	 WHEN EXTRACT(YEAR FROM date) = 2022 AND EXTRACT(MONTH FROM date) IN (4,5,6) THEN '22-Q2'
     WHEN EXTRACT(YEAR FROM date) = 2022 AND EXTRACT(MONTH FROM date) IN (7,8,9) THEN '22-Q3'
     WHEN EXTRACT(YEAR FROM date) = 2022 AND EXTRACT(MONTH FROM date) IN (10,11,12) THEN '22-Q4'
     WHEN EXTRACT(YEAR FROM date) = 2023 AND EXTRACT(MONTH FROM date) IN (1,2,3) THEN '23-Q1'
     WHEN EXTRACT(YEAR FROM date) = 2023 AND EXTRACT(MONTH FROM date) IN (4,5,6) THEN '23-Q2'
     WHEN EXTRACT(YEAR FROM date) = 2023 AND EXTRACT(MONTH FROM date) IN (7,8,9) THEN '23-Q3'	
END quater
, ROUND(SUM(revenue) / COUNT(*), 2) ARPPU
FROM project.daily_sales 
GROUP BY 1

--arpu 1인당 매출 
SELECT a.quater,p.revenue / a.active_user arpu
FROM
(SELECT 
CASE WHEN EXTRACT(YEAR FROM date) = 2022 AND EXTRACT(MONTH FROM date) IN (1,2,3) THEN '22-Q1'
	 WHEN EXTRACT(YEAR FROM date) = 2022 AND EXTRACT(MONTH FROM date) IN (4,5,6) THEN '22-Q2'
     WHEN EXTRACT(YEAR FROM date) = 2022 AND EXTRACT(MONTH FROM date) IN (7,8,9) THEN '22-Q3'
     WHEN EXTRACT(YEAR FROM date) = 2022 AND EXTRACT(MONTH FROM date) IN (10,11,12) THEN '22-Q4'
     WHEN EXTRACT(YEAR FROM date) = 2023 AND EXTRACT(MONTH FROM date) IN (1,2,3) THEN '23-Q1'
     WHEN EXTRACT(YEAR FROM date) = 2023 AND EXTRACT(MONTH FROM date) IN (4,5,6) THEN '23-Q2'
     WHEN EXTRACT(YEAR FROM date) = 2023 AND EXTRACT(MONTH FROM date) IN (7,8,9) THEN '23-Q3'
 	 END quater
, COUNT(*) active_user
FROM project.daily_play 
GROUP BY 1) a
INNER JOIN
(SELECT
CASE WHEN EXTRACT(YEAR FROM date) = 2022 AND EXTRACT(MONTH FROM date) IN (1,2,3) THEN '22-Q1'
	 WHEN EXTRACT(YEAR FROM date) = 2022 AND EXTRACT(MONTH FROM date) IN (4,5,6) THEN '22-Q2'
     WHEN EXTRACT(YEAR FROM date) = 2022 AND EXTRACT(MONTH FROM date) IN (7,8,9) THEN '22-Q3'
     WHEN EXTRACT(YEAR FROM date) = 2022 AND EXTRACT(MONTH FROM date) IN (10,11,12) THEN '22-Q4'
     WHEN EXTRACT(YEAR FROM date) = 2023 AND EXTRACT(MONTH FROM date) IN (1,2,3) THEN '23-Q1'
     WHEN EXTRACT(YEAR FROM date) = 2023 AND EXTRACT(MONTH FROM date) IN (4,5,6) THEN '23-Q2'
     WHEN EXTRACT(YEAR FROM date) = 2023 AND EXTRACT(MONTH FROM date) IN (7,8,9) THEN '23-Q3'	
END quater
,SUM(revenue) revenue
FROM project.daily_sales 
GROUP BY 1) p
ON a.quater = p.quater


 --VIP 유저 국가별 분포    
SELECT *
FROM
(WITH RecencyTarget AS (
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
    CASE
        WHEN DATE_DIFF(DATE '2023-09-30', R.last_purchase_date, DAY) <= 7 THEN '7일 이내 구매'
        WHEN DATE_DIFF(DATE '2023-09-30', R.last_purchase_date, DAY) <= 30 THEN '30일 이내 구매'
        ELSE '그 이상'
    END AS recency_segmentation,
    CASE
        WHEN F.total_buy_count >= 5 THEN '5회 이상 구매'
        WHEN F.total_buy_count BETWEEN 2 AND 4 THEN '2-4회 구매'
        ELSE '1회 구매'
    END AS frequency_segmentation,
    CASE 
        WHEN M.total_revenue < 100000 THEN '10만원 미만'
        WHEN M.total_revenue >= 100000 AND M.total_revenue < 1000000 THEN '10만원~100만원'
        ELSE '100만원 이상' 
    END AS expenditure_segmentation,
     CASE 
        WHEN DATE_DIFF(DATE '2023-09-30', R.last_purchase_date, DAY) <= 7
            AND F.total_buy_count >= 5
            AND M.total_revenue >= 1000000 THEN 'VIP'
        WHEN DATE_DIFF(DATE '2023-09-30', R.last_purchase_date, DAY) > 30
           AND F.total_buy_count >= 5
           AND M.total_revenue >= 1000000 THEN '이탈 VIP'
        WHEN DATE_DIFF(DATE '2023-09-30', R.last_purchase_date, DAY) > 30
           AND F.total_buy_count = 1
           AND M.total_revenue < 100000 THEN '소과금 VIP'
        WHEN DATE_DIFF(DATE '2023-09-30', R.last_purchase_date, DAY) <= 30 AND DATE_DIFF(DATE '2023-09-30', R.last_purchase_date, DAY) > 7
           AND F.total_buy_count >= 5
           AND M.total_revenue >= 100000 AND M.total_revenue < 1000000 THEN '중과금 VIP'
        WHEN DATE_DIFF(DATE '2023-09-30', R.last_purchase_date, DAY) > 30
           AND F.total_buy_count = 1
           AND M.total_revenue >= 100000 AND M.total_revenue < 1000000 THEN '잠재 VIP'        
    END AS Segment
FROM
    RecencyTarget R
JOIN
    FrequencyTarget F ON R.WID = F.WID
JOIN
    MonetaryTarget M ON R.WID = M.WID) t1
INNER JOIN
(SELECT WID, country FROM project.raw_register_data 
) t2
ON t1.WID = t2.WID




----- segment_active_user
SELECT Segment, Month, COUNT(DISTINCT b.WID) MAU
FROM
(SELECT t1.WID, Segment
FROM
(WITH RecencyTarget AS (
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
    CASE
        WHEN DATE_DIFF(DATE '2023-09-30', R.last_purchase_date, DAY) <= 7 THEN '7일 이내 구매'
        WHEN DATE_DIFF(DATE '2023-09-30', R.last_purchase_date, DAY) <= 30 THEN '30일 이내 구매'
        ELSE '그 이상'
    END AS recency_segmentation,
    CASE
        WHEN F.total_buy_count >= 5 THEN '5회 이상 구매'
        WHEN F.total_buy_count BETWEEN 2 AND 4 THEN '2-4회 구매'
        ELSE '1회 구매'
    END AS frequency_segmentation,
    CASE 
        WHEN M.total_revenue < 100000 THEN '10만원 미만'
        WHEN M.total_revenue >= 100000 AND M.total_revenue < 1000000 THEN '10만원~100만원'
        ELSE '100만원 이상' 
    END AS expenditure_segmentation,
     CASE 
        WHEN DATE_DIFF(DATE '2023-09-30', R.last_purchase_date, DAY) <= 7
            AND F.total_buy_count >= 5
            AND M.total_revenue >= 1000000 THEN 'VIP'
        WHEN DATE_DIFF(DATE '2023-09-30', R.last_purchase_date, DAY) > 30
           AND F.total_buy_count >= 5
           AND M.total_revenue >= 1000000 THEN '이탈 VIP'
        WHEN DATE_DIFF(DATE '2023-09-30', R.last_purchase_date, DAY) > 30
           AND F.total_buy_count = 1
           AND M.total_revenue < 100000 THEN '소과금 VIP'
        WHEN DATE_DIFF(DATE '2023-09-30', R.last_purchase_date, DAY) <= 30 AND DATE_DIFF(DATE '2023-09-30', R.last_purchase_date, DAY) > 7
           AND F.total_buy_count >= 5
           AND M.total_revenue >= 100000 AND M.total_revenue < 1000000 THEN '중과금 VIP'
        WHEN DATE_DIFF(DATE '2023-09-30', R.last_purchase_date, DAY) > 30
           AND F.total_buy_count = 1
           AND M.total_revenue >= 100000 AND M.total_revenue < 1000000 THEN '잠재 VIP'        
    END AS Segment
FROM
    RecencyTarget R
JOIN
    FrequencyTarget F ON R.WID = F.WID
JOIN
    MonetaryTarget M ON R.WID = M.WID) t1
INNER JOIN
(SELECT WID, country FROM project.raw_register_data 
) t2
ON t1.WID = t2.WID) a
INNER JOIN
	(SELECT 
    WID, 
    DATE(log_time) AS log_date,
    CASE 
        WHEN EXTRACT(YEAR FROM log_time) = 2022 AND EXTRACT(MONTH FROM log_time) = 1 THEN '22-01'
        WHEN EXTRACT(YEAR FROM log_time) = 2022 AND EXTRACT(MONTH FROM log_time) = 2 THEN '22-02'
        WHEN EXTRACT(YEAR FROM log_time) = 2022 AND EXTRACT(MONTH FROM log_time) = 3 THEN '22-03'
        WHEN EXTRACT(YEAR FROM log_time) = 2022 AND EXTRACT(MONTH FROM log_time) = 4 THEN '22-04'
        WHEN EXTRACT(YEAR FROM log_time) = 2022 AND EXTRACT(MONTH FROM log_time) = 5 THEN '22-05'
        WHEN EXTRACT(YEAR FROM log_time) = 2022 AND EXTRACT(MONTH FROM log_time) = 6 THEN '22-06'
        WHEN EXTRACT(YEAR FROM log_time) = 2022 AND EXTRACT(MONTH FROM log_time) = 7 THEN '22-07'
        WHEN EXTRACT(YEAR FROM log_time) = 2022 AND EXTRACT(MONTH FROM log_time) = 8 THEN '22-08'
        WHEN EXTRACT(YEAR FROM log_time) = 2022 AND EXTRACT(MONTH FROM log_time) = 9 THEN '22-09'
        WHEN EXTRACT(YEAR FROM log_time) = 2022 AND EXTRACT(MONTH FROM log_time) = 10 THEN '22-10'
        WHEN EXTRACT(YEAR FROM log_time) = 2022 AND EXTRACT(MONTH FROM log_time) = 11 THEN '22-11'
        WHEN EXTRACT(YEAR FROM log_time) = 2022 AND EXTRACT(MONTH FROM log_time) = 12 THEN '22-12'
        WHEN EXTRACT(YEAR FROM log_time) = 2023 AND EXTRACT(MONTH FROM log_time) = 1 THEN '23-01'
        WHEN EXTRACT(YEAR FROM log_time) = 2023 AND EXTRACT(MONTH FROM log_time) = 2 THEN '23-02'
        WHEN EXTRACT(YEAR FROM log_time) = 2023 AND EXTRACT(MONTH FROM log_time) = 3 THEN '23-03'
        WHEN EXTRACT(YEAR FROM log_time) = 2023 AND EXTRACT(MONTH FROM log_time) = 4 THEN '23-04'
        WHEN EXTRACT(YEAR FROM log_time) = 2023 AND EXTRACT(MONTH FROM log_time) = 5 THEN '23-05'
        WHEN EXTRACT(YEAR FROM log_time) = 2023 AND EXTRACT(MONTH FROM log_time) = 6 THEN '23-06'
        WHEN EXTRACT(YEAR FROM log_time) = 2023 AND EXTRACT(MONTH FROM log_time) = 7 THEN '23-07'
        WHEN EXTRACT(YEAR FROM log_time) = 2023 AND EXTRACT(MONTH FROM log_time) = 8 THEN '23-08'
        WHEN EXTRACT(YEAR FROM log_time) = 2023 AND EXTRACT(MONTH FROM log_time) = 9 THEN '23-09'
    END AS month
FROM 
    project.raw_login_data) b
ON a.WID = b.WID
GROUP BY 1,2
ORDER BY 2

SELECT 
    DATE(log_time) AS log_date,
    CASE 
        WHEN EXTRACT(YEAR FROM log_time) = 2022 AND EXTRACT(MONTH FROM log_time) = 1 THEN '22-01'
        WHEN EXTRACT(YEAR FROM log_time) = 2022 AND EXTRACT(MONTH FROM log_time) = 2 THEN '22-02'
        WHEN EXTRACT(YEAR FROM log_time) = 2022 AND EXTRACT(MONTH FROM log_time) = 3 THEN '22-03'
        WHEN EXTRACT(YEAR FROM log_time) = 2022 AND EXTRACT(MONTH FROM log_time) = 4 THEN '22-04'
        WHEN EXTRACT(YEAR FROM log_time) = 2022 AND EXTRACT(MONTH FROM log_time) = 5 THEN '22-05'
        WHEN EXTRACT(YEAR FROM log_time) = 2022 AND EXTRACT(MONTH FROM log_time) = 6 THEN '22-06'
        WHEN EXTRACT(YEAR FROM log_time) = 2022 AND EXTRACT(MONTH FROM log_time) = 7 THEN '22-07'
        WHEN EXTRACT(YEAR FROM log_time) = 2022 AND EXTRACT(MONTH FROM log_time) = 8 THEN '22-08'
        WHEN EXTRACT(YEAR FROM log_time) = 2022 AND EXTRACT(MONTH FROM log_time) = 9 THEN '22-09'
        WHEN EXTRACT(YEAR FROM log_time) = 2022 AND EXTRACT(MONTH FROM log_time) = 10 THEN '22-10'
        WHEN EXTRACT(YEAR FROM log_time) = 2022 AND EXTRACT(MONTH FROM log_time) = 11 THEN '22-11'
        WHEN EXTRACT(YEAR FROM log_time) = 2022 AND EXTRACT(MONTH FROM log_time) = 12 THEN '22-12'
        WHEN EXTRACT(YEAR FROM log_time) = 2023 AND EXTRACT(MONTH FROM log_time) = 1 THEN '23-01'
        WHEN EXTRACT(YEAR FROM log_time) = 2023 AND EXTRACT(MONTH FROM log_time) = 2 THEN '23-02'
        WHEN EXTRACT(YEAR FROM log_time) = 2023 AND EXTRACT(MONTH FROM log_time) = 3 THEN '23-03'
        WHEN EXTRACT(YEAR FROM log_time) = 2023 AND EXTRACT(MONTH FROM log_time) = 4 THEN '23-04'
        WHEN EXTRACT(YEAR FROM log_time) = 2023 AND EXTRACT(MONTH FROM log_time) = 5 THEN '23-05'
        WHEN EXTRACT(YEAR FROM log_time) = 2023 AND EXTRACT(MONTH FROM log_time) = 6 THEN '23-06'
        WHEN EXTRACT(YEAR FROM log_time) = 2023 AND EXTRACT(MONTH FROM log_time) = 7 THEN '23-07'
        WHEN EXTRACT(YEAR FROM log_time) = 2023 AND EXTRACT(MONTH FROM log_time) = 8 THEN '23-08'
        WHEN EXTRACT(YEAR FROM log_time) = 2023 AND EXTRACT(MONTH FROM log_time) = 9 THEN '23-09'
    END AS quater
    , WID
FROM 
    project.raw_login_data;


--segment_revenue
SELECT Segment, SUM(revenue) revenue
FROM
(SELECT t1.WID, Segment
FROM
(WITH RecencyTarget AS (
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
    CASE
        WHEN DATE_DIFF(DATE '2023-09-30', R.last_purchase_date, DAY) <= 7 THEN '7일 이내 구매'
        WHEN DATE_DIFF(DATE '2023-09-30', R.last_purchase_date, DAY) <= 30 THEN '30일 이내 구매'
        ELSE '그 이상'
    END AS recency_segmentation,
    CASE
        WHEN F.total_buy_count >= 5 THEN '5회 이상 구매'
        WHEN F.total_buy_count BETWEEN 2 AND 4 THEN '2-4회 구매'
        ELSE '1회 구매'
    END AS frequency_segmentation,
    CASE 
        WHEN M.total_revenue < 100000 THEN '10만원 미만'
        WHEN M.total_revenue >= 100000 AND M.total_revenue < 1000000 THEN '10만원~100만원'
        ELSE '100만원 이상' 
    END AS expenditure_segmentation,
     CASE 
        WHEN DATE_DIFF(DATE '2023-09-30', R.last_purchase_date, DAY) <= 7
            AND F.total_buy_count >= 5
            AND M.total_revenue >= 1000000 THEN 'VIP'
        WHEN DATE_DIFF(DATE '2023-09-30', R.last_purchase_date, DAY) > 30
           AND F.total_buy_count >= 5
           AND M.total_revenue >= 1000000 THEN '이탈 VIP'
        WHEN DATE_DIFF(DATE '2023-09-30', R.last_purchase_date, DAY) > 30
           AND F.total_buy_count = 1
           AND M.total_revenue < 100000 THEN '소과금 VIP'
        WHEN DATE_DIFF(DATE '2023-09-30', R.last_purchase_date, DAY) <= 30 AND DATE_DIFF(DATE '2023-09-30', R.last_purchase_date, DAY) > 7
           AND F.total_buy_count >= 5
           AND M.total_revenue >= 100000 AND M.total_revenue < 1000000 THEN '중과금 VIP'
        WHEN DATE_DIFF(DATE '2023-09-30', R.last_purchase_date, DAY) > 30
           AND F.total_buy_count = 1
           AND M.total_revenue >= 100000 AND M.total_revenue < 1000000 THEN '잠재 VIP'        
    END AS Segment
FROM
    RecencyTarget R
JOIN
    FrequencyTarget F ON R.WID = F.WID
JOIN
    MonetaryTarget M ON R.WID = M.WID) t1
INNER JOIN
(SELECT WID, country FROM project.raw_register_data 
) t2
ON t1.WID = t2.WID) a
INNER JOIN
	(SELECT * FROM project.daily_sales) b
ON a.WID = b.WID
GROUP BY 1







