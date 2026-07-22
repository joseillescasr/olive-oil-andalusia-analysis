# 🫒 Análisis de la Cadena de Valor del Aceite de Oliva Andaluz

## Descripción
Análisis end-to-end de la cadena de valor del aceite de oliva en Andalucía (2013-2023), desde la superficie de olivar hasta los precios percibidos por los agricultores en origen. El proyecto parte de datos oficiales del Ministerio de Agricultura español, los transforma con Python, los analiza con SQL en BigQuery y los visualiza en un dashboard interactivo en Looker Studio.

Este proyecto forma parte de mi portfolio de transición profesional hacia Data Analytics.

---

## 🗂️ Fuente de datos
**Anuario de Estadística 2024** — Ministerio de Agricultura, Pesca y Alimentación (MAPA)  
Capítulo 7.12: Olivar — superficies, producciones, rendimientos y precios  
Datos correspondientes al período 2013-2023 (precios desde 2000)

---

## 🛠️ Stack tecnológico
| Herramienta | Uso |
|---|---|
| Python (Google Colab) | Limpieza y transformación de datos |
| pandas | Manipulación de DataFrames |
| Google BigQuery | Almacenamiento y análisis SQL |
| SQL | Queries analíticas y vistas |
| Looker Studio | Dashboard interactivo |
| GitHub | Documentación y control de versiones |

---

## 🔄 Pipeline
Excel MAPA → Python/Colab (limpieza) → CSVs limpios → BigQuery → SQL → Looker Studio

## 📊 Tablas analizadas
| Tabla | Descripción |
|---|---|
| precios_historicos | Precios del aceite virgen 2000-2023 (€/100kg) |
| aceite_virgen_provincia_2023 | Producción por tipo y provincia 2023 |
| destino_produccion_aceituna | Destino almazara vs mesa 2013-2023 |
| aceituna_almazara_productos | Productos obtenidos de la almazara 2013-2023 |
| superficie_rendimiento_produccion | Superficie y rendimiento del olivar 2013-2023 |
| olivar_almazara_provincia | Olivar de almazara por provincia 2023 |

---

## 🔍 Hallazgos principales
- **Andalucía produce el 68.37%** del aceite de oliva virgen de España en 2023
- El precio del aceite virgen extra subió un **+72.5% en 2023** respecto a 2022 — crisis histórica de precios
- El rendimiento de extracción se mantiene constante en **~20%** independientemente del volumen de cosecha
- Existe una **correlación inversa** entre producción y precio, con excepciones documentadas (efecto rebote 2014-2015)
- Andalucía tiene menor % de aceite Extra (36%) que Castilla-La Mancha (88%) pese a ser la mayor productora — diferencia agronómica por tipo de olivar

---

## ⚠️ Notas metodológicas
- La clasificación de aceite por acidez cambió 3 veces entre 2000-2023 — series de precios no son directamente comparables entre períodos
- A partir de 2023 se incorpora el olivar de doble aptitud como categoría independiente
- Los datos de producción incluyen aceituna de doble aptitud con destino almazara

---

## 📈 Dashboard
[Ver dashboard interactivo en Looker Studio](https://datastudio.google.com/reporting/459dfeb0-3f66-4d63-b2ac-262305ae5c08)

---

## 👤 Autor
**José Illescas Regalett**  
Ingeniero Mecánico (Tec de Monterrey) | F&B Management (George Brown College Toronto) | Data Analytics  
7 años de experiencia en hostelería de alto nivel — NY, Toronto, Granada  
[LinkedIn](https://www.linkedin.com/in/josé-illescas-regalett-719755132)
