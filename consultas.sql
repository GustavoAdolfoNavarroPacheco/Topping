-- =========
-- CONSULTAS
-- =========

-- 1. Clientes con pedidos entre dos fechas (BETWEEN).
SELECT c.idCliente, p.nombre, p.apellido, ped.fechaPedido FROM Cliente c LEFT JOIN Persona p ON c.idPersona = p.idPersona LEFT JOIN Pedido ped ON c.idCliente = ped.idCliente WHERE ped.fechaPedido BETWEEN '2024-03-01' AND '2024-03-31';

-- 2. Pizzas más vendidas (GROUP BY y COUNT).
SELECT piz.nombrePizza, SUM(dp.cantidad) AS totalVendidas FROM DetallePedido dp LEFT JOIN Pizza piz ON dp.idPizza = piz.idPizza GROUP BY dp.idPizza ORDER BY totalVendidas DESC;

-- 3. Pedidos por repartidor (JOIN).
SELECT r.idRepartidor, per.nombre, per.apellido, COUNT(d.idDomicilio) AS totalPedidos FROM Repartidor r LEFT JOIN Persona per ON r.idPersona = per.idPersona LEFT JOIN Domicilio d ON r.idRepartidor = d.idRepartidor GROUP BY r.idRepartidor;

-- 4. Promedio de entrega por zona (AVG y JOIN).
SELECT z.nombreZona, AVG(TIMESTAMPDIFF(MINUTE, d.horaSalida, d.horaEntrega)) AS promedioEntregaMinutos FROM Domicilio d LEFT JOIN Repartidor r ON d.idRepartidor = r.idRepartidor LEFT JOIN Zona z ON r.idZona = z.idZona GROUP BY z.idZona;

-- 5. Clientes que gastaron más de un monto (HAVING)
SELECT c.idCliente, p.nombre, p.apellido, SUM(ped.totalCalculado) AS totalGastado FROM Cliente c LEFT JOIN Persona p ON c.idPersona = p.idPersona LEFT JOIN Pedido ped ON c.idCliente = ped.idCliente GROUP BY c.idCliente HAVING totalGastado > 50000;

-- 6. Búsqueda por coincidencia parcial de nombre de pizza (LIKE).
SELECT * FROM Pizza WHERE nombrePizza LIKE '%Pepper%';

-- 7. Subconsulta para obtener los clientes frecuentes (más de 5 pedidos mensuales).
SELECT * FROM Cliente c WHERE c.idCliente IN ( SELECT ped.idCliente FROM Pedido ped LEFT JOIN Cliente cli ON ped.idCliente = cli.idCliente WHERE MONTH(ped.fechaPedido) = 3 AND YEAR(ped.fechaPedido) = 2024 GROUP BY ped.idCliente HAVING COUNT(ped.idPedido) > 5);
