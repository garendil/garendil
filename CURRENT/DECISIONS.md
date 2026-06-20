# DECISIONS.md — Decisiones técnicas vigentes

> Solo decisiones activas. Historial superseded → ARCHIVE/DECISIONS-HISTORY.md
> Fuente canónica: este archivo. El del root es redirect.
> Mantenido por Perplexity + usuario. Claude Code solo lee.

---

## DEC-001
**Título:** Unidad de análisis: persona natural por DNI
**Fecha:** 2026-05-17 | **Estado:** ✅ Vigente
**Decisión:** Búsqueda principal por DNI de persona natural (no por cargo ni institución).
**Motivo:** DNI es el identificador único inequívoco en el sistema peruano.

---

## DEC-002
**Título:** Open source: repositorio público
**Fecha:** 2026-05-17 | **Estado:** ✅ Vigente
**Decisión:** Repositorio público en GitHub. Metodología IER transparente y auditable.
**Motivo:** Credibilidad depende de verificabilidad. Un scoring opaco no tiene legitimidad cívica.

---

## DEC-003
**Título:** Modelo de scoring: arquitectura híbrida 3 capas
**Fecha:** 2026-05-17 | **Estado:** ✅ Vigente
**Decisión:** Scoring en 3 capas:
1. Reglas explícitas (umbrales deterministas — auditable desde día 1)
2. Anomaly detection — Isolation Forest (sin etiquetas)
3. ML supervisado — Random Forest / XGBoost (cuando haya casos etiquetados)
**Referencia:** Serenata de Amor (okfn-brasil)

---

## DEC-004
**Título:** Stack frontend: Next.js + App Router en Vercel
**Fecha:** 2026-05-17 | **Estado:** ✅ Vigente
**Decisión:** Next.js con App Router, desplegado en Vercel. SSR para perfiles (/perfil/[dni]) — indexables por Google.
**Descartado:** Vite + React SPA (sin SSR = perfiles no indexables)

---

## DEC-005
**Título:** Stack backend: FastAPI en Hetzner VPS
**Fecha:** 2026-05-17 | **Estado:** ✅ Vigente
**Decisión:** FastAPI (Python) en Hetzner VPS. Workers de scraping también en Hetzner. No usar Render.

---

## DEC-006
**Título:** Auth y sesiones: Supabase Auth
**Fecha:** 2026-05-17 | **Estado:** ✅ Vigente
**Decisión:** Supabase gestiona auth y sesiones. Sin cuentas admin especiales — gestión vía Supabase dashboard y SSH a Hetzner.
**Ver también:** [DEC-016](#dec-016)

---

## DEC-007
**Título:** Grafo de conexiones: Neo4j en Hetzner VPS
**Fecha:** 2026-05-17 | **Estado:** ✅ Vigente
**Decisión:** Neo4j como motor del grafo (funcionarios, empresas, contratos). En el mismo VPS de Hetzner.

---

## DEC-008
**Título:** Visualización de grafo: global, modo Obsidian
**Fecha:** 2026-05-17 | **Estado:** ✅ Vigente
**Decisión:** vis.js Network (preferido) o D3.js force-directed. Grafo disponible en todo el sitio en modo persistente.

---

## DEC-009
**Título:** Acceso por fases: registro obligatorio en Fase 1
**Fecha:** 2026-05-17 | **Estado:** ✅ Vigente
**Decisión:** Fase 1: registro obligatorio para consultas (reduce scraping/abuso). Fase 2: guardado de docs, comparativas, análisis con IA.

---

## DEC-010
**Título:** Actualización de datos: triggers + escaneo semanal
**Fecha:** 2026-05-17 | **Estado:** ✅ Vigente
**Decisión:** Triggers en fuentes de noticias (tiempo real) + escaneo semanal de fuentes menos activas (OSCE, Contraloría, etc.)

---

## DEC-011
**Título:** Exportación de perfiles como .md
**Fecha:** 2026-05-17 | **Estado:** ✅ Vigente
**Decisión:** Perfiles exportables como .md — legibles por IA y humanos. .md consume 38% menos tokens que JSON.

---

## DEC-012
**Título:** Perfil incluye perfil psicológico inferido con disclaimer
**Fecha:** 2026-05-17 | **Estado:** ✅ Vigente
**Decisión:** Perfil psicológico inferido de conductas públicas. SIEMPRE con disclaimer:
> "Este análisis no constituye un diagnóstico clínico. Se basa en conductas públicas documentadas."
Con citas a estudios académicos (APA).

---

## DEC-013
**Título:** Donativos: Culqi
**Fecha:** 2026-05-17 | **Estado:** ✅ Vigente
**Decisión:** Culqi como procesador de donativos (tarjetas + Yape). SDK React en frontend + API REST en backend.

---

## DEC-014
**Título:** Repositorio bajo org garendil en GitHub
**Fecha:** 2026-05-25 | **Estado:** ✅ Vigente
**Decisión:** Todos los repos bajo github.com/garendil. rodhandev NO es propietario de ningún repo de Garendil.

---

## DEC-015
**Título:** Herramientas candidatas para RAG con embeddings
**Fecha:** 2026-05-27 | **Estado:** 🔵 Pendiente de elección
**Opciones:**
- **Qdrant** — vector DB open source, auto-hosteable en Hetzner. Rust: alto rendimiento.
- **Pinecone** — SaaS gestionado. Rápido para prototipar, datos externos, costo por uso.
**Casos de uso:** búsqueda semántica sobre documentos jurídicos, noticias, contratos OSCE.
**Elección pendiente:** depende de si el deployment final es self-hosted (→ Qdrant) o gestionado (→ Pinecone).

---

## DEC-016
**Título:** Base de datos principal: Supabase (PostgreSQL gestionado)
**Fecha:** 2026-05-29 | **Estado:** ✅ Vigente
**Decisión:** garendil-api migra de PostgreSQL local a Supabase. SQLAlchemy conecta vía connection string de Supabase. Supabase gestiona auth ([DEC-006](#dec-006)), RLS y migraciones.
**Descartado:** PostgreSQL local standalone en Hetzner.
**Motivo:** Unificar auth + DB + RLS reduce complejidad operacional.
**Impacto en garendil-api:**
- Reemplazar `DATABASE_URL` local por connection string de Supabase
- `supabase-py` solo para auth y storage; SQLAlchemy sigue siendo ORM para queries
- RLS habilitado en tablas de usuarios según migration 001

---

## DEC-017
**Título:** Supabase connection pooler: Transaction Pooler por defecto
**Fecha:** 2026-05-29 | **Estado:** ✅ Vigente
**Decisión:** Transaction Pooler (puerto 6543). `app/db/base.py`: `QueuePool(pool_size=5, max_overflow=0)`.
**Migrar a Session Pooler (puerto 5432) si:** ORM requiere estado persistente de conexión; backend serverless; errores `prepared statement already exists` con asyncpg.
**Cambio requerido al migrar:**
```python
from sqlalchemy.pool import NullPool
engine = create_async_engine(SUPABASE_DB_URL, poolclass=NullPool)
# SUPABASE_DB_URL → puerto 5432
```

---

## DEC-018
**Título:** Búsqueda principal: DNI → redirect directo al perfil
**Fecha:** 2026-05-29 | **Estado:** ✅ Vigente
**Decisión:** DNI exacto (8 dígitos) → redirect directo a `/perfil/[dni]`. Búsqueda por nombre → lista de resultados `/buscar?q=nombre`.
**UX:** Input detecta si valor es numérico 8 dígitos → redirect; si texto → lista con filtros (institución, cargo, rango IER).

---

## DEC-019
**Título:** Representación visual del score IER: número + color + etiqueta
**Fecha:** 2026-05-29 | **Estado:** ✅ Vigente
**Decisión:** IER siempre: número (0–100) + color semafórico + etiqueta.
- 0–39: verde (`--color-success`) — "Riesgo Bajo"
- 40–69: naranja (`--color-warning`) — "Riesgo Medio"
- 70–100: rojo (`--color-error`) — "Riesgo Alto"
En perfil: IER global desglosado en 3 sub-scores (corrupción, competencia, adecuación al cargo).
**Descartado:** barras de progreso como representación principal.

---

## DEC-020
**Título:** Página de perfil: layout 2 columnas — grafo + chat RAG lateral
**Fecha:** 2026-05-29 | **Estado:** ✅ Vigente
**Decisión:** `/perfil/[dni]` — 2 columnas en desktop:

**Columna principal (~65%):** header IER, grafo vis.js Network interactivo (nodos clickeables + arrastrables), línea de tiempo de cargos, contratos OSCE, alertas (Contraloría + Poder Judicial), fuentes.

**Columna lateral (~35%):** chat IA sticky con RAG sobre noticias diarias scrapeadas + documentos jurídicos + perfil estructurado. Cita fuentes. No inventa.

**Pipeline noticias:** garendil-workers scraping 24h → embeddings → Qdrant/Pinecone ([DEC-015](#dec-015)) → retrieval semántico.

**Fases:** Fase 1 MVP: grafo + secciones estáticas (sin chat). Fase 2: chat RAG. Fase 3: grafo global.

**APIs nuevas:** `GET /api/perfil/{dni}/grafo`, `POST /api/chat/{dni}`.
