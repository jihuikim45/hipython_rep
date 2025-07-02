

-- 문자열 함수, 숫자형 함수


SELECT LEFT('SQL 완전정복', 3)
	,RIGHT('SQL 완전정복', 4)
    ,SUBSTR('SQL 완전정복', 2, 5)
    ,SUBSTR('SQL 완전정복', 2);
    
SELECT SUBSTRING_INDEX('서울시 동작구 흑석로', ' ', 2)
	,SUBSTRING_INDEX('서울시 동작구 흑석로', ' ', -2);
    

SELECT LPAD('SQL', 10, '#')
	,RPAD('SQL', 5, '*');
    

SELECT LENGTH(LTRIM(' SQL '))
	,LENGTH(RTRIM(' SQL '))
    , LENGTH(TRIM(' SQL '));
    

SELECT TRIM(BOTH 'abc' FROM 'abcSQLabcabc')
	,TRIM(LEADING 'abc' FROM 'abcSQLabcabc')
    , TRIM(TRAILING 'abc' FROM 'abcSQLabcabc');

SELECT FIELD('JAVA', 'SQL', 'JAVA', 'C')
	,FIND_IN_SET('JAVA', 'SQL,JAVA,C')
    ,INSTR('네 인생을 살아라', '인생')
    ,LOCATE('인생', '네 인생을 살아라');
    
-- 날짜 / 시간형 함수
-- NOW(), SYSDATE(), CURCATE() & CURTIME()
-- 현재 날짜 + 시간 가져오기 : 
-- 쿼리 시작시점 NOW()
-- 함수 시작시점 SYSDATE()

SELECT NOW()
, SYSDATE()
, CURDATE()
, CURTIME();


SELECT NOW() AS NOW_1
, SLEEP(5)
, NOW() AS NOW_2
, SYSDATE() AS SYS_1
, SLEEP(5)
, SYSDATE() AS SYS_2;


SELECT NOW()
	,YEAR(NOW())
    ,QUARTER(NOW())
    ,MONTH(NOW())
    ,DAY(NOW())
    ,HOUR(NOW())
    ,MINUTE(NOW())
    ,SECOND(NOW());
    
    
-- 기간 반환 함수
SELECT NOW() AS NOW
, DATEDIFF(NOW(), '2025-06-01') AS '2025-06-01' -- END,START 순으로 지정
, TIMESTAMPDIFF(YEAR, NOW(), '2023-12-20') AS YEAR
, TIMESTAMPDIFF(MONTH, NOW(), '2024-12-20') AS MONTH
, TIMESTAMPDIFF(WEEK, NOW(), '2025-06-20') AS WEEK;

SELECT NOW()
, LAST_DAY(NOW()) -- 이번달의 마지막 일자
, DAYOFYEAR(NOW()) -- 오늘이 올해의 몇번째 날인지
,MONTHNAME(NOW()) -- 이번 달 이름을 영문으로
, WEEKDAY('2025-07-01'); -- 요일, 월요일 0~

-- 태어난지 몇일 되었나? 
SELECT DATEDIFF(CURDATE(), '1993-04-05') AS 'DAY 1993-04-05';



-- 내 생일부터 천일 기념일
SELECT NOW()
	,ADDDATE('1993-04-05', 1000) AS D1000;
    
SELECT DATE_ADD('1993-04-05', INTERVAL 1000 DAY);

-- 나는 몇요일의 아이일까?
SELECT DAYNAME('1993-04-05') AS '요일';

-- 형변환
-- CAST() ANSI SQL, CONVERT() MYSQL
SELECT CAST('1' AS UNSIGNED)
, CAST(2 AS CHAR(1))
, CONVERT ('1', UNSIGNED)
, CONVERT (2, CHAR(1));


-- 제어 함수
-- IF() 조건식, 참값, 거짓값
SELECT IF (12500 * 450 > 5000000, '초과달성', '미달성');


-- IFNULL(속성값, 2) : 널처리 > 속성, 널일때 > 2
USE wntrade;
SELECT 이름, IFNULL(상사번호, '없음')
FROM 사원; 

-- 고객의 지역 > NULL 이면 '미입력'
SELECT 고객회사명, IFNULL(지역, '미입력')
FROM 고객
WHERE 지역 IS NULL;


-- NULLIF() : 조건을 만족하면 NULL, 아니면 지정한 값 반환
SELECT NULLIF(12*10, 120)
, NULLIF(12*10, 1200);


SELECT 고객번호, NULLIF(마일리지, 0) AS '유효마일리지'
FROM 고객;

-- CASE 문
/*
SELECT 컬럼명,
CASE WHEN 조건1, THEN 결과1
	WHEN 조건2, THEN 결과2
END
*/

SELECT 
CASE
	WHEN 12500*450 > 5000000 THEN '초과'
	WHEN 2500*450 > 4000000 THEN '달성'
END;

-- 고객, 마일리지 1만점 > VIP, 5천점 > GOLD, 1천점 > SILVER

SELECT 고객번호, 고객회사명, 마일리지,
	CASE
		WHEN 마일리지 > 10000 THEN 'VIP'
		WHEN 마일리지 > 5000 THEN 'GOLD'
		WHEN 마일리지 > 1000 THEN 'SILVER'
		ELSE 'BRONZE'
	END AS '등급'
FROM 고객;

-- 회고시 풀어보기
-- 주문금액 = 수량*단가, 할인금액=주문금액*할인율, 실주문금액 = 주문금액-할인금액
-- 주문세부 TABLE

-- 사원 TABLE 에서 이름, 생일, 만나이, 입사일, 입사일수, 500일기념일 계산

-- 중앙데이블에서 주문번호, 고객번호, 주문일, 년도, 분기, 월, 일, 요일, 한글로요일


-- 4. 집계함수
SELECT COUNT(*)
, COUNT(고객번호)
, COUNT(도시)
, COUNT(지역)
FROM 고객;

SELECT SUM(마일리지)
	,AVG(마일리지)
    ,MAX(마일리지)
    ,MIN(마일리지)
FROM 고객;  -- 결과행이 1개로 축약

-- 조건부 집계
SELECT SUM(마일리지)
	,AVG(마일리지)
    ,MAX(마일리지)
    ,MIN(마일리지)
FROM 고객
WHERE 도시 = '서울특별시';

-- GROUP별 집계 : 컬럼값 > 범주로 집계
-- GROUP BY

SELECT 도시
	, COUNT(*) AS 고객수  -- 서브셋의 레코드 전체 *
    , AVG(마일리지) AS 평균마일리지
FROM 고객
GROUP BY 도시;


SELECT *
FROM 고객;

SELECT 담당자직위, 도시
		, COUNT(*) AS 고객수
        , AVG(마일리지) AS 평균마일리지
FROM 고객
GROUP BY 담당자직위, 도시
ORDER BY 1,2;


-- 집계 결과에 조건부 출력

SELECT 도시
	, COUNT(*) AS 고객수  
    , AVG(마일리지) AS 평균마일리지
FROM 고객
GROUP BY 도시
HAVING COUNT(*) >= 10;

-- WHERE : 셀렉션의 조건 (GROUP BY 이전에 실행)
-- HAVING : GROUP BY한 집계에 조건, 기준 미달인 경우를 제외하기 위해 사용

SELECT 제품번호, AVG(주문수량)
FROM 주문세부
WHERE 주문수량 >= 30
GROUP BY 제품번호
HAVING AVG(주문수량) >= 50;


SELECT 도시
	,SUM(마일리지)
FROM 고객
WHERE 고객번호 LIKE 'T%'
GROUP BY 도시
HAVING SUM(마일리지) >= 1000;


-- SQL 실행 순서
/* 
5 SELECT
1 FROM
2 WHERE
3 GROUP BY
4 HAVING
6 ORDER BY
*/

SELECT 도시
	, COUNT(*) AS 고객수  -- 서브셋의 레코드 전체 *
    , AVG(마일리지) AS 평균마일리지
FROM 고객
GROUP BY 도시
WITH ROLLUP;

SELECT 도시, SUM(마일리지)
FROM 고객
WHERE 고객번호 LIKE 'T%'
GROUP BY 도시 WITH ROLLUP
HAVING SUM(마일리지) >= 1000;

-- 개선
SELECT 도시, 합계
FROM (  SELECT 도시, SUM(마일리지) AS 합계 -- SELECT 그룹 
        FROM 고객
        WHERE 고객번호 LIKE 'T%'
        GROUP BY 도시 WITH ROLLUP
) AS 그룹
WHERE (도시 IS NULL OR 합계 >=1000);

SELECT 담당자직위
	, 도시
    , COUNT(*) AS 고객수
FROM 고객
WHERE 담당자직위 LIKE '%마케팅%'
GROUP BY 담당자직위, 도시
WITH ROLLUP;

-- GROUPING() ROLLUP의 결과 생성한 행은 1, 그룹행은 0을 출력

SELECT 지역
, IF (GROUPING(지역) = 1, '합계행', 지역) AS 도시명
, COUNT(*) AS 고객수
, GROUPING(지역) AS 구분
FROM 고객
WHERE 담당자직위 = '대표 이사'
GROUP BY 지역 WITH ROLLUP;

SELECT GROUP_CONCAT(고객회사명)
FROM 고객;

SELECT GROUP_CONCAT(DISTINCT 지역)
FROM 고객;

