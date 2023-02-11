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
WHERE firstName = nombre;
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
IN nombre VARCHAR(50)
)
BEGIN
SELECT firstName, lastName
FROM employees
WHERE firstName = nombre;
END //
DELIMITER ;
/*Llamarlo*/
CALL empleadosConNombre2('Larry');

/*34.Liste los nombres de los empleados con caracteres no alfabéticos en sus nombres.*/
DELIMITER //
CREATE PROCEDURE empleadosConCaracteresNoAlfabeticos()
BEGIN
SELECT firstName, lastName
FROM employees
WHERE firstName REGEXP '[^a-zA-Z]';
END //
DELIMITER ;
/*Llamarlo*/
CALL empleadosConCaracteresNoAlfabeticos();

/*35.Liste los vendedores cuyo nombre termina en Diecast*/
DELIMITER //
CREATE PROCEDURE empleadosConNombre3(
IN terminacion VARCHAR(50)
)
BEGIN
SELECT firstName, lastName
FROM employees
WHERE lastName LIKE CONCAT('%', terminacion);
END //
DELIMITER ;
/*Llamarlo*/
CALL empleadosConNombre3('Diecast');

/*36.Para pedidos que contengan más de dos productos, muestre aquellos productos que constituyan más del 50% del valor del pedido*/
DELIMITER //
CREATE PROCEDURE productosConMasDel50PorcientoDelValorDelPedido()
BEGIN
SELECT orderNumber, SUM(quantityOrdered * priceEach) AS 'Valor total del pedido'
FROM orderdetails, products
WHERE orderdetails.productCode = products.productCode
GROUP BY orderNumber
HAVING SUM(quantityOrdered * priceEach) > 10000;
END //
DELIMITER ;
/*Llamarlo*/
CALL productosConMasDel50PorcientoDelValorDelPedido();






