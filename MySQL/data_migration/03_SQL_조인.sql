-- 조인의 종류
-- 크로스조인 (카테지안프로덕트) n*m 건의 결과셋
-- 이너조인(내부조인, 이퀴조인, 동등조인) <=
-- 외부조인(left, right, full other) n
-- 셀프조인(1개의 테이블*2번 조인)

-- ansi
SELECT *
FROM A
JOIN B

-- non-ansi
SELECT *
FROM A,B;

-- 크로스조인 ansi
SELECT *
FROM 부서
CROSS JOIN 사원
WHERE 이름 ='이소미';


-- 크로스조인 non-ansi
SELECT *
FROM 부서, 사원;

-- 고객, 제품 크로스조인
SELECT *
FROM 고객, 제품;