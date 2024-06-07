-- 1. 주민번호가 70년대 생이면서 성별이 여자이고, 성이 ‘전’씨인 직원들의
-- 사원명, 주민번호, 부서명, 직급명을 조회하시오.
select emp_name, emp_no, DEPT_TITLE, JOB_NAME
FROM EMPLOYEE E, DEPARTMENT D, JOB J
WHERE E.DEPT_CODE = d.dept_id AND e.job_code = J.JOB_CODE 
AND SUBSTR(EMP_NO,1, 2) BETWEEN 70 AND 79
AND SUBSTR(EMP_NO,8, 1) = '2'
AND emp_name LIKE '전%';

SELECT E.EMP_NAME, E.EMP_NO, D.DEPT_TITLE, J.JOB_NAME
FROM employee E
JOIN department D ON (E.DEPT_CODE = d.dept_id)
JOIN JOB J ON (J.JOB_CODE = E.JOB_CODE)
WHERE E.emp_name LIKE '전%'
AND E.EMP_NO LIKE '7%'
AND SUBSTR(EMP_NO,8, 1) IN('2', '4');

-- 2. 이름에 '형'자가 들어가는 직원들의 사번, 사원명, 직급명을 조회하시오.
SELECT EMP_ID, EMP_NAME, JOB_NAME
FROM EMPLOYEE E, JOB J
WHERE e.job_code = J.JOB_CODE
AND emp_name LIKE '%형%';

SELECT E.EMP_ID, E.EMP_NAME, J.JOB_NAME
FROM EMPLOYEE E
JOIN JOB J ON(E.JOB_CODE = J.JOB_CODE)
WHERE E.EMP_NAME LIKE '%형%';


-- 3. 해외영업 1부, 2부에 근무하는 사원의
-- 사원명, 직급명, 부서코드, 부서명을 조회하시오.
SELECT EMP_NAME, JOB_NAME, DEPT_ID, DEPT_TITLE
FROM EMPLOYEE E, JOB J, DEPARTMENT D
WHERE e.job_code = J.JOB_CODE 
AND e.dept_code = d.dept_id
AND D.DEPT_TITLE IN ('해외영업1부','해외영업2부');

SELECT E.EMP_NAME, J.JOB_NAME, D.DEPT_ID, D.DEPT_TITLE
FROM EMPLOYEE E
JOIN department D ON (d.dept_id = e.dept_code)
JOIN JOB J ON (J.JOB_CODE = e.job_code)
WHERE D.DEPT_TITLE IN ('해외영업1부','해외영업2부');


--4. 보너스포인트를 받는 직원들의 사원명, 보너스포인트, 부서명, 근무지역명을 조회하시오.
SELECT EMP_NAME, BONUS, DEPT_TITLE, LOCAL_NAME
FROM EMPLOYEE E, DEPARTMENT D, LOCATION L
WHERE e.dept_code = d.dept_ID 
AND d.location_id = L.LOCAL_CODE
AND E.BONUS IS NOT NULL;

SELECT EMP_NAME, BONUS, DEPT_TITLE, LOCAL_NAME
FROM EMPLOYEE E
JOIN department D ON (d.dept_id = e.dept_code)
JOIN LOCATION L ON (d.location_id = l.local_code) 
WHERE BONUS IS NOT NULL;


--5. 부서가 있는 사원의 사원명, 직급명, 부서명, 지역명 조회
SELECT EMP_NAME, JOB_NAME, DEPT_TITLE, LOCAL_NAME
FROM EMPLOYEE E, JOB J, DEPARTMENT D, LOCATION L
WHERE e.job_code = J.JOB_CODE
AND d.location_id = l.local_code
AND e.dept_code = d.dept_id
AND E.DEPT_CODE IS NOT NULL;

SELECT EMP_NAME, JOB_NAME, DEPT_TITLE, LOCAL_NAME
FROM EMPLOYEE E
JOIN JOB J ON (J.JOB_CODE = E.JOB_CODE)
JOIN department D ON (d.dept_id = e.dept_code)
JOIN LOCATION L ON (d.location_id = l.local_code)
WHERE E.DEPT_CODE IS NOT NULL;

-- 6. 급여등급별 최소급여(MIN_SAL)보다 많이 받는 직원들의 ----------------------------------------------
--사원명, 직급명, 급여, 연봉(보너스포함)을 조회하시오.
--연봉에 보너스포인트를 적용하시오. 
SELECT EMP_NAME, JOB_NAME, E.SALARY, (E.SALARY*12) + (E.SALARY*12*NVL(BONUS, 0)) AS "연봉(보너스포함)"
FROM EMPLOYEE E, JOB J, SAL_GRADE S
WHERE E.JOB_CODE = J.JOB_CODE
AND E.SAL_LEVEL = S.SAL_LEVEL
AND S.MIN_SAL < E.SALARY;


-- 7.한국(KO)과 일본(JP)에 근무하는 직원들의
-- 사원명, 부서명, 지역명, 국가명을 조회하시오.
SELECT EMP_NAME AS "사원명", DEPT_TITLE AS "부서명", LOCAL_NAME AS "지역명", N.NATIONAL_NAME AS "국가명"
FROM EMPLOYEE E, DEPARTMENT D, LOCATION L, NATIONAL N
WHERE e.dept_code = d.dept_id
AND d.location_id = l.local_code
AND l.national_code = n.national_code
AND N.NATIONAL_CODE IN ('KO', 'JP');

SELECT EMP_NAME, DEPT_TITLE, LOCAL_NAME, NATIONAL_NAME
FROM EMPLOYEE E
JOIN department D ON(E.DEPT_CODE = d.dept_id)
JOIN location L ON (l.local_code = d.location_id)
JOIN NATIONAL N ON (n.national_code = l.national_code)
WHERE N.NATIONAL_CODE IN ('KO', 'JP');

-- 8. 같은 부서에 근무하는 직원들의 사원명, 부서코드, 동료이름을 조회하시오.
-- SELF JOIN 사용

SELECT E1.EMP_NAME AS "사원명", E1.DEPT_CODE AS "부서코드", E2.EMP_NAME AS "동료이름"
FROM employee E1, employee E2
WHERE E1.dept_code = E2.dept_code AND E1.EMP_NAME != E2.EMP_NAME
ORDER BY E1.EMP_NAME, E1.DEPT_CODE;



-- 9. 보너스포인트가 없는 직원들 중에서 직급코드가 J4 와 J7 인 직원들의 사원명, 직급명, 급여를 조회하시오.
-- 단, JOIN, IN 사용할 것
SELECT EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE E
JOIN JOB J ON E.JOB_CODE = J.JOB_CODE
WHERE E.JOB_CODE IN('J4', 'J7')
AND BONUS IS NULL;
