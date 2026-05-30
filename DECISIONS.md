# DECISIONS.md — Decisiones técnicas y estratégicas

> Mantenido por Perplexity + usuario. Claude Code solo lee este archivo.
> Formato de ID: DEC-001, DEC-002, etc.

---

## DEC-001 · Unidad de análisis: persona natural por DNI
**Fecha:** 2026-05-17
**Estado:** ✅ Vigente
**Decisión:** La búsqueda principal es por DNI de persona natural.
No por cargo ni institución (se pueden agregar como filtros secundarios).
**Motivo:** Máxima especificidad. El DNI es el identificador único
inequívoco de un funcionario en el sistema peruano.

---

## DEC-002 · Open source: repositorio público
**Fecha:** 2026-05-17
**Estado:** ✅ Vigente
**Decisión:** El repositorio es público en GitHub. La metodología
del IER es transparente y auditable por cualquier persona.
**Motivo:** La credibilidad del sistema depende de que la metodología
sea verificable. Un sistema de scoring opaco no tiene legitimidad cívica.

---

## DEC-003 · Modelo de scoring: arquitectura híbrida 3 capas
**Fecha:** 2026-05-17
**Estado:** ✅ Vigente
**Decisión:** Scoring en 3 capas en orden de implementación:
1. Reglas explícitas (umbrales deterministas, auditable desde el día 1)
2. Anomaly detection — Isolation Forest (sin etiquetas requeridas)
3. ML supervisado — Random Forest / XGBoost (cuando haya casos etiquetados)
**Referencia:** arquitectura Serenata de Amor (okfn-brasil)

---

## DEC-004 · Stack frontend: Next.js + App Router en Vercel
**Fecha:** 2026-05-17
**Estado:** ✅ Vigente
**Decisión:** Next.js con App Router, desplegado en Vercel.
SSR para perfiles de funcionarios (/perfil/[dni]) — indexables por Google.
**Descartado:** Vite + React SPA (sin SSR = perfiles no indexables)

---

## DEC-005 · Stack backend: FastAPI en Hetzner VPS
**Fecha:** 2026-05-17
**Estado:** ✅ Vigente
**Decisión:** FastAPI (Python) corriendo en Hetzner VPS.
Workers de scraping también en Hetzner. No usar Render para workers.

---

## DEC-006 · Auth y sesiones: Supabase Auth
**Fecha:** 2026-05-17
**Estado:** ✅ Vigente
**Decisión:** Supabase gestiona auth y sesiones de usuario.
Sin cuentas de administrador especiales —
gestión directa vía Supabase dashboard y SSH a Hetzner.
**Ver también:** DEC-016 (Supabase como DB principal)

---

## DEC-007 · Grafo de conexiones: Neo4j en Hetzner VPS
**Fecha:** 2026-05-17
**Estado:** ✅ Vigente
**Decisión:** Neo4j como motor del grafo de relaciones entre
funcionarios, empresas y contratos. Corre en el mismo VPS de Hetzner.

---

## DEC-008 · Visualización de grafo: global, modo Obsidian
**Fecha:** 2026-05-17
**Estado:** ✅ Vigente — expandido por DEC-020
**Decisión:** vis.js Network (preferido) o D3.js force-directed.
El grafo está disponible en todo el sitio en modo persistente,
no como vista aislada.

---

## DEC-009 · Acceso por fases: registro obligatorio en Fase 1
**Fecha:** 2026-05-17
**Estado:** ✅ Vigente
**Decisión:**
- Fase 1: registro obligatorio para consultas (reduce scraping/abuso)
- Fase 2: guardado de documentos, comparativas, análisis con IA
**Sin cuentas admin:** gestión directa vía Supabase + SSH.

---

## DEC-010 · Actualización de datos: triggers + escaneo semanal
**Fecha:** 2026-05-17
**Estado:** ✅ Vigente — expandido por DEC-020 (noticias: scraping diario)
**Decisión:** Triggers en fuentes de noticias principales (tiempo real)
+ escaneo semanal de fuentes menos activas (OSCE, Contraloría, etc.)

---

## DEC-011 · Exportación de perfiles como .md
**Fecha:** 2026-05-17
**Estado:** ✅ Vigente
**Decisión:** Los perfiles de funcionarios son exportables como
archivos .md — legibles por IA y por humanos. .md consume 38% menos
tokens que JSON con el mismo contenido estructurado.

---

## DEC-012 · Perfil incluye perfil psicológico inferido con disclaimer
**Fecha:** 2026-05-17
**Estado:** ✅ Vigente
**Decisión:** El perfil incluye perfil psicológico inferido a partir
de conductas públicas documentadas. SIEMPRE con disclaimer visible:
"Este análisis no constituye un diagnóstico clínico. Se basa en
conductas públicas documentadas." Con citas a estudios académicos (APA).

---

## DEC-013 · Donativos: Culqi
**Fecha:** 2026-05-17
**Estado:** ✅ Vigente
**Decisión:** Culqi como procesador de donativos (tarjetas + Yape).
SDK React en frontend + API REST en backend.

---

## DEC-014 · Repositorio bajo org garendil en GitHub
**Fecha:** 2026-05-25
**Estado:** ✅ Vigente
**Decisión:** Todos los repos del ecosistema Garendil viven bajo
github.com/garendil. La cuenta personal rodhandev NO es propietaria
de ningún repo de Garendil.
**Supersede:** Referencia anterior a github.com/rodhandev/garendil

---

## DEC-015 · Herramientas candidatas para RAG con embeddings
**Fecha:** 2026-05-27
**Estado:** 🔵 Pendiente de elección — ver DEC-020 para contexto de uso
**Decisión:** Se evaluarán dos herramientas de vector database para
implementar la capa RAG (Retrieval-Augmented Generation) con embeddings:

- **Qdrant** — vector DB open source, auto-hosteable en Hetzner VPS.
  Escrito en Rust: alto rendimiento, bajo consumo de memoria.
  Opción preferida si el deployment es propio.
- **Pinecone** — vector DB gestionado (SaaS). Sin infraestructura
  que mantener. Más rápido para prototipar, pero datos fuera de
  nuestra infra y con costo por uso.

**Casos de uso previstos:** búsqueda semántica sobre documentos
jurídicos, noticias, contratos OSCE y resoluciones de Contraloría.
**Decisión de elección:** pendiente — depende de si el deployment
final es self-hosted (Hetzner → Qdrant) o gestionado (→ Pinecone).

---

## DEC-016 · Base de datos principal: Supabase (PostgreSQL gestionado)
**Fecha:** 2026-05-29
**Estado:** ✅ Vigente
**Decisión:** garendil-api migra de PostgreSQL local a Supabase como
base de datos principal. SQLAlchemy se conecta vía connection string de
Supabase (postgresql://). Supabase gestiona también auth (DEC-006),
RLS y migraciones (archivo base: supabase/migrations/001_initial_schema.sql
en garendil-infra).
**Descartado:** PostgreSQL local standalone en Hetzner como DB principal.
**Motivo:** Unificar auth + DB + RLS en una sola plataforma reduce
complejidad operacional. Supabase es PostgreSQL compatible — sin cambios
en SQLAlchemy ni en los modelos del ORM.
**Impacto en garendil-api:**
- Reemplazar `DATABASE_URL` local por connection string de Supabase
- Usar `supabase-py` solo para operaciones de auth y storage;
  SQLAlchemy sigue siendo el ORM para queries de negocio
- Habilitar RLS en tablas de usuarios según migration 001
**Siguiente paso:** Claude Code conecta garendil-api a Supabase
(reemplaza `DATABASE_URL`, verifica migraciones, ejecuta tests).

---

## DEC-017 · Supabase connection pooler: Transaction Pooler por defecto
**Fecha:** 2026-05-29
**Estado:** ✅ Vigente (con condición de migración documentada)
**Decisión:** Usar **Transaction Pooler** (puerto 6543) como modo de
conexion en Supabase. En `app/db/base.py`: `QueuePool(pool_size=5, max_overflow=0)`.

**Cuándo migrar a Session Pooler (puerto 5432):**
- Si se agrega un ORM que requiera estado de conexión persistente entre queries
  (e.g. `SET` variables de sesión, advisory locks, cursors con estado)
- Si se adopta un entorno serverless (Vercel Functions, AWS Lambda) para el backend
  → en ese caso Supabase recomienda `NullPool` + Session Pooler
- Si aparecen errores de tipo `prepared statement already exists` en PostgreSQL
  (síntoma clásico de Transaction Pooler con asyncpg + prepared statements)

**Cambio requerido al migrar:**
```python
# app/db/base.py — si se migra a Session Pooler (puerto 5432)
from sqlalchemy.pool import NullPool
engine = create_async_engine(SUPABASE_DB_URL, poolclass=NullPool)
# SUPABASE_DB_URL debe apuntar al puerto 5432, no 6543
```
**Responsable del cambio:** Claude Code (instruir explícitamente cuando aplique).

---

## DEC-018 · Búsqueda principal: por DNI con redirect directo al perfil
**Fecha:** 2026-05-29
**Estado:** ✅ Vigente
**Decisión:** Cuando el usuario busca por DNI exacto (8 dígitos), el sistema
redirige directamente a `/perfil/[dni]` sin pasar por una página de resultados.
Cuando busca por nombre (texto libre), muestra una lista de resultados con cards.
La búsqueda por nombre es un filtro secundario — el flujo principal y canónico
es DNI → perfil directo.
**Motivo:** El DNI es un identificador inequívoco (DEC-001). Si el usuario ya sabe
el DNI, no tiene sentido mostrar una lista de un solo resultado. Si busca por nombre,
puede haber homónimos — la lista es necesaria.
**UX en el buscador:**
- Input detecta si el valor es numérico de 8 dígitos → redirige directamente
- Si es texto → muestra página de resultados `/buscar?q=nombre`
- Filtros secundarios disponibles en `/buscar`: institución, cargo, rango de score IER

---

## DEC-019 · Representación visual del score IER: número + color + etiqueta
**Fecha:** 2026-05-29
**Estado:** ✅ Vigente
**Decisión:** El score IER se muestra siempre como:
1. **Número** (0–100, entero)
2. **Color semafórico:**
   - 0–39: verde (`--color-success`)
   - 40–69: amarillo/naranja (`--color-warning`)
   - 70–100: rojo (`--color-error`)
3. **Etiqueta de texto:** "Riesgo Bajo" / "Riesgo Medio" / "Riesgo Alto"

En la página de perfil, el IER global se desglosa en sus 3 sub-scores:
corrupción, competencia y adecuación al cargo — cada uno con el mismo
sistema numérico + color + etiqueta.
**Descartado:** barras de progreso como representación principal
(el número es más legible y comparable entre perfiles).

---

## DEC-020 · Página de perfil: layout interactivo con grafo + chat RAG lateral
**Fecha:** 2026-05-29
**Estado:** ✅ Vigente
**Decisión:** La página de perfil (`/perfil/[dni]`) tiene un layout en dos
columnas en desktop:

**Columna principal (izquierda, ~65%):**
- Header: nombre, cargo, institución, score IER global + desglose 3 dimensiones
- Grafo de conexiones interactivo (vis.js Network):
  - Nodos: funcionarios, empresas, contratos vinculados
  - Nodos clickeables: click en un nodo carga ese perfil en el grafo
  - Nodos arrastrables (drag & drop libre, modo Obsidian)
  - El nodo central es el funcionario consultado
  - Aristas etiquetadas con tipo de relación (contrato, sociedad, cargo compartido)
- Secciones debajo del grafo: línea de tiempo de cargos, contratos OSCE,
  alertas (Contraloría + Poder Judicial), fuentes

**Columna lateral (derecha, ~35%):**
- Panel de chat con IA (sticky, siempre visible al hacer scroll)
- El chat usa RAG con embeddings sobre:
  - Noticias scrapeadas diariamente (fuentes: El Comercio, La República,
    Gestión, IDL-Reporteros, OjoPúblico, etc.)
  - Documentos jurídicos y resoluciones vinculados al funcionario
  - El propio perfil estructurado del funcionario
- Ejemplos de preguntas válidas:
  - "¿Cuántas leyes ha apoyado?"
  - "¿Con qué personas tiene vínculos conocidos?"
  - "¿Ha tenido sanciones de la Contraloría?"
  - "¿Qué dicen las noticias recientes sobre esta persona?"
- El chat NO inventa — responde solo con lo que tiene en el índice RAG,
  citando las fuentes usadas en cada respuesta

**Pipeline de noticias (worker diario):**
- garendil-workers corre scraping de noticias cada 24h
- Cada noticia pasa por embedding (modelo a definir en DEC-015)
- Se indexa en la vector DB (Qdrant o Pinecone — DEC-015 pendiente)
- El chat recupera por similitud semántica al contexto del funcionario consultado

**Implementación por fases:**
- Fase 1 MVP: grafo + secciones estáticas (sin chat)
- Fase 2: chat RAG con noticias indexadas
- Fase 3: grafo global (Obsidian-style, navegación entre todos los perfiles)

**Dependencias técnicas:**
- vis.js Network (ya decisión en DEC-008)
- Vector DB: Qdrant self-hosted en Hetzner (pendiente DEC-015)
- Modelo de embeddings: sentence-transformers o OpenAI text-embedding-3-small
- API endpoint nuevo: `GET /api/perfil/{dni}/grafo` — devuelve nodos + aristas
- API endpoint nuevo: `POST /api/chat/{dni}` — recibe pregunta, devuelve respuesta RAG con fuentes
