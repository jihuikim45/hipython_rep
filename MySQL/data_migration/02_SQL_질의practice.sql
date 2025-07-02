-- 성별에 따른 사원수, NULL>총 사원수 출력

SELECT *
FROM 사원
LIMIT 1;

SELECT 성별
	, COUNT(*) AS 사원수
FROM 사원
GROUP BY 성별 WITH ROLLUP;

SELECT 
IF(GROUPING(성별)=1, '총사원수', 성별)
, COUNT(*) AS 사원수
FROM 사원
GROUP BY 성별 WITH ROLLUP;


-- 주문년도별 주문건수
SELECT YEAR(주문일) AS 주문년도
	, COUNT(*) AS 주문건수
FROM 주문
GROUP BY YEAR(주문일)
ORDER BY 주문년도;


-- 주문년도별, 분기별, 전체주문건수 추가
SELECT YEAR(주문일) AS 주문년도
	,QUARTER(주문일) AS 분기
    , COUNT(*) AS 전체주문건수
FROM 주문
GROUP BY YEAR(주문일), QUARTER(주문일)
WITH ROLLUP;


-- 주문내역에서 월별 발송지연건 
SELECT YEAR(발송일) AS 발송년도
	, MONTH(발송일) AS 발송월
    , COUNT(*) AS 발송지연건수
FROM 주문
WHERE 발송일 > 요청일
GROUP BY YEAR(발송일), MONTH(발송일)
WITH ROLLUP;


SELECT *
FROM 제품
LIMIT 1;

-- 아이스크림 제품별 재고합
SELECT 제품명
	,COUNT(*) AS 재고합
FROM 제품
WHERE 제품명 LIKE '%아이스크림%'
GROUP BY 제품명
ORDER BY 제품명;


-- 고객구분(VIP,일반)에 따른 고객수, 평균 마일리지, 총합
SELECT
CASE
	WHEN 마일리지 > 10000 THEN 'VIP'
    ELSE 'GENERAL'
END AS 등급
, COUNT(*) AS 고객수
, AVG(마일리지) AS 평균마일리지
, SUM(마일리지) AS 총합마일리지

FROM 고객
GROUP BY 등급
WITH ROLLUP;

SELECT
IF (마일리지 > 10000, 'VIP', 'GENERAL') AS 등급
, COUNT(*) AS 고객수
, AVG(마일리지) AS 평균마일리지
, SUM(마일리지) AS 총합마일리지

FROM 고객
GROUP BY 등급
WITH ROLLUP;