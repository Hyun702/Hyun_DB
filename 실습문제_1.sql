drop table courses;
drop table students;
drop table professors;

-- 학생 테이블 생성
CREATE TABLE STUDENTS (
	STUDENT_ID VARCHAR2(10) PRIMARY KEY,  --학번
	NAME VARCHAR2(50) NOT NULL,           --이름
	MAJOR VARCHAR2(50),                   --전공
	BIRTH_DATE DATE,                      --생년월일
	ADMISSION_YEAR NUMBER(4),             --입학년도
	EMAIL VARCHAR2(100) UNIQUE            --이메일
);
-- 교수 테이블 생성
CREATE TABLE PROFESSORS (
	PROFESSOR_ID VARCHAR2(10) PRIMARY KEY, --교수ID
	NAME VARCHAR2(50) NOT NULL,            --이름
	DEPARTMENT VARCHAR2(50),               --학과
	POSITION VARCHAR2(30),                 --직위
	HIRE_DATE DATE,                        --임용일
	EMAIL VARCHAR2(100) UNIQUE             --이메일
);
-- 과목 테이블 생성
CREATE TABLE COURSES (
	COURSE_ID VARCHAR2(10) PRIMARY KEY,               --과목코드
	TITLE VARCHAR2(100) NOT NULL,                     --과목명
	CREDIT NUMBER(1) CHECK (CREDIT BETWEEN 1 AND 6),  --학점
	PROFESSOR_ID VARCHAR2(10),                        --담당교수ID
	SEMESTER VARCHAR2(20),                            --학기
	CAPACITY NUMBER(3) DEFAULT 30,                    --수강정원
	FOREIGN KEY (PROFESSOR_ID) REFERENCES PROFESSORS(PROFESSOR_ID)
);
-- 교수 데이터 삽입
INSERT INTO PROFESSORS VALUES ('P001', '김교수', '컴퓨터공학과', '정교수', '2010-03-01', 'kim@university.edu');
INSERT INTO PROFESSORS VALUES ('P002', '이교수', '전자공학과', '부교수', '2012-09-01', 'lee@university.edu');
INSERT INTO PROFESSORS VALUES ('P003', '박교수', '수학과', '조교수', '2015-03-01', 'park@university.edu');
INSERT INTO PROFESSORS VALUES ('P004', '정교수', '물리학과', '정교수', '2008-03-01', 'jung@university.edu');
INSERT INTO PROFESSORS VALUES ('P005', '최교수', '화학과', '부교수', '2013-09-01', 'choi@university.edu');
INSERT INTO PROFESSORS VALUES ('P006', '홍교수', '화학과', '부교수', '2013-09-01', 'hong@university.edu');
COMMIT;
SELECT * FROM PROFESSORS;
-- 학생 데이터 삽입
INSERT INTO STUDENTS VALUES ('S001', '홍길동', '컴퓨터공학과', '2000-05-15', 2019, 'hong@student.edu');
INSERT INTO STUDENTS VALUES ('S002', '김철수', '전자공학과', '2001-03-20', 2020, 'kim@student.edu');
INSERT INTO STUDENTS VALUES ('S003', '이영희', '수학과', '1999-11-10', 2018, 'lee@student.edu');
INSERT INTO STUDENTS VALUES ('S004', '박민준', '물리학과', '2000-08-22', 2019, 'park@student.edu');
INSERT INTO STUDENTS VALUES ('S005', '정수미', '화학과', '2001-07-30', 2020, 'jung@student.edu');

-- 과목 데이터 삽입
INSERT INTO COURSES VALUES ('C001', '데이터베이스개론', 3, 'P001', '2023-1', 40);
INSERT INTO COURSES VALUES ('C002', '전자회로', 4, 'P002', '2023-1', 35);
INSERT INTO COURSES VALUES ('C003', '선형대수학', 3, 'P003', '2023-1', 50);
INSERT INTO COURSES VALUES ('C004', '양자역학', 4, 'P004', '2023-2', 30);
INSERT INTO COURSES VALUES ('C005', '유기화학', 3, 'P005', '2023-2', 45);
INSERT INTO COURSES VALUES ('C006', '물리과학', 7, 'P006', '2023-3', 50);

COMMIT;

--문3) 모든 학생의 학번, 이름, 전공, 입학년도를 조회하세요.
SELECT STUDENT_ID ,NAME ,MAJOR ,ADMISSION_YEAR 
  FROM STUDENTS; 
--문4) 학점별 과목 수를 계산하여 학점과 해당 학점의 과목 수를 조회하세요.
	SELECT CREDIT "학점", count(*) "과목수"
	  FROM COURSES 
GROUP by CREDIT;  
  
--문5) 각 교수가 담당하는 과목 정보를 교수 이름, 학과, 과목명, 학점 순으로 조회하세요. 과목을 담당하지 않는 교수도 결과에 포함하세요.
	SELECT t1.NAME "교수이름", t1.DEPARTMENT "학과", t2.TITLE "과목명", t2.CREDIT "학점"
	  FROM PROFESSORS t1 LEFT OUTER JOIN COURSES t2 ON t1.PROFESSOR_ID = t2.PROFESSOR_ID;
--문6) 각 학과별 교수 수, 해당 학과 교수들이 담당하는 총 과목 수, 총 학점 수를 조회하세요.
	SELECT t1.DEPARTMENT, count(t1.PROFESSOR_ID) "교수 수", count(t2.COURSE_ID) "과목 수", SUM(t2.CREDIT) "총학점 수"
	  FROM PROFESSORS t1 LEFT OUTER JOIN COURSES t2 ON t1.PROFESSOR_ID = t2.PROFESSOR_ID
GROUP BY t1.DEPARTMENT	  
--문7) 평균 수강정원보다 수강정원이 많은 과목의 정보와 담당교수 정보를 조회하세요.
	SELECT t2.*, t1.*
	  FROM PROFESSORS t1 INNER JOIN COURSES t2 ON t1.PROFESSOR_ID  = t2.PROFESSOR_ID 
	 WHERE t2.CAPACITY > ( SELECT avg(CAPACITY)
											 	   FROM COURSES );

--문8) 각 학기별로 개설된 과목 수, 총 학점, 평균 수강정원, 그리고 해당 학기에 과목을 담당하는 고유 교수 수를 조회하세요.

	SELECT SEMESTER "학기", count(COURSE_ID) "과목 수", sum(CREDIT ) "총 학점", 
	       avg(CAPACITY) "평균 수강정원", count(DISTINCT PROFESSOR_ID) "교수 수"
	  FROM COURSES
GROUP BY SEMESTER  ;
	
--문9) 같은 학과에 소속된 교수와 학생을 매칭하여 교수 이름, 학생 이름, 학과명을 조회하세요.

	SELECT p.NAME "교수 이름", s.NAME "학생 이름", p.DEPARTMENT "학과명" 
		FROM PROFESSORS p INNER JOIN STUDENTS s ON p.DEPARTMENT = s.MAJOR;
	

--문10) 컴퓨터공학과 또는 전자공학과 소속이면서 2019년 이후 임용된 교수가 담당하는 3학점 이상 과목의 목록을 조회하세요.
	SELECT c.*
		FROM PROFESSORS p INNER JOIN COURSES c ON p.PROFESSOR_ID = c.PROFESSOR_ID
	 WHERE p.DEPARTMENT IN ('컴퓨터공학과', '한자공학과')
		 AND to_char (p.HIRE_DATE, 'YYYY') <= 2019
		 AND c.CREDIT >= 3;
	
	
	-- 오라클에서 날짜 타입에서 원하는 구성요소 추출하기
	
	 SELECT to_char(p.HIRE_DATE, 'YYY') "년", to_char(p.HIRE_DATE, 'MM') "월", to_char(p.HIRE_DATE, 'DD') "일",
	 				EXTRACT(year FROM p.HIRE_DATE) "년", EXTRACT(month FROM p.HIRE_DATE) "월", EXTRACT(day FROM p.HIRE_DATE) "일"
	 	 FROM PROFESSORS p; 
	 
	 SELECT	to_char(p.HIRE_DATE, 'HH') "시", to_char(p.HIRE_DATE, 'MI') "분", to_char(p.HIRE_DATE, 'SS') "초",
	 				EXTRACT(hour FROM p.HIRE_DATE) "시", EXTRACT(minute FROM p.HIRE_DATE) "분", EXTRACT(year FROM p.HIRE_DATE) "초"  
	 	 FROM PROFESSORS p ;
	 
	 SELECT EXTRACT(year FROM p.HIRE_DATE)
	 	 FROM PROFESSORS p ;