/*******DECODE 실습*******/

--1) 주어진 학생의 성별 기준으로 성별 출력
-- SELECT STUDENT_NAME, STUDENT_SSN, DECODE 성별 확인
-- FROM TB_STUDENT
SELECT STUDENT_NAME, STUDENT_SSN, 
DECODE(SUBSTR(STUDENT_SSN, 8, 1),
'1', '남',
'2', '여',
'기타') AS "성별"
FROM TB_STUDENT;

--2) SELECT EMP_NAME, DEPT_CODE FROM EMPLOTEE
/*
D1 인사관리부 
D2 회계관리부 
D3 마케팅부 
D4 국내영업부 
기타
*/
SELECT EMP_NAME, DEPT_CODE,
DECODE(DEPT_CODE,
'D1', '인사관리부',
'D2', '회계관리부',
'D3', '마케팅부',
'D4', '국내영업부',
'기타') AS "부서명"
FROM EMPLOYEE;

-- 3) SELECT EMP_NAME, JOB_CODE FROM EMPLOYEE
/*
J1 대표
J2 부사장
J3 
*/
SELECT EMP_NAME, JOB_CODE,
DECODE(JOB_CODE,
'J1', '대표',
'J2', '부사장',
'J3', '부장',
'J4', '차장',
'J5', '과장',
'J6', '대리',
'J7', '사원',
'기타') AS "직급"
FROM EMPLOYEE;



/*** CASE WHEN THEN END 실습 ***/
-- 1) 급여에 따라 등급 설정 600만 이상 S1, 500이상 S2, 400이상 S3 나머지 S4 AS 급여등급
SELECT EMP_NAME, SALARY, 
    CASE
        WHEN SALARY >= 6000000 THEN 'S1'
        WHEN SALARY >= 5000000 THEN 'S2'
        WHEN SALARY >= 4000000 THEN 'S3'
        ELSE 'S4'
    END AS "급여등급"
FROM EMPLOYEE;

-- 2) 사원의 근무 일 수에 따라 근속 기간 분류하는 CASE
--- SELECT EMP_NAME, HIRE_DATE,
--- FLOOR(MONTHS_BETWEEN(SYSDATE, HIRE_DATE) / 12) >= 20 THEN "20년 이상"
--- 10 10년 이상
--- 10년 미만 근속기간 분류
SELECT EMP_NAME, HIRE_DATE,
    CASE
        WHEN FLOOR(MONTHS_BETWEEN(SYSDATE, HIRE_DATE) / 12) >= 20 THEN '20년 이상'
        WHEN FLOOR(MONTHS_BETWEEN(SYSDATE, HIRE_DATE) / 12) >= 10 THEN '10년 이상'
        ELSE '10년 미만'
    END AS "근속기간"
FROM EMPLOYEE;
