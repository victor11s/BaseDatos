/*11.Cuál es el margen de beneficio porcentual promedio del MSRP en buyPrice, con duda*/
DELIMITER //
CREATE PROCEDURE margenBeneficio()
BEGIN
SELECT AVG((MSRP - buyPrice) / MSRP) AS 'Margen de beneficio'
FROM products;
END //
DELIMITER ;
/*Llamarlo*/
CALL margenBeneficio();

/*12.Cuántos productos distintos vende classicmodels, con duda*/
DELIMITER //
CREATE PROCEDURE productoClassic()
BEGIN
SELECT COUNT(DISTINCT productCode) AS 'Total de productos'
FROM products;
END //
DELIMITER ;
/*Llamarlo*/
CALL productoClassic();

/*13.Muestre el nombre y la ciudad de los clientes que no tienen representantes de ventas.*/
DELIMITER //
CREATE PROCEDURE compradoresSNRepresentante()
BEGIN
SELECT customerName, city
FROM customers
WHERE salesRepEmployeeNumber IS NULL;
END //
DELIMITER ;
/*Llamarlo*/
CALL compradoresSNRepresentante();

/*14.¿Cuáles son los nombres de los ejecutivos con VP o Gerente en su cargo? Usar la función CONCAT para combinar el nombre y apellido del empleado en un solo campo para informar*/
DELIMITER //
CREATE PROCEDURE employeesWithVPorManager()
BEGIN
SELECT CONCAT(firstName, ' ', lastName) AS 'Nombre completo', jobTitle
FROM employees
WHERE jobTitle LIKE '%VP%' OR jobTitle LIKE '%Manager%';
END //
DELIMITER ;
/*Llamarlo*/
CALL employeesWithVPorManager();

/*15.Qué pedidos tienen un valor superior a $ 5,000, usar stored procedure in */
DELIMITER //
CREATE PROCEDURE ordenesMayoresDeDinero(
IN monto DECIMAL(10,2)
)
BEGIN
SELECT orderNumber, orderDate
FROM orders, customers, payments
WHERE orders.customerNumber = customers.customerNumber and payments.customerNumber = customers.customerNumber and payments.amount > monto;
END //
DELIMITER ;
/*Llamarlo*/
CALL ordenesMayoresDeDinero(5000);

/*16.Listar todos los productos comprados por Herkku Gifts.---DA ERROR NO ME TRAE A NADIE*/
DELIMITER //
CREATE PROCEDURE productosCompradosPor(
IN customerName VARCHAR(50)
)
BEGIN
SELECT productName, customerName
FROM products, customers, orders, orderdetails
WHERE customers.customerName = orders.customerNumber and orders.orderNumber = orderdetails.orderNumber and orderdetails.productCode = products.productCode and customers.customerName = customerName;
END //
DELIMITER ;
/*Llamarlo*/
CALL productosCompradosPor('Herkku Gifts');

/*17.Mostrar el numero y nombre del representante, es decir el SalesRepEmployeenumber de cuenta de cada uno de los cliente y tambien mostrar el nombre del cliente*/
DELIMITER //
CREATE PROCEDURE numeroNombreRepresentante()
BEGIN
SELECT customers.customerName AS 'Nombre Cliente', employees.employeeNumber AS 'Numero Representante', CONCAT(employees.firstName, ' ', employees.lastName) AS 'Nombre Representante'
FROM customers, employees
WHERE customers.salesRepEmployeeNumber = employees.employeeNumber;
END //
DELIMITER ;
/*Llamarlo*/
CALL numeroNombreRepresentante();


/*18.Muestre la lista de pagos totales de Atelier graphique.*/
DELIMITER //
CREATE PROCEDURE pagosTotalesDe(
IN customerName VARCHAR(50)
)
BEGIN
SELECT SUM(amount) AS 'Total de pagos'
FROM payments, customers
WHERE payments.customerNumber = customers.customerNumber and customers.customerName = customerName;
END //
DELIMITER ;
/*Llamarlo*/
CALL pagosTotalesDe('Atelier graphique');


/*19.Muestre los pagos totales en cada fecha que se haya realizo una venta DUDA DE SI ES POR CADA FECHA LISTAR LOS PAGOS*/
DELIMITER //
CREATE PROCEDURE pagosTotalesPorCadaFecha()
BEGIN
SELECT paymentDate, SUM(amount) AS 'Total de pagos'
FROM payments
GROUP BY paymentDate;
END //
DELIMITER ;
/*Llamarlo*/
CALL pagosTotalesPorCadaFecha();

/*20.Mostrar los productos que no han sido vendidos usando OUT  de salida.*/
DELIMITER //
CREATE PROCEDURE productosNoVendidos()
BEGIN
SELECT productName
FROM products
WHERE productCode NOT IN (SELECT productCode FROM orderdetails);
END //
DELIMITER ;
/*Llamarlo*/
CALL productosNoVendidos();
