# 🏠 Análisis del Mercado Inmobiliario en USA con SQL

Proyecto de análisis de datos usando SQL puro para explorar el mercado inmobiliario en Estados Unidos, respondiendo 15 preguntas de negocio reales.

## 🎯 Objetivo
Practicar y demostrar habilidades en SQL (agregaciones, joins, window functions) resolviendo problemas de análisis de datos similares a los que enfrentaría un analista de datos o data analyst en el mundo real.

## 📊 Dataset
- **Fuente:** [USA Real Estate Dataset](https://www.kaggle.com/) (Kaggle)
- **Formato:** CSV, cargado en SQL Server
- **Contenido:** precios, ubicación, dormitorios, tamaño y fechas de venta de propiedades en EE.UU.

## 🛠️ Herramientas
- SQL Server
- SQL Server Management Studio (SSMS)

## ❓ Preguntas respondidas
1. ¿Cuál es el precio promedio de las propiedades?
2. ¿Qué ciudades tienen las propiedades más caras?
3. ¿Cuál es el precio promedio por estado?
4. ¿Dónde existe mayor cantidad de propiedades?
5. ¿Cómo cambia el precio según número de dormitorios?
6. ¿Qué relación existe entre tamaño y precio?
7. ¿Cuáles son las 10 propiedades más caras?
8. ¿Cuál es la propiedad más cara de cada ciudad?
9. ¿Qué propiedades están sobre el precio promedio de su ciudad?
10. ¿Cuál es el ranking de propiedades por precio dentro de cada ciudad?
11. ¿Qué porcentaje de las propiedades corresponde a cada estado?
12. ¿Cuánto se aleja cada propiedad del precio promedio de su zona?
13. ¿Cómo evolucionan los precios en el tiempo?
14. ¿Cuál es el promedio móvil de precios?
15. ¿Qué ciudades combinan alta oferta + precios elevados?

## 💡 Principales hallazgos

- **New York City lidera tanto en oferta como en precio:** con 12,634 propiedades listadas (la mayor cantidad de todas las ciudades analizadas) y un precio promedio de $22.6M, se confirma como el mercado más caliente y costoso simultáneamente, seguido de cerca por Miami (9,737 propiedades) y Los Ángeles (8,984 propiedades).

- **El precio no crece de forma lineal con el número de dormitorios:** aunque la tendencia general es que más dormitorios implican mayor precio, categorías con muy pocas propiedades (como 17-19 dormitorios, con menos de 150 registros cada una) muestran promedios inestables y poco representativos comparados con las categorías más comunes (1-4 dormitorios, que concentran más de 1.5 millones de propiedades en conjunto).

- **El dataset presenta outliers extremos que requieren limpieza:** se detectaron valores de precio anómalos (como $21,474,836,480 en la ciudad "International"), cercanos al límite de overflow de un entero de 32 bits (2,147,483,647), lo que sugiere errores de carga de datos. Esto resalta la importancia de validar y filtrar los datos antes de sacar conclusiones de negocio.
