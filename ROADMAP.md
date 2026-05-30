# ROADMAP.md — Estado de tareas

> Mantenido por Perplexity + usuario.

## Fase 0 — Brain y estructura ✅
- [x] Definir stack completo
- [x] Definir modelo de scoring IER
- [x] Definir arquitectura de infraestructura
- [x] Crear CLAUDE.md
- [x] Crear STATUS.md, DECISIONS.md, SESSIONS.md, ROADMAP.md, TROUBLESHOOTING.md, AGENTS-PROTOCOL.md
- [x] Crear docs/14-frontend-ux.md (especificación UI/UX)

## Fase 0.5 — Código base v0.7 sincronizado ✅
- [x] Inicializar monorepo con estructura apps/ workers/ infra/ docs/
- [x] Crear garendil/garendil-api en GitHub — FastAPI v0.7 (98 archivos, 60+ endpoints, scoring Layer1/2/3, 27 tests)
- [x] Crear garendil/garendil-web en GitHub — Next.js v0.7 (25 archivos, homepage, buscador por DNI)
- [x] Crear garendil/garendil-infra en GitHub — Docker Compose + k8s (14 archivos)
- [x] Schema Supabase con profiles + RLS
- [x] Schema Neo4j con constraints para Funcionario, Empresa, Contrato
- [x] Auditoría de secrets — todos os.getenv() con fallbacks dev, .env excluido de git

## Fase 0.7 — Integración Supabase en garendil-api ✅
- [x] Migrar DB connection de PostgreSQL local a Supabase (`SUPABASE_DB_URL`)
- [x] QueuePool configurado para Transaction Pooler (port 6543)
- [x] Singleton supabase-py para auth/storage
- [x] AuthMiddleware JWT — inyecta `user_id` en request.state, no bloquea rutas públicas
- [x] Schema SQL `supabase_001_initial_schema.sql` — 6 tablas + pg_trgm + RLS + triggers
- [x] 27 tests passing (SQLite in-memory, sin conflicto con cambios de pool)

## Fase 1 — MVP frontend + buscador
- [ ] **Crear proyecto Supabase** → obtener `SUPABASE_URL`, `SUPABASE_SERVICE_KEY`, `SUPABASE_DB_URL`
- [ ] **Ejecutar `supabase_001_initial_schema.sql`** en Supabase SQL Editor
- [ ] **Deploy garendil-api** en Hetzner VPS (configurar secrets + systemd)
- [ ] **Deploy garendil-web** en Vercel
- [ ] Implementar login/register funcionales en garendil-web (actualmente placeholders)
- [ ] Conectar buscador DNI al backend real (actualmente endpoints retornan 501)
- [ ] Página de perfil /perfil/[dni] con SSR
- [ ] Visualización de grafo (vis.js) en página de perfil
- [ ] Sección de donativos con Culqi

## Fase 2 — Backend + scoring conectado
- [ ] Setup Hetzner VPS — instalar Neo4j, configurar PM2/systemd para garendil-api
- [ ] Worker ETL: OSCE API (OCDS) con storage a PostgreSQL
- [ ] Workers scraping: MEF, Contraloría, Poder Judicial
- [ ] Endpoints API funcionando (actualmente retornan 501)
- [ ] Conectar frontend a API real

## Fase 3 — Features avanzados
- [ ] Exportación de perfiles como .md
- [ ] Módulo 09 · Noticias (scoring de veracidad)
- [ ] Módulo 10 · Jurídico (lógica difusa)
- [ ] Módulo 11 · Competencia Dual
- [ ] Módulo 13 · LexGraph (Neo4j)
- [ ] Capa 3 IER (ML supervisado) cuando haya datos etiquetados
- [ ] RAG con embeddings — Qdrant (self-hosted) o Pinecone (pendiente DEC-015)
