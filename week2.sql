SELECT date, item_id, sum(revenue) sum_revenue FROM project.daily_sales
GROUP BY 1,2

SELECT item_id, avg(sum_revenue) daily_avg_revenue 
FROM (SELECT date, item_id, sum(revenue) sum_revenue FROM project.daily_sales
GROUP BY 1,2) 
GROUP BY 1

--- 2023년 3월에 3번 모드를 플레이하고, 아이템을 구매한 적 있는 유저들에게 보상을 준다.
SELECT DISTINCT WID FROM project.daily_sales


SELECT DISTINCT WID FROM project.daily_play
WHERE FORMAT_DATE('%Y-%m', date) ='2023-03'
AND mode = 3


SELECT DISTINCT WID FROM project.daily_sales
WHERE WID IN (
SELECT DISTINCT WID FROM project.daily_play
WHERE FORMAT_DATE('%Y-%m', date) ='2023-03'
AND mode = 3)

WITH my_with_table AS(
SELECT date, item_id, sum(revenue) sum_revenue FROM project.daily_sales 
GROUP BY 1,2)
SELECT item_id, avg(sum_revenue) daily_avg_revenue
FROM my_with_table
GROUP BY 1



