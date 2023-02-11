/*Ejercicio 1 CREAR PROCEDURE PAGINADOR*/
DELIMITER $$
CREATE PROCEDURE Paginador(
INOUT contador INT,
IN incremento INT) 
BEGIN
SET contador=contador+incremento;
END $$
DELIMITER ;

SET @contador=0;
CALL Paginador(@contador,1);
SELECT @contador;



/*SET CONTADOR*/
DELIMITER ;
#setear el inicio del contador
SET @contador=1;
#le sumas el parametro que le mandaste
CALL paginador(@contador,1)

#para llamarlo
SELECT @contador;


/*Ejercicio 3 OBTENER TOTAL DE ORDENES*/
#No se le mando ningun parametro
DELIMITER //
CREATE PROCEDURE obtenerOrdenTotal()
BEGIN
DECLARE ordenTotal INT DEFAULT 0;
SELECT COUNT(*) INTO ordenTotal FROM orders;
SELECT ordenTotal;
END //
DELIMITER ;

CALL obtenerOrdenTotal();


/*Ejercicio 4 PROCEDIMIENTO ALMACENADO ESTRUCTURA DE CONTROL, PARA CATEGORIZAR CLIENTES*/
#CATEGORIZAR CLIENTES
DELIMITER //
CREATE PROCEDURE obtieneNivelCliente(
IN numeroCliente INT, 
OUT nivelCliente VARCHAR(30))
BEGIN
DECLARE credito DECIMAL(10,2) DEFAULT 0; 
SELECT creditLimit 
INTO credito 
FROM customers
WHERE customerNumber = numeroCliente;

IF credito > 50000 THEN
 SET nivelCliente= "PLATINO";
ELSEIF credito <=50000 AND credito > 10000 THEN
	SET nivelCliente="DORADO";
ELSE
	SET nivelCliente="PLATA";
END IF;
END//

DELIMITER ; 

#Llamar Función y guardarlo en la variable nivel

CALL obtieneNivelCliente(121,@nivel) 

SELECT @nivel AS NIVEL_DE_CLIENTE 


/*Ejercicio 5 OBTIENE ESTATUS CLIENTE*/
DELIMITER //
CREATE PROCEDURE obtieneEstatusCliente(
	IN numeroOrden INT,/*LE PASO DE PARAMETRO EL NUMERO DE ORDER*/
	OUT estatusEnvio VARCHAR(100))/*OBTENDRE EL ESTATUS DE ENVIO*/
BEGIN
	DECLARE diasEspera INT DEFAULT 0;/*DECLARO COMO VARIABLE LOCAL*/

	SELECT 
		DATEDIFF(requiredDate,shippedDate)
		INTO diasEspera FROM orders /*LE PASO LOS DIAS QUE TARDO EN LLEGAR A diasEspera*/
		WHERE orderNumber= numeroOrden;

	CASE 
	WHEN diasEspera=0 THEN
		SET estatusEnvio= "A tiempo";
	WHEN diasEspera >=1 AND diasEspera <5 THEN
		SET estatusEnvio= "Tardio";
	WHEN diasEspera >= 5 THEN
		SET estatusEnvio= "Muy Tarde";
	END CASE;
END //
DELIMITER ;

/*Llamarlo*/
	CALL obtieneEstatusCliente(10100,@envio);
	SELECT @envio as Estatus;




/*Crear un SP, que acepte el número de cliente y nos devuelva número total de pedidos que se enviaron, que están en disputa, etc.*/
DELIMITER //
CREATE PROCEDURE obtieneOrdenPorCliente(
IN numero_cliente INT,
OUT enviado INT, /BINARIZAR/
OUT cancelado INT,
OUT resuelto INT,
OUT disputa INT)
BEGIN
--Shipped
SELECT
COUNT() INTO enviado FROM orders 
WHERE customerNumber = numero_cliente
AND status='Shipped';
--Cancelled
COUNT() INTO cancelado FROM orders 
WHERE customerNumber = numero_cliente
AND status='Cancelled';
--Resolved
COUNT() INTO resuelto FROM orders 
WHERE customerNumber = numero_cliente
AND status='Resolved';
--Disputed
COUNT() INTO disputa FROM orders 
WHERE customerNumber = numero_cliente
AND status='Disputed';
END//
DELIMITER ;

/*Llamarlo*/
CALL obtieneOrdenPorCliente(141,@enviado,@cancelado,@resuelto,@disputa);
SELECT @enviado as enviado, @cancelado as cancelado, @resuelto as resuelto, @disputa as "En disputa";
/*Ya que tiene espacio, se usa comillas*/
