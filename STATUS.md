# STATUS.md — Estado en tiempo real

> Este archivo lo escribe Claude Code al inicio/fin de cada sesión.
> Se sobreescribe completo. No tiene historial acumulado.
> Perplexity lo lee al inicio de cada sesión pero nunca lo modifica.

---

## Sesión actual
- **Fecha:** 2026-05-29
- **Agente:** Claude Code
- **Estado:** Migración monorepo → repos separados completada

---

## Qué se hizo en esta sesión

1. **Auditoría de diferencias** — comparado monorepo vs repos separados archivo por archivo
2. **garendil-api** — agregado `.env.example` faltante del monorepo
3. **garendil-web** — sincronizados desde monorepo:
   - `.env.example`
   - `lib/supabase/client.ts` + `server.ts` (Supabase SSR)
   - `middleware.ts` (protección de rutas para DEC-009)
   - `app/(auth)/login/page.tsx` + `register/page.tsx` (placeholders auth)
   - `package.json` actualizado con `@supabase/ssr` + `@supabase/supabase-js`
4. **garendil-infra** — sincronizados desde monorepo:
   - `neo4j/schema.cypher` (constraints + indexes)
   - `supabase/migrations/001_initial_schema.sql` (profiles + RLS)
5. **garendil-workers** — creado repo en GitHub, pusheado `scraper/osce_worker.py`
6. **garendil/garendil (este repo)** — convertido a brain puro:
   - `git rm -r apps/ infra/ workers/ package.json` (25 archivos de código)
   - `graphify-out/cache/` excluido del tracking (124 JSONs)
   - `.gitignore` actualizado

---

## Estado de cada repo tras la migración

### garendil/garendil — Brain (docs only) ✅
**Contiene:** CLAUDE.md, DECISIONS.md (DEC-001 a DEC-015), ROADMAP.md, SESSIONS.md,
TROUBLESHOOTING.md, AGENTS-PROTOCOL.md, README.md, docs/, graphify-out/, prompts/
**No contiene:** ningún código fuente

### garendil/garendil-api ✅
**Contiene:** FastAPI v0.7
- 60+ endpoints (search, perfil, scoring, admin, batch, metrics)
- Motor IER: Layer1Scorer (weight=0.7) + Layer2Scorer IsolationForest (weight=0.3) + Layer3Scorer RandomForest (weight=0.0)
- Redis cache TTL 7 días, Prometheus metrics, Sentry, audit trail
- Tests: 27/27 passing
- `.env.example` con Supabase + Neo4j vars
- **DB actual:** PostgreSQL local (pendiente migrar a Supabase)
- **Grafo:** Neo4j local (pendiente conectar Hetzner)

### garendil/garendil-web ✅
**Contiene:** Next.js 14 v0.7
- Homepage: hero + buscador DNI + stats + perfiles recientes + metodología + footer
- `/perfil/[dni]`: SSR, grafo vis.js, historial contratos, exportar .md
- `/grafo`: placeholder (pendiente Neo4j)
- `/metodologia`: spec completa del modelo IER
- Admin dashboard: `/admin` + `/admin/status`
- Auth: `lib/supabase/client.ts + server.ts`, `middleware.ts`, login/register placeholders
- Build: 0 errores, 8/8 páginas
- **Auth:** NO implementada aún (solo scaffolding)

### garendil/garendil-infra ✅
**Contiene:**
- `docker-compose.yml`: PostgreSQL + Neo4j + Redis para desarrollo local
- `k8s/`: namespace, deployment, HPA, PVC, secrets (CHANGE_ME), configmap
- `nginx.conf`: proxy reverso
- `neo4j/schema.cypher`: constraints + indexes
- `supabase/migrations/001_initial_schema.sql`: profiles + RLS
- `scripts/`: setup-env, build-docker, deploy-k8s

### garendil/garendil-workers ✅
**Contiene:**
- `scraper/osce_worker.py`: fetch desde API OCDS OSCE (fetch funciona, storage pendiente)
- `scraper/requirements.txt`: scrapy, httpx, celery, redis, supabase, neo4j
- `README.md`: workers planificados (MEF, Contraloría, Poder Judicial)

---

## Qué está pendiente

- [ ] **Conectar garendil-api a Supabase** (reemplazar PostgreSQL local)
- [ ] **Deploy garendil-api** en Hetzner VPS (DEC-005)
- [ ] **Deploy garendil-web** en Vercel (DEC-004)
- [ ] **Implementar auth Supabase** en garendil-web — login/register funcionales (DEC-009)
- [ ] **Conectar buscador DNI** al backend real
- [ ] **garendil-workers:** implementar storage a Supabase en osce_worker
- [ ] **Layer3 training:** requiere ≥50 samples etiquetados del Poder Judicial

---

## Alertas para Perplexity

1. **README.md actualizado** — Perplexity actualizó README.md y ROADMAP.md y SESSIONS.md en la misma sesión. Revisar que reflejen el stack real (Next.js, FastAPI, Supabase, no Integritas/scikit-fuzzy).
2. **DEC-015 pendiente:** elegir Qdrant vs Pinecone para RAG/embeddings. No bloquea MVP.
3. **garendil-api usa PostgreSQL local** — el código del API usa SQLAlchemy con Postgres. Antes del deploy, hay que decidir si migrar a Supabase (via supabase-py) o mantener Postgres y solo usar Supabase para auth.
4. **`__pycache__/` en garendil-api** — hay archivos `.pyc` tracked en git. Perplexity debe agregar `**/__pycache__/` al `.gitignore` de garendil-api en próxima sesión.
