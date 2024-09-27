-- 1. 부서코드가 노옹철 사원과 같은 소속의 직원 명단 조회하세요.
SELECT
		*
    FROM EMPLOYEE
    WHERE DEPT_CODE = (SELECT
								DEPT_CODE
						   FROM EMPLOYEE
                           WHERE EMP_NAME  LIKE '노옹철');


-- 2. 전 직원의 평균 급여보다 많은 급여를 받고 있는 직원의 사번, 이름, 직급코드, 급여를 조회하세요.
SELECT
							AVG(SALARY)
					   FROM EMPLOYEE;


SELECT 
		EMP_ID,
        EMP_NAME,
        JOB_CODE,
        SALARY
   FROM EMPLOYEE
   WHERE SALARY > (SELECT
							AVG(SALARY)
					   FROM EMPLOYEE);
                       
        

-- 3. 노옹철 사원의 급여보다 많이 받는 직원의 사번, 이름, 부서코드, 직급코드, 급여를 조회하세요.
SELECT
		EMP_ID,
        EMP_NAME,
        DEPT_CODE,
        JOB_CODE,
        SALARY
   FROM EMPLOYEE
   WHERE SALARY > (SELECT
							SALARY
					   FROM EMPLOYEE
                       WHERE SALARY = 3700000);

-- 4. 가장 적은 급여를 받는 직원의 사번, 이름, 부서코드, 직급코드, 급여, 입사일을 조회하세요.
SELECT
		EMP_ID,
        EMP_NAME,
        DEPT_CODE,
        JOB_CODE,
        SALARY,
        HIRE_DATE
   FROM EMPLOYEE
   WHERE SALARY=(SELECT
						MIN(SALARY)
				   FROM EMPLOYEE);
                   

-- *** 서브쿼리는 SELECT, FROM, WHERE, HAVING, ORDER BY절에도 사용할 수 있다.

-- 5. 부서별 최고 급여를 받는 직원의 이름, 직급코드, 부서코드, 급여 조회하세요.
SELECT
		A.EMP_NAME,
        A.JOB_CODE,
        A.DEPT_CODE
   FROM EMPLOYEE AS A
   WHERE A.SALARY = (SELECT
							MAX(SALARY)
					   FROM EMPLOYEE AS E
                       WHERE E.DEPT_CODE =A.DEPT_CODE
                       OR (E.DEPT_CODE IS NULL AND A.DEPT_CODE IS NULL));



-- *** 여기서부터 난이도 극상

-- 6. 관리자에 해당하는 직원에 대한 정보와 관리자가 아닌 직원의 정보를 추출하여 조회하세요.
-- 사번, 이름, 부서명, 직급, '관리자' AS 구분 / '직원' AS 구분
-- HINT!! is not null, union(혹은 then, else), distinct
SELECT 
		DISTINCT A.EMP_ID,
        A.EMP_NAME,
        B.DEPT_TITLE,
        C.JOB_NAME, '관리자' AS 구분
   FROM EMPLOYEE A
   JOIN DEPARTMENT B ON B.DEPT_ID=A.DEPT_CODE
   JOIN JOB C ON C.JOB_CODE = A.JOB_CODE
   WHERE A.MANAGER_ID IS NULL

UNION

SELECT 
		DISTINCT A.EMP_ID,
        A.EMP_NAME,
        B.DEPT_TITLE,
        C.JOB_NAME, '직원' AS 구분
   FROM EMPLOYEE A
   JOIN DEPARTMENT B ON B.DEPT_ID=A.DEPT_CODE
   JOIN JOB C ON C.JOB_CODE = A.JOB_CODE
   WHERE A.MANAGER_ID IS NOT NULL;
        
		
   


-- 7. 자기 직급의 평균 급여를 받고 있는 직원의 사번, 이름, 직급코드, 급여를 조회하세요.
-- 단, 급여와 급여 평균은 만원단위로 계산하세요.
-- HINT!! round(컬럼명, -5)
SELECT
		EMP_ID,
        EMP_NAME,
        JOB_CODE,
        SALARY
FROM EMPLOYEE AS A
WHERE ROUND(SALARY, -5) = (
    SELECT ROUND(AVG(SALARY), -5)
    FROM EMPLOYEE AS E
    WHERE E.JOB_CODE = A.JOB_CODE);

-- 8. 퇴사한 여직원과 같은 부서, 같은 직급에 해당하는 직원의 이름, 직급코드, 부서코드, 입사일을 조회하세요.
SELECT
		A.EMP_NAME,
        A.JOB_CODE,
        A.DEPT_CODE,
        A.HIRE_DATE
   FROM EMPLOYEE A
   WHERE A.DEPT_CODE =(SELECT
								DEPT_CODE
						   FROM EMPLOYEE
                           WHERE EMP_NO LIKE '_______2%' AND ENT_DATE IS NOT NULL);
							
-- 9. 급여 평균 3위 안에 드는 부서의 부서 코드와 부서명, 평균급여를 조회하세요.
-- HINT!! limit

-- 10. 부서별 급여 합계가 전체 급여의 총 합의 20%보다 많은 부서의 부서명과, 부서별 급여 합계를 조회하세요. 
