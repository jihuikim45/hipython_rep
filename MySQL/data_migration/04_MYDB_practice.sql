USE my_db;

-- 사원들의 소속 부서 종류만 조회
SELECT ENAME, DNAME
FROM emp, dept;


-- 급여가 2000이상 3000이하를 받는 사원 정보(부서번호, 이름, 직무, 급여)만 조회 , 결과집합 생성
SELECT DEPTNO, ENAME, JOB, SAL
FROM emp
WHERE SAL BETWEEN 2000 AND 3000;


-- 사원번호가 7902, 7788, 7566인  사원 정보(사원번호,부서번호, 이름, 직무 )만 조회
SELECT EMPNO, DEPTNO, ENAME, JOB
FROM emp
WHERE EMPNO IN ('7902', '7788','7566');

-- 사원 이름이 ‘A’로 시작하는  사원이름, 급여, 업무
SELECT ENAME, SAL, JOB
FROM emp
WHERE ENAME LIKE 'A%';

-- 사원 이름의 두번째 문자가 ‘A’인  모든 사원이름, 급여, 업무
SELECT ENAME, SAL, JOB
FROM emp
WHERE ENAME LIKE '_A%';

-- 사원 이름이 마지막 문자가 ‘N’인  사원이름, 급여, 업무 조회
SELECT ENAME, SAL, JOB
FROM emp
WHERE ENAME LIKE '%N';


-- 커미션을 받지 않는 사원이름, 급여, 업무, 커미션을  조회
SELECT ENAME, SAL, JOB, COMM
FROM emp
WHERE COMM IS NULL;

-- 커미션이 NULL인 경우 0으로 SAL+COMM = TOTAL_SALARY 계산
SELECT ENAME, SAL, JOB, COMM
,SAL + IFNULL (COMM, 0) AS TOTAL_SALARY
FROM emp;


-- 커미션을 받는 사원들의 커미션 평균
SELECT AVG(COMM) AS 평균커미션
FROM emp
WHERE COMM IS NOT NULL;

 

-- DEPTNO, JOB 별 급여합계, 급여평균, 총합계
SELECT DEPTNO, JOB
, SUM(SAL) AS 급여합계
, AVG(SAL) AS 급여평균
FROM emp
GROUP BY DEPTNO, JOB WITH ROLLUP;

-- 외에 연습문제 출제해서 풀기

-- 문제 설명

-- 쿼리

-- 2문제 구성

-- 1. 부서별 총 급여가 8000 이상인 부서만 급여 높은 순으로 조회하기
SELECT dept.DNAME
       ,SUM(emp.SAL) AS 부서별총급여
FROM emp, dept
WHERE emp.DEPTNO = dept.DEPTNO
GROUP BY dept.DNAME
HAVING SUM(emp.SAL) >= 8000
ORDER BY 부서별총급여 DESC;



-- 2.  부서별, 직무별 사원 수와 평균 급여, 평균 커미션 구하기 
SELECT dept.DNAME
	,emp.JOB
    , COUNT(*) AS 사원수
    ,AVG(IFNULL(emp.COMM, 0)) AS 평균커미션
FROM emp
JOIN dept ON emp.DEPTNO = dept.DEPTNO
GROUP BY dept.DNAME, emp.JOB
ORDER BY dept.DNAME, emp.JOB;

    


