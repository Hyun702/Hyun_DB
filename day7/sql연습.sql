

SELECT bookname, publisher, concat(concat(PUBLISHER ,'-'),bookname)
	FROM book;

SELECT bookname, publisher, publisher || '-' || bookname 
	FROM book;

	SELECT *
		FROM book
ORDER BY price;

	SELECT *
		FROM book
ORDER BY 4;


	SELECT rownum, b.*
		FROM book b
-- WHERE rownum <= 3
ORDER BY b.PRICE; 	
	
-- 도서 테이블에서 도서 가격이 제일 비싼 도서명을 보이시오. (단, rownum사용)

--case1 ) rownum 사용
SELECT rownum r2, t1.*
	FROM (SELECT rownum r1, b.*
					FROM book b
			ORDER BY b.PRICE DESC ) t1
 WHERE rownum <= 1 ;

--case 2 ) max 사용
SELECT *
	FROM book
 WHERE price = (SELECT max(price)
								  FROM book );

--case 3) fetch 절 사용
	SELECT *
		FROM book b
ORDER BY b.price DESC
FETCH FIRST 1 ROWS ONLY ; 

--기타 ) offset fetch 사용					ex ) 처음 2행 건너띄고 3행 가져오기
	SELECT *
		FROM book b
ORDER BY b.price DESC
offset 2 ROWS FETCH NEXT 3 ROWS ONLY ; 
