# RetailPro · Análisis de Datos

Proyecto de análisis de datos para **RetailPro**: consultas analíticas en **PostgreSQL**, modelo y métricas en **Power BI**, y validación en **Excel**.

## 1. Contexto del negocio
Análisis comercial sobre ventas, productos y clientes para evaluar:
- Evolución de la facturación mensual y ticket promedio.
- Productos con mayor volumen de venta y facturación.
- Concentración de ingresos por categoría.

## 2. Tecnologías utilizadas
- **PostgreSQL / pgAdmin 4:** Base de datos relacional y consultas SQL.
- **Power BI:** Medidas en DAX y visualización interactiva.
- **Excel:** Validación inicial de datos.
- **GitHub:** Documentación y control de versiones.

## 3. Consultas SQL principales

### Resumen mensual
```sql
SELECT 
    DATE_TRUNC('month', v.fecha_ventas)::date AS mes,
    COUNT(v.id_venta) AS total_transacciones,
    SUM(v.cantidad * p.precio) AS total_facturado,
    ROUND(AVG(v.cantidad * p.precio), 2) AS ticket_promedio
FROM ventas v
INNER JOIN productos p ON v.id_producto = p.id_producto
GROUP BY DATE_TRUNC('month', v.fecha_ventas)::date
ORDER BY mes ASC;

---Ranking de productos---
SELECT 
    p.nombre_producto,
    SUM(v.cantidad) AS unidades_vendidas,
    SUM(v.cantidad * p.precio) AS total_facturado
FROM ventas v
INNER JOIN productos p ON v.id_producto = p.id_producto
GROUP BY p.nombre_producto
ORDER BY total_facturado DESC
LIMIT 5;

---Autor Franyil A---












