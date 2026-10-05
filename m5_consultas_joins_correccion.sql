-- Correcciones entrega 5 --

-- CONSULTA 1: Vista base comercial con detalle de clientes, productos y categorías
SELECT 
    v.id_venta,
    v.fecha_venta,
    c.nombre AS nombre_cliente,
    c.ciudad,
    p.nombre_producto,
    p.precio,
    cat.nombre_categoria,
    v.cantidad,
    v.total_venta,
    v.canal
FROM ventas v
INNER JOIN clientes c ON v.id_cliente = c.id_cliente
INNER JOIN productos p ON v.id_producto = p.id_producto
INNER JOIN categorias cat ON p.id_categoria = cat.id_categoria
ORDER BY v.fecha_venta ASC;


-- CONSULTA 2: Detección de clientes registrados sin compras registradas
SELECT 
    c.nombre,
    c.email,
    c.fecha_registro
FROM clientes c
LEFT JOIN ventas v ON c.id_cliente = v.id_cliente
WHERE v.id_cliente IS NULL;


-- CONSULTA 3: Detección de productos del catálogo sin ventas, con su categoría
SELECT 
    p.id_producto,
    p.nombre_producto,
    cat.nombre_categoria,
    p.precio,
    p.costo
FROM productos p
INNER JOIN categorias cat ON p.id_categoria = cat.id_categoria
LEFT JOIN ventas v ON p.id_producto = v.id_producto
WHERE v.id_producto IS NULL;


-- CONSULTA 4: Consolidación y agregación de ventas por canal mediante UNION ALL
SELECT 
    canal_tipo,
    COUNT(id_venta) AS total_transacciones,
    SUM(total_venta) AS total_facturado
FROM (
    SELECT 
        id_venta,
        total_venta,
        'Online' AS canal_tipo
    FROM ventas
    WHERE canal = 'Online'

    UNION ALL

    SELECT 
        id_venta,
        total_venta,
        'Presencial' AS canal_tipo
    FROM ventas
    WHERE canal = 'Presencial'
) AS ventas_consolidadas
GROUP BY canal_tipo;
