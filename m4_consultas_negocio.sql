DROP TABLE IF EXISTS ventas;
DROP TABLE IF EXISTS productos;
DROP TABLE IF EXISTS clientes;
DROP TABLE IF EXISTS categorias;

CREATE TABLE categorias (id_categoria INT PRIMARY KEY,nombre_categoria VARCHAR(50) NOT NULL,descripcion VARCHAR(200)
);

CREATE TABLE clientes (id_cliente INT PRIMARY KEY,nombre VARCHAR(100) NOT NULL,email VARCHAR(100) UNIQUE,ciudad VARCHAR(50),fecha_registro DATE NOT NULL
);

CREATE TABLE productos (id_producto INT PRIMARY KEY,nombre_producto VARCHAR(100) NOT NULL,id_categoria INT NOT NULL,precio NUMERIC(10,2) NOT NULL,costo NUMERIC(10,2) NOT NULL,
FOREIGN KEY (id_categoria) REFERENCES categorias(id_categoria)
);

CREATE TABLE ventas (id_venta INT PRIMARY KEY,fecha_venta DATE NOT NULL,id_cliente INT NOT NULL,id_producto INT NOT NULL,cantidad INT NOT NULL,total_venta NUMERIC(10,2) NOT NULL,canal VARCHAR(50),
FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente),
FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
);

INSERT INTO categorias (id_categoria, nombre_categoria, descripcion) VALUES
(1, 'Audio', 'Auriculares y parlantes'),
(2, 'Computación', 'Laptops y accesorios'),
(3, 'Smartphones', 'Teléfonos y smartwatches');

INSERT INTO clientes (id_cliente, nombre, email, ciudad, fecha_registro) VALUES
(1, 'Lucas Gomez', 'lucas.gomez@email.com', 'Buenos Aires', '2023-01-15'),
(2, 'Maria Perez', 'maria.perez@email.com', 'Cordoba', '2023-03-20'),
(3, 'Juan Lopez', 'juan.lopez@email.com', 'Rosario', '2023-06-10');

INSERT INTO productos (id_producto, nombre_producto, id_categoria, precio, costo) VALUES
(101, 'Auriculares Pro', 1, 15000.00, 9000.00),
(102, 'Laptop Gamer', 2, 450000.00, 320000.00),
(103, 'Smartwatch Fit', 3, 35000.00, 21000.00);

INSERT INTO ventas (id_venta, fecha_venta, id_cliente, id_producto, cantidad, total_venta, canal) VALUES
(1001, '2024-01-10', 1, 101, 2, 30000.00, 'Online'),
(1002, '2024-01-12', 2, 102, 1, 450000.00, 'Físico'),
(1003, '2024-01-15', 3, 103, 1, 35000.00, 'Online'),
(1004, '2024-02-01', 1, 103, 2, 70000.00, 'Online'),
(1005, '2024-02-15', 2, 101, 1, 15000.00, 'Online'),
(1006, '2024-03-05', 3, 102, 1, 450000.00, 'Físico');

SELECT 
EXTRACT(MONTH FROM fecha_venta) AS mes,
SUM(total_venta) AS total_facturado,
COUNT(id_venta) AS cantidad_pedidos,ROUND(AVG(total_venta), 2) AS ticket_promedio
FROM ventas
GROUP BY EXTRACT(MONTH FROM fecha_venta)
ORDER BY mes ASC;

-- =======================================================
-- Consulta 2: Ranking de productos más vendidos
-- =======================================================
SELECT id_producto,
SUM(cantidad) AS unidades_vendidas,
SUM(total_venta) AS facturacion_total
FROM ventas
GROUP BY id_producto
ORDER BY facturacion_total DESC
LIMIT 5;

-- =======================================================
-- Consulta 3: Clientes recurrentes (más de una compra)
-- =======================================================
SELECT id_cliente,
COUNT(id_venta) AS cantidad_compras,
SUM(total_venta) AS total_gastado
FROM ventas
GROUP BY id_cliente
HAVING COUNT(id_venta) > 1
ORDER BY total_gastado DESC;

-- =======================================================
-- Consulta 4: Desempeño mensual vs. promedio
-- =======================================================
WITH ventas_mensuales 
AS (SELECT EXTRACT(MONTH FROM fecha_venta) AS mes,
SUM(total_venta) AS facturacion_mes
FROM ventas
GROUP BY EXTRACT(MONTH FROM fecha_venta)
)
SELECT mes,facturacion_mes,
CASE 
WHEN facturacion_mes >= (SELECT AVG(facturacion_mes) FROM ventas_mensuales) 
THEN 'Por encima del promedio'
ELSE 'Por debajo del promedio'
END AS clasificacion_desempeno
FROM ventas_mensuales
ORDER BY mes ASC;

/* =======================================================
   HALLAZGOS Y CONCLUSIONES DE NEGOCIO
   =======================================================
1. Concentración de facturación por producto:
El producto 'Laptop Gamer' (id_producto 102) es el principal
motor de ingresos del negocio debido a su alto ticket, a pesar de
tener menor rotación en unidades que los accesorios.

2. Comportamiento y recurrencia de clientes:
La base muestra fidelidad temprana, con clientes que ya registran
múltiples compras en el período analizado, impulsando el valor de vida
del cliente (LTV).

3. Estacionalidad y desempeño mensual:
Los meses 1 (Enero) y 3 (Marzo) superaron el promedio mensual de ventas,
traccionados por compras de alto valor unitario, mientras que Febrero
mostró una facturación menor concentrada en productos de gama media/baja.
*/



