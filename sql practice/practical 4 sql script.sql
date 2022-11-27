SHOW DATABASES;
USE classicmodels;
show tables;
#see employees 
SELECT E.employeeNumber, C.customerNumber
FROM employees E, customers C
WHERE E.employeeNumber = C.salesRepEmployeeNumber;
#Using employees and customers, find the number of customers managed by each employee number, sorted from the largest to smallest value.
SELECT E.employeeNumber, C.customerNumber, COUNT(*)
FROM employees E, customers C
WHERE E.employeeNumber = C.salesRepEmployeeNumber
GROUP BY employeeNumber 
ORDER BY  COUNT(*) DESC;

#Using customers and orders, find the customer name and the number of orders each customer places, sorted by the number of orders from largest to smallest
SELECT C.customerNumber, count(O.orderNumber)
FROM customers C, orders O
WHERE C.customerNumber = O.customerNumber
GROUP BY C.customerNumber
ORDER BY count(O.orderNumber) DESC;
#Using customers and payments, find the customer name and the amount that each customer pays, sorted by the payment amount from largest to smallest value.
SELECT N.customerName,D.customerNumber,A.amount
FROM customers N,customers D,payments A
WHERE D.customerNumber = A.customerNumber
ORDER BY amount DESC;
#Using customers, orders and orderDetails, find the customer name, 
#the order number and for each order, the quantity ordered and price each.
SELECT 
customerName,orders.orderNumber,quantityOrdered,priceEach
FROM orderdetails 
LEFT JOIN orders ON orderdetails.orderNumber = orders.orderNumber
LEFT JOIN customers ON Orders.customerNumber = customers.customerNumber;
#q5 Using customers, orders and orderDetails,
# find the customer name and the total quantity ordered for each customer,
# sorted by the order amount from largest to smallest.
SELECT customerName,orders.orderNumber,sum(quantityOrdered),priceEach
FROM orderdetails 
LEFT JOIN orders ON orderdetails.orderNumber = orders.orderNumber
LEFT JOIN customers ON Orders.customerNumber = customers.customerNumber
GROUP BY orderNumber;
#Using customers, orders and orderDetails, 
#find the customer name and the total amount (currency value) spent by each customer,
# sorted by the order amount, from largest to smallest.
SELECT customerName,orders.orderNumber,SUM(quantityOrdered),SUM(priceEach)
FROM orderdetails 
LEFT JOIN orders ON orderdetails.orderNumber = orders.orderNumber
LEFT JOIN customers ON Orders.customerNumber = customers.customerNumber
GROUP BY orderNumber 
ORDER BY SUM(priceEach) DESC;
#Using orderDetails and products, find the product name,
#order number and quantity ordered for the product.
SELECT productname, orderNumber, quantityOrdered
FROM products 
LEFT JOIN orderdetails ON products.productCode = orderdetails.productCode;
#Using orderDetails and products, 
#find the product name and the total quantity ordered for the product,
# sorted from largest to smallest quantity.
SELECT productname, orderNumber, sum(quantityOrdered)
FROM products 
LEFT JOIN orderdetails ON products.productCode = orderdetails.productCode
GROUP BY productnam

order by sum(quantityOrdered) DESC



