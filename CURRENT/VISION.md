---
type: reference
title: "Visión del Producto"
description: "Documento fundacional — qué es Garendil, para quién, y hacia dónde va. Claude Code debe leer este archivo antes de proponer cambios de arquitectura o nuevas funcionalidades."
tags: [vision, product, estrategia]
timestamp: 2026-06-29
---

# VISION.md — Garendil

## ¿Qué es Garendil?

Plataforma de monitoreo de funcionarios públicos peruanos basada en datos abiertos. Calcula un **Índice de Exposición al Riesgo (IER)** por funcionario (0-100) cruzando 6 dimensiones: declaraciones juradas, procesos disciplinarios, sentencias penales, contratos con el Estado, incremento patrimonial inconsistente, e historial de cargos.

**Valor diferencial:** Automatiza el cruce de fuentes públicas dispersas (SEACE, Contraloría, Poder Judicial) en un score verificable y auditado, permitiendo a periodistas y ciudadanos detectar patrones de riesgo que manualmente tomarían semanas.

## El problema que resuelve

**Problema:** Datos sobre funcionarios públicos en Perú están dispersos en múltiples portales (OSCE/SEACE, MEF, Contraloría, Poder Judicial, SERVIR), sin formato unificado, sin cruce automático, y sin alertas proactivas. Periodistas de investigación y ciudadanos no tienen herramientas para detectar patrones de riesgo tempranamente.

**Solución:** Garendil:
1. Agrega fuentes públicas automáticamente (scraping + APIs)
2. Calcula IER por funcionario con metodología transparente
3. Visualiza redes de relaciones (funcionario ↔ contratos ↔ empresas)
4. Alerta cuando el IER cruza umbrales o detecta anomalías
5. Exporta perfiles completos con fuentes verificables

**Inspiración:** Serenata de Amor (OKFN Brasil) — ML para auditar gasto público.

## Para quién

**Usuarios primarios:**
1. **Periodistas de investigación** — necesitan cruces rápidos de datos para investigaciones
2. **Sociedad civil organizada** — ONGs que monitorean contrataciones públicas
3. **Ciudadanos interesados** — verificar antecedentes de funcionarios

**Contexto de uso:**
- Web-first (Next.js + Tailwind)
- Búsqueda por DNI o nombre
- Perfil completo del funcionario con IER desglosado por dimensión
- Visualización de grafo de relaciones (vis.js)
- Export .md del perfil para periodismo

**No usuarios:** No es para denuncias directas (no hay módulo de reportes legales), ni para reemplazar a la Contraloría (es herramienta de análisis, no de auditoría oficial).

## Arquitectura de producto

**Stack tecnológico:**
- **Backend:** Python 3.12 + FastAPI + SQLAlchemy
- **Base de datos relacional:** PostgreSQL (Supabase)
- **Base de datos grafo:** Neo4j (Hetzner VPS)
- **Frontend:** Next.js 14 App Router + Tailwind CSS
- **Visualización grafo:** vis.js Network
- **Scraping:** BeautifulSoup / Scrapy
- **Scoring:** Reglas explícitas + Isolation Forest (capa 2) + futuro ML supervisado (capa 3)
- **LLM:** Claude (procesamiento documentos, destilación)
- **Hosting:** Hetzner VPS (API + Neo4j), Vercel (frontend)

**Flujo principal:**
```
Fuentes públicas (SEACE, Contraloría, PJ)
      ↓
Scraping/API → ingesta a PostgreSQL + Neo4j
      ↓
Scoring IER (3 capas: reglas + anomaly + ML)
      ↓
Indexación búsqueda + cache
      ↓
Frontend consulta perfil por DNI
      ↓
Visualización IER + grafo + export .md
```

**Módulos core:**
1. **IER Core** — motor central de scoring (6 dimensiones)
2. **Scraping workers** — ingesta asíncrona desde fuentes públicas
3. **Neo4j sync** — construcción grafo funcionario ↔ contratos ↔ empresas
4. **Dashboard admin** — status workers, entrenamiento ML, alertas
5. **Perfil público** — `/perfil/[dni]` con IER desglosado + grafo

## Principios que Claude Code debe respetar

### 1. IER es un score de riesgo, no de culpabilidad
- NUNCA etiquetar como "corrupto" o "culpable"
- Texto UI: "alto riesgo", "anomalías detectadas", "requiere revisión"
- Cada punto del IER tiene fuente pública verificable

### 2. Scoring multicapa, nunca caja negra
- **Capa 1:** Reglas explícitas (umbrales deterministas) — auditable desde día 1
- **Capa 2:** Isolation Forest (anomaly detection sin labels)
- **Capa 3:** ML supervisado (futuro, requiere datos etiquetados)
- Ver [DEC-003](DECISIONS.md#dec-003)

### 3. Fuentes verificables en cada dato
- Todo campo en perfil de funcionario tiene `source_url` + `date_fetched`
- Export .md incluye links a fuente original
- NO mostrar datos sin fuente verificable

### 4. pnpm, nunca npm ni yarn
- Workspace usa pnpm como package manager
- `package.json` scripts deben asumir pnpm
- Ver [DEC-016](DECISIONS.md#dec-016) si existe

### 5. Auth es Supabase Auth + JWT
- NO implementar auth custom
- Supabase Auth ya configurado
- JWT para API backend
- Ver [DEC-006](DECISIONS.md#dec-006)

### 6. Neo4j para grafo, PostgreSQL para relacional
- Relaciones funcionario ↔ contrato ↔ empresa → Neo4j
- Datos tabulares (scores, logs, cache) → PostgreSQL
- NO duplicar datos entre ambas DBs sin sincronización

## Estado actual

**Fase:** 1 — Auditoría post-pausa completada (2026-06-04)

**Componentes operativos:**
- ✅ API FastAPI (20+ endpoints funcionales)
- ✅ Frontend Next.js (homepage, perfil DNI, admin dashboard, grafo global)
- ✅ Scoring IER (capa 1 + capa 2 Isolation Forest activas)
- ✅ Supabase PostgreSQL + Neo4j en Hetzner

**Pendientes:**
- 🟡 Capa 3 ML supervisado (placeholder, sin entrenar)
- 🟡 Alertas Slack webhook (no bloquea)
- 🟡 Tests requieren `pytest` instalado en entorno local
- 🟡 Auth pages (`/login`, `/register`) son placeholder sin implementación

**Fuentes de datos:**
- ✅ OSCE/SEACE (API REST OCDS)
- 🔄 MEF, INFOBRAS, Contraloría, Poder Judicial (scraping en progreso)
- ❌ RENIEC, SUNAT declaraciones (no viables fase 1, requieren convenio Estado)

Ver [STATUS.md](STATUS.md) y [ROADMAP.md](ROADMAP.md) para estado detallado.
