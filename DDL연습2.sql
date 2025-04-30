--질의 3-35
CREATE TABLE newcustomer(
	custid 	NUMBER	PRIMARY KEY,
	name 		varchar2(40),
	address varchar2(40),
	phone		varchar2(30)
);
SELECT * FROM newcustomer;
INSERT INTO newcustomer(custid,name,address,phone)
	   VALUES (1,'이름1','주소1','010-1111-1111');
INSERT INTO newcustomer(custid,name,address,phone)
	   VALUES (2,'이름2','주소2','010-1111-2222');
COMMIT;
--질의 3-36
CREATE TABLE neworders(
	orderid			NUMBER,
	custid			NUMBER		NOT NULL,
	bookid			NUMBER		NOT NULL,
	saleprice		NUMBER,
	orderdate		DATE,
	PRIMARY key(orderid),
	FOREIGN key(custid) 
		REFERENCES newcustomer(custid) 
		ON DELETE CASCADE -- 부모테이블의 레코드가 삭제될때 참조되는 자식 테이블의 레코드도 같이 삭제
);
SELECT * FROM neworders;
INSERT INTO neworders
  	 VALUES (1,1,1,10000,to_date('2025-04-21','yyyy-mm-dd'));
INSERT INTO neworders
  	 VALUES (2,1,2,20000,to_date('2025-04-22','yyyy-mm-dd'));
COMMIT;

DELETE FROM newcustomer
      WHERE custid = 1;
COMMIT;


DROP TABLE newbook;
CREATE TABLE NEWbook(
	bookid		NUMBER,
	bookname	varchar2(20),
	publisher	varchar2(20),
	price 		NUMBER
);
SELECT * FROM newbook;
ALTER TABLE newbook ADD isbn varchar2(13);
ALTER TABLE newbook modify isbn number;
ALTER TABLE newbook DROP COLUMN isbn;
ALTER TABLE newbook MODIFY bookid NUMBER NOT NULL;
ALTER TABLE NEWbook ADD PRIMARY key(bookid);

DROP TABLE NEWbook;
DROP TABLE newcustomer;
DROP TABLE neworders;







