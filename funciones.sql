-- =====================================
-- PROCEDIMIENTO PARA INSERCION DE DATOS
-- =====================================

-- Procedimiento para insercion de Datos en la tabla Persona
DELIMITER //
CREATE PROCEDURE insertarPersona( IN p_nombre VARCHAR(50), IN p_apellido VARCHAR(50), IN p_telefono VARCHAR(50), IN p_direccion VARCHAR(100), IN p_correo VARCHAR(100))
BEGIN
    INSERT INTO Persona (nombre, apellido, telefono, direccion, correo)
    VALUES (p_nombre, p_apellido, p_telefono, p_direccion, p_correo);
END ; //
DELIMITER ;

-- Prueba de insersion de datos mediante call del procedimiento
CALL insertarPersona('Juan','Pérez','3001112233','Calle 10 #5-22','juan@mail.com');
CALL insertarPersona('Ricardo','Martínez','3009876543','Cra 45 #22-18','ricardom@mail.com');
CALL insertarPersona('Felipe','Ardila','3015566778','Av 9 #33-34','fardila@mail.com');


-- Procedimiento para insercion de Datos en la tabla Cliente
DELIMITER //
CREATE PROCEDURE insertarCliente( IN p_idPersona INT, IN p_fechaRegistro DATE)
BEGIN
    INSERT INTO Cliente (idPersona, fechaRegistro)
    VALUES (p_idPersona, p_fechaRegistro);
END ; //
DELIMITER ;

-- Prueba de insersion de datos mediante call del procedimiento
CALL insertarCliente(8,'2025-01-01');

-- Procedimiento para insercion de Datos en la tabla Vendedor
DELIMITER //
CREATE PROCEDURE insertarVendedor( IN p_idPersona INT, IN p_turno VARCHAR(20))
BEGIN
    INSERT INTO Vendedor (idPersona, turno)
    VALUES (p_idPersona, p_turno);
END ; //
DELIMITER ;

-- Prueba de insersion de datos mediante call del procedimiento
CALL insertarVendedor(9,'mañana');

-- Procedimiento para insercion de Datos en la tabla Zona
DELIMITER //
CREATE PROCEDURE insertarZona( IN p_nombreZona VARCHAR(50), IN p_tarifaBase DOUBLE, IN p_precioPorKilometro DOUBLE)
BEGIN
    INSERT INTO Zona (nombreZona, tarifaBase, precioPorKilometro)
    VALUES (p_nombreZona, p_tarifaBase, p_precioPorKilometro);
END ; //
DELIMITER ;

-- Prueba de insersion de datos mediante call del procedimiento
CALL insertarZona('Piedecuesta',3000,800);

-- Procedimiento para insercion de Datos en la tabla Repartidor
DELIMITER //
CREATE PROCEDURE insertarRepartidor( IN p_idPersona INT, IN p_idZona INT, IN p_estado ENUM('disponible','ocupado','inactivo'))
BEGIN
    INSERT INTO Repartidor (idPersona, idZona, estado)
    VALUES (p_idPersona, p_idZona, p_estado);
END ; //
DELIMITER ;

-- Prueba de insersion de datos mediante call del procedimiento
CALL insertarRepartidor(10,4,'disponible');

-- Procedimiento para insercion de Datos en la tabla Pizza
DELIMITER //
CREATE PROCEDURE insertarPizza( IN p_nombrePizza VARCHAR(50), IN p_tamano VARCHAR(20), IN p_precioBase DOUBLE, IN p_tipo VARCHAR(20), IN p_estado ENUM('activo','inactivo'))
BEGIN
    INSERT INTO Pizza (nombrePizza, tamano, precioBase, tipo, estado)
    VALUES (p_nombrePizza, p_tamano, p_precioBase, p_tipo, p_estado);
END ; //
DELIMITER ;

-- Prueba de insersion de datos mediante call del procedimiento
CALL insertarPizza('Especial','Grande',35000,'especial','activo');

-- Procedimiento para insercion de Datos en la tabla Ingrediente
DELIMITER //
CREATE PROCEDURE insertarIngrediente( IN p_nombreIngrediente VARCHAR(50), IN p_precioUnidad DOUBLE, IN p_stockDisponible INT, IN p_estado ENUM('activo','inactivo'))
BEGIN
    INSERT INTO Ingrediente (nombreIngrediente, precioUnidad, stockDisponible, estado)
    VALUES (p_nombreIngrediente, p_precioUnidad, p_stockDisponible, p_estado);
END ; //
DELIMITER ;

-- Prueba de insersion de datos mediante call del procedimiento
CALL insertarIngrediente('Queso Mozarella',1500,100,'activo');

-- Procedimiento para insercion de Datos en la tabla PizzaIngrediente
DELIMITER //
CREATE PROCEDURE insertarPizzaIngrediente( IN p_idPizza INT, IN p_idIngrediente INT, IN p_cantidadUso INT)
BEGIN
    INSERT INTO PizzaIngrediente (idPizza, idIngrediente, cantidadUso)
    VALUES (p_idPizza, p_idIngrediente, p_cantidadUso);
END ; //
DELIMITER ;

-- Prueba de insersion de datos mediante call del procedimiento
CALL insertarPizzaIngrediente(2,5,1);

-- Procedimiento para insercion de Datos en la tabla MetodoPago
DELIMITER //
CREATE PROCEDURE insertarMetodoPago( IN p_metodo VARCHAR(30))
BEGIN
    INSERT INTO MetodoPago (metodo)
    VALUES (p_metodo);
END ; //
DELIMITER ;

-- Prueba de insersion de datos mediante call del procedimiento
CALL insertarMetodoPago('Daviplata');

-- Procedimiento para insercion de Datos en la tabla Pedido
DELIMITER //
CREATE PROCEDURE insertarPedido( IN p_idCliente INT, IN p_idVendedor INT, IN p_idPago INT, IN p_fechaPedido DATE, IN p_estado ENUM('pendiente','preparando','enviado','entregado','cancelado'), IN p_tipoPedido VARCHAR(20), IN p_totalCalculado DOUBLE)
BEGIN
    INSERT INTO Pedido (idCliente, idVendedor, idPago, fechaPedido, estado, tipoPedido, totalCalculado)
    VALUES (p_idCliente, p_idVendedor, p_idPago, p_fechaPedido, p_estado, p_tipoPedido, p_totalCalculado);
END ; //
DELIMITER ;

-- Prueba de insersion de datos mediante call del procedimiento
CALL insertarPedido(1,1,1,'2025-01-02','pendiente','domicilio',45000);

-- Procedimiento para insercion de Datos en la tabla DetallePedido
DELIMITER //
CREATE PROCEDURE insertarDetallePedido(IN p_idPedido INT,IN p_idPizza INT,IN p_cantidad INT,IN p_subtotal DOUBLE)
BEGIN
    INSERT INTO DetallePedido (idPedido, idPizza, cantidad, subtotal)
    VALUES (p_idPedido, p_idPizza, p_cantidad, p_subtotal);
END ; //
DELIMITER ;

-- Prueba de insersion de datos mediante call del procedimiento
CALL insertarDetallePedido(1,1,2,70000);

-- Procedimiento para insercion de Datos en la tabla Domicilio
DELIMITER //
CREATE PROCEDURE insertarDomicilio( IN p_idPedido INT, IN p_idRepartidor INT, IN p_horaSalida DATETIME, IN p_horaEntrega DATETIME, IN p_distanciaKm DOUBLE, IN p_costoEnvio DOUBLE)
BEGIN
    INSERT INTO Domicilio (idPedido, idRepartidor, horaSalida, horaEntrega, distanciaKm, costoEnvio)
    VALUES (p_idPedido, p_idRepartidor, p_horaSalida, p_horaEntrega, p_distanciaKm, p_costoEnvio);
END ; //
DELIMITER ;

-- Prueba de insersion de datos mediante call del procedimiento
CALL insertarDomicilio(3,3,'2025-01-05 18:10:00','2025-01-05 18:35:00',4.8,6000);

-- ===========================
-- CALLS DIVIDOS INDIVUALMENTE 
-- ===========================

CALL insertarPersona('Juan','Pérez','3001112233','Calle 10 #5-22','juan@mail.com');
CALL insertarCliente(3,'2025-01-01');
CALL insertarVendedor(1,'mañana');
CALL insertarZona('Piedecuesta',3000,800);
CALL insertarRepartidor(1,1,'disponible');
CALL insertarPizza('Hawaiana','Grande',35000,'especial','activo');
CALL insertarHistorialPrecio(1,30000,35000,'2025-01-01');
CALL insertarIngrediente('Queso Mozarella',1500,100,'activo');
CALL insertarPizzaIngrediente(2,5,1);
CALL insertarMetodoPago('Daviplata');
CALL insertarPedido(1,1,1,'2025-01-02','pendiente','domicilio',45000);
CALL insertarDetallePedido(1,1,2,70000);
CALL insertarDomicilio(3,3,'2025-01-05 18:10:00','2025-01-05 18:35:00',4.8,6000);

-- =====================================
-- FUNCIONES Y PROCEDIMIENTOS REQUERIDOS
-- =====================================

-- Funcion para calcular el total de un pedido
DELIMITER //
CREATE FUNCTION calcularTotalPedido(pIdPedido INT) 
RETURNS DOUBLE
DETERMINISTIC
BEGIN
    DECLARE totalPizzas DOUBLE DEFAULT 0;
    DECLARE costoDomicilio DOUBLE DEFAULT 0;
    DECLARE totalFinal DOUBLE DEFAULT 0;

    SELECT SUM(subtotal) INTO totalPizzas FROM DetallePedido WHERE idPedido = pIdPedido;

    SELECT costoEnvio INTO costoDomicilio FROM Domicilio WHERE idPedido = pIdPedido;

    IF costoDomicilio IS NULL THEN
        SET costoDomicilio = 0;
    END IF;

    SET totalFinal = (totalPizzas + costoDomicilio) * 1.19;

    RETURN totalFinal;
END ; //
DELIMITER ;

-- Ejemplo de Ejecucion
SELECT calcularTotalPedido(1);

-- Procedimiento para marcar pedido como entregado
DELIMITER //
CREATE PROCEDURE marcarPedidoEntregado(pIdPedido INT, pHoraEntrega DATETIME)
BEGIN
    UPDATE Pedido SET estado = 'entregado' WHERE idPedido = pIdPedido;

    UPDATE Domicilio SET horaEntrega = pHoraEntrega WHERE idPedido = pIdPedido;
END ; //
DELIMITER ;

-- Ejemplo de Ejecucion
CALL marcarPedidoEntregado(2, '2025-03-13 10:32:00');

