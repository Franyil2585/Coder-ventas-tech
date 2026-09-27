-- Motor utilizado: PostgreSQL 16
-- Base de datos: Ventas_Tech_DB
-- Checkpoint: Script SQL de Ingeniería de Datos

-- =======================================================
-- SECCIÓN 1: DROP TABLES (Orden inverso de dependencias)
-- =======================================================
DROP TABLE IF EXISTS ventas;
DROP TABLE IF EXISTS productos;
DROP TABLE IF EXISTS clientes;
DROP TABLE IF EXISTS categorias;

-- =======================================================
-- SECCIÓN 2: CREATE TABLES (Orden de dependencias)
-- =======================================================

-- 1. Tabla categorias (independiente)
CREATE TABLE categorias (
    id_categoria INT PRIMARY KEY,
    nombre_categoria VARCHAR(50) NOT NULL,
    descripcion VARCHAR(200)
);

-- 2. Tabla clientes (independiente)
CREATE TABLE clientes (
    id_cliente INT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    ciudad VARCHAR(50),
    fecha_registro DATE NOT NULL
);

-- 3. Tabla productos (depende de categorias)
CREATE TABLE productos (
    id_producto INT PRIMARY KEY,
    nombre_producto VARCHAR(100) NOT NULL,
    id_categoria INT NOT NULL,
    precio NUMERIC(10,2) NOT NULL,
    costo NUMERIC(10,2) NOT NULL,
    FOREIGN KEY (id_categoria) REFERENCES categorias(id_categoria)
);

-- 4. Tabla ventas (depende de clientes y productos)
CREATE TABLE ventas (
    id_venta INT PRIMARY KEY,
    fecha_venta DATE NOT NULL,
    id_cliente INT NOT NULL,
    id_producto INT NOT NULL,
    cantidad INT NOT NULL,
    total_venta NUMERIC(10,2) NOT NULL,
    canal VARCHAR(50),
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente),
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
);

-- =======================================================
-- SECCIÓN 3: INSERT INTO (Carga de datos consistentes)
-- =======================================================

-- Carga en categorias
INSERT INTO categorias (id_categoria, nombre_categoria, descripcion) VALUES
(1, 'Audio', 'Auriculares, parlantes y micrófonos'),
(2, 'Computación', 'Laptops, accesorios y componentes'),
(3, 'Smartphones', 'Teléfonos móviles y smartwatches');

-- Carga en clientes
INSERT INTO clientes (id_cliente, nombre, email, ciudad, fecha_registro) VALUES
(1, 'Lucas Gomez', 'lucas.gomez@email.com', 'Buenos Aires', '2023-01-15'),
(2, 'Maria Perez', 'maria.perez@email.com', 'Cordoba', '2023-03-20'),
(3, 'Juan Lopez', 'juan.lopez@email.com', 'Rosario', '2023-06-10');

-- Carga en productos (los id_categoria deben existir en la tabla categorias)
INSERT INTO productos (id_producto, nombre_producto, id_categoria, precio, costo) VALUES
(101, 'Auriculares Bluetooth Pro', 1, 15000.00, 9000.00),
(102, 'Laptop Gamer 15"', 2, 450000.00, 320000.00),
(103, 'Smartwatch Fit 2', 3, 35000.00, 21000.00);

-- Carga en ventas (los id_cliente e id_producto deben existir previamente)
INSERT INTO ventas (id_venta, fecha_venta, id_cliente, id_producto, cantidad, total_venta, canal) VALUES
(1001, '2024-01-10', 1, 101, 2, 30000.00, 'Online'),
(1002, '2024-01-12', 2, 102, 1, 450000.00, 'Físico'),
(1003, '2024-01-15', 3, 103, 1, 35000.00, 'Online'),
(1004, '2024-02-01', 1, 103, 2, 70000.00, 'Online');

-- =======================================================
-- SECCIÓN 4: VALIDACIÓN
-- =======================================================
SELECT * FROM categorias;
SELECT * FROM clientes;
SELECT * FROM productos;
SELECT * FROM ventas;
