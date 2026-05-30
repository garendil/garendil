# SESSIONS.md — Historial de sesiones

> Mantenido por Perplexity + usuario al cierre de cada sesión.
> Entrada más reciente arriba.

---

## Sesión 004 — 2026-05-29

**Agente principal:** Claude Code + Perplexity + usuario
**Tema:** Integración Supabase en garendil-api — DB + Auth middleware

**Resuelto:**
- `app/db/base.py`: migrado de `DATABASE_URL` local a `SUPABASE_DB_URL`; pool cambiado de `NullPool` a `QueuePool(pool_size=5, max_overflow=0, pool_recycle=300)`
- `app/db/supabase_client.py`: creado singleton supabase-py para auth/storage (no queries de negocio — eso sigue siendo SQLAlchemy)
- `app/middleware/auth.py`: JWT verify vía Supabase; inyecta `request.state.user_id`; no bloquea rutas públicas; solo activo si `SUPABASE_URL` presente en env
- `app/main.py`: registra `AuthMiddleware` condicionalmente
- `db/migrations/supabase_001_initial_schema.sql`: schema completo — 6 tablas (`funcionarios`, `empresas`, `contratos`, `procesos`, `conexiones`, `user_profiles`) + pg_trgm + triggers `updated_at` + RLS en `user_profiles` + trigger auto-create de user_profile en registro
- `requirements.txt`: añadido `supabase>=2.3.0`, `asyncpg>=0.29.0`, `aiosqlite>=0.19.0`; eliminado `psycopg2-binary` (redundante con asyncpg) y redis duplicado
- `.env.example`: variables completas Supabase + Redis + Neo4j + CORS
- 27 tests passing sin modificación (usan SQLite in-memory con override de `get_db`)

**Alertas activas (de STATUS.md):**
- Pool: Transaction Pooler puerto 6543 + `QueuePool`. Si se migra a Session Pooler (5432) → cambiar a `NullPool`
- `garendil-web` usa axios para API calls — rutas protegidas deben enviar `Authorization: Bearer <token>`
- DEC-015 pendiente: Qdrant vs Pinecone

**Pendiente para próxima sesión:**
- Crear proyecto en Supabase Dashboard → obtener `SUPABASE_URL`, `SUPABASE_SERVICE_KEY`, `SUPABASE_DB_URL`
- Ejecutar `supabase_001_initial_schema.sql` en Supabase SQL Editor
- Configurar secrets en Hetzner VPS
- Deploy garendil-api en Hetzner VPS
- Deploy garendil-web en Vercel
- Implementar login/register funcionales en garendil-web

---

## Sesión 003 — 2026-05-29

**Agente principal:** Perplexity + usuario + Claude Code
**Tema:** Sincronización código v0.7 a GitHub + auditoría del repo

**Resuelto:**
- Claude Code auditó el workspace local y detectó estado real del código
- Creados repos garendil/garendil-api, garendil/garendil-web, garendil/garendil-infra
- Push exitoso del código v0.7 a los 3 repos (98 + 25 + 14 archivos)
- Auditoría de secrets: todos os.getenv() con fallbacks, .env excluido
- Corregido README.md: eliminadas referencias a Integritas, Mírantir, scikit-fuzzy, NetworkX, androdstark
- Corregido ROADMAP.md: añadida Fase 0.5 con ítems completados, ajustados pendientes reales
- Adaptadas instrucciones del Space de Garendil (inspiradas en Zhinova)

**Pendiente para próxima sesión:**
- Deploy garendil-web en Vercel
- Configurar Hetzner VPS para garendil-api
- Conectar endpoints API (actualmente 501) a lógica real
- Resolver DEC-015: Qdrant vs Pinecone

---

## Sesión 002 — 2026-05-27

**Agente principal:** Perplexity + usuario
**Tema:** Herramientas RAG y vector database

**Resuelto:**
- Evaluadas opciones para capa RAG: Qdrant (self-hosted) vs Pinecone (SaaS)
- Registrada como DEC-015 — pendiente de elección final

**Pendiente:**
- Elegir entre Qdrant y Pinecone según decisión de deployment

---

## Sesión 001 — 2026-05-25

**Agente principal:** Perplexity + usuario
**Tema:** Definición de arquitectura completa del proyecto

**Resuelto:**
- Stack completo definido (Next.js, FastAPI, Supabase, Neo4j, Hetzner)
- Modelo de scoring IER: arquitectura híbrida 3 capas
- Unidad de análisis: persona natural por DNI
- Modelo de acceso: registro obligatorio en Fase 1
- Fuentes de datos mapeadas (OSCE API + scraping resto)
- Visualización de grafo: vis.js, modo persistente global
- Perfiles exportables como .md
- Tono visual: cívico y moderno
- Repo bajo org garendil (no cuenta personal rodhandev)

**Pendiente:**
- Inicializar estructura Next.js en apps/web/
- Construir homepage con buscador por DNI
- Construir página de perfil /perfil/[dni]
