CREATE TABLE Newbook (
	bookid 		NUMBER,
	bookname 	varchar2(20),
	publisher varchar2(20),
	price			NUMBER
);

SELECT * FROM newbook;

DELETE FROM NEWBOOK;
COMMIT;

--데이터 삽입
INSERT INTO newbook (bookid, bookname, publisher, price) 
			 VALUES (1, '도서명1', '출판사명', 10000);
COMMIT;

INSERT INTO newbook (bookid, bookname, publisher, price) 
			 VALUES (2, '도서명2', '출판사명2', 20000);
COMMIT;

INSERT INTO newbook (bookid, bookname, publisher, price) 
			 VALUES (3, '도서명3', '출판사명3', 30000);

INSERT INTO newbook (bookid, bookname, publisher, price) 
			 VALUES (4, '도서명4', '출판사명4', 40000);

--가장최근에 commit한 이후의 변경작업(삽입,삭제,수정) 취소
ROLLBACK;