-- ============================================
-- ANÁLISIS DEL MERCADO INMOBILIARIO EN USA - SQL
-- 15 preguntas de negocio resueltas con SQL Server
-- ============================================

-- 1. ¿Cuál es el precio promedio de las propiedades?
SELECT ROUND(AVG(price), 2) AS precio_promedio
FROM properties
WHERE price IS NOT NULL;


-- 2. ¿Qué ciudades tienen las propiedades más caras?
SELECT TOP 10 city, state, ROUND(AVG(price), 2) AS precio_promedio
FROM properties
WHERE price IS NOT NULL
GROUP BY city, state
ORDER BY precio_promedio DESC;


-- 3. ¿Cuál es el precio promedio por estado?
SELECT state, ROUND(AVG(price), 2) AS precio_promedio
FROM properties
WHERE state IS NOT NULL
GROUP BY state
ORDER BY precio_promedio DESC;


-- 4. ¿Dónde existe mayor cantidad de propiedades?
SELECT COUNT(*) AS num_propiedades, state
FROM properties
GROUP BY state
ORDER BY COUNT(*) DESC;


-- 5. ¿Cómo cambia el precio según número de dormitorios?
SELECT 
    bed AS numero_dormitorios,
    COUNT(*) AS num_propiedades,
    AVG(price) AS precio_promedio,
    MIN(price) AS precio_minimo,
    MAX(price) AS precio_maximo
FROM properties
WHERE bed IS NOT NULL
GROUP BY bed
ORDER BY bed;


-- 6. ¿Qué relación existe entre tamaño y precio?
SELECT house_size,
    ROUND(AVG(price), 2) AS precio_promedio,
    COUNT(*) AS num_propiedades
FROM properties
WHERE house_size IS NOT NULL
GROUP BY house_size
ORDER BY house_size;


-- 7. ¿Cuáles son las 10 propiedades más caras?
SELECT TOP 10 id, street, city, state, price
FROM properties
ORDER BY price DESC;


-- 8. ¿Cuál es la propiedad más cara de cada ciudad?
SELECT city, street, price, id
FROM (
    SELECT *,
        RANK() OVER (PARTITION BY city ORDER BY price DESC) AS ranking
    FROM properties
) sub
WHERE ranking = 1;


-- 9. ¿Qué propiedades están sobre el precio promedio de su ciudad?
SELECT *
FROM (
    SELECT *,
        AVG(price) OVER (PARTITION BY city) AS precio_promedio_ciudad
    FROM properties
) sub
WHERE price > precio_promedio_ciudad;


-- 10. ¿Cuál es el ranking de propiedades por precio dentro de cada ciudad?
SELECT city, street, price,
    RANK() OVER (PARTITION BY city ORDER BY price DESC) AS ranking_precio
FROM properties
ORDER BY city, ranking_precio;


-- 11. ¿Qué porcentaje de las propiedades corresponde a cada estado?
SELECT state,
    COUNT(*) AS total_propiedades,
    ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (), 2) AS porcentaje
FROM properties
GROUP BY state
ORDER BY porcentaje DESC;


-- 12. ¿Cuánto se aleja cada propiedad del precio promedio de su zona?
SELECT city, street, price,
    AVG(price) OVER (PARTITION BY city) AS precio_promedio_zona,
    price - AVG(price) OVER (PARTITION BY city) AS diferencia_absoluta,
    ROUND(100.0 * (price - AVG(price) OVER (PARTITION BY city)) 
          / AVG(price) OVER (PARTITION BY city), 2) AS diferencia_porcentual
FROM properties
ORDER BY city;


-- 13. ¿Cómo evolucionan los precios en el tiempo?
SELECT prev_sold_date,
    AVG(price) AS precio_promedio,
    COUNT(*) AS num_propiedades
FROM properties
WHERE prev_sold_date IS NOT NULL
GROUP BY prev_sold_date
ORDER BY prev_sold_date;


-- 14. ¿Cuál es el promedio móvil de precios?
SELECT prev_sold_date, price,
    AVG(price) OVER (
        ORDER BY prev_sold_date
        ROWS BETWEEN 4 PRECEDING AND CURRENT ROW
    ) AS promedio_movil_5
FROM properties
WHERE prev_sold_date IS NOT NULL
ORDER BY prev_sold_date;


-- 15. ¿Qué ciudades combinan alta oferta + precios elevados?
SELECT city,
    COUNT(*) AS num_propiedades,
    AVG(price) AS precio_promedio
FROM properties
GROUP BY city
HAVING COUNT(*) > (
        SELECT AVG(cnt) FROM (
            SELECT COUNT(*) AS cnt FROM properties GROUP BY city
        ) t
    )
    AND AVG(price) > (SELECT AVG(price) FROM properties)
ORDER BY num_propiedades DESC, precio_promedio DESC;
