---Consulta 1---
SELECT 
    v.id_venta,
    v.fecha_venta,
    c.nombre AS nombre_cliente,
    c.ciudad,
    p.nombre_producto,
    v.cantidad,
    v.total_venta,
    v.canal
FROM ventas v
INNER JOIN clientes c ON v.id_cliente = c.id_cliente
INNER JOIN productos p ON v.id_producto = p.id_producto
ORDER BY v.fecha_venta ASC;

-- Consulta 2 --
SELECT 
    p.id_producto,
    p.nombre_producto,
    p.precio,
    v.id_venta
FROM productos p
LEFT JOIN ventas v ON p.id_producto = v.id_producto
WHERE v.id_venta IS NULL;

-- Consulta 3 --
SELECT column_name, data_type 
FROM information_schema.columns 
WHERE table_name = 'categorias';

SELECT 
    c.nombre_categoria,
    COUNT(v.id_venta) AS total_pedidos,
    SUM(v.cantidad) AS unidades_vendidas,
    SUM(v.total_venta) AS facturacion_total,
    SUM(v.total_venta - (p.costo * v.cantidad)) AS ganancia_estimada
FROM ventas v
INNER JOIN productos p ON v.id_producto = p.id_producto
INNER JOIN categorias c ON p.id_categoria = c.id_categoria
GROUP BY c.nombre_categoria
ORDER BY facturacion_total DESC;

-- Consulta 4 --
SELECT 
    c.id_cliente,
    c.nombre,
    c.ciudad,
    'Cliente con compra' AS tipo_registro
FROM clientes c
INNER JOIN ventas v ON c.id_cliente = v.id_cliente

UNION

SELECT 
    c.id_cliente,
    c.nombre,
    c.ciudad,
    'Cliente registrado general' AS tipo_registro
FROM clientes c
ORDER BY id_cliente ASC;

