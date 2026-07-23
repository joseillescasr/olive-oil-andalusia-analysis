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
SELECT
  TRIM(territorio) AS territorio,
  `TOTAL`,
  ROUND(`TOTAL` / (
    SELECT `TOTAL`
    FROM `proyecto-aceite-oliva.aceite_oliva_andaluz.aceite_virgen_provincia_2023`
    WHERE TRIM(territorio) = 'ESPAÑA'
  ) * 100, 2) AS pct_sobre_espana
FROM `proyecto-aceite-oliva.aceite_oliva_andaluz.aceite_virgen_provincia_2023`
WHERE TRIM(territorio) IN ('ANDALUCÍA', 'CASTILLA–LA MANCHA', 'EXTREMADURA', 'CATALUÑA', 'ARAGÓN')
ORDER BY `TOTAL` DESC;


-- QUERY 3: Composición de calidad por CCAA 2023
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
