/*1.Prepare una lista de oficinas ordenadas por país, estado, ciudad*/
DELIMITER //
CREATE PROCEDURE officesList()
BEGIN
SELECT country, state, city, officeCode
FROM offices
ORDER BY country, state, city;
END //
DELIMITER ;
/*Llamarlo*/
CALL officesList();

/*2.Cuantos empleados hay en la empresa.*/
DELIMITER //
CREATE PROCEDURE employeesCount()
BEGIN
SELECT COUNT(*) AS 'Total de empleados'
FROM employees;
END //
DELIMITER ;
/*Llamarlo*/
CALL employeesCount();

/*3.Cual es el total de pagos recibidos*/
DELIMITER //
CREATE PROCEDURE pagosTotal()
BEGIN
SELECT SUM(amount) AS 'Total de pagos'
FROM payments;
END //  
DELIMITER ;
/*Llamarlo*/
CALL pagosTotal();

/*4.Enumere las lineas de productos que contienen automoviles*/
DELIMITER //
CREATE PROCEDURE carroList()
BEGIN
SELECT productLine
FROM productlines
WHERE textDescription LIKE '%car%';
END //
DELIMITER ;
/*Llamarlo*/
CALL carroList();

/*5.Informar pagos totales al 28 de octubre de 2004, es decir hasta esa fecha cuanto se ha pagado*/
DELIMITER //
CREATE PROCEDURE pagosHastaFecha(
IN fecha DATE
)
BEGIN
SELECT SUM(amount) AS 'Total de pagos'
FROM payments
WHERE paymentDate <= fecha;
END //
DELIMITER ;
/*Llamarlo*/
CALL pagosHastaFecha('2004-10-28');


/*6.Reporte de aquellos pagos mayores a 100000*/
DELIMITER //
CREATE PROCEDURE pagosMayoresque(
IN paymentAmount DECIMAL(10,2)
)
BEGIN
SELECT customerNumber, checkNumber, amount
FROM payments
WHERE amount > paymentAmount;
END //
DELIMITER ;
/*Llamarlo*/
CALL pagosMayoresque(100000);

/*7.Enumere los productos de cada linea de productos*/
DELIMITER //
CREATE PROCEDURE listaProductosLinea()
BEGIN
SELECT productLine, productName
FROM products
ORDER BY productLine;
END //
DELIMITER ;
/*Llamarlo*/
CALL listaProductosLinea();


/*8.Cuantos productos en cada linea de productos*/
DELIMITER //
CREATE PROCEDURE productosCuenta()
BEGIN
SELECT productLine, COUNT(*) AS 'Total de productos'
FROM products
GROUP BY productLine;
END //
DELIMITER ;
/*Llamarlo*/
CALL productosCuenta();

/*9.Cual es el pago minimo recibido*/
DELIMITER //
CREATE PROCEDURE paymentsMin()
BEGIN
SELECT MIN(amount) AS 'Pago minimo'
FROM payments;
END //
DELIMITER ;
/*Llamarlo*/
CALL paymentsMin();

/*10.Enumere todos los pagos mayores que el doble de la cantidad promedio*/
DELIMITER //
CREATE PROCEDURE pagosMayoresPromedio()
BEGIN
SELECT customerNumber, checkNumber, amount
FROM payments
WHERE amount > (SELECT AVG(amount) FROM payments) * 2;
END //
DELIMITER ;
/*Llamarlo*/
CALL pagosMayoresPromedio();

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
CREATE PROCEDURE productoClassic()
BEGIN
SELECT COUNT(DISTINCT productCode) AS 'Total de productos'
FROM products;
END //
DELIMETER ;
/*Llamarlo*/
CALL productoClassic();

/*13.Muestre el nombre y la ciudad de los clientes que no tienen representantes de ventas.*/
DELIMETER //
CREATE PROCEDURE compradoresSNRepresentante()
BEGIN
SELECT customerName, city
FROM customers
WHERE salesRepEmployeeNumber IS NULL;
END //
DELIMETER ;
/*Llamarlo*/
CALL compradoresSNRepresentante();

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
CREATE PROCEDURE ordenesMayoresA(
IN monto DECIMAL(10,2)
)
BEGIN
SELECT orderNumber, orderDate, status, comments
FROM orders
WHERE orderAmount > monto;
END //
DELIMETER ;
/*Llamarlo*/
CALL ordenesMayoresA(5000);

/*16.Listar todos los productos comprados por Herkku Gifts.*/
DELIMETER //
CREATE PROCEDURE productosCompradosPor(
IN customerName VARCHAR(50)
)
BEGIN
SELECT productName
FROM products, customers, orders, orderdetails
WHERE customers.customerName = orders.customerNumber and orders.orderNumber = orderdetails.orderNumber and orderdetails.productCode = products.productCode and customers.customerName = customerName;
END //
DELIMETER ;
/*Llamarlo*/
CALL productosCompradosPor('Herkku Gifts');

/*17.Mostrar el numero del representante, es decir el SalesRepEmployeenumber de cuenta de cada cliente*/


/*18.Muestre la lista de pagos totales de Atelier graphique.*/
DELIMETER //
CREATE PROCEDURE pagosTotalesDe(
IN customerName VARCHAR(50)
)
BEGIN
SELECT SUM(amount) AS 'Total de pagos'
FROM payments, customers
WHERE payments.customerNumber = customers.customerNumber and customers.customerName = customerName;
END //
DELIMETER ;
/*Llamarlo*/
CALL pagosTotalesDe('Atelier graphique');


/*19.Muestre los pagos totales por fecha, con in de stored procedure*/
DELIMETER //
CREATE PROCEDURE pagosTotalesPorFecha(
IN paymentDate DATE
)
BEGIN
SELECT SUM(amount) AS 'Total de pagos'
FROM payments
WHERE paymentDate = paymentDate;
END //
DELIMETER ;
/*Llamarlo*/
CALL pagosTotalesPorFecha('2004-10-28');


/*20.Mostrar los productos que no han sido vendidos.*/
DELIMETER //
CREATE PROCEDURE productosNoVendidos()
BEGIN
SELECT productName
FROM products
WHERE productCode NOT IN (SELECT productCode FROM orderdetails);
END //
DELIMETER ;
/*Llamarlo*/
CALL productosNoVendidos();




/*26. Liste los productos que terminan en 'barco'.*/
DELIMITER //
CREATE PROCEDURE productosBarco()
BEGIN
SELECT productName
FROM products
WHERE productName LIKE '%boat%';
END //
DELIMITER ;
/*Llamarlo*/
CALL productosBarco();
/**/
DELIMITER $$
CREATE PROCEDURE Paginador(
INOUT contador INT,
IN incremento INT) #lo que le voy a incrementar
BEGIN
SET contador=contador+incremento;
END $$
DELIMITER ;
CALL Paginador(@contador,1);
SELECT @contador;
