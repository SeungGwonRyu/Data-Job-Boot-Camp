-- 여러 테이블의 데이터를 한 번에 조회하거나, 결합 후 집계 등으로 데이터 활용
SELECT *
FROM TABLE 1
( ) JOIN TABLE 2
ON TABLE 1.key = TABLE2.key

-- 로그인 횟수가 40번 이상이고, 구매일수가 5일 이상인 유저들의 레벨과 구매횟수를 구하세요

(SELECT * FROM(
SELECT WID, COUNT(*) num_of_login, MAX(level) max_lv 
FROM project.raw_login_data 
GROUP BY 1)
WHERE num_of_login >= 40)


--(2) having



SELECT WID, COUNT(*) num_of_login, MAX(level) max_lv 
FROM project.raw_login_data 
GROUP BY 1
HAVING num_of_login >= 40

INNER JOIN

(SELECT WID, COUNT(DISTINCT date) num_of_paydays, SUM(revenue) total_revenue
from project.daily_sales 
GROUP BY 1
HAVING num_of_paydays >= 5)



SELECT * 
FROM
	(SELECT WID, COUNT(*) num_of_login, MAX(level) max_lv 
	FROM project.raw_login_data 
	GROUP BY 1
	HAVING num_of_login >= 40) A
INNER JOIN 
	(SELECT WID, COUNT(DISTINCT date) num_of_paydays, SUM(revenue) total_revenue
	from project.daily_sales 
	GROUP BY 1
	HAVING num_of_paydays >= 5) B
ON A.WID = B.WID;

-- left join
-- 각 국가별 매출금액, 과금유저수, 무과금유저수
COALESCE(A,B,C,D,E,....0)
A가 널이면 B 가널이면 C가 널이면 D


SELECT country
,SUM(revenue) total_revenue
,COUNT(DISTINCT t2.WID) pu
,COUNT(DISTINCT t1.WID)  - COUNT(DISTINCT t2.WID) non_pu
,COUNT(DISTINCT CASE WHEN t2.WID IS NULL THEN t1. WID END) non_pu2
FROM project.raw_register_data t1
LEFT JOIN project.daily_sales t2
ON t1.WID =t2.WID
GROUP BY 1


SELECT *
, CASE WHEN t2.WID IS NULL THEN t1. WID END
FROM project.raw_register_data t1
LEFT JOIN project.daily_sales t2
ON t1.WID =t2.WID

-- 국가별 D+1 RETENTION
" 오늘 누가 들어왔을까 "
잔존율 : 오늘 들어온 유저중 내일 들어온 사람은 몇 %인가?


SELECT DISTINCT date(log_time) log_date,WID, country FROM project.raw_login_data



--- 이거 다시한번 공부해보기......
WITH login_list AS (
SELECT DISTINCT date(log_time) log_date, WID, country  FROM project.raw_login_data)
SELECT d0.country, COUNT(DISTINCT d1.WID) / COUNT(DISTINCT d0.WID) 
FROM login_list d0 -- 오늘
LEFT JOIN login_list d1 -- 내일
ON d0.WID = d1.WID
AND DATE_ADD(d0.log_date, INTERVAL 1 DAY) = d1.log_date
GROUP BY 1



d0.date + 하루 = d1.date

DATE_ADD(날짜 INTERVAL 숫자단위 )
date_add(do.log_date INTERVAL 1 DAY)







