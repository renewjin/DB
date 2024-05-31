/*
함수 실습 코드
*/

-- LENGTH --

-- 1. 직원 이름의 길이 조회 이름_길이로 작성
SELECT EMP_ID, EMP_NAME, LENGTH(EMP_NAME) AS "이름_길이"
FROM employee;

-- 2. 이메일 아이디의 길이 조회 이메일 길이로 작성
--> 아이디, 이름, 이메일, 이메일길이
SELECT EMP_ID, EMP_NAME, EMAIL, LENGTH(EMAIL) AS "이메일길이"
FROM employee;

--3. 전화번호 길이가 11자리인 직원 조회
--> 아이디, 이름, 번호
SELECT EMP_ID, EMP_NAME, PHONE
FROM employee
WHERE LENGTH(PHONE) = 11;

-- 4. 이메일의 길이가 15자 이상인 직원 조회
--> 아이디 이름, 이메일, 이메일_길이
SELECT EMP_ID, EMP_NAME, EMAIL, LENGTH(EMAIL) AS "이메일_길이"
FROM employee
WHERE LENGTH(EMAIL) >= 15;

-- 5. 부서코드가 2글자인 직원 조회
--> 아이디, 이름, 부서코드 조회
SELECT EMP_ID, EMP_NAME, DEPT_CODE
FROM employee
WHERE LENGTH(DEPT_CODE) = 2;

-- 6. 전화번호 010이 포함된 직원 조회
SELECT EMP_ID, EMP_NAME, PHONE
FROM employee
WHERE INSTR(PHONE, '010')>0;

-- LIKE로 변경해서 작성
SELECT EMP_ID, EMP_NAME, PHONE
FROM employee
WHERE PHONE LIKE '010%';