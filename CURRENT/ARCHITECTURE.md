---
type: concept
title: "Architecture"
description: "Solo estado vigente. Historial de cambios → ARCHIVE/"
tags: [architecture]
timestamp: 2026-06-20
---

# ARCHITECTURE.md — Arquitectura del sistema

> Solo estado vigente. Historial de cambios → ARCHIVE/
> Fuente canónica: este archivo.

---

## Stack tecnológico

| Capa | Tecnología |
|---|---|
| Backend | Python 3.12 · FastAPI |
| ORM | SQLAlchemy (queries de negocio) |
| DB relacional | Supabase / PostgreSQL ([DEC-016](DECISIONS.md#dec-016)) |
| DB grafo | Neo4j en Hetzner VPS |
| Auth | Supabase Auth + JWT ([DEC-006](DECISIONS.md#dec-006)) |
| Frontend | Next.js 14 App Router + Tailwind CSS |
| Grafo UI | vis.js Network (preferido) o D3.js |
| Scraping | BeautifulSoup / Scrapy |
| Scoring | Reglas explícitas + Isolation Forest + (futuro) scikit-learn |
| LLM | Claude (procesamiento de documentos, destilación) |
| Pagos | Culqi (donativos) |
| Hosting | Hetzner VPS (API + Neo4j + workers), Vercel (frontend) |
| Package manager | **pnpm** — nunca npm ni yarn |

---

## Índice de Exposición al Riesgo (IER)

Score numérico **0 a 100** por funcionario. Cruza 6 dimensiones:

| # | Dimensión | Fuente |
|---|---|---|
| 1 | Declaraciones juradas de bienes | SUNAT / SERVIR |
| 2 | Procesos disciplinarios | SERVIR / Contraloría |
| 3 | Sentencias y procesos penales | Poder Judicial |
| 4 | Contratos con el Estado | SEACE |
| 5 | Incremento patrimonial inconsistente | Cruce declaraciones vs. ingresos |
| 6 | Historial de cargos | Rotación inusual, cargos simultáneos |

**El IER es un score de riesgo, no de culpabilidad.** Cada punto tiene fuente verificable.

### Modelo de scoring — 3 capas ([DEC-003](DECISIONS.md#dec-003))

1. **Reglas explícitas** — umbrales deterministas (auditable desde día 1)
2. **Anomaly detection** — Isolation Forest (sin etiquetas)
3. **ML supervisado** — Random Forest / XGBoost (fase futura, requiere datos etiquetados)

Referencia: Serenata de Amor (okfn-brasil)

---

## Fuentes de datos

| Fuente | API | Método | Prioridad |
|---|---|---|---|
| OSCE/SEACE | ✅ REST (OCDS) | API estándar OCDS | 1 |
| MEF Portal Transparencia | ❌ | Scraping | 2 |
| INFOBRAS | ❌ | Scraping | 2 |
| Contraloría General | ❌ PDFs + web | Scraping + PDF parsing | 2 |
| Poder Judicial | ❌ | Scraping | 2 |
| SERVIR | TBD | TBD | 2 |
| RENIEC | ❌ Solo convenio Estado | No viable fase 1 | — |
| SUNAT declaraciones | ❌ No pública | No viable fase 1 | — |

---

## Módulos del sistema

### Módulo 01 · IER Core
Motor central de scoring. Agrega y pondera las 6 dimensiones por funcionario. Cada actualización documentada con fuente, fecha y delta.

### Módulo 09 · Noticias — Scoring de Veracidad y Riesgo
Pipeline: scraping diario → clasificación por funcionario (NER) → scoring de veracidad (0.0–1.0) → impacto ponderado al IER → registro .md por evento.

Campos del .md por evento:
```
- funcionario, cargo, fecha, titular, medio, URL
- nivel de veracidad (0.0–1.0), justificación
- resumen del acto, impacto al IER (delta), fecha de registro
```

### Módulo 10 · Jurídico — Lógica Difusa
Leyes destiladas a .md → base de casos indexados → motor lógica difusa → probabilidades de resultados con referencias exactas (artículos + casos previos).

Motor candidato: `scikit-fuzzy` o `simpful` (Python).

### Módulo 11 · Competencia Dual — Inteligencia & Moral
Score bidimensional: **Moral** (IER existente) + **Inteligencia** (pruebas periódicas voluntarias). Plataforma de pruebas: Galendor.

### Módulo 13 · LexGraph
Derecho como grafo de precedentes. Neo4j o Kuzu. Integra con Módulo 10.

---

## Principios de diseño

1. **Trazabilidad total** — cada punto IER tiene fuente, fecha y justificación
2. **Auditabilidad humana** — .md legibles por personas, no solo máquinas
3. **Datos abiertos únicamente** — sin extracción de datos privados
4. **Lógica difusa sobre certezas falsas** — honesto sobre incertidumbre
5. **Transparencia radical** — código y metodología públicos
6. **Impacto social sobre monetización**

---

## Marco legal

| Ley | Descripción |
|---|---|
| Ley 27806 | Transparencia y Acceso a la Información Pública |
| Ley 27815 | Código de Ética de la Función Pública |
| Ley 29733 | Protección de Datos Personales |

---

## Formato de datos internos

`.md` como formato primario para LLM (38% menos tokens que JSON).
CSV incrustado en .md para datos tabulares masivos.
YAML para relaciones jerárquicas (funcionario → institución → contratos).

---

## Repositorios

| Repo | Contenido |
|---|---|
| github.com/garendil/garendil | Brain — docs, decisiones, roadmap |
| github.com/garendil/garendil-api | FastAPI v0.7 — 60+ endpoints, scoring Layer1/2/3 |
| github.com/garendil/garendil-web | Next.js v0.7 — homepage, buscador |
| github.com/garendil/garendil-infra | Docker Compose, k8s, schemas |
| github.com/garendil/garendil-workers | Scraping workers (OSCE, MEF, etc.) |
