-- ============================================================
-- ANÁLISIS DE LA CADENA DE VALOR DEL ACEITE DE OLIVA ANDALUZ
-- Proyecto: olive-oil-andalusia-analysis
-- Fuente: MAPA - Anuario de Estadística 2024
-- ============================================================


-- QUERY 1: Evolución del precio con variación anual 2000-2023
SELECT
  anio,
  precio_calidad_alta,
  precio_calidad_media,
  precio_calidad_baja,
  ROUND(precio_calidad_alta - LAG(precio_calidad_alta) 
    OVER (ORDER BY anio), 2) AS variacion_anual,
  ROUND((precio_calidad_alta - LAG(precio_calidad_alta) 
    OVER (ORDER BY anio)) / LAG(precio_calidad_alta) 
    OVER (ORDER BY anio) * 100, 2) AS variacion_pct
FROM `proyecto-aceite-oliva.aceite_oliva_andaluz.precios_historicos`
ORDER BY anio;


-- QUERY 2: Peso de cada CCAA en la producción nacional 2023
-- NOTA DE CALIDAD DE DATOS:
-- La tabla aceite_virgen_provincia_2023 mezcla en la misma columna "territorio"
-- filas de nivel Comunidad Autónoma (ej. "ANDALUCÍA") y filas de nivel provincia
-- (ej. "Jaén", "Córdoba"), sin ninguna columna que indique el nivel jerárquico.
-- Por eso esta query usa una lista explícita de nombres en vez de un
-- ORDER BY / LIMIT dinámico, que mezclaría provincias con comunidades.
-- Además, "CASTILLA–LA MANCHA" usa un guion largo (en dash, U+2013) en el
-- dato de origen, no un guion normal — hay que respetarlo en cualquier
-- comparación exacta de texto.
SELECT
  TRIM(territorio) AS territorio,
  `TOTAL`,
  ROUND(`TOTAL` / (
    SELECT `TOTAL`
    FROM `proyecto-aceite-oliva.aceite_oliva_andaluz.aceite_virgen_provincia_2023`
    WHERE TRIM(territorio) = 'ESPAÑA'
  ) * 100, 2) AS pct_sobre_espana
FROM `proyecto-aceite-oliva.aceite_oliva_andaluz.aceite_virgen_provincia_2023`
WHERE TRIM(territorio) IN ('ANDALUCÍA', 'CASTILLA–LA MANCHA', 'EXTREMADURA', 'CATALUÑA', 'C. VALENCIANA')
ORDER BY `TOTAL` DESC;


-- QUERY 3: Composición de calidad por CCAA 2023
-- Se comparan las 3 CCAA con mayor volumen de producción (según Query 2)
-- contra el promedio nacional (ESPAÑA), para ver si el liderazgo en volumen
-- se corresponde con liderazgo en proporción de aceite de categoría "Extra".
SELECT
  TRIM(territorio) AS territorio,
  ROUND(Extra / `TOTAL` * 100, 2) AS pct_extra,
  ROUND(Virgen / `TOTAL` * 100, 2) AS pct_virgen,
  ROUND(Lampante / `TOTAL` * 100, 2) AS pct_lampante,
  `TOTAL`
FROM `proyecto-aceite-oliva.aceite_oliva_andaluz.aceite_virgen_provincia_2023`
WHERE TRIM(territorio) IN ('ANDALUCÍA', 'ESPAÑA', 'CASTILLA–LA MANCHA', 'EXTREMADURA')
ORDER BY `TOTAL` DESC;


-- QUERY 4: Cadena de valor completa - rendimiento de extracción 2013-2023
SELECT
  a.anio,
  a.aceituna_almazara_miles_ton,
  a.aceite_virgen_ton,
  ROUND(a.aceite_virgen_ton / (a.aceituna_almazara_miles_ton * 1000) * 100, 2) AS rendimiento_pct,
  p.precio_calidad_alta AS precio_eur_100kg
FROM `proyecto-aceite-oliva.aceite_oliva_andaluz.aceituna_almazara_productos` a
JOIN `proyecto-aceite-oliva.aceite_oliva_andaluz.precios_historicos` p
  ON a.anio = p.anio
ORDER BY a.anio;


-- QUERY 5: Vista auxiliar para el dashboard "Producción vs Precio 2013-2023"
-- Se recreó porque la tabla original de esta vista se perdió en BigQuery,
-- rompiendo el gráfico correspondiente en Looker Studio (detectado y corregido).
-- Une producción nacional anual (aceituna_almazara_productos) con precios
-- históricos (precios_historicos) por año.
CREATE OR REPLACE VIEW `proyecto-aceite-oliva.aceite_oliva_andaluz.produccion_vs_precio` AS
SELECT
  a.anio,
  a.aceituna_almazara_miles_ton AS almazara_miles_ton,
  h.precio_calidad_alta,
  h.precio_calidad_media,
  h.precio_calidad_baja
FROM `proyecto-aceite-oliva.aceite_oliva_andaluz.aceituna_almazara_productos` AS a
JOIN `proyecto-aceite-oliva.aceite_oliva_andaluz.precios_historicos` AS h
  ON a.anio = h.anio
ORDER BY a.anio;
