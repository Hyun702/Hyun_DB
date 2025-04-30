SELECT * FROM book;
INSERT INTO book (bookid,bookname,publisher,price)
		 VALUES (11,'스포트 의학','한술의학서적',9000);
COMMIT;

INSERT INTO book (bookid,bookname,publisher)
		 VALUES (14,'스포트 의학','한술의학서적');

INSERT INTO book
	   SELECT *
	     FROM imported_book;

SELECT * FROM imported_book;
commit;

SELECT * FROM customer;
UPDATE CUSTOMER
   SET address = '대한민국 부산'
 WHERE custid = 5;

ROLLBACK;

UPDATE customer
   SET address = ( SELECT address
                     FROM CUSTOMER 
                    WHERE name = '김연아')
 where name = '박세리';
COMMIT;

DELETE FROM customer
 WHERE custid = 5;
COMMIT;

SELECT * FROM customer;






