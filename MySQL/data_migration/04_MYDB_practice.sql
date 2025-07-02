USE my_db;

-- 사원들의 소속 부서 종류만 조회
SELECT  ENAME, DNAME
FROM emp, dept;

-- 급여가 2000이상 3000이하를 받는 사원 정보(부서번호, 이름, 직무, 급여)만 조회 , 결과집합 생성
SELECT emp.DEPTNO,
       emp.ENAME,
       emp.JOB,
       emp.SAL
FROM emp, dept
WHERE emp.DEPTNO = dept.DEPTNO
  AND emp.SAL BETWEEN 2000 AND 3000;


-- 사원번호가 7902, 7788, 7566인  사원 정보(사원번호,부서번호, 이름, 직무 )만 조회
SELECT emp.EMPNO, emp.DEPTNO, emp.ENAME, emp.JOB
FROM emp, dept
WHERE emp.DEPTNO = dept.DEPTNO
AND emp.EMPNO IN (7902, 7788, 7566);

-- 사원 이름이 ‘A’로 시작하는  사원이름, 급여, 업무


-- 사원 이름의 두번째 문자가 ‘A’인  모든 사원이름, 급여, 업무
-- 사원 이름이 마지막 문자가 ‘N’인  사원이름, 급여, 업무 조회
-- 커미션을 받지 않는 사원이름, 급여, 업무, 커미션을  조회
-- 커미션이 NULL인 경우 0으로 SAL+COMM = TOTAL_SALARY 계산
-- 커미션을 받는 사원들의 커미션 평균
-- DEPTNO, JOB 별 급여합계, 급여평균, 총합계


-- 외에 연습문제 출제해서 풀기
