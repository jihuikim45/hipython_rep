-- SELECT 연산
-- DML(Data Manipulation Language) 데이터조작어
-- INSERT : INSERT SELECT, INSERT ON DUPLICATE KEY
-- UPDATE : UPDATE SELECT, UPTATE JOIN
-- DELETE : DELETE SELECT, DELETE JOIN


SELECT * FROM 부서;

/*
INSERT INTO 테이블명
VALUES(값목록);
*/

INSERT INTO 부서
VALUES('A5', '마케팅부');

SELECT * FROM 부서;

-- 제품
SELECT *
FROM 제품
WHERE 제품번호 = 90;

-- 제품번호: 91, 제품명: 연어피클소스, 단가:5000, 재고: 40
INSERT INTO 제품
VALUES('91', '연어피클소스', ' ', '5000', '40');

INSERT INTO 제품(제품번호, 제품명, 단가, 재고)
VALUES('90', '연어핫소스', '4000', '50');


-- 사원테이블 세 명의 사원 추가하기
INSERT INTO 사원(사원번호, 이름, 직위, 성별, 입사일)
VALUES('E20', '김사과', '수습사원', '남', CURDATE())
,('E21', '박바나나', '수습사원', '여', CURDATE())
,('E22', '정오렌지', '수습사원', '여', CURDATE());

SELECT *
FROM 사원;

/*
UPDATE 테이블명
SET 컬럼이름 = 값,
WHERE 사원번호 = 'E20'
*/

UPDATE 사원
SET 이름 = '김레몬'
WHERE 사원번호 = 'E20';

SELECT *
FROM 사원;


UPDATE 제품
SET 포장단위 = '200 ml bottles'
WHERE 제품번호 = 91;


UPDATE 제품 SET 단가 = 단가*1.1, 재고=재고-10
WHERE 제품번호 = 91;

SELECT *
FROM 제품
WHERE 제품번호 = 91;


DELETE FROM 제품
WHERE 제품번호 = 91;

SELECT *
FROM 제품
WHERE 제품번호 = 91;


SELECT * FROM 사원
WHERE 이름 IN ('김레몬', '박나나나', '정오렌지');



INSERT INTO 제품(제품번호, 제품명, 단가, 재고)
VALUES(91, '연어피클핫소스',6000,50)
ON DUPLICATE KEY UPDATE
제품명 = '연어피클핫소스',단가 = 6000, 재고 = 50;




CREATE TABLE 고객주문요약
(
	고객번호 CHAR(5) PRIMARY KEY,
	고객회사명 VARCHAR(50),
	주문건수 INT,
	최종주문일 DATE
);



INSERT INTO 고객주문요약(고객번호, 고객회사명,주문건수,최종주문일)
-- VALUES
SELECT
	고객.고객번호
	,고객회사명
    ,COUNT(*)
    ,MAX(주문일) AS 최종주문일
FROM 고객
INNER JOIN 주문
ON 고객.고객번호 = 주문.고객번호
GROUP BY 고객.고객번호, 고객회사명
ON DUPLICATE KEY UPDATE
주문건수 = VALUES(주문건수),
최종주문일 = VALUES(최종주문일);


SELECT *
FROM 고객주문요약;

SELECT *
FROM (
SELECT AVG(단가)
FROM 제품
WHERE 제품명 LIKE '%소스%'
) AS T; -- 인라인뷰

SELECT AVG(단가)
FROM 제품
WHERE 제품명 LIKE '%소스%';


UPDATE 고객
	,(
    SELECT DISTINCT 고객번호
    FROM 주문
    ) AS 주문고객
SET 마일리지 = 마일리지 * 1.1
WHERE 고객.고객번호 IN (주문고객.고객번호);

SELECT *
FROM 고객
WHERE 고객번호 IN (SELECT DISTINCT 고객번호
				FROM 주문
                );
                
SELECT *
FROM 마일리지등급;

UPDATE 고객
INNER JOIN 마일리지등급
ON 마일리지 BETWEEN 하한마일리지 AND 상한마일리지
SET 마일리지 = 마일리지 + 1000
WHERE 등급명 = 'S';


UPDATE 고객, 마일리지등급
SET 마일리지 = 마일리지 + 1000
WHERE 마일리지 BETWEEN 하한마일리지 AND 상한마일리지
AND 등급명 = 'S';

SELECT 고객번호, 고객회사명, 마일리지
FROM 고객
INNER JOIN 마일리지등급
ON 마일리지 BETWEEN 하한마일리지 AND 상한마일리지
WHERE 등급명 = 'S';


DELETE FROM 주문
WHERE 주문번호 NOT IN (
				SELECT DISTINCT 주문번호
                FROM 주문세부
                );
                

SELECT *
FROM 주문
WHERE 주문번호 = 'H0248';

SELECT *
FROM 주문세부
WHERE 주문번호 = 'H0248';

DELETE 주문, 주문세부
FROM 주문
INNER JOIN 주문세부
ON 주문.주문번호 = 주문세부.주문번호
WHERE 주문.주문번호 = 'H0248';

DELETE 주문, 주문세부
FROM 주문, 주문세부
WHERE 주문.주문번호 = 주문세부.주문번호
AND 주문.주문번호 = 'H0248';

SELECT 고객.*
FROM 고객
LEFT OUTER JOIN 주문
ON 고객.고객번호 = 주문.주문번호
WHERE 주문.고객번호 IS NULL;

DELETE 고객
FROM 고객
LEFT JOIN 주문
ON 고객.고객번호 = 주문.고객번호
WHERE 주문.고객번호 IS NULL;

SELECT *
FROM 고객
WHERE 고객번호 IN ('BQQZA', 'RISPA', 'SSAFI', 'TIRAN');


-- 제약조건: 무결성
-- PRIMARY KEY = NOT NULL+ UNIQUE
-- CHECK, DEFAULT, FOREIGN KEY

