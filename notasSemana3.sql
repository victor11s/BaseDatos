/*Crear un base de datos llamada Agencia y darle permisos a un nuevo usuario*/
CREATE DATABASE Agencia;
GRANT ALL PRIVILEGES ON Agencia.* TO agencia_user@localhost IDENTIFIED
BY '4336';
FLUSH PRIVILEGES;

/*Restaurar contenido de una Base de Datos, si es que se creo antes esta misma*/
mysql --user=root --password agencia < AutosClasicos.sql 
#para restaurar los datos



/*Pasos para crear un Stored Procedure y llamarlo*/
DELIMITER //
CREATE PROCEDURE ObtieneProductos2()
BEGIN
SELECT productName, buyPrice FROM products;
END // 
/*Llamarlo*/
CALL ObtieneProductos();




/*Tarea devolver información de los empleados con sus oficinas*/
DELIMITER //
CREATE PROCEDURE EmpleadosOficinas()
BEGIN
SELECT employees.firstName, employees.lastName, offices.city, offices.country, offices.officeCode
From employees inner join offices 
ON employees.officeCode=offices.officeCode;
END //
DELIMITER;



/*Encontrar las oficinas que se encuentren en cierto país*/
DELIMITER//
CREATE PROCEDURE ObtieneOficinaPais(
IN pais VARCHAR(30)
)
BEGIN
SELECT * FROM offices
WHERE country =pais;
END//
DELIMITER ;

/*Llamar Procedure*/

CALL ObtieneOficinaPais('USA');




/*Encontrar los empleados que se encuentren en cierto país*/
DELIMITER //
	CREATE PROCEDURE ObtieneNumeroPedidoEstatus(
	IN estatusOrden VARCHAR(25), OUT total INT )
	BEGIN
	SELECT COUNT(orderNumber)
	INTO total
	FROM orders
	WHERE status= estatusOrden;
	END //
DELIMITER ;

/*Llamarlo con variable de Sesión*/

CALL ObtieneNumeroPedidoEstatus('Shipped',@total);
SELECT @total as shipped;