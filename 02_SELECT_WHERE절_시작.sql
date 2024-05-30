/*
SELECT WHERE 절
WHERE의 경우 조건을 걸어 선택한 조건에 해당하는 행만 볼 수 있도록 설정
WHERE 원하는컬럼 = 원하는컬럼에서 해당하는 조건;

만약 아무것도 없는 NULL 값을 조히하길 원한다면
WHERE 원하는컬럼 IS NULL;

만약 NULL이 아닌 값만 조회하길 원한다면
WHERE 원하는컬럼 IS NOT NULL;

~이상이거나 ~이하일 때는 >= <= > < 사용(미만, 초과 포함)
WHERE 원하는 컬럼 >= 원하는값;

00과 00 사이를 조회하길 원한다면 BETWEEN 

-- WHERE 절 사용X
ORDER BY
오름차순 ASC
내림차순 DESC

00 AND 00;
예 WHERE BETWEEN 사당 AND 의정부;
*/


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

-- 보너스가 없는 사원의 이름과 보너스를 조회
SELECT EMP_NAME, BONUS FROM employee WHERE bonus IS NULL;

-- 급여 등급이 S5인 사원의 이름과 급여 조회
SELECT EMP_NAME, SALARY FROM employee WHERE sal_level = 'S5';

-- 사원 번호가 210인 사원의 모든 정보 조회
SELECT * FROM employee WHERE emp_ID = '210';

-- 이메일 주소가 null이 아닌 사원의 이름과 이메일 조회
SELECT EMP_NAME, EMAIL FROM employee WHERE email IS NOT NULL;

-- 보너스가 0.2이상인 사원의 이름과 보너스를 조회
SELECT EMP_NAME, BONUS FROM employee WHERE BONUS >= 0.2;

-- 급여가 3000000 에서 4000000 사이인 사원의 이름과 급여 조회
SELECT EMP_NAME, SALARY FROM employee WHERE SALARY BETWEEN 3000000 AND 4000000;

-- 급여가 높은 순서대로 사원의 이름과 급여 조회
SELECT EMP_NAME, SALARY FROM employee ORDER BY SALARY DESC;

-- 사원의 이름을 오름차순으로 정렬
SELECT EMP_NAME FROM employee ORDER BY EMP_NAME ASC;

-- 급여가 3000000 초과하는 사원의 사번 이름 급여 부서코드 조회
SELECT EMP_ID, EMP_NAME, DEPT_CODE FROM employee WHERE salary > 3000000;

-- 연봉이 50000000 이하인 사원의 사번 이름 연봉조회 연봉은 연봉으로 표기
SELECT EMP_ID, EMP_NAME, SALARY*12 AS "연봉" FROM employee WHERE SALARY*12 <= 50000000;

-- 부서코드가 D9가 아닌 사원들의 이름 부서코드 전화번호 조회
SELECT EMP_ID, DEPT_CODE, PHONE FROM employee WHERE dept_code != 'D9';

// 부서코드가 D6 사원중에서 급여가 300만원을 초과하는 사원의 이름 부서코드 급여조회
SELECT EMP_NAME, DEPT_CODE, SALARY FROM employee WHERE DEPT_CODE = 'D6' AND SALARY > 3000000;

// 부서코드가 D6이고 직급코드가 J3인 사원의 이름과 급여
SELECT EMP_NAME, SALARY FROM employee WHERE dept_code = 'D6' AND JOB_CODE = 'J3';

-- 날짜 범위 비교
-- 입사일이 2000-01-01 부터 2000-12-31 사이인 사원의 이름, 입사일 조회
SELECT EMP_NAME, HIRE_DATE AS "입사일" FROM employee WHERE hire_date 
BETWEEN TO_DATE('2000-01-01', 'YYYY-MM-DD') AND TO_DATE('2000-12-31','YYYY-MM-DD');

-- 입사일이 2000년 이후 입사한 사원의 이름과 입사일 조회
SELECT EMP_NAME, HIRE_DATE FROM employee WHERE hire_date BETWEEN TO_DATE('2000','YYYY') AND TO_DATE('9999','YYYY');

-- 특정 전화번호 패턴을 가진 사원의 이름과 전화번호 조회
SELECT emp_name, phone from employee where phone like '010%';

-- 이메일의 아이디의 글자 수가 5글자인 사원의
-- 이름 이메일 조회 5글자@
SELECT EMP_NAME, EMAIL FROM employee WHERE EMAIL LIKE '_____@%';

-- 이메일의 아이디 중 _앞 쪽의 글자수가 3글자인 사원의 사번 이름 이메일 조회
SELECT EMP_NAME, EMAIL FROM employee WHERE EMAIL LIKE '___%';

-- ESCAPE 옵션 : LIKE 의미를 벗어나 단순 문자열로 인식
--> 적용범위 : 특수문자 뒤 한글자
SELECT EMP_NAME, EMAIL FROM employee WHERE EMAIL LIKE '___#_%' ESCAPE '#';
/*
___ 세글자 의미
ESCAPE '#' 구분을 지을 것이다.
___LIKE 사용하는 3글자만 찾으라는 의미로 구분짓는 것
_% -> _로된 글자 찾기

___#_% __@%
_를 @ 처럼 사용하길 원했기 때문에 중간 # 넣어준 것
___#_%__돈%
_를 돈 처럼 사용하길 원했기 때문에 중간 # 넣어준 것
*/

-- 1. EMP_NAME을 "이름", SALARY를 급여로 표시
SELECT EMP_NAME AS "이름", SALARY AS "급여" FROM employee;

-- 2. DEPT_CODE를 부서코드로, JOB_CODE를 직무코드로 표시하여 선택
SELECT dept_code AS "부서코드", job_code AS "직무코드" FROM employee;

-- 3. EMAIL을 이메일, PHONE을 전화번호로 표시하여 선택
SELECT email AS "이메일", phone AS "전화번호" FROM employee;

-- 4. EMP_ID을 사원ID, HIRE_DATE를 입사일로 표시하여 선택
SELECT EMP_ID AS "사원ID", HIRE_DATE AS "입사일" FROM employee;

-- 5. EMP_NAME, DEPT_CODE, SALARY를 각각 이름, 부서 급여로 표시
SELECT EMP_NAME AS "이름", DEPT_CODE AS "부서", SALARY AS "급여" FROM employee;

-- 6. 중복되지 않은 DEPT_CODE를 선택
SELECT DISTINCT DEPT_CODE FROM employee;

-- 7. 중복되지 않은 JOB_CODE를 선택
SELECT DISTINCT JOB_CODE FROM employee;

-- 7. 중복되지 않은 SAL_LEVEL를 선택
SELECT DISTINCT SAL_LEVEL FROM employee;

-- 7. 중복되지 않은 MANAGER_ID를 선택
SELECT DISTINCT MANAGER_ID FROM employee;

-- 10. 중복되지 않은 EMP_NAME를 선택
SELECT DISTINCT EMP_NAME FROM employee;

-- OR

-- DEPT_CODE가 D5이거나 SALARY가 2000000보다 큰 사원의 이름과 급여 선택
SELECT EMP_NAME, SALARY FROM employee WHERE dept_code = 'D5' OR salary > 2000000;

-- DEPT_CODE가 D6이거나 JOB_CODE가 J3인 사원의 이름과 급여
SELECT EMP_NAME, SALARY FROM employee WHERE dept_code = 'D6' OR job_code = 'J3';

-- SAL_LEVEL이 S5이거나 BONUS가 0.2인 사원의 이름과 급여수준
SELECT EMP_NAME, SALARY FROM employee WHERE sal_level = 'S5' OR bonus = '0.2';

-- ENT_YN가 N이거나 HIRE_DATE가 2000년 이후인 사원의 이름과 입사일
SELECT EMP_NAME, HIRE_DATE FROM employee WHERE ent_yn = 'N' OR hire_date > TO_DATE ('2000-01-01', 'YYYY-MM-DD');




