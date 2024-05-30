-- 모든 직원 정보 조회
SELECT * FROM employee;

-- 모든 부서 정보 조회
SELECT * FROM department;

-- 모든 직업 정보 조회
SELECT * FROM job;

-- EMPLOYEE 테이블에서 이름 입사일 조회
SELECT EMP_NAME, hire_date from employee;

/*
컬럼값 산술 연산
-- 컬럼값 : 행과 열이 교차되는 테이블 한 칸에 작성된 값

-- SELECT 문 작성 시 컬럼명에 산술 연산을 직접 작성하면
    조회결과(RESULT SET)에 연산 결과가 반영되어 조회된다.
*/

-- EMPLOYEE 테이블에서 모든 사원의 이름, 급여, 급여 + 100만 조회
-- 급여 우리회사 직원들의 급여를 1000만원씩 + 하면 어떻게 될 것인가?
SELECT EMP_NAME, SALARY, SALARY + 1000000 FROM employee;

-- 급여 +100에 AS 사용해서 100만원인상 추가
-- AS의 경우 큰 따옴표를 사용해서 표기
SELECT EMP_NAME, SALARY, SALARY + 1000000 AS "급여_100만원_인상" FROM employee;

-- EMPLOYEE 테이블에서 모든 사원의 사번, 이름, 연봉(급여*12) 조회
SELECT EMP_ID, EMP_NAME, SALARY * 12 AS "연봉" FROM employee;

-- EMPLOYEE 테이블에서 모든 사원의 사번, 이름, 상반기급여 조회
SELECT EMP_ID, EMP_NAME, SALARY * 6 AS "상반기급여" FROM employee;

-- 특정 부서에서 속한 사원의 이름과 이메일 조회
-- 특정 부서 D9
SELECT DEPT_CODE, EMP_NAME, EMAIL FROM EMPLOYEE WHERE DEPT_CODE = 'D9';

-- 특정 부서 D1에서 속한 사원의 이름과 이메일 조회
SELECT EMP_NAME, EMAIL FROM employee WHERE DEPT_CODE = 'D1';

-- 특정 부서 D4에서 속한 사원의 이름과 전화번호 이메일 조회
SELECT EMP_NAME, PHONE, EMAIL FROM EMPLOYEE WHERE dept_code = 'D4';
-- WHERE에서 조회한 조건에 부합하는 사람이 없으면 값이 나오지 않음
-- IS NULL 을 사용하면 없는 사람을 조회할 수 있음

SELECT DEPT_CODE, EMP_NAME, EMAIL, PHONE FROM employee WHERE DEPT_CODE IS NULL;

-- DEPT_CODE가 모두 IS NULL 인 사람의 모든 정보를 조회
SELECT * FROM employee WHERE DEPT_CODE IS NULL;
