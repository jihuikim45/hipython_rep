-- 관게형 데이터베이스 관계연산 - 프로젝션, 셀렉션, 조인
-- 수학의 집합 연산

-- 조인의 종류: 1이상의 테이블에서 데이터 모아올 때
-- 크로스조인 (카테지안프로덕트) n*m 건의 결과셋
-- 이너조인(내부조인, 이퀴조인, 동등조인) <=
-- 외부조인(left, right, full outer) n
-- 셀프조인(1개의 테이블*2번 조인)

USE wntrade;

-- ansi
SELECT *
FROM A
JOIN B;

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


-- 내부 조인
-- 가장 일반적인 조인 방식, 두 테이블에서 조건에 만족하는 행만 연결 추출
-- 연결 컬럼을 찾아서 매핑
SELECT 사원번호, 직위, 사원.부서번호, 부서명
FROM 사원
INNER JOIN 부서
ON 사원.부서번호 = 부서.부서번호
WHERE 이름 = '이소미';


-- 주문, 제품 제품명을 연결
SELECT 주문번호, 주문세부.제품번호, 제품.제품명
FROM 주문세부
INNER JOIN 제품
ON 주문세부.제품번호 = 제품.제품번호;


-- 5-3
SELECT 고객.고객번호, 담당자명, 고객회사명, (*) AS 주문건수
FROM 고객
INNER JOIN 주문
ON 고객.고객번호 = 주문.고객번호
GROUP BY 고객.고객번호, 담당자명, 고객회사명
ORDER BY COUNT(*) DESC;


-- 5-4
SELECT 고객.고객번호, 담당자명, 고객회사명, SUM(주문수량*단가) AS 주문금액총합
FROM 고객
INNER JOIN 주문
ON 고객.고객번호 = 주문.고객번호
INNER JOIN 주문세부
ON 주문.주문번호 = 주문세부.주문번호
GROUP BY 고객.고객번호, 담당자명, 고객회사명
ORDER BY 주문금액총합 DESC;

-- 5-5
SELECT 고객번호, 담당자명, 마일리지, 마일리지등급.*
FROM 고객
CROSS JOIN 마일리지등급
ON 마일리지 BETWEEN 하한마일리지 AND 상한마일리지
WHERE 담당자명 = '이은광';


-- 카테지안 프로덕트: 범위성 테이블과 나올 수 있는 모든 조합을 확인
-- 내부조인: 연결(컬럼)된 테이블에서 매핑된 행의 컬럼을 가져올 때
-- 외부조인: 기준 테이블의 결과를 유지하면서 매핑된 컬럼을 갖오려 할 때

-- 외부조인
-- LEFT, RIGHT, 양쪽 다 -> MYSQL은 지원 X



-- 부서, 사원
SELECT 사원번호, 이름, 부서명
FROM 사원
LEFT JOIN 부서
ON 사원.부서번호 = 부서.부서번호;


-- 고객 기준으로 주문번호, 주문금액을 조회
SELECT 고객회사명, 주문.주문번호, SUM(단가 * 주문수량) AS 주문금액
FROM 고객
LEFT JOIN 주문
    ON 고객.고객번호 = 주문.고객번호
LEFT JOIN 주문세부
    ON 주문.주문번호 = 주문세부.주문번호
GROUP BY 고객회사명, 주문.주문번호
ORDER BY 주문금액;



-- 사원이 없는 부서
SELECT 부서.부서명, 부서.부서번호
FROM 부서
LEFT JOIN 사원
ON 부서.부서번호 = 사원.부서번호
WHERE 사원.사원번호 IS NULL;

SELECT 부서명, 사원.*
FROM 부서
LEFT JOIN 사원
ON 부서.부서번호 = 사원.부서번호;

-- 등급이 할당되지 않는 고객
SELECT 고객회사명, 마일리지
FROM 고객
LEFT JOIN 마일리지등급
ON 마일리지 BETWEEN 하한마일리지 AND 상한마일리지
WHERE 마일리지등급.등급명 IS NULL;



SELECT 사원번호, 직위, 사원.부서번호, 부서명
FROM 사원
INNER JOIN 부서
ON 사원.부서번호 = 부서.부서번호
UNION
SELECT 사원번호, 직위, 사원.부서번호, 부서명
FROM 사원
RIGHT JOIN 부서
ON 사원.부서번호 = 부서.부서번호;


-- 셀프내부조인 (동등조인)
SELECT 사원.이름 AS 사원이름, 사원.직위, 상사.이름 AS 상사이름
FROM 사원
INNER JOIN 사원 AS 상사
ON 사원.상사번호 = 상사.사원번호;


-- 외부조인 + 셀프조인 (상사가 업는 직원까지 출력)
SELECT 사원.이름 AS 사원이름, 사원.직위, 상사.이름 AS 상사이름
FROM 사원 AS 상사
RIGHT OUTER JOIN 사원 
ON 사원.상사번호 = 상사.사원번호
ORDER BY 상사.이름;


-- 주문, 고객 FULL OUTER JOIN
SELECT 주문.고객번호, 고객회사명, 담당자명
FROM 주문
LEFT JOIN 고객
ON 고객.고객번호 = 주문.고객번호
UNION
SELECT 주문.고객번호, 고객회사명, 담당자명
FROM 주문
RIGHT JOIN 고객
ON 고객.고객번호 = 주문.고객번호;


-- 입사일이 빠른 선배 - 후배 관계
SELECT 사원.직위 
	,사원.이름 AS 사원이름
	, 사원.입사일 AS 사원입사일
    , 상사.이름 AS 상사이름
    , 상사.입사일 AS 상사입사일
FROM 사원 AS 상사
RIGHT OUTER JOIN 사원 
ON 사원.상사번호 = 상사.사원번호
WHERE 상사.입사일 < 사원.입사일
ORDER BY 사원입사일 DESC;

-- 제품별로 주문수량합, 주문금액 합
SELECT 제품명
	, SUM(주문세부.주문수량) AS 주문수량합
	, SUM(주문세부.단가*주문세부.주문수량) AS 주문금액합
FROM 제품
LEFT OUTER JOIN 주문세부
ON 제품.제품번호 = 주문세부.제품번호
GROUP BY 제품명;


-- 아이스크림 제품의 주문년도, 제품명 별 주문수량 합
SELECT 제품.제품명,
       YEAR(주문.주문일) AS 주문년도,
       SUM(주문세부.주문수량) AS 주문수량합
FROM 제품
LEFT OUTER JOIN 주문세부
    ON 제품.제품번호 = 주문세부.제품번호
LEFT OUTER JOIN 주문
    ON 주문세부.주문번호 = 주문.주문번호
WHERE 제품.제품명 LIKE '%아이스크림%'
GROUP BY 제품.제품명, 주문년도
ORDER BY 주문년도, 제품.제품명;




-- 주문이 한번도 안된 제품도 포함한 제품별로 주문수량합, 주문금액 합
SELECT 제품명
	, IFNULL(SUM(주문세부.주문수량),0) AS 주문수량합
	, IFNULL(SUM(주문세부.단가*주문세부.주문수량),0) AS 주문금액합
FROM 제품
LEFT OUTER JOIN 주문세부
ON 제품.제품번호 = 주문세부.제품번호
LEFT OUTER JOIN 주문
ON 주문.주문번호 = 주문세부.주문번호
GROUP BY 제품명
ORDER BY 주문수량합;

-- 고객 회사 중 마일리지 등급이 'A'인 고객의 정보  (고객번호, 담당자명, 고객회사명, 등급명, 마일리지)
SELECT 고객번호, 담당자명, 고객회사명, 등급명, 마일리지
FROM 고객
LEFT OUTER JOIN 마일리지등급
ON 마일리지 BETWEEN 하한마일리지 AND 상한마일리지
WHERE 등급명 = 'A';

-- MY_DB 조인 연습
-- emp테이블에서 사원들의 이름, 급여와 급여 등급을 출력하는 SQL문 작성
SELECT ENAME, SAL, salgrade.grade
FROM emp
INNER JOIN salgrade;

-- 사원번호, 사원이름, 관리자번호, 관리자이름을 조회
SELECT e.EMPNO AS 사원번호
	, e.ENAME AS 사원이름
    , e.MGR AS 관리자번호
    , IFNULL(m.ENAME, '없음') AS 관리자이름
FROM emp e
LEFT JOIN emp m
ON e.MGR = m.EMPNO
ORDER BY e.EMPNO;

-- 모든 사원에 대해서 사원번호와 이름, 부서번호, 부서이름을 조회
SELECT emp.EMPNO, emp.ENAME, emp.DEPTNO, dept.DNAME
FROM emp
LEFT OUTER JOIN dept
ON emp.DEPTNO = dept.DEPTNO;

-- 모든 부서에 대해서 부서별로 소속 사원들의 정보를 출력
SELECT dept.DNAME, emp.ENAME
FROM dept
LEFT OUTER JOIN emp
ON emp.DEPTNO = dept.DEPTNO;


-- 모든 사원과 모든 부서 정보를 조인 결과로 생성
SELECT emp.EMPNO, emp.ENAME, emp.DEPTNO, dept.DNAME
FROM emp
LEFT OUTER JOIN dept
ON emp.DEPTNO = dept.DEPTNO;

-- 부서에 소속된 사원이 없어도 부서와 소속되지 않은 사원 출력
-- 1) 부서를 기준으로 LEFT JOIN (사원이 없어도 부서 출력)
SELECT emp.EMPNO, emp.ENAME, emp.DEPTNO, dept.DNAME
FROM dept
LEFT OUTER JOIN emp
ON dept.DEPTNO = emp.DEPTNO

UNION

-- 2) 사원을 기준으로 LEFT JOIN (부서에 소속되지 않은 사원 출력)
SELECT emp.EMPNO, emp.ENAME, emp.DEPTNO, dept.DNAME
FROM emp
LEFT OUTER JOIN dept
ON emp.DEPTNO = dept.DEPTNO
WHERE emp.DEPTNO IS NULL;

