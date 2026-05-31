# STATUS.md — Estado en tiempo real

> Escrito por Claude Code al inicio/fin de cada sesión. Se sobreescribe completo. Sin historial acumulado.
> Fuente canónica: este archivo. El del root es redirect.

---

## Sesión actual
- **Fecha:** 2026-05-29
- **Agente:** Claude Code
- **Estado:** Arquitectura Supabase implementada en garendil-api

---

## Qué se hizo en esta sesión

### garendil-api — Supabase DB architecture (commit `db4d473`)

| Archivo | Acción | Descripción |
|---------|--------|-------------|
| `app/db/base.py` | Modificado | `DATABASE_URL` → `SUPABASE_DB_URL`; `NullPool` → `QueuePool(pool_size=5, max_overflow=0)` |
| `app/db/supabase_client.py` | Creado | Singleton supabase-py para auth/storage (no queries de negocio) |
| `app/middleware/__init__.py` | Creado | Export `AuthMiddleware` |
| `app/middleware/auth.py` | Creado | JWT verify vía Supabase; inyecta `request.state.user_id`; solo activo si `SUPABASE_URL` presente |
| `app/main.py` | Modificado | Registra `AuthMiddleware` condicionalmente |
| `db/migrations/supabase_001_initial_schema.sql` | Creado | Schema completo para Supabase SQL Editor |
| `requirements.txt` | Modificado | + `supabase>=2.3.0`, `asyncpg>=0.29.0`, `aiosqlite>=0.19.0`; - `psycopg2-binary` |
| `.env.example` | Actualizado | Variables Supabase + Redis + Neo4j + CORS |

---

## Estado de los repos

### garendil/garendil-api ✅
- FastAPI v0.7 + arquitectura Supabase implementada
- **Pendiente:** configurar `SUPABASE_DB_URL` real y ejecutar `supabase_001_initial_schema.sql`
- Tests: 27/27 passing (usan SQLite in-memory, no afectados por el cambio de URL)
- Middleware auth: desactivado en tests (no hay `SUPABASE_URL` en env de test)

### garendil/garendil-web ✅
- Next.js v0.7 + supabase libs + middleware + auth placeholders
- **Pendiente:** implementar login/register funcionales

### garendil/garendil-infra ✅
- docker-compose + k8s + neo4j schema + supabase migration

### garendil/garendil-workers ✅
- scraper/osce_worker.py — fetch funciona, storage pendiente

### garendil/garendil (brain) ✅
- Solo docs. Nueva arquitectura CURRENT/ + ARCHIVE/ implementada (2026-05-31).

---

## Conflictos encontrados (resueltos)

1. **`DATABASE_URL` en tests** — `tests/test_api.py` usa `TEST_DATABASE_URL = "sqlite+aiosqlite:///:memory:"` como constante local, no importa la variable de `base.py`. Sin conflicto.
2. **NullPool → QueuePool** — tests crean su propio engine con override completo. Sin conflicto.
3. **AuthMiddleware en tests** — middleware solo se registra si `SUPABASE_URL` está en env. Tests no lo setean. Sin conflicto.
4. **`aiosqlite` faltante** — estaba implícito pero no en requirements. Agregado.

---

## Schema Supabase (`supabase_001_initial_schema.sql`)

**6 tablas creadas:**
- `funcionarios` — con GIN index pg_trgm + unaccent en nombre, index score_ier DESC
- `empresas` — GIN trgm en razon_social
- `contratos` — FK a funcionarios + empresas, flags Layer1
- `procesos` — FK a funcionarios
- `conexiones` — FK origen + destino a funcionarios (CASCADE)
- `user_profiles` — UUID PK, FK a auth.users, plan free/pro, contadores consultas

**Features:**
- Trigger `updated_at` automático en todas las tablas
- RLS en `user_profiles` (usuarios ven solo su fila)
- Service role policy para backend
- Trigger `on_auth_user_created`: auto-crea user_profile al registrarse

---

## Pendiente inmediato

- [ ] **Crear proyecto Supabase** y obtener `SUPABASE_DB_URL` real
- [ ] **Ejecutar `supabase_001_initial_schema.sql`** en Supabase SQL Editor
- [ ] **Configurar secrets** en Hetzner VPS (SUPABASE_URL, SUPABASE_SERVICE_KEY, SUPABASE_DB_URL)
- [ ] **Deploy garendil-api** en Hetzner VPS
- [ ] **Deploy garendil-web** en Vercel
- [ ] **Implementar login/register** en garendil-web (app/(auth)/login y register son placeholders)
- [ ] **Conectar buscador DNI** al backend real

---

## Alertas

1. **`__pycache__/` ya excluido** — .gitignore de garendil-api fue actualizado externamente con `__pycache__/`. Alerta resuelta.
2. **Pool de conexiones:** Transaction Pooler (puerto 6543) con `pool_size=5`. Si se migra a Session Pooler (puerto 5432), cambiar a `NullPool`.
3. **DEC-015 pendiente:** Qdrant vs Pinecone para RAG. No bloquea MVP.
4. **garendil-web usa axios** — rutas protegidas deben enviar `Authorization: Bearer <token>`.
