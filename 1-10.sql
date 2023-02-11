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
CREATE PROCEDURE pagosMayoresPromedio1(
    INOUT contador INT
)
BEGIN

SET contador = contador + 1;

SELECT customerNumber, checkNumber, amount, contador
FROM payments
WHERE amount > (SELECT AVG(amount) FROM payments) * 2;
END //
DELIMITER ;
/*Llamarlo*/
CALL pagosMayoresPromedio1();

/*10 NUEVO*/
DELIMITER //
CREATE PROCEDURE pagosMayoresPromedio5(INOUT contador INT)
BEGIN

SET contador = contador + 1;

SELECT contador, customerNumber, checkNumber, amount
FROM payments
WHERE amount > (SELECT AVG(amount) FROM payments) * 2;
END //
DELIMITER ;
/*Llamarlo*/
SET @contador = 0;
CALL pagosMayoresPromedio5(@contador);