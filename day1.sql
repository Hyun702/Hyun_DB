SELECT bookname, price 
FROM book;

SELECT price, bookname
FROM book;

SELECT bookid, bookname, publisher, price
FROM book;

SELECT *
FROM book;

SELECT publisher
FROM book;

SELECT DISTINCT publisher
FROM book;

SELECT *
FROM book
WHERE price < 20000;

SELECT *
FROM book
WHERE price BETWEEN 10000 AND 20000; 

SELECT *
FROM BOOK
WHERE price >= 10000 AND price <= 20000;

SELECT *
FROM book
WHERE publisher IN ('굿스포츠', '대한미디어');

SELECT * 
FROM book
WHERE publisher NOT IN ('굿스포츠', '대한미디어');

SELECT bookname,publisher
FROM BOOK
WHERE bookname LIKE '축구의 역사';

SELECT bookname, publisher
FROM book
WHERE bookname LIKE '%축구%';

SELECT *
FROM BOOK
WHERE bookname LIKE '_구%';

SELECT *
FROM book
WHERE bookname LIKE '%축구%' AND price >= 20000;

SELECT *
FROM book
WHERE publisher = '굿스포츠' OR publisher = '대한미디어';

SELECT *
FROM book
ORDER BY bookname;					

SELECT *
FROM book
ORDER BY price, bookname;

SELECT *
FROM book 
ORDER BY price DESC , publisher ASC;

SELECT sum(saleprice) AS 총매출
FROM orders;

SELECT sum(saleprice) AS 총매출
FROM orders
WHERE custid=2;

SELECT sum(saleprice) AS Total,
	   avg(saleprice) AS Average,
	   min(saleprice) AS Minimum,
	   max(saleprice) AS Maximum
FROM   orders;

SELECT count(*)
FROM   orders;

-- 고객별 도서 수량, 판매총액
  SELECT custid, count(*) "도서수량", sum(saleprice) "총액"
    FROM orders
GROUP BY custid; 

-- 도서별 판매 총액
  SELECT BOOKID "도서" , sum(saleprice) "총액"
    FROM orders
GROUP BY bookid;

-- 도서별 판매 총액을 내림차순
  SELECT BOOKID "도서" , sum(saleprice) "판매총액"
    FROM orders
GROUP BY bookid
ORDER BY sum(saleprice) DESC;

SELECT * FROM book;

  SELECT publisher, sum(price)
    FROM book
GROUP BY publisher;  

-- group by 절과 함께 사용될때,
-- select절에는 group by절에 나열된 컬럼 또는 집계함수만 올 수 있다.
  SELECT sum(price)
    FROM book
GROUP BY publisher

