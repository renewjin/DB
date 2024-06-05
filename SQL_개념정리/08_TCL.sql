/*
TCL (Transaction Control Language) : 트랜잭션 제어 언어

Transaction : 업무, 처리

변경된 사항을 묶어서 하나의 트랜잭션에 처리

트랜잭션에서 데이터 변경 대상 : INSERT, UPDATE, DELETE (DML)

TCL = COMMIT, ROLLBACK

EX)
    INSERT INTO 값 추가 ---------------------------------------------> DB 반영(X)
    INSERT INTO 값 추가 -------트랜잭션에 추가--------COMMIT-----------> DB 반영(O)
    INSERT INTO 10번 값 추가 --> 1개 트랜잭션에 10개 추가 --> ROLLBACK ---->DB 반영(X)
    
    1) COMMIT : 메모리 트랜잭션에 임시 저장된 데이터를 DB에 완전히 추가

    2) ROLLBACK : 메모리 트랜잭션에 임시 저장된 데이터를 삭제하고
                  마지막 COMMIT 상태로 돌아감
                  
    3) SAVEPOINT : 메모리 트랜잭션에 저장 지점을 정의
                    ROLLBACK 수행시 전체 작업을 삭제하는 것이 아닌
                    저장 지점까지만 일부 ROLLBACK
                    
    -- SAVEPOINT는 잘 사용하지 않음
    
*/

-- 복제테이블 DEPARTMENT3
CREATE TABLE DEPARTMENT3 AS SELECT * FROM DEPARTMENT;

SELECT * FROM DEPARTMENT3;

--1) COMMIT 예제
---> D0 경리부 L2 삽입
INSERT INTO DEPARTMENT3 VALUES ('D0', '경리부', 'L2');

SELECT * FROM DEPARTMENT3;

---> D9 인 부서의 이름과 지역코드를 전략기획팀 L3수정
UPDATE department3
SET DEPT_TITLE = '전략기획팀',
LOCATION_ID = 'L3'
WHERE dept_id = 'D9';

SELECT * FROM DEPARTMENT3;

-- 추가와 수정된 사항들을 최종 저장
COMMIT; --> 완벽하게 저장완료

ROLLBACK; --> 완벽하게 저장이 된 상태에서 돌아가기를 진행할 경우 커밋이 완료된 시점으로 돌아감
-- 47 ~ 50 사이나 다른 구문에서 INSERT UPDATE DELETE해준 사항이 없기 때문에 변경X

--2) ROLLBACK 예제
-- DEPT_ID D0 삭제
DELETE FROM department3
WHERE DEPT_ID = 'D0';

SELECT * FROM department3;

-- DEPT_ID D9 삭제
DELETE FROM department3
WHERE DEPT_ID = 'D9';

-- DEPT_ID D8 삭제 후 모두 되돌리기
DELETE FROM department3
WHERE DEPT_ID = 'D8';

ROLLBACK;

--3) SAVEPOINT 예제
-- SAVEPOINT 작성해준 후 저장지점 이름설정

-- DEPT_ID 가 D0인 행 삭제
DELETE FROM department3
WHERE DEPT_ID = 'D0';

SAVEPOINT "SP1"; -- SP1 이라는 저장지점 설정

-- DEPT_ID D9 삭제
DELETE FROM department3
WHERE DEPT_ID = 'D9';

SAVEPOINT "AAA"; -- AAA 라는 저장 지점 설정

-- department3 전체 삭제
DELETE FROM department3;

SELECT * FROM department3;

-- AAA 까지 롤백 (AAA 까지 돌아가고 싶다)
ROLLBACK TO "AAA"; -- AAA 시점으로 저장된 DB내역이 돌아옴

ROLLBACK TO "SP1"; -- SP1 시점으로 저장된 DB내역이 돌아옴

-- 모든 내역 SP1이전으로 되돌리기
ROLLBACK;