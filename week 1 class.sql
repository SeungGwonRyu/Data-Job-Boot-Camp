SELECT * FROM project.raw_register_data

SELECT * FROM project.raw_register_data 
WHERE country ='KR' 
-- 한국 유저만 조회

SELECT * FROM project.raw_register_data 
WHERE country ='KR'
LIMIT 5

SELECT DISTINCT country,os  FROM project.raw_register_data 

SELECT * FROM project.raw_register_data


SELECT * FROM project.raw_register_data 
WHERE country ='KR' and os = 'ios'

SELECT * FROM project.raw_register_data 
WHERE log_time  >= '2023-01-01'

SELECT * FROM project.raw_register_data 
WHERE country !='KR'

SELECT * FROM project.raw_register_data 
WHERE country ='KR'
OR country ='JP'
OR country ='US'

SELECT * FROM project.raw_register_data 
WHERE country in('KR','JP', 'US')
--위랑 똑같은 문법

SELECT * FROM project.raw_register_data 
WHERE country NOT IN('KR','JP', 'US')


#레벨 순으로 정렬
SELECT * FROM project.raw_login_data
ORDER BY level DESC ,country 
#

SELECT MIN(level) AS min_lv
, MAX(level) max_lv
, MIN(log_time) first_login_time
, MAX(log_time) last_login_time
FROM project.raw_login_data 

-- 우리 게임에 접속한 유저수
SELECT COUNT(DISTINCT WID), COUNT(WID), COUNT(*)  FROM project.raw_login_data 
-- 빈 값이 없다라는 것을 확인 가능하다.


SELECT SUM(revenue), COUNT(DISTINCT WID) pu,
SUM(revenue) / COUNT(DISTINCT WID) arppu   --구매유저당 지출 금액
FROM project.daily_sales


--group by
SELECT date, mode, SUM(playtime) total_playtime FROM project.daily_play  
GROUP BY mode, date
ORDER BY 3 DESC



위와 동일하게 컬럼명 말고 컬럼 번호를 사용 가능하다.

일별 모드에 따른 플레이타임


--ACTIVE USER : 활성화 유저수 / 접속자수
--DAU(daily active user)

SELECT date(log_time) log_date, COUNT(DISTINCT WID) dau 
FROM project.raw_login_data 
GROUP BY 1


SELECT * ,
CASE WHEN log_time < '2023-01-01' THEN 'old-user'
       ELSE 'youn-user' END regster_group
FROM project.raw_login_data 
-- 2023에 가입한 사람들은 young-user
-- 2022에 가입한 사람들은 old-user

SELECT CASE WHEN log_time < '2023-01-01' THEN 'old-user'
       ELSE 'youn-user' END regster_group
, COUNT(DISTINCT WID) num_of_data 
FROM project.raw_register_data  
GROUP BY 1


SELECT *
, CASE  WHEN log_time < '2023-01-01' THEN 1 ELSE 0 END FROM project.raw_register_data 

--국가별로 young유저수, old 유저수
SELECT country 
,SUM(CASE  WHEN log_time < '2023-01-01' THEN 1 ELSE 0 END) old_users
,SUM(CASE  WHEN log_time < '2023-01-01' THEN 0 ELSE 1 END) young_users
FROM project.raw_register_data
GROUP BY 1


--FORMAT_DATE, EXTRACT()
--BIGQUERY에만있음

FORMAT_DATE('날짜형', 날짜데이) ->날짜데이터를 내가 정한 형식으로 바꾼다
EXTRACT(원하는 날짜부분 FROM 날짜데이) -> 날짜데이터에서 내가 필요한 날짜 부분을 가져온다. 추출한다m
YEAR, MONTH, DAY, MINUTE, HOUR ~날짜부분s



SELECT FORMAT_DATE('%Y-%m', log_time)
,EXTRACT (YEAR FROM log_time) extract_ex
, * from project.raw_login_data 






