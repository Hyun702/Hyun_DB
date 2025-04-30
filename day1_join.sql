SELECT *
	FROM customer, orders
 WHERE customer.custid = orders.custid;	

SELECT *
	FROM customer, orders
 WHERE customer.custid = orders.custid
 ORDER BY customer.custid;

SELECT name, saleprice 
	FROM CUSTOMER, orders
	WHERE customer.custid = orders.custid ;

SELECT name ,sum(saleprice)
	FROM customer, orders
 WHERE customer.custid = orders.custid
GROUP BY customer.name
ORDER BY customer.name;