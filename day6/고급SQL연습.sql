SELECT rownum, c.*
	FROM customer c
 WHERE rownum < 3;  



SELECT rownum, b.* 
  FROM book b;


SELECT rownum, b.*
  FROM book b
 WHERE ROWNUM <= 5;


  SELECT rownum, b.*
    FROM book b
 	 WHERE ROWNUM <= 5
ORDER BY price;


SELECT rownum, b.*
  FROM (SELECT * 
       		FROM book 
      order BY price)b
  WHERE ROWNUM <= 5;


SELECT rownum, b.*
       FROM (SELECT * 
       				 FROM book 
       				WHERE ROWNUM <= 5)b
Order BY price;


SELECT rownum, b.*
  FROM (SELECT * 
  				FROM book 
         WHERE ROWNUM <= 5
      Order BY price)b;

SELECT rownum, b.*
	FROM ( SELECT * 
					 FROM book
			 ORDER BY price DESC) b 	 
 WHERE rownum <= 3; 

SELECT rownum r2, b.*
	FROM ( SELECT rownum r2, b1.*
					 FROM book b1
			 ORDER BY price DESC) b; 


SELECT orderid, saleprice
	FROM ORDERS
 WHERE saleprice > ALL (SELECT saleprice
 													FROM ORDERS
 												 WHERE custid = 3); 

SELECT orderid, saleprice
	FROM ORDERS
 WHERE saleprice > ( SELECT max(saleprice)
 											 FROM ORDERS
 											WHERE custid = 3); 

SELECT orderid, saleprice
	FROM ORDERS
 WHERE saleprice > SOME (SELECT saleprice 
 													 FROM ORDERS
 												  WHERE custid = 3); 

SELECT orderid, saleprice
	FROM ORDERS
 WHERE saleprice > ( SELECT min(saleprice) 
 											 FROM ORDERS
 										  WHERE custid = 3); 


	SELECT (SELECT name 
						FROM customer c 
					 WHERE c.custid = o.custid) "고객 이름", 
				 sum(saleprice) "판매 총액"
		FROM orders o 
GROUP BY custid;

	SELECT c.name, sum(saleprice)
		FROM orders o INNER JOIN customer c ON o.custid = c.custid
GROUP BY o.custid, c.name;


-- 컬럼 추가
ALTER TABLE orders ADD bookname varchar2(40);

SELECT * FROM orders;

UPDATE orders o
	 SET bookname = ( SELECT bookname
	 										FROM book b
	 									 WHERE b.bookid = o.bookid);

ROLLBACK;

--컬럼 삭제
ALTER TABLE orders DROP COLUMN bookname;

--none ansi
SELECT t1.name, sum(t2.saleprice) "total"
	FROM ( SELECT custid, name 
					 FROM CUSTOMER 
					WHERE custid <= 2) t1,
			   orders t2
WHERE t1.custid = t2.custid
GROUP BY t1.name;

--ansi
SELECT t1.name, sum(t2.saleprice) "total"
	FROM ( SELECT custid, name 
					 FROM CUSTOMER 
					WHERE custid <= 2) t1
			  INNER JOIN  orders t2 ON t1.custid = t2.custid 
GROUP BY t1.name;




CREATE VIEW vandors AS
SELECT o.orderid, c.name, b.bookname, b.price, o.saleprice, o.orderdate 
	FROM ORDERS o INNER JOIN CUSTOMER c ON o.custid = c.custid
								INNER JOIN book b			ON o.bookid = b.bookid;

SELECT sum(saleprice)
	FROM vandors; 

	SELECT name, sum(saleprice)
		FROM vandors
GROUP BY name
ORDER BY sum(saleprice) DESC;

-- 뷰 생성
CREATE VIEW vw_customer
AS SELECT *
		 FROM customer
		WHERE address LIKE '%대한민국%';


CREATE VIEW vw_customer ("c","n","a","p")
AS SELECT *
		 FROM customer
		WHERE address LIKE '%대한민국%';

SELECT *
	FROM VW_CUSTOMER;

-- 뷰 삭제
DROP VIEW vw_customer;

CREATE VIEW vw_orders
AS SELECT o.ORDERID, c.name, b.bookname, o.saleprice  
	FROM orders o INNER JOIN CUSTOMER c ON c.CUSTID = o.CUSTID
								INNER JOIN BOOK b  ON  o.bookid = b.bookid; 

SELECT orderid, bookname, saleprice
	FROM vw_orders
 WHERE name = '김연아';


CREATE OR REPLACE VIEW vw_customer ("c", "n", "a")
AS SELECT	custid, name, address
		 FROM customer
		WHERE address LIKE '%영국%';

SELECT *
	FROM vw_customer;



--8. 마당서점 데이터베이스를 이용해 다음에 해당하는 뷰를 작성하시오.
--(1) 판매가격이 20,000원 이상인 도서의 도서번호, 도서이름, 고객이름, 출판사, 판매가격을
--보여주는 highorders 뷰를 생성하시오.

CREATE VIEW highorders 
AS SELECT b.BOOKID, b.BOOKNAME, c.NAME, b.PUBLISHER, o.SALEPRICE
	FROM CUSTOMER c INNER JOIN ORDERS o ON c.CUSTID = o.CUSTID
									INNER JOIN BOOK b 	ON b.BOOKID	= o.BOOKID
 WHERE o.saleprice >= 20000;


--(2) 생성한 뷰를 이용하여 판매된 도서의 이름과 고객의 이름을 출력하는 SQL 문을 작성하시오.

SELECT bookname, name
	FROM highorders;


--(3) highorders 뷰를 변경하고자 한다. 판매가격 속성을 삭제하는 명령을 수행하시오.

CREATE OR REPLACE VIEW highorders 
AS SELECT b.BOOKID, b.BOOKNAME, c.NAME, b.PUBLISHER
	FROM CUSTOMER c INNER JOIN ORDERS o ON c.CUSTID = o.CUSTID
									INNER JOIN BOOK b 	ON b.BOOKID	= o.BOOKID
 WHERE o.saleprice >= 20000;

SELECT bookname, name
	FROM highorders;

--삭제 후 (2)번 SQL 문을 다시 수행하시오.

DROP VIEW HIGHORDERS; 

SELECT bookname, name
	FROM highorders;
