/*UPDATE 실습*/

SELECT * FROM department2;

-- D1 인사관리부 -> 인사팀으로 변경
UPDATE department2
SET dept_title = '인사팀'
WHERE dept_id = 'D1';

-- D3 마케팅부 -> 마케팅팀 변경
UPDATE department2
SET dept_title = '마케팅팀'
WHERE dept_id = 'D3';

-- D8 기술지원부 -> 기술지원팀 변경
UPDATE department2
SET dept_title = '기술지원팀'
WHERE dept_id = 'D8';

SELECT * FROM department2;

-- 수정된 내용을 저장하길 원한다면 COMMIT
-- 저장하지 않길 원한다면 ROLLBACK;
COMMIT;

-- EMPLOYEE2 테이블에서 BONUS를 받지 않은 사원의
-- BONUS를 0.1로 변경
UPDATE employee2
SET bonus = 0.1
WHERE bonus IS NULL;

ROLLBACK;

-- 변경 후 EMP_NAME, BONUS 모두 조회
SELECT EMP_NAME, BONUS FROM employee2;

-- 모든 직원의 기본 급여 인상 EMPLOYEE2
UPDATE employee2
SET salary = salary * 1.1;
SELECT EMP_NAME, SALARY FROM employee2;

-- D9 부서의 모든 직원의 보너스율 0.4로 수정 EMPLOYEE2
UPDATE employee2
SET bonus = 0.4
WHERE dept_code = 'D9';

SELECT DEPT_CODE, BONUS FROM employee2;

-- DEPT_CODE 가 NULL인 직원은 D3부서로 이동
UPDATE employee2
SET dept_code = 'D3'
WHERE dept_code IS NULL;

SELECT EMP_NAME, DEPT_CODE FROM employee2;

-- 특정 입사일 (2000-01-01) 이후입사한 직원의 급여 수정
-- HRIE_DATE
UPDATE employee2
SET salary = salary + 1000000
WHERE hire_date > TO_DATE('2000-01-01', 'YYYY-MM-DD');

-- 1997-09-12에 입사한 직원 퇴사처리
UPDATE employee2
SET ENT_YN = 'Y'
WHERE hire_date = TO_DATE('1997-09-12', 'YYYY-MM-DD');

ROLLBACK;

SELECT * FROM employee2;


SELECT emp_name, email from employee2;
-- 특정 도메인 주소 변경
UPDATE employee2
SET EMAIL = REPLACE(email, 'or.kr', 'kh.kh');

SELECT emp_name, email from employee2;

-- 핸드폰번호 employ2에서 010enldp -붙여서 변경

UPDATE employee2
SET PHONE = REPLACE(PHONE, '010', '010-')
-- 중간에 010있을경우 문제발생
WHERE PHONE LIKE '010%';

ROLLBACK;

SELECT * FROM employee2;

SELECT PHONE FROM employee2;

--특정 입사일을 가진 직원의 입사일 변경
-- HIRE-DATE 1999-09-09 -> 2000-01-02
UPDATE employee2
SET hire_date = TO_DATE('2000-01-02', 'YYYY-MM-DD')
WHERE hire_date = TO_DATE('1999-09-09','YYYY-MM-DD');

COMMIT;

SELECT * FROM department2;

UPDATE department2
SET dept_title = '인사팀';

SELECT * FROM department2;

ROLLBACK;

-- UPDATE 한 번에 여러컬럼 업데이트

-- 진행하기전 EMPLOYEE3 만들기
CREATE TABLE EMPLOYEE3 AS SELECT * FROM EMPLOYEE;

-- EMP ID 200 직원의 이메일과 전화번호 업데이트
update employee3
SET EMAIL = 'ONE_SUN@or.kr',
phone = '01012345678'
where emp_id = '200';

-- D9 부서의 모든 직원의 급여 *1.1 보너스 =0.2변경
UPDATE employee3
SET salary = salary * 1.1,
BONUS = 0.2
WHERE dept_code = 'D9';

SELECT dept_code, bonus, salary FROM employee3;
-- J3 직무 코드를 가진 직원의 직무 코드와 부서코드 변경
-- J5 D5
UPDATE employee3
SET dept_code = 'D5',
JOB_CODE = 'J5'
WHERE job_code = 'J3';

-- 송은희 직원의 이름과이메일 변경
-- 송은휘 SONGSONG@or.kr
UPDATE employee3
SET emp_name = '송은휘',
EMAIL = 'SONGSONG@or.kr'
WHERE emp_name = '송은희';

SELECT * FROM employee3;

ROLLBACK;

-- 차태연 직원의 이름과 급여변경
--> 차태형 80000000
UPDATE employee3
SET emp_NAME = '차태형',
SALARY = 8000000
WHERE emp_name = '차태연';

SELECT EMP_NAME, SALARY FROM employee3;

--> D4 부서에 해당하는 모든 직원의 이메일 도메인과 부서코드 D4변경
UPDATE employee3
SET dept_code = 'D4',
EMAIL = REPLACE(email, 'or.kr', 'kh.kh');

select * from employee3;
ROLLBACK;



-- employee3 전체 테이블 삭제
delete from employee2;

COMMIT;

-- 완전 삭제 --> COMMIT
-- 되돌리기 --> ROLLBACK

SELECT * FROM employee2;

DROP TABLE employee3;



