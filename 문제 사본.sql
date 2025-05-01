--문제1~문제4 ) 테이블 생성 ~ 기본키 지정 , 외래키 지정 , 참조 무결성 조건 지정  

--부서 테이블
CREATE TABLE Department (
	deptno				NUMBER(3) 		PRIMARY KEY ,
	deptname			varchar2(20) 	UNIQUE NOT NULL,
	manager				NUMBER(5)

);

--직원 테이블
CREATE TABLE Employee (
	empno					NUMBER(5),
	name					varchar2(30)	NOT NULL,
	phoneno				varchar2(20),
	address				varchar2(20),
	sex						varchar2(10) CHECK (sex IN ('남','여')),
	position			varchar2(20),
	salary				number(10) DEFAULT 0,
	deptno				NUMBER(3),

	PRIMARY KEY (empno),
	FOREIGN KEY (deptno) REFERENCES department(deptno)

);

-- 프로젝트 테이블
CREATE TABLE Project (
	projno			 NUMBER(3),
	projname		 varchar2(20) NOT NULL,
	deptno			 NUMBER(3),

	PRIMARY KEY (projno),
	FOREIGN KEY (deptno) REFERENCES Department(deptno)

);

-- 업무 테이블 
CREATE TABLE Works (
	empno					NUMBER(5),
	projno				NUMBER(3),
	hoursworked		NUMBER(5) CHECK (hoursworked > 0),
	PRIMARY KEY (projno,empno),
	FOREIGN KEY (projno) REFERENCES Project(projno),
	FOREIGN KEY (empno) REFERENCES  Employee(empno)

);

--시퀀스 삭제
DROP SEQUENCE Employee_seq;
DROP SEQUENCE Department_seq;
DROP SEQUENCE Project_seq;

--문제 5 )시퀀스 생성
CREATE SEQUENCE Employee_seq START WITH 1001; 
CREATE SEQUENCE Department_seq START WITH 10 INCREMENT BY 10; 
CREATE SEQUENCE Project_seq START WITH 101; 


--문제 6 )데이터 insert
--샘플 데이터 생성

--사원 정보 삽입
INSERT INTO Employee VALUES (Employee_seq.nextval, '홍길동1', '010-111-1001', '울산1', '남', '팀장',		7000000, 10);
INSERT INTO Employee VALUES (Employee_seq.nextval, '홍길동2', '010-111-1002', '울산2', '남', '팀원1',	4000000, 10);
INSERT INTO Employee VALUES (Employee_seq.nextval, '홍길동3', '010-111-1003', '울산3', '남', '팀원2',	3000000, 10);
INSERT INTO Employee VALUES (Employee_seq.nextval, '홍길동4', '010-111-1004', '부산1', '여', '팀장', 	6000000, 20);
INSERT INTO Employee VALUES (Employee_seq.nextval, '홍길동5', '010-111-1005', '부산2', '남', '팀원1', 	3500000, 20);
INSERT INTO Employee VALUES (Employee_seq.nextval, '홍길동6', '010-111-1006', '부산3', '남', '팀원2', 	2500000, 20);
INSERT INTO Employee VALUES (Employee_seq.nextval, '홍길동7', '010-111-1007', '서울1', '남', '팀장', 	5000000, 30);
INSERT INTO Employee VALUES (Employee_seq.nextval, '홍길동8', '010-111-1008', '서울2', '남', '팀원1', 	4000000, 30);
INSERT INTO Employee VALUES (Employee_seq.nextval, '홍길동9', '010-111-1009', '서울3', '남', '팀원2', 	3000000, 30);
INSERT INTO Employee VALUES (Employee_seq.nextval, '홍길동10', NULL, '서울4', '남', '팀원3', 2000000, 30);
INSERT INTO Employee VALUES (Employee_seq.nextval, '홍길동11', '010-111-1011', '대구1', '여', '팀장', 	5500000, 40);
INSERT INTO Employee VALUES (Employee_seq.nextval, '홍길동12', '010-111-1012', '대구2', '남', '팀원1',	2000000, 40);
INSERT INTO Employee VALUES (Employee_seq.nextval, '홍길동13', '010-111-1013', '제주1', '남', '팀장', 	6500000, 50);
INSERT INTO Employee VALUES (Employee_seq.nextval, '홍길동14', '010-111-1014', '제주2', '남', '팀원1',	3500000, 50);

--부서 정보 삽입
INSERT INTO Department VALUES (Department_seq.nextval, '전산팀', 1001);
INSERT INTO Department VALUES (Department_seq.nextval, '회계팀', 1004);
INSERT INTO Department VALUES (Department_seq.nextval, '영업팀', 1007);
INSERT INTO Department VALUES (Department_seq.nextval, '총무팀', 1011);
INSERT INTO Department VALUES (Department_seq.nextval, '인사팀', 1013);

--프로젝트 정보 삽입
INSERT INTO Project VALUES (Project_seq.nextval, '빅데이터구축', 10);
INSERT INTO Project VALUES (Project_seq.nextval, 'IFRS', 20);
INSERT INTO Project VALUES (Project_seq.nextval, '마케팅', 30);

--업무 정보 삽입
INSERT INTO Works VALUES (1001, 101, 800);
INSERT INTO Works VALUES (1002, 101, 400);
INSERT INTO Works VALUES (1003, 101, 300);
INSERT INTO Works VALUES (1004, 102, 700);
INSERT INTO Works VALUES (1005, 102, 500);
INSERT INTO Works VALUES (1006, 102, 200);
INSERT INTO Works VALUES (1007, 103, 500);
INSERT INTO Works VALUES (1008, 103, 400);
INSERT INTO Works VALUES (1009, 103, 300);
INSERT INTO Works VALUES (1010, 103, 200);

-- 부서 팀장 번호 업데이트
--UPDATE department SET manager = 1001 WHERE deptno = 10;
--UPDATE department SET manager = 1004 WHERE deptno = 20;
--UPDATE department SET manager = 1007 WHERE deptno = 30;
--UPDATE department SET manager = 1011 WHERE deptno = 40;
--UPDATE department SET manager = 1013 WHERE deptno = 50;

SELECT * FROM department ; 

-- 사원 중 같은 성씨를 가진 사람 성씨별 인원수 
SELECT substr(name, 1, 1), count(*)
	FROM EMPLOYEE e 
GROUP BY substr(name, 1, 1);

-- '영업팀' 부서에서 일하는 사원의 이름, 연락처, 주소
SELECT e.name "이름", NVL2(e.phoneno, substr(e.phoneno, 1, 8) || '**' || substr(e.phoneno, 11, 2), '연락처 없음') "연락처", e.ADDRESS "주소"
	FROM DEPARTMENT d JOIN EMPLOYEE e ON d.DEPTNO = e.DEPTNO
 WHERE d.DEPTNAME = '영업팀';

-- 홍길동7 팀장(manager) 부서에서 일하는 팀원의 수
SELECT count(*) "부서원 수"
	FROM EMPLOYEE e 
 WHERE EXISTS (SELECT *
 								FROM DEPARTMENT d
 							 WHERE e.DEPTNO = d.DEPTNO AND d.DEPTNAME ='영업팀') AND e.NAME != '홍길동7' ;

-- 프로젝트에 참여하지 않은 사원의 이름
SELECT e.NAME "프로젝트 미 참여자"
	FROM EMPLOYEE e
 WHERE NOT EXISTS (SELECT *
 										 FROM PROJECT p  
 										WHERE p.DEPTNO = e.DEPTNO	);

-- 급여 상위 top3을 순위와 함께
SELECT rownum "순위", p1.name "이름", p1.salary "급여"
	FROM (SELECT *
					FROM EMPLOYEE   
			ORDER BY salary DESC ) p1	
 FETCH FIRST 3 ROWS ONLY;

-- 사원들이 일한 시간 수를 부서별 사원 이름별 오름차순

SELECT d.DEPTNO "사원 번호" , e.NAME " 이름 ", sum(w.HOURSWORKED) "일한 시간"
	FROM WORKS w JOIN EMPLOYEE e ON w.EMPNO = e.EMPNO
							 JOIN DEPARTMENT d ON e.DEPTNO = d.DEPTNO
GROUP BY d.DEPTNO, e.NAME 
ORDER BY d.DEPTNO, e.NAME;

-- 부서별로 금여가 부서평균 급여 보다 높은 사원의 이름과 월급
SELECT e.name, e.SALARY
	FROM EMPLOYEE e 
 WHERE e.SALARY > (SELECT avg(e1.salary)
 										 FROM EMPLOYEE e1 JOIN DEPARTMENT d ON e1.DEPTNO = d.DEPTNO 
 								 GROUP BY d.DEPTNO
 								 HAVING 	e1.DEPTNO = e.DEPTNO);

-- 2명 이상의 사원이 참여한 프로젝트의 번호, 프로젝트명, 사원수
SELECT p.PROJNO, p.PROJNAME, COUNT(*) 
	FROM PROJECT p JOIN EMPLOYEE e ON p.DEPTNO = e.DEPTNO 
GROUP BY p.PROJNO, p.PROJNAME
HAVING count(*) >= 2;

-- 프로젝트에 참여시간이 가장 많은 사원 가장 적은 사원 
SELECT e.name "이름" , w.HOURSWORKED "시간"
	FROM EMPLOYEE e JOIN WORKS w ON e.EMPNO = w.EMPNO
 WHERE w.HOURSWORKED = (SELECT max(HOURSWORKED) FROM WORKS)
 UNION
SELECT e.name "이름", w.HOURSWORKED "시간"
	FROM EMPLOYEE e JOIN WORKS w ON e.EMPNO = w.EMPNO
 WHERE w.HOURSWORKED = (SELECT min(hoursworked) FROM works)

-- 팀장의 급여를 10% 인상후 인상된 결과
 
 UPDATE EMPLOYEE 
 	  SET salary = salary * 1.1
 	WHERE "POSITION" = '팀장';
 
 SELECT name, "POSITION", salary 
 	 FROM EMPLOYEE e
 	WHERE "POSITION" = '팀장';
 
 ROLLBACK;
