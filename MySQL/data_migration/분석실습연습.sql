USE 분석실습;
SELECT * FROM 분석실습.sales;

CREATE OR REPLACE VIEW view_sales_summary AS
SELECT
	Country,
    StockCode,
    SUM(Quantity) AS total_quantity,
    SUM(Quantity*UnitPrice) AS total_sales
FROM sales
GROUP BY Country, StockCode;

-- 뷰조회
SELECT * 
FROM view_sales_summary
WHERE Country = 'United kingdom'; 

SHOW FULL TABLES IN my_db WHERE TABLE_TYPE='VIEW';
SHOW CREATE VIEW view_sales_summary;

SHOW INDEX FROM sales;

-- 고객 ID, 인보이스 날짜 기준으로 자주 조회시 성능 향상
CREATE INDEX idx_customer_date ON sales (CustomerID, InvoiceDate);

EXPLAIN ANALYZE
SELECT * FROM sales
WHERE CustomerID LIKE '%17850' AND InvoiceDate >= '2010-12-01';

ALTER TABLE SALES DROP INDEX idx_customer_date;

SELECT * 
FROM sales WHERE StockCode=''


CREATE TABLE 날씨
(
	년도 INT
    ,월 INT
    ,일 INT
    ,도시 VARCHAR(20)
    ,기온 NUMERIC(3,1)
    ,습도 INT
    ,PRIMARY KEY(년도, 월, 일, 도시)
    ,INDEX 기온인덱스(기온)
    ,INDEX 도시인덱스(도시)
    );

-- 인덱스 탈 때
-- WHERE 조건절에 인덱스 컬럼이 사용될 때
-- 범위가 너무 넓지 않아 인덱스가 효율적일 때
-- ORDER BY, GROUP BY 컬럼이 인덱스에 포함될 때
-- JOIN 시 ON 절에 인덱스가 사용될 때

-- 1. WHERE 년도=2023 AND 월=6 ; ⭕
-- 2. WHERE년도=2023 OR 월=6; ❌
-- 3. WHERE 년도=2023AND 일>1; ⭕
-- 4. WHERE 기온 BETWEEN 10 AND 20 ⭕
-- 5. WHERE 월=6 AND 일>1 ⭕
-- 6. WHERE 기온>=10 AND 습도>=20 기온만⭕
-- 7. WHERE 기온>=10 OR 습도>=20 ❌
-- 8. WHERE 도시='서울' ⭕
-- 9. WHERE 도시 LIKE '서울%'    ⭕
-- 10. WHERE 도시 LIKE '%서울%' ❌
-- 11. WHERE 년도= 2023 AND 월 = 6 AND 일 > 1 AND 도시='서울';   ⭕   
-- 12. WHERE 년도= 2023 AND 월 = 6 AND 일 > 1 AND 도시 LIKE '서울%';  ⭕
