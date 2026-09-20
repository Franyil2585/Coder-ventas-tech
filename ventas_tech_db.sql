DROP TABLE IF EXISTS ventas CASCADE;

CREATE TABLE ventas (id_venta SERIAL PRIMARY KEY,
id_cliente INT NOT NULL,
id_producto INT NOT NULL,
cantidad INT NOT NULL,
fecha_ventas TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente),
FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
);

DROP TABLE IF EXISTS productos CASCADE;
CREATE TABLE productos (id_producto SERIAL PRIMARY KEY,
nombre_producto VARCHAR(150) NOT NULL,
descripcion TEXT,
precio NUMERIC(12,2) NOT NULL,
fecha_venta TIMESTAMP DEFAULT CURRENT_TIMESTAMP);

DROP TABLE IF EXISTS clientes CASCADE;
CREATE TABLE clientes (id_cliente SERIAL PRIMARY KEY,
nombre VARCHAR(100) NOT NULL,
email VARCHAR(150) UNIQUE NOT NULL,
ciudad VARCHAR(100) NOT NULL);

DROP TABLE IF EXISTS categorias CASCADE;
CREATE TABLE categorias (id_categoria SERIAL PRIMARY KEY,
nombre_categoria VARCHAR(100) NOT NULL);

INSERT INTO categorias (nombre_categoria) VALUES
('Smartphones'),
('Laptops'),
('Auriculares'),
('Relojes'),
('Accesorios');

INSERT INTO clientes (nombre, email, ciudad) VALUES
('Luis Torres', 'luis.t@gmail.com', 'Cordoba'),
('Maria Diaz', 'maria.diaz@hotmail.com', 'Buenos Aires'),
('Pedro Gomez', 'pedro.gomez@yahoo.com', 'Rosario');

INSERT INTO productos (nombre_producto, descripcion, precio, id_categoria) VALUES
('iPhone 16', '128GB color negro', 950.00, 1),
('iPhone 16', '128GB color blanco', 950.00, 1),
('Apple whatch serie 11', '44mm', 850.00, 1),
('MacBook Air M1', '8GB RAM 256GB SSD', 1100.00, 2),
('Apple whatch serie 11', '46mm', 900.00, 2),
('Auriculares Bluetooth', 'Cancelación de ruido', 80.00, 3);

INSERT INTO ventas (id_cliente, id_producto, cantidad, fecha_ventas) VALUES
(1, 1, 1, '2026-01-10 10:30:00'),
(2, 3, 1, '2026-01-11 15:45:00'),
(3, 5, 2, '2026-01-12 11:20:00'),
(1, 2, 1, '2026-01-15 09:15:00'),
(2, 4, 1, '2026-01-18 18:00:00'),
(3, 1, 1, '2026-01-20 14:10:00'),
(1, 5, 3, '2026-01-22 16:30:00'),
(2, 2, 1, '2026-01-25 12:00:00'),
(3, 3, 1, '2024-01-28 17:50:00'),
(1, 4, 1, '2024-01-30 19:00:00');
