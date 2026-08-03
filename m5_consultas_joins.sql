/*
=========================================================
MÓDULO 5 - CONSULTAS CON JOIN

=========================================================

Utilice la base de datos creada en el Módulo 3, compuesta por las tablas:

- categorias
- clientes
- productos
- ventas

NOTA IMPORTANTE

La consigna solicita utilizar información de:
- territorios (región)
- segmento de clientes
- canal (Online / Presencial)

Sin embargo, esas columnas o tablas NO existen en el modelo
de datos entregado en el Módulo 3.

Por este motivo:

- En la Consulta 1 se reemplaza "región" por clientes.ciudad.
- La columna segmento se devuelve como NULL.
- En la Consulta 4 el canal se representa como una constante
  ('Ventas'), ya que no existe un campo que permita distinguir
  entre ventas Online y Presenciales.
*/

----------------------------------------------------------
-- CONSULTA 1
-- Vista base del proyecto (INNER JOIN)
----------------------------------------------------------

SELECT
    v.fecha_venta,
    c.nombre AS nombre_cliente,
    NULL AS segmento,
    c.ciudad AS region,
    p.nombre_producto,
    cat.nombre_categoria AS categoria,
    v.cantidad,
    v.precio_unitario,
    (v.cantidad * v.precio_unitario) AS total_venta,
    'Ventas' AS canal
FROM ventas v
INNER JOIN clientes c
    ON v.id_cliente = c.id_cliente
INNER JOIN productos p
    ON v.id_producto = p.id_producto
INNER JOIN categorias cat
    ON p.id_categoria = cat.id_categoria
ORDER BY v.fecha_venta;

----------------------------------------------------------
-- CONSULTA 2
-- Clientes sin ventas (LEFT JOIN)
----------------------------------------------------------

SELECT
    c.nombre,
    c.email,
    c.fecha_registro
FROM clientes c
LEFT JOIN ventas v
    ON c.id_cliente = v.id_cliente
WHERE v.id_cliente IS NULL;

----------------------------------------------------------
-- CONSULTA 3
-- Productos sin ventas (LEFT JOIN)
----------------------------------------------------------

SELECT
    p.nombre_producto,
    cat.nombre_categoria AS categoria,
    p.precio
FROM productos p
LEFT JOIN ventas v
    ON p.id_producto = v.id_producto
INNER JOIN categorias cat
    ON p.id_categoria = cat.id_categoria
WHERE v.id_producto IS NULL;

----------------------------------------------------------
-- CONSULTA 4
-- Consolidado por canal (UNION ALL)
----------------------------------------------------------

SELECT
    canal,
    SUM(total_venta) AS total_facturado
FROM (

    SELECT
        'Ventas' AS canal,
        (cantidad * precio_unitario) AS total_venta
    FROM ventas

    UNION ALL

    SELECT
        'Ventas' AS canal,
        (cantidad * precio_unitario) AS total_venta
    FROM ventas

) t
GROUP BY canal;