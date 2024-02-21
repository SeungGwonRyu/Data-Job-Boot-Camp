-- 1. daily_play 테이블에서 mode가 1인 데이터를 출력하세요(단, 날짜 순으로 100행만 출력)
SELECT * FROM project.daily_play 
WHERE mode = 1
ORDER BY date
LIMIT 100


-- 2. 가입 유저중 WID가 W10500~W11000이며, 국적이 한국(KR)인 데이터만 출력하세요.
SELECT WID ,country  FROM project.raw_register_data 
WHERE WID <= 'W11000' AND WID >= 'W10500' AND country = 'KR'

-- 3. item_id가 200~300인 경우를 제외하고, 2023년 매출 데이터만 출력하세요.
SELECT FORMAT_DATE('%Y-%m-%d', date) date, item_id, revenue FROM project.daily_sales
WHERE (item_id < 200 OR item_id > 300)
AND EXTRACT (YEAR FROM date) = 2023

-- 4. 우리 프로젝트의 최초 거래일, 최종 거래일, 총 매출, 구매 유저수, ARPPU(구매 유저 당 매출), 구매 건 수를 구하세요.
SELECT * FROM project.daily_sales 

-- 4.1최초 거래일 
SELECT date FROM project.daily_sales 
ORDER BY date

-- 4.2최종 거래일 
SELECT date FROM project.daily_sales 
ORDER BY date DESC

-- 최초 거래일, 최종거래일 ,총매출, 구매 유저수, 구매 유저당 매출, 구매 건
SELECT MIN(date) first_purchase_date
,MAX(date) last_purchase_date
,sum(revenue) total_revenue
,COUNT(DISTINCT(WID)) unique_user
,SUM(revenue) / COUNT(DISTINCT WID) arppu
,SUM(buy_count) Number_of_purchases
FROM project.daily_sales 


-- 5. 연도별, 국가별 접속 유저를 구하세요. (연도는 EXTRACT, FORMAT_DATE 등을 활용할 것) 
SELECT FORMAT_DATE('%Y', log_time) year
,COUNT(DISTINCT(WID)) user_count, country  
FROM project.raw_login_data
GROUP BY country ,year
ORDER BY user_count DESC


-- 6. KR, JP의 가입 채널별 유저 수를 구해 가장 많은 가입자가 있는 플랫폼을 찾아보세요 
SELECT register_channel , COUNT(DISTINCT(WID)) user_count, country  FROM project.raw_register_data 
WHERE country = 'KR'
GROUP BY register_channel ,country 
ORDER BY user_count DESC

SELECT register_channel, COUNT(DISTINCT(WID)) user_count, country  FROM project.raw_register_data
WHERE country = 'JP'
GROUP BY register_channel , country 
ORDER BY user_count DESC

-- 7. 상품별로 매출과 PU(구매 유저수), ARPPU(구매 유저당 매출)을 구하세요.  
SELECT DISTINCT (item_id)
,SUM(revenue) total_revenue
,COUNT(WID) PU
,SUM(revenue) / COUNT(DISTINCT WID) ARPPU
FROM project.daily_sales 
GROUP BY item_id
ORDER BY item_id 

-- 8. KR 유저의 OS 별 DAU를 구하세요.
SELECT date(log_time) log_date, COUNT(WID) DAU, country, os  FROM project.raw_login_data
WHERE country = 'KR'
GROUP BY 1, country, os 

-- 9. 구매 수량이 5개 이상인 경우 'mid', 10개 이상인 경우 'high', 5개 미만인 경우 'low'로 정의하여 해당 그룹별로 구매 건수와
-- 매출 총액을 구하세요.

SELECT 
CASE WHEN buy_count >= 5 AND buy_count < 10 THEN 'mid'
	 WHEN buy_count >= 10 THEN 'high'
	 ELSE 'low' END as buy_grade
, SUM(revenue) total_revenue
, SUM(buy_count) buy_count 
FROM project.daily_sales
GROUP BY 1

SELECT * FROM project.daily_sales 

-- 10. KR, JP 그리고 그 외 국가를 ETC로 정의한 뒤 일별로 최고 레벨과 로그인 횟수를 구하세요.
SELECT * FROM project.raw_login_data 

SELECT CASE WHEN country IN ('KR', 'JP') THEN country ELSE 'ETC' END country
, date(log_time) log_date
,MAX(level) max_lv
,COUNT(*) login_cnt
FROM project.raw_login_data 
GROUP BY 1, 2



-- 1. 새로운 서비스 지역 발굴을 위해 가입 유저 규모를 파악하고자 합니다. kr/jp를 제외하고 2022년, 2023년 가장 많은 가입자를 보유한
-- 국가는 어디인지 확인해주세요.
SELECT COUNT(DISTINCT(WID)) user_count, country  FROM project.raw_login_data
WHERE country != 'KR' AND country != 'JP'
GROUP BY country
ORDER BY user_count DESC

-- 2. 우리 프로젝트의 연도 및 월별 매출, MAU를 나타내고 트렌드에 대한 해석을 하세요. 

SELECT FORMAT_DATE('%Y', date) year, SUM(revenue) revenue FROM project.daily_sales
GROUP BY year

SELECT FORMAT_DATE('%Y-%m', date) month, SUM(revenue) revenue FROM project.daily_sales
GROUP BY month
ORDER BY revenue 

SELECT FORMAT_DATE('%Y-%m', date) month, COUNT(DISTINCT(WID)) mau FROM project.daily_play
GROUP BY month






