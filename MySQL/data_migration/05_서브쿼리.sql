-- SELECT  1개 테이블
-- JOIN 2개 이상 테이블
-- 서브쿼리 (내부쿼리)
use wntrade;
/*
SELECT  컬럼
FROM 고객
INNER JOIN 주문
ON 고객번호
WHERE 

SELECT *
FROM 테이블
WHERE 컬럼 = (  서브쿼리 );
*/

-- 종류 
-- 1. 서브쿼리가 반환하는 행의 갯수 : 단일행, 복수행
-- 2. 서브쿼리의 위치에 따라 : 조건절(WHERE), FROM 절, SELECT 절
-- 3. 상관서브쿼리 : 메인쿼리와 서브쿼리 상관(컬럼)
-- 4. 반환하는 컬럼수 : 단일컬럼, 다중컬럼 서브쿼리

SELECT  고객회사명, 담당자명, 마일리지
FROM 고객
WHERE 마일리지 = (
	SELECT MAX(마일리지)
    FROM 고객
);

SELECT  A.고객회사명, A.담당자명, A.마일리지
FROM 고객 A
LEFT JOIN 고객 B
ON A.마일리지 < B.마일리지
WHERE B.고객번호 IS NULL;


SELECT 고객번호, 고객회사명, 담당자명
FROM 고객
WHERE 고객번호 = ( -- 서브쿼리 단일행, 컬럼1개
	SELECT 고객번호
    FROM 주문
    WHERE 주문번호 = 'H0250'
);

SELECT 고객번호
    FROM 주문
    WHERE 주문번호 = 'H0250';


SELECT 담당자명, 고객회사명, 마일리지
FROM 고객
WHERE 마일리지 > (
	SELECT MIN(마일리지)
	FROM 고객
	WHERE 도시 = '부산광역시'
);

SELECT MIN(마일리지)
FROM 고객
WHERE 도시 = '부산광역시';


-- 복수행 서브쿼리  IN, ANY(최소값비교), SOME, ALL(최대값과 비교) , EXISTS
SELECT 고객번호, 마일리지
FROM 고객
WHERE 도시 = '부산광역시'
ORDER BY 2 ;

SELECT COUNT(*) AS 주문건수
FROM 주문
WHERE 고객번호 IN ( 
	SELECT 고객번호
	FROM 고객
	WHERE 도시 = '부산광역시'
);

-- ANY
SELECT 담당자명, 고객회사명, 마일리지
FROM 고객
WHERE 마일리지 >  ANY (
	SELECT 마일리지
	FROM 고객
	WHERE 도시 = '부산광역시'  -- 806
);

SELECT 담당자명, 고객회사명, 마일리지
FROM 고객
WHERE 마일리지 > ALL (
	SELECT 마일리지
	FROM 고객
	WHERE 도시 = '부산광역시' -- 7795
)
ORDER BY 3;

SELECT 고객번호, 고객회사명
FROM 고객
WHERE EXISTS (
	SELECT * 
    FROM 주문
    WHERE 고객번호 =  고객.고객번호  -- 상관서브쿼리
);

-- 위치 : WHERE 에 존재하는 서브쿼리
--  GROUP BY 의 조건절에 사용하는 서브쿼리
SELECT 도시, AVG(마일리지)  AS 평균
FROM 고객
GROUP BY 도시
HAVING 평균 > (
	SELECT AVG(마일리지) 
    FROM 고객
);
SELECT AVG(마일리지) 
    FROM 고객;
    
 -- FROM 절의 서브쿼리 :  인라인 뷰 , 별명 필수  
 
SELECT 도시, AVG(마일리지) AS 도시_평균마일리지
FROM 고객
GROUP BY 도시;

SELECT 담당자명, 고객회사명, 마일리지
, 도시_평균마일리지
, (도시_평균마일리지 - 마일리지 ) AS 마일리지차이
FROM 고객 , 
(  
	SELECT 도시, AVG(마일리지) AS 도시_평균마일리지
	FROM 고객
	GROUP BY 도시 
)     AS 도시별요약
WHERE 고객.도시 = 도시별요약.도시;

-- ANSI CODE
SELECT 담당자명, 고객회사명, 마일리지
, 도시_평균마일리지
, (도시_평균마일리지 - 마일리지 ) AS 마일리지차이
FROM 고객 
JOIN (  
	SELECT 도시, AVG(마일리지) AS 도시_평균마일리지
	FROM 고객
	GROUP BY 도시 
)     AS 도시별요약
ON 고객.도시 = 도시별요약.도시;


-- 사원별 상사의 이름 출력을 인라인뷰로 구현
SELECT  A.이름 AS 사원명, B.이름 AS 상사명
FROM 사원 A 
JOIN ( SELECT 사원번호, 이름 FROM 사원) B
ON A.상사번호 = B.사원번호;

-- 제품별 총 주문 수량과 재고 비교를 인라인뷰로 구현
SELECT 제품번호, SUM(주문수량) AS 총주문수량
FROM 주문세부
GROUP BY 제품번호; 

SELECT 제품명, 재고, 주문요약.총주문수량
, (제품.재고 - 주문요약.총주문수량) AS 잔여가능수량
FROM 제품
JOIN (
	SELECT 제품번호, SUM(주문수량) AS 총주문수량
	FROM 주문세부
	GROUP BY 제품번호
 ) AS 주문요약  -- 제품별 총주문수량 집계 테이블
ON 제품.제품번호 = 주문요약.제품번호;

-- 고객별 가장 최근 주문일 출력
SELECT 고객번호, MAX(주문일) AS 최근주문일
FROM 주문
GROUP BY 고객번호;

SELECT 고객.고객번호, 고객회사명, 최근주문.최근주문일
FROM 고객
JOIN (
	SELECT 고객번호, MAX(주문일) AS 최근주문일
	FROM 주문
	GROUP BY 고객번호
) AS 최근주문
ON 고객.고객번호 = 최근주문.고객번호;


-- 인라인뷰, 조인  : 유지보수 관점에서는 되도록이면 조인을 추천


-- 스칼라 서브쿼리
SELECT 고객번호, 고객회사명, ( 
	SELECT MAX(주문일)
    FROM 주문
    WHERE 주문.고객번호 = 고객.고객번호
) AS 최근주문일
FROM 고객;


-- 고객별 총주문건수

SELECT 고객번호
     , 담당자명
     , (SELECT COUNT(*)
        FROM 주문
        WHERE 주문.고객번호 = 고객.고객번호) AS 총주문건수
FROM 고객;

-- 조인

SELECT 고객.고객번호
     , 고객.담당자명
     , COUNT(주문.주문번호) AS 총주문건수
FROM 고객
LEFT JOIN 주문
  ON 고객.고객번호 = 주문.고객번호
GROUP BY 고객.고객번호, 고객.담당자명;


-- JOIN 문법

SELECT 고객.고객회사명, COUNT(DISTINCT 주문.주문번호) AS 총주문건수
FROM 고객
INNER JOIN 주문
ON 고객.고객번호 = 주문.고객번호
INNER JOIN 주문세부
ON 주문.주문번호 = 주문세부.주문번호
GROUP BY 고객.고객회사명;


-- 스칼라 문법

SELECT 
    고객.고객회사명,
    (
        SELECT COUNT(DISTINCT 주문.주문번호)
        FROM 주문
        INNER JOIN 주문세부
        ON 주문.주문번호 = 주문세부.주문번호
        WHERE 주문.고객번호 = 고객.고객번호
    ) AS 총주문건수
FROM 고객
ORDER BY 고객.고객회사명;

-- 각 제품의 마지막 주문단가
SELECT 제품번호, 제품명,
(SELECT 단가
FROM 주문세부
WHERE 주문세부.제품번호 = 제품.제품번호
ORDER BY 주문번호 DESC
LIMIT 1)
AS 최근주문단가
FROM 제품;

SELECT 사원번호
,이름
,(
	SELECT MAX(주문수량)
    FROM 주문 JOIN 주문세부
    ON 주문.주문번호 = 주문세부.주문번호
    WHERE 주문.사원번호 = 사원.사원번호)
AS 최대주문수량
FROM 사원;


-- CTE: 임시테이블 정의, 쿼리 1개
WITH 도시요약 AS (
SELECT 도시, AVG(마일리지) AS 도시평균마일리지
FROM 고객
GROUP BY 도시)

SELECT 담당자명, 고객회사명, 마일리지, 고객.도시
, 도시평균마일리지
FROM 고객
INNER JOIN 도시요약
ON 고객.도시 = 도시요약.도시;

-- 다중 컬럼 서브쿼리
SELECT 고객회사명, 도시, 담당자명, 마일리지
FROM 고객
WHERE (도시, 마일리지) IN (
	SELECT 도시, MAX(마일리지)
    FROM 고객
    GROUP BY 도시
)
ORDER BY 1;


-- GPT JOIN
SELECT 
  고객.고객회사명, 
  고객.도시, 
  고객.담당자명, 
  고객.마일리지
FROM 고객
JOIN (
  SELECT 도시, MAX(마일리지) AS 최고마일리지
  FROM 고객
  GROUP BY 도시
) AS 도시별최고
  ON 고객.도시 = 도시별최고.도시 
 AND 고객.마일리지 = 도시별최고.최고마일리지;

-- 강의 JOIN

SELECT A.고객회사명, A.도시, A.담당자명, A.마일리지 
FROM 고객 AS A
JOIN 고객 AS  B
ON A.도시 = B.도시
GROUP BY A.고객회사명, A.도시, A.담당자명, A.마일리지 
HAVING A.마일리지 = MAX(B.마일리지)
ORDER BY 1;
