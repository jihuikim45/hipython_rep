USE WNTRADE;

INSERT INTO VIEW_사원_여 (이름, 입사일, 주소, 성별)
VALUES ('황여름', '2023-02-10', '서울시 강남구 청담동 23-5', '여');

CREATE OR REPLACE VIEW view_사원_여
AS
SELECT 사원번호
	,이름
    ,집전화 AS 전화번호
    ,입사일
    ,주소
    ,성별
FROM 사원
WHERE 성별='여';

INSERT INTO VIEW_사원_여 (사원번호, 이름, 전화번호, 입사일, 주소, 성별)
VALUES ('E12', '황여름','(02)587-4989', '2023-02-10', '서울시 강남구 청담동 23-5', '여');

SELECT *
FROM view_사원_여
WHERE 사원번호 = 'E12';


SELECT *
FROM 사원
WHERE 사원번호 = 'E12';


INSERT INTO view_사원_여(사원번호, 이름, 입사일, 주소, 성별)
VALUES('E13','강겨울','2023-02-10','서울시 성북구 장위동 123-7','남');


SELECT *
FROM view_사원_여
WHERE 사원번호 = 'E13';

SELECT *
FROM 사원
WHERE 사원번호 = 'E13';

CREATE OR REPLACE VIEW view_사원_여
AS
SELECT 사원번호
	,이름
    ,집전화 AS 전화번호
    ,입사일
    ,주소
    ,성별
FROM 사원
WHERE 성별='여'
WITH CHECK OPTION;