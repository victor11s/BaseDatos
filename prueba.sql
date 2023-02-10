/*1.Prepare una lista de oficinas ordenadas por país, estado, ciudad*/
DELIMETER //
CREATE PROCEDURE officesList()
BEGIN
SELECT country, state, city, officeCode
FROM offices
ORDER BY country, state, city;
END //
DELIMETER ;
/*2.Cuantos empleados hay en la empresa.*/
DELIMETER //
CREATE PROCEDURE employeesCount()
BEGIN
SELECT COUNT(*) AS 'Total de empleados'
FROM employees;
END //
DELIMETER ;
/*3.Cual es el total de pagos recibidos*/
DELIMETER //
CREATE PROCEDURE paymentsTotal()
BEGIN
SELECT SUM(amount) AS 'Total de pagos'
FROM payments;
END //  
DELIMETER ;
/*4.Enumere las lineas de productos que contienen automoviles*/
DELIMETER //
CREATE PROCEDURE carsList()
BEGIN
SELECT productLine, textDescription
FROM productlines
WHERE textDescription LIKE '%car%';
END //
DELIMETER ;
/*5.Informar pagos totales al 28 de octubre de 2004*/
DELIMETER //
CREATE PROCEDURE paymentsTotalByDate(
IN paymentDate DATE
)
BEGIN
SELECT SUM(amount) AS 'Total de pagos'
FROM payments
WHERE paymentDate = paymentDate;
END //  
DELIMETER ;
/*6.Reporte de aquellos pagos mayores a 100000*/
DELIMETER //
CREATE PROCEDURE paymentsGreaterThan(
IN paymentAmount DECIMAL(10,2)
)
BEGIN
SELECT customerNumber, checkNumber, amount
FROM payments
WHERE amount > paymentAmount;
END //
DELIMETER ;
/*7.Enumere los productos de cada linea de productos*/
DELIMETER //
CREATE PROCEDURE productsList()
BEGIN
SELECT productLine, productName
FROM products
ORDER BY productLine;
END //
DELIMETER ;
/*8.Cuantos productos en cada linea de productos*/
DELIMETER //
CREATE PROCEDURE productsCount()
BEGIN
SELECT productLine, COUNT(*) AS 'Total de productos'
FROM products
GROUP BY productLine;
END //
DELIMETER ;
/*9.Cual es el pago minimo recibido*/
DELIMETER //
CREATE PROCEDURE paymentsMin()
BEGIN
SELECT MIN(amount) AS 'Pago minimo'
FROM payments;
END //
DELIMETER ;
/*10.Enumere todos los pagos mayores que el doble de la cantidad promedio*/
DELIMETER //
CREATE PROCEDURE paymentsGreaterThanAverage()
BEGIN
SELECT customerNumber, checkNumber, amount
FROM payments
WHERE amount > (SELECT AVG(amount) FROM payments) * 2;
END //
DELIMETER ;
/*11.Cuál es el margen de beneficio porcentual promedio del MSRP en buyPrice, con duda*/
DELIMETER //
CREATE PROCEDURE profitMargin()
BEGIN
SELECT AVG((MSRP - buyPrice) / MSRP) AS 'Margen de beneficio'
FROM products;
END //
DELIMETER ;
/*12.Cuántos productos distintos vende classicmodels, con duda*/
DELIMETER //
CREATE PROCEDURE productsCount()
BEGIN
SELECT COUNT(DISTINCT productCode) AS 'Total de productos'
FROM products;
END //
DELIMETER ;
/*13.Muestre el nombre y la ciudad de los clientes que no tienen representantes de ventas.*/
DELIMETER //
CREATE PROCEDURE customersWithoutSalesRep()
BEGIN
SELECT customerName, city
FROM customers
WHERE salesRepEmployeeNumber IS NULL;
END //
DELIMETER ;
/*14.¿Cuáles son los nombres de los ejecutivos con VP o Gerente en su cargo? Usar la función CONCAT para combinar el nombre y apellido del empleado en un solo campo para informar*/
DELIMETER //
CREATE PROCEDURE employeesWithVPorManager()
BEGIN
SELECT CONCAT(firstName, ' ', lastName) AS 'Nombre completo', jobTitle
FROM employees
WHERE jobTitle LIKE '%VP%' OR jobTitle LIKE '%Manager%';
END //
DELIMETER ;
/*15.Qué pedidos tienen un valor superior a $ 5,000, usar stored procedure in */
DELIMETER //
CREATE PROCEDURE ordersGreaterThan(
IN monto DECIMAL(10,2)
)
BEGIN
SELECT orderNumber, orderDate, status, comments
FROM orders
WHERE orderAmount > monto;
END //
DELIMETER ;
/*16.Listar todos los productos comprados por Herkku Gifts.*/
DELIMETER //
CREATE PROCEDURE productsBoughtBy(
IN customerName VARCHAR(50)
)
BEGIN
SELECT productName
FROM products, customers, orders, orderdetails
WHERE customers.customerName = orders.customerNumber and orders.orderNumber = orderdetails.orderNumber and orderdetails.productCode = products.productCode and customers.customerName = customerName;
END //
DELIMETER ;
/*17.Mostrar el numero del representante de cuenta de cada cliente*/
DELIMETER //
CREATE PROCEDURE salesRepOfCustomers()
BEGIN
SELECT customerName, CONCAT(firstName, ' ', lastName) AS 'Nombre completo'
FROM customers, employees
WHERE customers.salesRepEmployeeNumber = employees.employeeNumber;
END //
DELIMETER ;
/*18.Muestre la lista de pagos totales de Atelier graphique.*/
DELIMETER //
CREATE PROCEDURE paymentsTotalByCustomer(
IN customerName VARCHAR(50)
)
BEGIN
SELECT SUM(amount) AS 'Total de pagos'
FROM payments, customers
WHERE payments.customerNumber = customers.customerNumber and customers.customerName = customerName;
END //
DELIMETER ;
/*19.Muestre los pagos totales por fecha*/
DELIMETER //
CREATE PROCEDURE paymentsTotalByDate()
BEGIN
SELECT paymentDate, SUM(amount) AS 'Total de pagos'
FROM payments
GROUP BY paymentDate;
END //
DELIMETER ;
/*20.Mostrar los productos que no han sido vendidos.*/
DELIMETER //
CREATE PROCEDURE productsNotSold()
BEGIN
SELECT productName
FROM products
WHERE productCode NOT IN (SELECT productCode FROM orderdetails);
END //
DELIMETER ;




