SHOW DATABASES;
USE world;
SHOW TABLES;

USE wntrade;
SHOW TABLES;

DESCRIBE 고객;
SHOW COLUMNS FROM 고객;


-- 셀렉션 명령 : 테이블에서 행단위로 추출 

SELECT COUNT(*) FROM 고객;  -- 93건
SELECT COUNT(*) FROM 주문;  -- 830건 

SELECT *
FROM information_schema.tables
WHERE table_schema = 'WNTRADE';


-- 프로젝션 연산 
SELECT 고객번호, 고객회사명, 담당자명 -- 어떤 컬럼 지정
FROM 고객
WHERE 담당자명 = '이은광';  -- 셀렉션 연산


SELECT * FROM 주문;

SELECT 주문번호, 고객번호, 주문일, 발송일
FROM 주문
WHERE 사원번호 = 'E04';


SELECT * FROM 제품
WHERE 단가 <1500;


-- 쿼리 연산: 각 테이블의 데이터를 셀렉션, 프로젝션 하기

-- 프로젝션 >> 컬럼, 연산식, 함수

SELECT 고객회사명
, 담당자명 AS 이름
, 담당자직위 AS 직위
, 마일리지
, 마일리지 * 1.1 AS '인상된 마일리지'
FROM 고객
WHERE 마일리지 > 100000
ORDER BY 마일리지 DESC;

-- 2-5
SELECT *
FROM 고객
LIMIT 3;

-- 마일리지가 많은 TOP3 고객
SELECT *
FROM 고객
ORDER BY 마일리지 DESC
LIMIT 3;

SELECT DISTINCT 도시 FROM 고객;

-- DISTINCT, ORDER BY, ASC, DESC
-- 1. SQL 문에서는 대소문자 구분이 없다 - 키워드, 객체명 모두
-- 2. 꼭 한 줄에 쓰지 않아도 된다 ; 로 구분
-- 3. 가독성을 위해 줄을 맞춰 쓴다.
-- 4. 일반적으로 키워드는 대문자, 객체명은 소문자로 입력한다.
-- 5. 프로젝션에서 지정한 컬럼의 순서가 결과 출력의 순서이다. 


-- 산술, 비교, 논리, 집합 연산자
SELECT
23 + 5 AS 더하기
, 23-5 AS 빼기
, 23 / 5 AS 실수나누기
, 23 DIV 5 AS 정수나누기
, 23 % 5 AS 나머지1
, 23 MOD 5 AS 나머지2;

-- 2-9
SELECT 
23 >= 5
, 23 <= 5
, 23 > 23
, 23 < 23
, 23 = 23
, 23 != 23
, 23 <> 23;

-- 2-10
SELECT *
FROM 고객
WHERE 담당자직위 <> '대표 이사';

-- 2-11
SELECT *
FROM 고객
WHERE 도시 = '부산광역시'
AND 마일리지 < 1000;


-- 주문일이 2020-3-16일 이전인 주문 목록
SELECT *
FROM 주문
WHERE 주문일 < '2020-03-16';


-- 논리연산자 : AND, OR, NOT
SELECT *
FROM 고객
WHERE 도시 = '부산광역시'
AND 마일리지 < 1000;

-- 서울이거나 또는 마일리지가 5000이상
SELECT *
FROM 고객
WHERE 도시 = '서울특별시'
AND 마일리지 >= 5000;

-- 서울이 아닌 고객
SELECT *
FROM 고객
WHERE 도시 <> '서울특별시';

-- 서울이 아닌데 마일리지가 5000 이상
SELECT *
FROM 고객
WHERE 도시 <>'서울특별시'
OR 마일리지 >= 5000
ORDER BY 마일리지 DESC;

-- 서울, 부산인 마일리지 많은 고객
SELECT *
FROM 고객
WHERE (도시 = '부산광역시' OR 도시 = '서울특별시')
ORDER BY 마일리지 DESC
LIMIT 20;

-- 집합연산 : 합집합 UNION, UNIONALL

SELECT 고객회사명, 주소, 도시
FROM 고객
WHERE 도시 = '부산광역시'
AND 마일리지 > 5000
UNION
SELECT 고객회사명, 주소, 도시
FROM 고객
WHERE 도시 = '서울특별시'
AND 마일리지 > 5000
ORDER BY 1;


SELECT 도시
FROM 고객
UNION ALL  -- 103건
SELECT 도시
FROM 사원;


-- 교집합 INSERSECTION
SELECT DISTINCT 도시 FROM 고객
WHERE 도시 IN (
	SELECT 도시 FROM 사원
);

-- 여집합 EXCEPT
SELECT DISTINCT 도시 FROM 고객
WHERE 도시 NOT IN (
	SELECT 도시 FROM 사원
);

-- 합집합 : 컬럼수와 컬럼의 데이터타입이 일치
-- 정렬 : 전체쿼리 바깥에서 ORDER BY


-- IS NULL 연산자
-- NULL : 값없음 0, '' 이 아님

SELECT *
FROM 고객
-- WHERE 지역 = ''; 공백문자 66ROW
WHERE 지역 IS NULL; -- 0 ROW

-- 상사가 없는 사원

SELECT *
FROM 사원
-- WHERE 상사번호 = ''; 2개
WHERE 상사번호 IS NULL;

-- 2-13
SELECT *
FROM 고객
WHERE 지역 IS NULL;

USE WNTRADE;

UPDATE 고객
SET 지역 = NULL
WHERE 지역 = '';

SELECT *
FROM 고객
WHERE 지역 IS NULL;

-- IN : OR 연산
-- BETWEEN ~ AND ~ : AND 연산, 범위 지정

SELECT 고객번호
, 담당자명
, 담당자직위
FROM 고객
WHERE 담당자직위 = '영업 과장' OR 담당자직위 = '마케팅 과장';

-- IN 의 적용 > 여러개 중에 1개만 만족해도 참
SELECT 고객번호
, 담당자명
, 담당자직위
FROM 고객
WHERE 담당자직위 IN ('영업 과장', '마케팅 과장'); 

-- 서울, 부천, 부산에 사는 사원
SELECT  이름, 도시, 주소
FROM 사원
WHERE 도시 IN ('서울특별시', '부천시', '부산광역시'); -- 컬럼/속성의 도메인 값을 확인

-- A1, A2 부서의 사원
SELECT *
FROM 사원
WHERE 부서번호 IN ('A1', 'A2');

-- 마일리지가 100000점 이상 200000점 이하인 고객의 담장자명, 마일리지

SELECT 담당자명, 마일리지 
FROM 고객
WHERE 마일리지 BETWEEN 100000 AND 200000;


-- 주문이 특정 1달 동안 발생한 목록
SELECT *
FROM 주문
WHERE 주문일 BETWEEN '2020-06-01' AND '2020-06-30';

-- 마일리지 7천대 ~ 9천대 인 고객 추출
SELECT *
FROM 고객
WHERE 마일리지 BETWEEN 7000 AND 9000;


-- LIKE 연산자 %, _ (밑줄)

-- 광역시 이면서 고객번호 2번째 글자 또는 3번째 글자가 C
SELECT *
FROM 고객
WHERE 도시 LIKE '%광역시' 
AND (고객번호 LIKE '_C%' OR 고객번호 LIKE '__C%'); -- 3ROW
-- AND 고객번호 LIKE'_C%' OR 고객번호 LIKE '__C%'; -- 8ROW

-- 전화번호가 45로 끝나는 고객
SELECT *
FROM 고객
WHERE 전화번호 LIKE '%45'; -- 5 ROW

-- 전화번호 중에 45가 있는 고객
SELECT *
FROM 고객
WHERE 전화번호 LIKE '%45%'; -- 17 ROW

-- 서울에 사는 고객 중 마일리지 15천점 이상 2만점 이하 고객
SELECT *
FROM 고객
WHERE 도시 = '서울특별시'
AND 마일리지 BETWEEN 15000 AND 20000; -- 1ROW

-- 고객의 거주 지역, 도시를 1개씩 보이기 > 지역순, 동일지역은 도시순으로 출력
SELECT DISTINCT 지역, 도시
FROM 고객
ORDER BY 1, 2;

-- 춘천시, 과천시, 광명시 고객중 직위에 이사/사원이 있는 고객
SELECT *
FROM 고객
WHERE 도시 IN ('춘천시', '과천시', '광명시')
AND (담당자직위 LIKE '%이사' OR 담당자직위 LIKE '%사원');

-- 광역시, 특별시가 아닌 고객중 마일리지가 많은 상위 고객 3명
SELECT *
FROM 고객
WHERE 도시 NOT LIKE '%광역시' AND 도시 NOT LIKE '%특별시'
ORDER BY 마일리지 DESC;

-- 지역 값이 있는 고객, 담당자직위가 대표이사인 고객을 제외하고 출력
SELECT *
FROM 고객
WHERE 지역 IS NOT NULL
AND 담당자직위 <> '대표 이사';
