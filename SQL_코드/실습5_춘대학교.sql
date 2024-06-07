-- 1번
-- 학생이름과 주소지를 조회하시오
-- 단, 출력 헤더는 "학생 이름", "주소지"로 하고, 정렬은 이름으로 오름차순 정렬
SELECT STUDENT_NAME AS "학생 이름", STUDENT_ADDRESS AS "주소지"
FROM tb_student
ORDER BY STUDENT_NAME;

-- 2번
-- 휴학중인 학생들의 이름과 주민번호를 나이가 적은 순서 조회하시오.
SELECT * FROM tb_student;
SELECT STUDENT_NAME, STUDENT_SSN
FROM tb_student
WHERE absence_yn = 'Y'
ORDER BY STUDENT_SSN DESC;

-- 3번
-- 주소지가 강원도나 경기도인 학생들 중 1900년대 학번을 가진 학생들의 
-- 이름과 학번, 주소를 이름 오름차순으로 조회하시오.
-- 단, 출력헤더에는 "학생이름", "학번", "거주지 주소"가 출력되도록 한다.
SELECT STUDENT_NAME AS "학생이름", STUDENT_NO AS "학번", STUDENT_ADDRESS AS "주소"
FROM  TB_STUDENT
WHERE SUBSTR(STUDENT_ADDRESS, 1, 3) IN('강원도', '경기도') 
AND SUBSTR(STUDENT_NO, 1, 1) != 'A'
-- AND STUDENT_NO LIKE '9%' AND STUDENT_ADDERESS LIKE '경기도%' OR STUDENT_ADDERESS LIKE '강원도%'
ORDER BY STUDENT_NAME, STUDENT_NO, STUDENT_ADDRESS;

-- 4번
-- 현재 법학과 교수의 이름, 주민등록 번호를 나이가 많은 순서부터 조회하시오.
SELECT * FROM tb_professor;
SELECT * FROM TB_CLASS;
SELECT * FROM tb_class_professor;
-- ANSI
SELECT PROFESSOR_NAME, PROFESSOR_SSN, FLOOR((SYSDATE - TO_DATE(SUBSTR(PROFESSOR_SSN, 1, 6)))/365) AS "나이"
FROM tb_professor P
JOIN TB_DEPARTMENT D ON  P.DEPARTMENT_NO = D.DEPARTMENT_NO
WHERE d.department_name = '법학과' 
ORDER BY PROFESSOR_SSN;
-- ORACLE
SELECT PROFESSOR_NAME, PROFESSOR_SSN, FLOOR((SYSDATE - TO_DATE(SUBSTR(PROFESSOR_SSN, 1, 6)))/365) AS "나이"
FROM tb_professor P, TB_DEPARTMENT D
WHERE P.DEPARTMENT_NO = D.DEPARTMENT_NO
AND d.department_name = '법학과' 
ORDER BY PROFESSOR_SSN;

-- 5번
-- 2004년 2학기에 'C3118100' 과목을 수강한 학생들의 학점을 조회하려고 한다. 
-- 학점이 높은 학생부터 표시하고, 학점이 같으면 학번이 낮은 학생부터 조회하시오.
-- (참고) 소수점 아래 2자리까지 0으로 표현 : TO_CHAR(NUMBER, 'FM9.00')
-- (FM : 조회 결과 양쪽 공백 제거)

SELECT * FROM TB_STUDENT;
SELECT * FROM TB_GRADE;
SELECT STUDENT_NO, TO_CHAR(POINT, 'FM9.00')
FROM TB_GRADE
WHERE CLASS_NO = 'C3118100'
AND SUBSTR(TERM_NO, 1, 4) = '2004'
AND SUBSTR(TERM_NO, 5, 6) = '02'
-- TERM_NO = '200402'
ORDER BY POINT DESC, STUDENT_NO;

-- 6번
-- 학생 번호, 학생 이름, 학과 이름을 학생 이름 오름차순으로 조회하시오.
-- ANSI
SELECT STUDENT_NO, STUDENT_NAME, DEPARTMENT_NAME
FROM tb_department D
JOIN tb_student S USING (DEPARTMENT_NO)
ORDER BY STUDENT_NAME;
-- ORACLE
SELECT STUDENT_NO, STUDENT_NAME, DEPARTMENT_NAME
FROM tb_department D, tb_student S
WHERE d.department_no = s.department_no
ORDER BY STUDENT_NAME;

-- 7번
-- 춘 기술대학교의 과목 이름, 해당 과목을 수업하는 학과 이름을 조회하시오.
SELECT * FROM TB_CLASS;
SELECT * FROM tb_department;

-- ANSI
SELECT CLASS_NAME AS "과목명", DEPARTMENT_NAME AS "학과"
FROM tb_department D
JOIN TB_CLASS C USING (DEPARTMENT_NO);

-- ORACLE
SELECT CLASS_NAME AS "과목명", DEPARTMENT_NAME AS "학과"
FROM tb_department D, TB_CLASS C
WHERE d.department_no = c.department_no;

-- 8번
-- 과목, 해당 과목 교수 이름을 조회하시오.
-- TB_CLASS_PROFESSOR : 과목별 교수의 정보를 저장한 테이블(과목 코드, 학과 코드)
SELECT * FROM TB_CLASS;
SELECT * FROM TB_CLASS_PROFESSOR;
SELECT * FROM TB_PROFESSOR;

-- ANSI
-- TB_CLASS와  TB_PROFESSOR 테이블이 공통으로
-- DEPARTMENT_NO 컬럼을 가지고 있다 해서 이를 이용해서 JOIN을 하면 안됨!
SELECT CLASS_NAME, PROFESSOR_NAME
FROM TB_CLASS C
JOIN tb_class_professor CP USING (CLASS_NO)
JOIN tb_professor P USING (professor_no);

SELECT CLASS_NAME, PROFESSOR_NAME
FROM TB_CLASS C
JOIN tb_class_professor CP ON (C.CLASS_NO = cp.class_no)
JOIN tb_professor P ON (P.professor_no = cp.professor_no);


-- ORACLE
SELECT * FROM tb_class;
SELECT * FROM tb_class_professor;
SELECT * FROM tb_professor;

SELECT CLASS_NAME, PROFESSOR_NAME 
FROM TB_CLASS C, tb_class_professor CP, tb_professor P
WHERE c.class_no = cp.class_no
AND cp.professor_no = p.professor_no;

-- 9번
-- 8번의 결과 중 '인문 사회' 계열에 속한 과목명, 교수이름을 과목명 오름차순으로 조회하시오.
SELECT * FROM TB_CLASS;
SELECT * FROM tb_department;
SELECT * FROM tb_professor;
SELECT * FROM tb_class_professor;
-- ANSI
SELECT CLASS_NAME, PROFESSOR_NAME
FROM tb_professor P
JOIN tb_class_professor CP USING(professor_no)
JOIN tb_class C USING(CLASS_NO)
JOIN tb_department D ON (D.DEPARTMENT_NO = c.department_no)
WHERE d.category = '인문사회'
ORDER BY CLASS_NAME;

-- ORACLE
SELECT CLASS_NAME, PROFESSOR_NAME
FROM TB_CLASS C, tb_class_professor CP, tb_department D, tb_professor P
WHERE c.class_no = cp.class_no
AND  cp.professor_no = p.professor_no
AND p.department_no = d.department_no
AND d.category = '인문사회'
ORDER BY CLASS_NAME;
                        
-- 10번
-- 음악학과 학생들의 "학번", "학생 이름", "전체 평점"을 조회하시오.
-- (단, 평점은 소수점 1자리까지만 반올림하여 표시한다.)

-- ANSI
SELECT * FROM tb_student;
SELECT * FROM tb_grade;
SELECT * FROM tb_department;
SELECT * FROM tb_class;

SELECT S.STUDENT_NO, S.STUDENT_NAME, ROUND(AVG(POINT), 1) AS "전체 평점"
FROM tb_grade G
JOIN tb_student S ON (g.student_no = s.student_no)
JOIN tb_department D ON (s.department_no = d.department_no)
WHERE d.department_name = '음악학과'
GROUP BY s.student_no, s.student_name;

-- USING 절을 사용할 때, GROUP BY 절에 포함된 열은 테이블 별칭(S.) 없이 사용
-- GROUP BY 절은 집계 함수와 함께 사용되어 각 그룹에 대해 요약된 데이터를 계산
-- 집계 함수 사용: 각 그룹에 대해 집계 함수(SUM, AVG, COUNT, MAX, MIN 등)

SELECT S.STUDENT_NO 학번, STUDENT_NAME "학생 이름", ROUND(AVG(POINT),1) "전체 평점"
FROM TB_GRADE G
JOIN TB_STUDENT S ON(S.STUDENT_NO = G.STUDENT_NO)
JOIN TB_DEPARTMENT D ON(S.DEPARTMENT_NO = D.DEPARTMENT_NO)
WHERE DEPARTMENT_NAME = '음악학과'
GROUP BY S.STUDENT_NO, S.STUDENT_NAME;

-- ORACLE
SELECT s.STUDENT_NO, s.STUDENT_NAME, ROUND(AVG(POINT), 1)
FROM tb_student S, tb_grade G, tb_department D
WHERE s.department_no = d.department_no
AND g.student_no = s.student_no
AND d.department_name = '음악학과'
GROUP BY S.STUDENT_NO, s.student_name;

-- 11번
-- 학번이 A313047인 학생의 학과이름, 학생이름, 지도교수 이름을 조회하시오.
-- ANSI
SELECT * FROM tb_department;
SELECT * FROM tb_student;
SELECT * FROM tb_professor;

SELECT D.DEPARTMENT_NAME AS "학과이름", STUDENT_NAME AS "학생이름", PROFESSOR_NAME AS "지도교수"
FROM tb_department D
JOIN tb_student S ON (d.department_no = s.department_no)
JOIN tb_professor P ON (p.professor_no = s.coach_professor_no)
WHERE s.student_no = 'A313047';

-- ORACLE
SELECT DEPARTMENT_NAME, STUDENT_NAME, PROFESSOR_NAME
FROM tb_department D, tb_student S, tb_professor P
WHERE d.department_no = s.department_no
AND p.professor_no = s.coach_professor_no
AND s.student_no = 'A313047'
ORDER BY p.professor_name;

-- 12번
-- 2007년도에 '인간관계론' 과목을 수강한 학생을 찾아 
-- 학생이름과 수강학기를 조회하는 SQL을 작성하시오.
SELECT * FROM tb_department;
SELECT * FROM tb_class;
SELECT * FROM tb_student;
SELECT * FROM tb_grade;
-- ANSI
SELECT S.STUDENT_NAME, SUBSTR(G.TERM_NO, 5,2) AS "수강학기"
FROM tb_class C
JOIN TB_GRADE G ON (g.class_no = c.class_no)
JOIN tb_student S ON (s.student_no = g.student_no)
WHERE SUBSTR(g.term_no,1,4) = '2007'
AND c.class_name = '인간관계론';


-- ORACLE
SELECT STUDENT_NAME, SUBSTR(TERM_NO, 5,2) AS "수강학기"
FROM tb_class C, tb_student S, tb_grade G
WHERE g.class_no = c.class_no
AND s.student_no = g.student_no
AND c.class_name = '인간관계론'
AND SUBSTR(g.term_no,1, 4) = '2007';


-- 13번
-- 예체능 계열 과목 중 과목 담당교수를 한 명도 배정받지 못한 과목을 찾아 
-- 과목 이름, 학과 이름을 조회하시오.

-- ANSI
SELECT CLASS_NAME, DEPARTMENT_NAME
FROM tb_department D
JOIN tb_class C USING(DEPARTMENT_NO)
WHERE d.category = '예체능'
AND C.PREATTENDING_CLASS_NO IS NULL;

SELECT CLASS_NAME, DEPARTMENT_NAME
FROM TB_CLASS C
LEFT JOIN TB_CLASS_PROFESSOR USING(CLASS_NO)
JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
WHERE CATEGORY = '예체능'
AND PROFESSOR_NO IS NULL;

-- ORACLE

-- 14번
-- 춘 기술대학교 서반아어학과 학생들의 지도교수를 게시하고자 한다. 
-- 학생이름, 지도교수이름 학번이 높은 순서로 조회하는 SQL을 작성하시오.
-- 단, 지도교수가 없을 경우 "지도교수 미지정"으로 표시

-- ANSI
SELECT * FROM TB_STUDENT;
SELECT * FROM tb_professor;
SELECT * FROM tb_department;

SELECT STUDENT_NAME, NVL(PROFESSOR_NAME, '지도교수 미지정'), STUDENT_NO
FROM tb_student S
LEFT JOIN tb_professor P ON (s.coach_professor_no = p.professor_no)
JOIN tb_department D ON (s.department_no = d.department_no)
WHERE d.department_name = '서반아어학과'
ORDER BY STUDENT_NAME, PROFESSOR_NAME, STUDENT_NO;

-- ORACLE


-- 15번
-- 휴학생이 아닌 학생 중 평점이 4.0 이상인 학생을 찾아 
-- 학생의 학번, 이름, 학과, 이름, 평점을 조회하시오.
SELECT * FROM tb_student;
SELECT * FROM tb_department;
SELECT * FROM tb_grade;

SELECT S.STUDENT_NO, S.STUDENT_NAME, D.DEPARTMENT_NAME, ROUND(AVG(POINT),2)
FROM tb_student S
JOIN tb_department D ON (s.department_no = d.department_no)
JOIN tb_grade G ON (s.student_no = g.student_no)
WHERE s.absence_yn = 'N'
GROUP BY S.STUDENT_NO, S.STUDENT_NAME, D.DEPARTMENT_NAME
HAVING AVG(POINT) >= 4.0;

-- ANSI
-- ORACLE



-- 16번
-- 환경조경학과 전공과목들의 과목 별 평점을 조회하시오.
-- (평점은 TRUNC를 이용해 소수점 아래 둘째 자리까지 표시)
SELECT * FROM tb_grade;
SELECT * FROM tb_department;
SELECT * FROM tb_class;

-- ANSI
SELECT C.CLASS_NAME, TRUNC(AVG(POINT),2)
FROM tb_class C
JOIN tb_department D ON (d.department_no = c.department_no)
JOIN tb_grade G ON (g.class_no = c.class_no)
WHERE d.department_name = '환경조경학과'
AND c.class_type LIKE '전공%'
GROUP BY CLASS_NAME;

-- ORACLE


-- 17번
-- 춘 기술대학교에 다니고 있는 최경희 학생과 같은 과 학생들의 이름과 주소를 조회하시오.
SELECT * FROM tb_student;
SELECT STUDENT_NAME, STUDENT_ADDRESS
FROM tb_student
WHERE DEPARTMENT_NO = (SELECT DEPARTMENT_NO 
                        FROM tb_student 
                        WHERE tb_student.student_name = '최경희');

  
-- 18번
-- 국어국문학과에서 총 평점이 가장 높은 학생의 이름과 학번을 조회하시오
SELECT * FROM tb_student;
SELECT * FROM tb_department;
SELECT * FROM tb_grade;

SELECT S.STUDENT_NAME, s.student_no, AVG(POINT)
FROM tb_student S
JOIN tb_department D ON(s.department_no = d.department_no)
JOIN tb_grade G ON (s.student_no = g.student_no)
WHERE d.department_name = '국어국문학과'
AND MAX(AVG(POINT)) = (SELECT MAX(AVG(POINT))
                        FROM tb_grade G
                        JOIN tb_department D);
                        
SELECT STUDENT_NO, STUDENT_NAME
FROM
    (SELECT STUDENT_NO, STUDENT_NAME, AVG(POINT) 평점
    FROM TB_GRADE
    JOIN TB_STUDENT USING(STUDENT_NO)
    WHERE DEPARTMENT_NO  = (SELECT DEPARTMENT_NO
                            FROM TB_DEPARTMENT
                            WHERE DEPARTMENT_NAME = '국어국문학과')
    GROUP BY STUDENT_NO, STUDENT_NAME
    ORDER BY 평점 DESC)
WHERE ROWNUM = 1;

-- 19번
-- 춘 기술대학교의 "환경조경학과"가 속한 같은 계열 학과들의 
-- 학과 별 전공과목 평점을 파악하기 위한 적절한 SQL문을 작성하시오
-- 단, 출력헤더는 "계열 학과명", "전공평점"으로 표시되도록 하고, 
-- 평점은 소수점 첫째자리까지만 반올림하여 표시
SELECT * FROM tb_department;
SELECT * FROM tb_class;
SELECT * FROM TB_GRADE;
SELECT D.DEPARTMENT_NAME AS "계열 학과명", ROUND(AVG(POINT),1) AS "전공평점"
FROM tb_department D
JOIN tb_class C ON (c.department_no = d.department_no)
JOIN tb_grade G ON (g.class_no = c.class_no)
WHERE d.category = (SELECT CATEGORY FROM tb_department WHERE DEPARTMENT_NAME = '환경조경학과')
AND c.class_type LIKE '전공%'
GROUP BY D.DEPARTMENT_NAME
ORDER BY "전공평점" DESC;

-- ANSI

-- ORACLE


