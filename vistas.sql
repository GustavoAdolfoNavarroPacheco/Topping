-- =========
-- VISTAS
-- =========

-- 2. Vista de desempeño de repartidores (número de entregas, tiempo promedio, zona).
CREATE VIEW DesempenoRepartidores AS
SELECT
    r.idRepartidor,
    CONCAT(per.nombre, ' ', per.apellido) AS nombreRepartidor,
    COUNT(d.idDomicilio) AS totalEntregas,
    AVG(TIMESTAMPDIFF(MINUTE, d.horaSalida, d.horaEntrega)) AS tiempoPromedioMinutos,
    z.nombreZona
FROM Repartidor r
LEFT JOIN Persona per ON r.idPersona = per.idPersona
LEFT JOIN Domicilio d ON r.idRepartidor = d.idRepartidor
LEFT JOIN Zona z ON r.idZona = z.idZona
GROUP BY r.idRepartidor;
