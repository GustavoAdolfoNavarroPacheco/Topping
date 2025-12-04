-- ============
-- DISPARADORES
-- ============

-- Disparador para calcular el total de un pedido

DELIMITER //
CREATE TRIGGER actualizarTotalPedido
AFTER INSERT ON DetallePedido
FOR EACH ROW
BEGIN
    DECLARE totalPedido DOUBLE DEFAULT 0;

    SELECT costoEnvio INTO totalPedido FROM Domicilio WHERE idPedido = NEW.idPedido LIMIT 1;

    IF totalPedido IS NULL THEN 
        SET totalPedido = 0;
    END IF;

    UPDATE Pedido SET totalCalculado = (SELECT SUM(subtotal) FROM DetallePedido WHERE idPedido = NEW.idPedido) + totalPedido WHERE idPedido = NEW.idPedido;
END ; //
DELIMITER ;

-- Datos de para la prueba del disparador
INSERT INTO Pedido(idCliente, idVendedor, idPago, fechaPedido, estado, tipoPedido, totalCalculado)
VALUES (2, 1, 3, NOW(), 'entregado', 'domicilio', 0);

INSERT INTO Domicilio(idPedido, idRepartidor, horaSalida, horaEntrega, distanciaKm, costoEnvio)
VALUES (6, 2, '2025-11-29 00:00:01', '2025-11-29 00:10:01', 10, 10000);

INSERT INTO DetallePedido (idPedido, idPizza, cantidad, subtotal)
VALUES (6, 1, 1, 20000);