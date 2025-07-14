-- 기간별 매출 현황
SELECT invoicedate
,SUM(unitprice*quantity) AS 매출액
,SUM(quantity) AS 주문수량
,COUNT(DISTINCT invoiceno) AS 주문건수
,COUNT(DISTINCT customerid) AS 주문고객수
FROM sales
GROUP BY invoicedate
ORDER BY invoicedate;


-- 국가별 매출 현황
SELECT country
,SUM(unitprice*quantity) AS 매출액
,SUM(quantity) AS 주문수량
,COUNT(DISTINCT invoiceno) AS 주문건수
,COUNT(DISTINCT customerid) AS 주문고객수
FROM sales
GROUP BY country;

-- 국가별 x 제품별 매출 현황
SELECT country
,stockcode
,SUM(unitprice*quantity) AS 매출액
,SUM(quantity) AS 주문수량
,COUNT(DISTINCT invoiceno) AS 주문건수
,COUNT(DISTINCT customerid) AS 주문고객수
FROM sales
GROUP BY country, stockcode;

-- 특정 제품의 매출 지표(매출액, 주문 수량)파악
SELECT SUM(unitprice*quantity) AS 매출액
,SUM(quantity) AS 주문수량
,COUNT(DISTINCT invoiceno) AS 주문건수
,COUNT(DISTINCT customerid) AS 주문고객수
FROM sales
WHERE stockcode = '21615';

-- 특정 제품의 기간별 매출 현황
SELECT DATE(invoicedate) AS 날짜
,SUM(unitprice*quantity) AS 매출액
,SUM(quantity) AS 주문수량
,COUNT(DISTINCT invoiceno) AS 주문건수
,COUNT(DISTINCT customerid) AS 주문고객수
FROM sales
WHERE stockcode IN('21615','21731')
GROUP BY DATE(invoicedate)
ORDER BY 날짜;

-- 이벤트 효과 분석(시기에 대한 비교)
SELECT CASE WHEN invoicedate BETWEEN '2011-09-10' AND '2011-09-25' THEN '이벤트 기간'
	WHEN invoicedate BETWEEN '2011-08-10' AND '2011-08-25' THEN '이벤트 비교기간(전월동기간)' END AS 기간구분
    ,SUM(unitprice*quantity) AS 매출액
    ,SUM(quantity) AS 주문수량
    ,COUNT(DISTINCT invoiceno) AS 주문건수
    ,COUNT(DISTINCT customerid) AS 주문고객수
    FROM sales
    WHERE invoicedate BETWEEN '2011-09-10' AND '2011-09-25'
    OR invoicedate BETWEEN '2011-08-10' AND '2011-08-25'
    GROUP BY CASE WHEN invoicedate BETWEEN '2011-09-10' AND '2011-09-25' THEN '이벤트 기간'
    WHEN invoicedate BETWEEN '2011-08-10' AND '2011-08-25' THEN '이벤트 비교기간(전월동기간)' END;
    
    -- 이벤트 제품 효과 분석(시기에 대한 비교)
SELECT CASE WHEN invoicedate BETWEEN '2011-09-10' AND '2011-09-25' THEN '이벤트 기간'
WHEN invoicedate BETWEEN '2011-08-10' AND '2011-08-25' THEN '이벤트 비교기간(전월동기간)' END AS 기간구분
,SUM(unitprice*quantity) AS 매출액
,SUM(quantity) AS 주문수량
,COUNT(DISTINCT invoiceno) AS 주문건수
,COUNT(DISTINCT customerid) AS 주문고객수
FROM sales
WHERE (invoicedate BETWEEN '2011-09-10' AND '2011-09-25'
OR invoicedate BETWEEN '2011-08-10' AND '2011-08-25')
AND stockcode IN ('17012A', '17012C', '17021', '17084N')
GROUP BY CASE WHEN invoicedate BETWEEN '2011-09-10' AND '2011-09-25' THEN '이벤트 기간'
WHEN invoicedate BETWEEN '2011-08-10' AND '2011-08-25' THEN '이벤트 비교기간(전월동기간)' END;

-- 특정 제품 구매 고객 정보
SELECT s.customerid
	,C.customer_name
	,C.gd
	,C.birth_dt
	,C.entr_dt
	,C.grade
	,C.sign_up_ch
FROM (
	SELECT DISTINCT customerid
	FROM sales
    WHERE stockcode IN ('21730','21615')
    AND invoicedate BETWEEN '2010-12-01' AND '2010-12-10'
    )s
LEFT
JOIN (
	SELECT mem_no
		,CONCAT(last_name,first_name) AS customer_name
        ,gd
        ,birth_dt
        ,entr_dt
        ,grade
        ,sign_up_ch
	FROM customer
    )c
ON S.customerid = C.mem_no;

-- 미구매 고객 정보 step1: SALES 테이블과 CUSTOMER 테이블을 결하하고 미구매 고객을 구분하는 쿼리를 CASE문을 사용해 작성하기
SELECT CASE WHEN s.CustomerID IS NULL THEN c.mem_no END AS non_purchaser
	,c.mem_no
    ,c.last_name
    ,c.first_name
    ,s.InvoiceNo
    ,s.StockCode
    ,s.Quantity
    ,s.InvoiceDate
    ,s.UnitPrice
    ,s.CustomerID
FROM customer c
LEFT JOIN sales s
ON c.mem_no = s.CustomerID;

-- step2 : 전체 고객수와 미구매 고객수를 계산하기
SELECT COUNT(DISTINCT CASE WHEN s.CustomerID IS NULL THEN c.mem_no END) AS non_purchaser
	,COUNT(DISTINCT c.mem_no) AS total_customer
FROM customer c
LEFT JOIN sales s
ON c.mem_no = s.CustomerID;

-- 매출 평균 지표 ATV, AMV, Avg, Frq, Avg.Units
SELECT SUM(unitprice*quantity) AS 매출액
	,SUM(quantity) AS 주문수량
    ,COUNT(DISTINCT invoiceno) AS 주문건수
    ,COUNT(DISTINCT customerid) AS 주문고객수
    
    ,SUM(unitprice*quantity)/COUNT(DISTINCT invoiceno) AS ATV
    ,SUM(unitprice*quantity)/COUNT(DISTINCT customerid) AS AMV
    ,COUNT(DISTINCT invoiceno)*1.00/COUNT(DISTINCT customerid)*1.00 AS AvgFrq
    ,SUM(quantity)*1.00/COUNT(DISTINCT invoiceno)*1.00 AS AvgUnits
FROM sales;

-- 연도 및 월별로 평균 매출 지표 산출
SELECT YEAR(invoicedate) AS 연도
	,MONTH(invoicedate) AS 월
    ,SUM(unitprice*quantity) AS 매출액
    ,COUNT(DISTINCT invoiceno) AS 주문건수
    ,COUNT(DISTINCT customerid) AS 주문고객수
    
    ,SUM(unitprice*quantity)/COUNT(DISTINCT invoiceno) AS ATV
    ,SUM(unitprice*quantity)/COUNT(DISTINCT customerid) AS AMV
    ,COUNT(DISTINCT invoiceno)*1.00/COUNT(DISTINCT customerid)*1.00 AS AvgFrq
    ,SUM(quantity)*1.00/COUNT(DISTINCT invoiceno)*1.00 AS AvgUnits
    FROM sales
    GROUP BY YEAR(invoicedate), MONTH(invoicedate)
    ORDER BY 1,2;


-- 2011년에 가장 많이 판매된 제품 1위~10위
SELECT stockcode
    ,description
    ,SUM(quantity) AS qty
FROM sales
WHERE YEAR(invoicedate) = '2011'
GROUP BY stockcode, description
ORDER BY qty DESC
LIMIT 10;

-- 국가별로 가장 많이 판매된 수
SELECT ROW_NUMBER() OVER (PARTITION BY country ORDER BY qty DESC) AS rnk
	,country
	,stockcode
	,description
	,qty
FROM (
	SELECT country
		,stockcode
        ,description
        ,SUM(quantity) AS qty
	FROM sales
	GROUP BY country
			,stockcode
			,description
	) a
ORDER BY 2,1;

-- 20대 여성 고객의 베스트 셀링 상품
SELECT *
FROM (
	SELECT ROW_NUMBER() OVER (ORDER BY qty DESC) AS rnk
			,stockcode
            ,description
            ,qty
	FROM (
		SELECT stockcode
			,description
            ,SUM(quantity) AS qty
		FROM sales s
        LEFT JOIN customer c
        ON s.customerid = c.mem_no
        WHERE c.gd = 'F'
        AND 2023-YEAR(c.birth_dt) BETWEEN '20' AND '29'
        GROUP BY stockcode, description 
        )a
	)aa
WHERE rnk <= 10;

-- 특정 제품과 함께 가장 많이 구매한 제품 확인
-- STEP 1
SELECT DISTINCT invoiceno
FROM sales
WHERE stockcode = '20725';

-- step2
SELECT *
FROM sales s
INNER
JOIN (
		SELECT DISTINCT invoiceno
        FROM sales
        WHERE stockcode = '20725'
        ) i
ON s.invoiceno = i.invoiceno
WHERE s.stockcode <> '20725';

-- step3
SELECT s.stockcode
	,s.description
    ,SUM(quantity) AS qty
FROM sales s
INNER JOIN (
			SELECT DISTINCT invoiceno
            FROM sales
			WHERE stockcode = '20725'
			)i
ON s.invoiceno = i.invoiceno
WHERE s.stockcode <> '20725'
GROUP BY s.stockcode, s.description
ORDER BY qty DESC
LIMIT 10;

-- 제품명에 LUNCH가 포함된 제품 제외
SELECT s.stockcode
	,s.description
    ,SUM(quantity) AS qty
FROM sales s
INNER JOIN (
			SELECT DISTINCT invoiceno
            FROM sales
			WHERE stockcode = '20725'
			)i
ON s.invoiceno = i.invoiceno
WHERE s.stockcode <> '20725'
AND s.description NOT LIKE '&LUNCH%'
GROUP BY s.stockcode, s.description
ORDER BY qty DESC
LIMIT 10;

-- 고객별로 구매일수를 카운팅하는 방법
SELECT COUNT(DISTINCT customerid) AS repurchaser_count
FROM (
	SELECT customerid, COUNT(DISTINCT invoicedate) AS frq
    FROM sales
	WHERE customerid <> ''
    GROUP BY customerid
	HAVING COUNT(DISTINCT invoicedate) >= 2
    )a;
    
-- 고객별로 구매한 일자에 순서를 매기는 방법
SELECT COUNT(DISTINCT customerid) AS repurchaser_count
FROM (
	SELECT customerid, DENSE_RANK() OVER (PARTITION BY customerid ORDER BY invoicedate) AS rnk
    FROM sales
	WHERE customerid <> ''
    AND stockcode = '21088'
    )a
WHERE rnk = 2;

-- 2010년 구매 이력이 있는 고객 매출 내역
SELECT COUNT(DISTINCT customerid) AS retention_customer_count
FROM sales
WHERE customerid <> ''
AND customerid IN (SELECT customerid
					FROM sales
                    WHERE customerid <> ''
                    AND YEAR(invoicedate) = '2010'
                    )
AND YEAR(invoicedate) = '2011';

-- 고객별로 재구매까지의 구매 기간 확인 방법
-- STEP 1: 고객별로 제품 구매 순서
SELECT customerid
	,invoicedate
    , DENSE_RANK() OVER (PARTITION BY customerid ORDER BY invoicedate) AS day_no
FROM (
	SELECT customerid, invoicedate
    FROM sales
    WHERE customerid <> ''
    GROUP BY customerid, invoicedate
    )a;
    
-- step2: step1에서 확인한 순서를 바탕으로 첫 구매와 재구매 기간 확인
SELECT aa.customerid AS first_pur_customerid
	,aa.invoicedate AS first_pur_invoicedate
    ,aa.day_no AS first_pur_day_no
    ,bb.customerid AS second_pur_customerid
    ,bb.invoicedate AS second_pur_invoicedate
    ,bb.day_no AS second_pur_day_no
FROM (
	SELECT customerid
		,invoicedate
        ,DENSE_RANK() OVER (PARTITION BY customerid ORDER BY invoicedate) AS day_no
	FROM (
		SELECT customerid, invoicedate
        FROM sales
        WHERE customerid <> ''
        GROUP BY customerid, invoicedate
        )a
	)aa
LEFT JOIN (
			SELECT customerid
					,invoicedate
                    ,DENSE_RANK() OVER (PARTITION BY customerid ORDER BY invoicedate) AS day_no
			FROM (
					SELECT customerid, invoicedate
                    FROM sales
					WHERE customerid <> ''
                    GROUP BY customerid, invoicedate
                    )b
			)bb
ON aa.customerid = bb.customerid AND aa.day_no +1 = bb.day_no
WHERE aa.day_no = 1
AND bb.day_no = 2;

-- STEP3: 첫 구매와 재구매 기간의 차이 계산
SELECT aa.customerid AS first_pur_customerid
	,aa.invoicedate AS first_pur_invoicedate
    ,aa.day_no AS first_pur_day_no
    ,bb.customerid AS second_pur_customerid
    ,bb.invoicedate AS second_pur_invoicedate
    ,bb.day_no AS second_pur_day_no
    ,DATEDIFF(aa.invoicedate,bb.invoicedate) AS purchase_period
FROM (
	SELECT customerid
			,invoicedate
            ,DENSE_RANK() OVER (PARTITION BY customerid ORDER BY invoicedate) AS day_no
	FROM (
			SELECT customerid, invoicedate
            FROM sales
			WHERE customerid <> ''
            GROUP BY customerid, invoicedate
            )a
		)aa
LEFT JOIN (
			SELECT customerid
					,invoicedate
                    ,DENSE_RANK() OVER (PARTITION BY customerid ORDER BY invoicedate) AS day_no
			FROM (
					SELECT customerid, invoicedate
                    FROM sales
					WHERE customerid <> ''
                    GROUP BY customerid, invoicedate
                    )b
				)bb
ON aa.customerid = bb.customerid AND aa.day_no+1 = bb.day_no
WHERE aa.day_no = 1
AND bb.day_no = 2;

-- step4: 구매 기간 차이 일수에 대한 평균 지표 구하는 집계 함수 구하기
SELECT avg(purchase_period) AS avg_purchase_period
FROM(
	SELECT aa.customerid AS first_pur_customerid
		,aa.invoicedate AS firtst_pur_invoicedate
        ,aa.day_no AS first_pur_day_no
        ,bb.customerid AS second_pur_customerid
        ,bb.invoicedate AS second_pur_invoicedate
        ,bb.day_no AS second_pur_day_no
        ,DATEDIFF(aa.invoicedate, bb.invoicedate) AS purchase_period
FROM (
	SELECT customerid
		,invoicedate
        ,DENSE_RANK() OVER (PARTITION BY customerid ORDER BY invoicedate) AS day_no
	FROM (
		SELECT customerid, invoicedate
        FROM sales
		WHERE customerid <> ''
        GROUP BY customerid, invoicedate
        )a
	)aa
LEFT JOIN (
		SELECT customerid
			,invoicedate
            ,DENSE_RANK() OVER (PARTITION BY customerid ORDER BY invoicedate) AS day_no
		FROM (
			SELECT customerid, invoicedate
            FROM sales
            WHERE customerid <> ''
            GROUP BY customerid, invoicedate
            )b
		)bb
	ON aa.customerid = bb.customerid AND aa.day_no+1 = bb.day_no
WHERE aa.day_no = 1
AND bb.day_no = 2
)aaa;
        