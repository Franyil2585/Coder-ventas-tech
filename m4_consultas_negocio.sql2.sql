---Consulta de columnas---
SELECT * FROM ventas LIMIT 5;

-- Consulta 1 Resumen ejecutivo mensual --
SELECT 
    EXTRACT(MONTH FROM fecha_venta) AS mes,
    SUM(total_venta) AS total_facturado,
    COUNT(*) AS cantidad_pedidos,
    ROUND(AVG(total_venta), 2) AS ticket_promedio
FROM ventas
GROUP BY EXTRACT(MONTH FROM fecha_venta)
ORDER BY mes ASC;

-- Consulta 2 Ranking de productos --
SELECT 
    id_producto,
    SUM(cantidad) AS unidades_vendidas,
    SUM(total_venta) AS total_facturado
FROM ventas
GROUP BY id_producto
ORDER BY total_facturado DESC
LIMIT 5;

--Consulta 3 Clientes recurrentes --
SELECT 
    id_cliente,
    COUNT(*) AS cantidad_pedidos,
    SUM(total_venta) AS total_gastado
FROM ventas
GROUP BY id_cliente
HAVING COUNT(*) > 1
ORDER BY total_gastado DESC;

-- Consulta 4 Meses por encima y por debajo del promedio --
WITH ventas_mensuales AS (
SELECT 
EXTRACT(MONTH FROM fecha_venta) AS mes,
SUM(total_venta) AS total_facturado
FROM ventas
GROUP BY EXTRACT(MONTH FROM fecha_venta)
)
SELECT 
mes,total_facturado,
CASE 
WHEN total_facturado >= (SELECT AVG(total_facturado) FROM ventas_mensuales) 
THEN 'Por encima'
ELSE 'Por debajo'
END AS comparativa_promedio
FROM ventas_mensuales
ORDER BY mes ASC;

--Comentarios de Hallazgos--
1 El producto ID102 representa el 86% de las ventas segun el total facturado.
2 Se cuenta con 3 clientes recurrentes dentro el cual el ID_cliente 2, representa mayor facturación.
3 El mes 1 representa la facturación promedio mas significativa por encima del promedio
