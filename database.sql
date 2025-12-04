-- ==================================
-- CREACION Y USO DE LA BASE DE DATOS
-- ==================================
CREATE DATABASE Pizzeria_DonPiccolo;

USE Pizzeria_DonPiccolo;

--   TABLA PERSONA
CREATE TABLE Persona (
    idPersona INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    telefono VARCHAR(50) NOT NULL,
    direccion VARCHAR(100) NOT NULL,
    correo VARCHAR(100) NOT NULL
);

--   TABLA CLIENTE
CREATE TABLE Cliente (
    idCliente INT AUTO_INCREMENT PRIMARY KEY,
    idPersona INT NOT NULL,
    fechaRegistro DATETIME NOT NULL DEFAULT NOW(),
    FOREIGN KEY (idPersona) REFERENCES Persona(idPersona)
);

--   TABLA VENDEDOR
CREATE TABLE Vendedor (
    idVendedor INT AUTO_INCREMENT PRIMARY KEY,
    idPersona INT NOT NULL,
    turno VARCHAR(20) NOT NULL,
    FOREIGN KEY (idPersona) REFERENCES Persona(idPersona)
);

--   TABLA ZONA
CREATE TABLE Zona (
    idZona INT AUTO_INCREMENT PRIMARY KEY,
    nombreZona VARCHAR(50) NOT NULL,
    tarifaBase DOUBLE NOT NULL,
    precioPorKilometro DOUBLE NOT NULL
);

--   TABLA REPARTIDOR
CREATE TABLE Repartidor (
    idRepartidor INT AUTO_INCREMENT PRIMARY KEY,
    idPersona INT NOT NULL,
    idZona INT NOT NULL,
    estado ENUM('disponible','ocupado','inactivo') NOT NULL DEFAULT 'disponible',
    FOREIGN KEY (idPersona) REFERENCES Persona(idPersona),
    FOREIGN KEY (idZona) REFERENCES Zona(idZona)
);

--   TABLA PIZZA
CREATE TABLE Pizza (
    idPizza INT AUTO_INCREMENT PRIMARY KEY,
    nombrePizza VARCHAR(50) NOT NULL,
    tamano VARCHAR(20) NOT NULL,
    precioBase DOUBLE NOT NULL,
    tipo ENUM('vegetariana','especial','clasica') NOT NULL,
    estado ENUM('activo','inactivo') NOT NULL DEFAULT 'activo'
);

--   TABLA INGREDIENTE
CREATE TABLE Ingrediente (
    idIngrediente INT AUTO_INCREMENT PRIMARY KEY,
    nombreIngrediente VARCHAR(50) NOT NULL,
    precioUnidad DOUBLE NOT NULL,
    stockDisponible INT NOT NULL DEFAULT 0,
    estado ENUM('activo','inactivo') NOT NULL DEFAULT 'activo'
);

--   TABLA PIZZA INGREDIENTE
CREATE TABLE PizzaIngrediente (
    idPizza INT NOT NULL,
    idIngrediente INT NOT NULL,
    cantidadUso INT NOT NULL,
    PRIMARY KEY (idPizza, idIngrediente),
    FOREIGN KEY (idPizza) REFERENCES Pizza(idPizza),
    FOREIGN KEY (idIngrediente) REFERENCES Ingrediente(idIngrediente)
);

--   TABLA MÉTODO DE PAGO
CREATE TABLE MetodoPago (
    idPago INT AUTO_INCREMENT PRIMARY KEY,
    metodo VARCHAR(30) NOT NULL
);

--   TABLA PEDIDO
CREATE TABLE Pedido (
    idPedido INT AUTO_INCREMENT PRIMARY KEY,
    idCliente INT NOT NULL,
    idVendedor INT NOT NULL,
    idPago INT NOT NULL,
    fechaPedido DATETIME NOT NULL DEFAULT NOW(),
    estado ENUM('pendiente','preparando','enviado','entregado','cancelado') NOT NULL DEFAULT 'pendiente',
    tipoPedido ENUM('domicilio','local') NOT NULL,
    totalCalculado DOUBLE NOT NULL,
    FOREIGN KEY (idCliente) REFERENCES Cliente(idCliente),
    FOREIGN KEY (idVendedor) REFERENCES Vendedor(idVendedor),
    FOREIGN KEY (idPago) REFERENCES MetodoPago(idPago)
);

--   TABLA DETALLE PEDIDO
CREATE TABLE DetallePedido (
    idDetallePedido INT AUTO_INCREMENT PRIMARY KEY,
    idPedido INT NOT NULL,
    idPizza INT NOT NULL,
    cantidad INT NOT NULL,
    subtotal DOUBLE NOT NULL,
    FOREIGN KEY (idPedido) REFERENCES Pedido(idPedido),
    FOREIGN KEY (idPizza) REFERENCES Pizza(idPizza)
);

--   TABLA DOMICILIO
CREATE TABLE Domicilio (
    idDomicilio INT AUTO_INCREMENT PRIMARY KEY,
    idPedido INT NOT NULL,
    idRepartidor INT NOT NULL,
    horaSalida DATETIME NOT NULL,
    horaEntrega DATETIME NOT NULL,
    distanciaKm DOUBLE,
    costoEnvio DOUBLE,
    FOREIGN KEY (idPedido) REFERENCES Pedido(idPedido),
    FOREIGN KEY (idRepartidor) REFERENCES Repartidor(idRepartidor)
);

-- ===========================
--   INSERCIONES
-- ===========================

-- PERSONAS
INSERT INTO Persona (nombre, apellido, telefono, direccion, correo) VALUES
('Carlos', 'Gómez', '3001112233', 'Calle 10 #5-22', 'carlosg@mail.com'),
('María', 'Lozano', '3002223344', 'Cra 15 #22-10', 'marial@mail.com'),
('Sandra', 'Ruiz', '3003334455', 'Av 3 #40-12', 'sruiz@mail.com'),
('Jorge', 'Pérez', '3004445566', 'Calle 50 #20-33', 'jorgep@mail.com'),
('Ana', 'Torres', '3005556677', 'Cra 12 #9-21', 'ana@mail.com'),
('Luis', 'Ramos', '3006667788', 'Calle 99 #45-20', 'luisr@mail.com'),
('Daniel', 'Cano', '3017778899', 'Cra 18 #70-44', 'danielc@mail.com');

SELECT * FROM Persona;

-- CLIENTES (Personas 1,2)
INSERT INTO Cliente (idPersona, fechaRegistro) VALUES
(1, '2024-01-10'),
(2, '2024-02-15');

SELECT * FROM Cliente;

-- VENDEDORES (Personas 3)
INSERT INTO Vendedor (idPersona, turno) VALUES
(3, 'mañana'),
(4, 'tarde');

SELECT * FROM Vendedor;

-- ZONAS
INSERT INTO Zona (nombreZona, tarifaBase, precioPorKilometro) VALUES
('Bucaramanga', 3000, 800),
('Giron', 2500, 700),
('Floridablanca', 3500, 900);

SELECT * FROM Zona;

-- REPARTIDORES (Personas 5, 6, 7)
INSERT INTO Repartidor (idPersona, idZona, estado) VALUES
(5, 1, 'disponible'),
(6, 2, 'ocupado'),
(7, 3, 'inactivo');

SELECT * FROM Repartidor;

-- PIZZAS
INSERT INTO Pizza (nombrePizza, tamano, precioBase, tipo, estado) VALUES
('Hawaiana', 'mediana', 20000, 'especial', 'activo'),
('Pepperoni', 'grande', 28000, 'clasica', 'activo'),
('Vegetariana', 'mediana', 22000, 'vegetariana', 'activo');

SELECT * FROM Pizza;

-- INGREDIENTES
INSERT INTO Ingrediente (nombreIngrediente, precioUnidad, stockDisponible, estado) VALUES
('Queso Mozzarella', 1500, 200, 'activo'),
('Jamón', 1200, 100, 'activo'),
('Piña', 800, 80, 'activo'),
('Pepperoni', 1300, 150, 'activo'),
('Champiñones', 900, 50, 'activo'),
('Pimiento', 700, 60, 'activo');

SELECT * FROM Ingrediente;

-- PIZZA-INGREDIENTE (composición)
INSERT INTO PizzaIngrediente (idPizza, idIngrediente, cantidadUso) VALUES
(1, 1, 2), 
(1, 2, 2), 
(1, 3, 2); 

-- Pepperoni
INSERT INTO PizzaIngrediente (idPizza, idIngrediente, cantidadUso) VALUES
(2, 1, 2), 
(2, 4, 3); 

-- Vegetariana
INSERT INTO PizzaIngrediente (idPizza, idIngrediente, cantidadUso) VALUES
(3, 1, 2),
(3, 5, 2),
(3, 6, 2);

SELECT * FROM PizzaIngrediente;

-- MÉTODOS DE PAGO
INSERT INTO MetodoPago (metodo) VALUES
('Efectivo'),
('Tarjeta'),
('Nequi');

SELECT * FROM MetodoPago;

-- PEDIDOS
INSERT INTO Pedido (idCliente, idVendedor, idPago, fechaPedido, estado, tipoPedido, totalCalculado) VALUES
(1, 1, 1, '2024-03-10', 'pendiente', 'domicilio', 32000),
(2, 2, 2, '2024-03-11', 'enviado', 'domicilio', 28000),
(1, 1, 3, '2024-03-12', 'entregado', 'local', 20000);

SELECT * FROM Pedido;

-- DETALLE PEDIDO
INSERT INTO DetallePedido (idPedido, idPizza, cantidad, subtotal) VALUES
(1, 1, 1, 20000),
(1, 3, 1, 12000),
(2, 2, 1, 28000),
(3, 1, 1, 20000);

SELECT * FROM DetallePedido;

-- DOMICILIOS
INSERT INTO Domicilio (idPedido, idRepartidor, horaSalida, horaEntrega, distanciaKm, costoEnvio) VALUES
(1, 1, '2024-03-10 14:30:00', '2024-03-10 14:55:00', 3.2, 4500),
(2, 2, '2024-03-11 16:00:00', '2024-03-11 16:25:00', 5.1, 7000);

SELECT * FROM Domicilio;

-- ==================================
-- SELECTS DIVIDIDOS INDIVIDUALEMENTE
-- ==================================
SELECT * FROM Persona;
SELECT * FROM Cliente;
SELECT * FROM Vendedor;
SELECT * FROM Zona;
SELECT * FROM Repartidor;
SELECT * FROM Pizza;
SELECT * FROM Ingrediente;
SELECT * FROM PizzaIngrediente;
SELECT * FROM MetodoPago;
SELECT * FROM Pedido;
SELECT * FROM DetallePedido;
SELECT * FROM Domicilio;
