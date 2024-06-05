-- 1. 전지연 사원이 속해있는 부서원들을 조회하시오 (단, 전지연은 제외)
-- 사번, 사원명, 전화번호, 고용일, 부서명
SELECT EMP_ID AS "사번", EMP_NAME AS "사원명", PHONE AS "전화번호", HIRE_DATE AS "고용일", DEPT_TITLE AS "부서명"
FROM EMPLOYEE E, DEPARTMENT D
WHERE e.dept_code = d.dept_id 
AND E.DEPT_CODE = (SELECT E.DEPT_CODE FROM employee E WHERE E.emp_name = '전지연')
AND E.EMP_NAME != '전지연';

-- 2. 고용일이 2000년도 이후인 사원들 중 급여가 가장 높은 사원의
-- 사번, 사원명, 전화번호, 급여, 직급명을 조회하시오.
SELECT EMP_ID AS "사번", EMP_NAME AS "사원명", PHONE AS "전화번호", SALARY AS "급여", JOB_NAME AS "직급명"
FROM EMPLOYEE E, JOB J
WHERE E.JOB_CODE = J.JOB_CODE
AND SALARY = (SELECT MAX(SALARY) FROM EMPLOYEE WHERE HIRE_DATE >= TO_DATE('2000', 'YYYY'));

-- 3. 노옹철 사원과 같은 부서, 같은 직급인 사원을 조회하시오. (단, 노옹철 사원은 제외)
-- 사번, 이름, 부서코드, 직급코드, 부서명, 직급명
SELECT E.EMP_ID, E.EMP_NAME, E.DEPT_CODE, E.JOB_CODE, D.DEPT_TITLE, J.JOB_NAME
FROM EMPLOYEE E, DEPARTMENT D, JOB J
WHERE e.dept_code = d.dept_id
AND e.job_code = J.JOB_CODE
AND e.dept_code = (SELECT DEPT_CODE FROM EMPLOYEE WHERE EMP_NAME = '노옹철')
AND e.JOB_code = (SELECT JOB_CODE FROM EMPLOYEE WHERE EMP_NAME = '노옹철')
AND EMP_NAME != '노옹철';


-- 4. 2000년도에 입사한 사원과 부서와 직급이 같은 사원을 조회하시오
-- 사번, 이름, 부서코드, 직급코드, 고용일
SELECT EMP_ID, EMP_NAME, DEPT_CODE, JOB_CODE, HIRE_DATE
FROM EMPLOYEE
WHERE DEPT_CODE =(SELECT DEPT_CODE FROM EMPLOYEE 
WHERE hire_date BETWEEN TO_DATE('2000-01-01', 'YYYY-MM-DD') AND TO_DATE('2000-12-31', 'YYYY-MM-DD'))
AND JOB_CODE = (SELECT JOB_CODE FROM EMPLOYEE 
WHERE hire_date BETWEEN TO_DATE('2000-01-01', 'YYYY-MM-DD') AND TO_DATE('2000-12-31', 'YYYY-MM-DD'));

-- 5. 77년생 여자 사원과 동일한 부서이면서 동일한 사수를 가지고 있는 사원을 조회하시오
-- 사번, 이름, 부서코드, 사수번호, 주민번호, 고용일
SELECT EMP_ID, EMP_NAME, DEPT_CODE, MANAGER_ID, EMP_NO, HIRE_DATE
FROM EMPLOYEE
WHERE MANAGER_ID = (SELECT MANAGER_ID FROM EMPLOYEE WHERE SUBSTR(EMP_NO,1,2) = '77' AND SUBSTR(EMP_NO, 8,1) = '2')
AND DEPT_CODE = (SELECT DEPT_CODE FROM EMPLOYEE WHERE SUBSTR(EMP_NO,1,2) = '77' AND SUBSTR(EMP_NO, 8,1) = '2');


-- 6. 부서별 입사일이 가장 빠른 사원의
-- 사번, 이름, 부서명(NULL이면 '소속없음'), 직급명, 입사일을 조회하고
-- 입사일이 빠른 순으로 조회하시오
-- 단, 퇴사한 직원은 제외하고 조회..
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME, HIRE_DATE
FROM EMPLOYEE E, DEPARTMENT D, JOB J
WHERE E.DEPT_CODE = D.DEPT_ID
AND E.JOB_CODE = J.JOB_CODE
AND ENT_YN = 'N'

ORDER BY HIRE_DATE;



-- 7. 직급별 나이가 가장 어린 직원의
-- 사번, 이름, 직급명, 나이, 보너스 포함 연봉을 조회하고
-- 나이순으로 내림차순 정렬하세요
-- 단 연봉은 \124,800,000 으로 출력되게 하세요. (\ : 원 단위 기호)
SELECT EMP_ID, EMP_NAME, JOB_NAME
FROM EMPLOYEE E, JOB J
WHERE e.job_code = J.JOB_CODE
AND EMP_NAME = (SELECT EMP_NAME FROM EMPLOYEE E1, EMPLOYEE E2 WHERE e1.job_code = E2.JOB_CODE AND E1.)