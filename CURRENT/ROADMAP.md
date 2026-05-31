# ROADMAP.md — Estado de tareas

> Mantenido por Perplexity + usuario. Fuente canónica: este archivo.

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
- [x] Reorganización documental CURRENT/ + ARCHIVE/ (2026-05-31)

## Fase 1 — MVP frontend + buscador
- [ ] Diseño system: tokens, paleta, tipografía (basado en docs/14-frontend-ux.md)
- [ ] Homepage con buscador por DNI — pulir y conectar a API real
- [ ] Página de perfil /perfil/[dni] con SSR
- [ ] Visualización de grafo (vis.js) en página de perfil
- [ ] Auth con Supabase (registro + login)
- [ ] Sección de donativos con Culqi
- [ ] Deploy en Vercel apuntando a garendil/garendil-web

## Fase 2 — Backend + scoring conectado
- [ ] Setup Hetzner VPS — instalar PostgreSQL, Neo4j, FastAPI con PM2/systemd
- [ ] Conectar Supabase real (variables de entorno en producción)
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
