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
CREATE PROCEDURE totalPagosRecibidos()
BEGIN
	SELECT SUM(amount) AS 'Total Pagos Recibidos' FROM payments;
END //
DELIMITER ;

CALL totalPagosRecibidos();

/*4.Enumere las lineas de productos que contienen automoviles*/
DELIMITER //
CREATE PROCEDURE enumeraLProducto()
BEGIN
  	SELECT ROW_NUMBER() OVER(ORDER BY productLine) AS 'Lista', productLine FROM productlines
	WHERE productline LIKE '%CARS%';
END //
DELIMITER ;

CALL enumeraLProducto();
/*5.Informar pagos totales al 28 de octubre de 2004, es decir hasta esa fecha cuanto se ha pagado*/
DELIMITER //
CREATE PROCEDURE pagosTotalesAl(
	IN diaLimite VARCHAR(35))
BEGIN
	SELECT sum(amount) as 'Total' FROM payments
	WHERE paymentDate <= diaLimite;
END //
DELIMITER ;

CALL pagosTotalesAl('2004-10-28');

/*6.Reporte de aquellos pagos mayores a 100000*/
DELIMITER //
CREATE PROCEDURE pagosMayoresA(
	IN cantidad INT)
BEGIN
	SELECT * FROM payments WHERE amount > cantidad;
END //
DELIMITER ;

CALL pagosMayoresA(100000);

/*7.Enumere los productos de cada linea de productos*/
DELIMITER //
CREATE PROCEDURE enumeraProductosXLinea()
BEGIN
	SELECT ROW_NUMBER() OVER(PARTITION BY productLine ORDER BY productName) AS '#Producto',productLine,productName FROM products;
END //
DELIMITER ;

CALL enumeraProductosXLinea();

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
CREATE PROCEDURE doblePromedio()
BEGIN
	SELECT ROW_NUMBER() OVER(ORDER BY amount) AS 'Fila',amount FROM payments WHERE amount > (2*(SELECT AVG(amount) FROM payments));
END //
DELIMITER ;

CALL doblePromedio();

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

/*12.Cuántos productos distintos vende classicmodels, lo cambie parea usar out*/
DELIMITER //
CREATE PROCEDURE productoClassicM(
    IN vendor VARCHAR(100)
)
BEGIN 
SELECT COUNT(DISTINCT productCode) AS 'TOTAL DE PRODUCTOS'
FROM products
WHERE productVendor = vendor;
END //
DELIMITER ;
CALL productoClassicM('Classic Metal Creations');

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

/*15.Qué pedidos tienen un valor superior a $ 5,000 */
DELIMITER //
CREATE PROCEDURE ordenesMayoresDeDineroQue(
IN monto DECIMAL(10,2)
)
BEGIN
SELECT orderNumber, orderDate
FROM orders, customers, payments
WHERE orders.customerNumber = customers.customerNumber and payments.customerNumber = customers.customerNumber and payments.amount > monto
GROUP BY orderNumber;
END //
DELIMITER ;
/*Llamarlo*/
CALL ordenesMayoresDeDineroQue(5000);

/*16.Listar todos los productos comprados por Herkku Gifts.---DA ERROR NO ME TRAE A NADIE*/
DELIMITER //
CREATE PROCEDURE productosCompradosPor(
	IN comprador VARCHAR(100))
BEGIN
	SELECT orderdetails.orderNumber, orderdetails.productCode, products.productName, quantityOrdered, priceEach,(quantityOrdered*priceEach) AS 'Total'
	FROM customers NATURAL JOIN orders NATURAL JOIN orderdetails NATURAL JOIN products
	WHERE customerName = comprador AND orderdetails.productCode = products.productCode;
END //
DELIMITER ;

CALL productosCompradosPor('Herkku Gifts');

/*17.Mostrar el numero y nombre del representante, es decir el SalesRepEmployeenumber de cuenta de cada uno de los cliente y tambien mostrar el nombre del cliente*/
DELIMITER //
CREATE PROCEDURE numeroNombreRepresentante()
BEGIN
SELECT customers.customerName AS 'Nombre Cliente', employees.employeeNumber AS 'Numero Representante', CONCAT(employees.firstName, ' ', employees.lastName) AS 'Nombre Representante'
FROM customers, employees
WHERE customers.salesRepEmployeeNumber = employees.employeeNumber
ORDER BY customerName;
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


/*19.Muestre los pagos totales en cada fecha que se haya realizo una venta */
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

/*20.Mostrar los productos que no han sido vendidos.*/
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

/*21. Indique el monto pagado por cada cliente.*/

DELIMITER //
DELIMITER //
CREATE PROCEDURE montoPagadoCliente()
BEGIN
	SELECT payments.customerNumber,customerName,SUM(amount) AS 'Monto Pagado' 
	FROM customers NATURAL JOIN payments GROUP BY payments.customerNumber;
END //
DELIMITER ;

CALL montoPagadoCliente();

/*22.Listar el número de pedidos 'En espera' de cada cliente.*/
DELIMITER //
CREATE PROCEDURE listarNumPedidosEn(
	IN estatus VARCHAR(50))
BEGIN
	SELECT customerName,COUNT(*) AS '# En Estatus' FROM customers NATURAL JOIN orders
	WHERE status = estatus
	GROUP BY customerName;
END //
DELIMITER ;

CALL listarNumPedidosEn('Shipped');


/*23.Liste los productos pedidos un lunes.*/
DELIMITER //
CREATE PROCEDURE productosPedidosUn(
	IN diaSemana VARCHAR(30))
BEGIN
	SELECT DISTINCT productName
	FROM products, orders, orderdetails
	WHERE products.productCode = orderdetails.productCode and orderdetails.orderNumber = orders.orderNumber and DAYNAME(orderDate) = diaSemana;
END //
DELIMITER ;


/*24.*/

/*25.Busque productos que contengan el nombre 'Ford'*/
DELIMITER //
CREATE PROCEDURE buscaProductosFord()
BEGIN
	SELECT productName FROM products WHERE productName LIKE '%Ford%';
END//
DELIMITER ;
/*Llamarlo*/
CALL buscaProductosFord();

/*26.Liste los productos que terminan en 'barco'*/
DELIMITER //
CREATE PROCEDURE terminaEnBarco()
BEGIN
	SELECT productName FROM products WHERE productName LIKE '%boat';
END //
DELIMITER ;
/*Llamarlo*/
CALL terminaEnBarco();

/*27.Muestre el número de clientes en Dinamarca, Noruega y Suecia.*/
DELIMITER //
CREATE PROCEDURE numClientes3Paises(
	IN pais1 VARCHAR(50),
	IN pais2 VARCHAR(50),
	IN pais3 VARCHAR(50))
BEGIN
	SELECT country,COUNT(*) AS 'Num Empleados' FROM customers WHERE country = pais1;
	SELECT country,COUNT(*) AS 'Num Empleados' FROM customers WHERE country = pais2;	
	SELECT country,COUNT(*) AS 'Num Empleados' FROM customers WHERE country = pais3;
END //
DELIMITER ;
/*Llamarlo*/
CALL numClientes3Paises('Denmark','Norway','Sweden');

/*28.¿Cuáles son los productos con un código de producto en el rango S700_1000 a S700_1499*/
DELIMITER //
CREATE PROCEDURE productosEnRango(
	IN lInferior INT,
	IN lSuperior INT)
BEGIN
	SELECT productName,productCode FROM products 
	WHERE productCode LIKE 'S700%' AND substr(productCode,6) > lInferior AND substr(productCode,6) < lSuperior;
END //
DELIMITER ;
/*Llamarlo*/
CALL productosEnRango(1000,1499);



/*29.¿Qué clientes tienen un dígito en su nombre?*/
DELIMITER //
CREATE PROCEDURE clientesConDigitoEn(
IN nombre VARCHAR(50)
)
BEGIN
SELECT customerName
FROM customers
WHERE customerName LIKE CONCAT('%', nombre, '%');
END //
DELIMITER ;
/*Llamarlo*/
CALL clientesConDigitoEn('4');

/*30.Liste los nombres y apellidos de los empleados llamados */
DELIMITER //
CREATE PROCEDURE empleadosConNombre(
IN nombre VARCHAR(50)
)
BEGIN
SELECT firstName, lastName
FROM employees
WHERE firstName = nombre ;
END //
DELIMITER ;
/*Llamarlo*/
CALL empleadosConNombre('Diane');
/*31.Liste los productos que contengan cierta palabra en su nombre de producto .*/
DELIMITER //
CREATE PROCEDURE productosConPalabra(
IN palabra VARCHAR(50)
)
BEGIN
SELECT productName
FROM products
WHERE productName LIKE CONCAT('%', palabra, '%');
END //
DELIMITER ;
/*Llamarlo*/
CALL productosConPalabra('Classic');

/*32.Liste los productos con un código de producto que comience con S700*/
DELIMITER //
CREATE PROCEDURE productosConCodigo2(
IN codigo VARCHAR(50)
)
BEGIN
SELECT productName, productCode
FROM products
WHERE productCode LIKE CONCAT(codigo, '%');
END //
DELIMITER ;
/*Llamarlo*/
CALL productosConCodigo2('S700');

/*33.Liste los nombres de los empleados llamados Larry o Barry.*/
DELIMITER //
CREATE PROCEDURE empleadosConNombre2(
IN nombre VARCHAR(50),
IN nombre2 VARCHAR(50)
)
BEGIN
SELECT firstName, lastName
FROM employees
WHERE firstName = nombre OR firstName = nombre2;
END //
DELIMITER ;
/*Llamarlo*/
CALL empleadosConNombre2('Larry', 'Barry');
