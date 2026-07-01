---
type: log
title: "Status"
description: "Escrito por Claude Code al inicio/fin de cada sesión. Se sobreescribe completo. Sin historial acumul"
tags: [documentation]
timestamp: 2026-06-20
volatile: true
---

# STATUS.md — Estado en tiempo real

> Escrito por Claude Code al inicio/fin de cada sesión. Se sobreescribe completo. Sin historial acumulado.
> Fuente canónica: este archivo. El del root es redirect.

---

## Sesión actual
- **Fecha:** 2026-06-04
- **Agente:** Claude Code
- **Estado:** Auditoría post-pausa completada (6 días sin actividad desde 2026-05-29)

---

## AUDITORÍA GARENDIL — 2026-06-04

### garendil-api ✅

- **Estado general:** ✅ Arquitectura sólida, sin bugs críticos
- **Tests:** Estructura correcta (7 archivos), `pytest` no instalado en entorno local — no ejecutable
- **Endpoints operativos (20+):**
  - `GET /health`, `GET /health/full`
  - `GET /api/search`, `GET /api/perfil/{dni}`, `GET /api/stats`
  - `GET /api/perfil/{dni}/scores`, `GET /perfil/{dni}/scores-cached`
  - `GET /dashboard/resumen`, `GET /dashboard/riesgo-top`, `GET /dashboard/tendencias`, `GET /dashboard/alertas`
  - `POST /dashboard/reportar-riesgo`
  - `POST /admin/sync-osce`, `POST /admin/train-layer2`, `POST /admin/train-layer3`, `POST /admin/sync-neo4j`
  - `GET /admin/layer3-status`
  - `POST /batch/score-funcionarios` (max 1000)
  - `GET /metrics` (Prometheus)
- **Endpoints 501 pendientes:** Ninguno — no hay 501s en el código
- **Problemas encontrados:**
  - 🟡 `app/monitoring/alerting.py` — TODO Slack webhook (no bloquea)
  - 🟡 `app/api/routes.py:426` — `"model_version": "v3-placeholder"` (Layer3 sin entrenar, correcto)
  - 🟡 Tests requieren `pytest` en entorno para ejecutar — código OK, entorno no

### garendil-web ✅

- **Estado general:** ✅ Estructura correcta, auth pages intencionales como placeholder
- **Páginas funcionales:**
  - `/` — Homepage (hero, stats, buscador DNI, perfiles recientes)
  - `/perfil/[dni]` — Perfil SSR completo (IER scores, grafo vis.js, contratos, export .md)
  - `/admin` — Dashboard admin
  - `/admin/status` — Status page
  - `/grafo` — Visualización grafo global
  - `/metodologia` — Explicación metodología IER
- **Páginas placeholder (Fase 1):**
  - `/login` — solo `<h1>`, sin implementación
  - `/register` — solo `<h1>`, sin implementación
- **Problemas encontrados:**
  - 🟡 [README.md](../README.md) usa `npm install` en vez de `pnpm` — violación DEC

### garendil-infra ✅

- **Estado general:** ✅ Listo para producción
- **Scripts listos:**
  - `setup-hetzner.sh` — provisioning inicial completo (Docker, nginx, certbot, UFW)
  - `deploy.sh` — redeploy con healthcheck
  - Valida que `.env` no tenga placeholders antes de deployar
- **docker-compose.prod.yml:** garendil-api + neo4j + redis, red interna `garendil-internal`, healthchecks
- **nginx/nginx.prod.conf:** HTTP→HTTPS, SSL Let's Encrypt, security headers, proxy a 127.0.0.1:8000
- **env.prod.example:** completo, cubre todas las variables del código
- **Problemas encontrados:**
  - 🟡 `docker-compose.prod.yml` — `NEO4J_PASSWORD:-changeme` (placeholder, se debe cambiar en prod — correcto, documentado)

### garendil-workers ⚠️

- **Estado general:** ⚠️ Implementación parcial (Fase 2)
- **Workers funcionales:**
  - `scraper/osce_worker.py` — fetch de API OCDS OSCE con paginación y retry ✅
- **Workers pendientes:**
  - `osce_worker.py` — storage layer (parse OCDS → Supabase + Neo4j) 🟡
  - MEF, Contraloría, Poder Judicial — no existen aún (Fase 2)
- **requirements.txt:** propio, completo (httpx, scrapy, supabase, neo4j, celery, redis)
- **Problemas encontrados:**
  - 🟡 Storage pendiente en osce_worker (line 34) — bloqueante para datos reales

### garendil (brain) ✅

- **Estado general:** ✅ Docs sincronizados, sin contradicciones
- **CURRENT/ completo:** STATUS.md ✅, [DECISIONS.md](DECISIONS.md) ✅, [ARCHITECTURE.md](ARCHITECTURE.md) ✅, [SERVERS.md](SERVERS.md) ✅, [ROADMAP.md](ROADMAP.md) ✅, [AGENTS-PROTOCOL.md](AGENTS-PROTOCOL.md) ✅
- **Archivos root:** son redirects correctos
- **Inconsistencias documentación vs. código:**
  - [README.md](../README.md) menciona `npm install` → debe ser `pnpm install` (menor)
  - Estado [DEC-017](DECISIONS.md#dec-017) (NullPool si Session Pooler) — código aún usa Transaction Pooler (correcto, no hay cambio pendiente)

---

## Próximos pasos recomendados (prioridad MVP)

1. **[BLOQUEANTE]** Crear proyecto Supabase — obtener `SUPABASE_DB_URL`, `SUPABASE_URL`, `SUPABASE_ANON_KEY`, `SUPABASE_SERVICE_KEY` reales
2. **[BLOQUEANTE]** Ejecutar `supabase_001_initial_schema.sql` en Supabase SQL Editor
3. **[BLOQUEANTE]** Configurar `/opt/garendil/.env` en Hetzner VPS con secrets reales
4. **[BLOQUEANTE]** Ejecutar `setup-hetzner.sh` y `deploy.sh` en VPS — deploy garendil-api
5. **[BLOQUEANTE]** Conectar garendil-web en Vercel (repo garendil/garendil-web)
6. Implementar login/register en garendil-web (`app/(auth)/login` y `register`)
7. Conectar buscador DNI del homepage al backend real
8. Implementar storage layer en `osce_worker.py` (OSCE → Supabase + Neo4j)
9. Fix menor: [README.md](../README.md) → cambiar `npm install` a `pnpm install`

---

## Estado de repos (commits)

| Repo | Último commit | Estado |
|------|--------------|--------|
| garendil/garendil-api | `db4d473` (Supabase DB arch) | ✅ En orden |
| garendil/garendil-web | `6862b39` (vercel.json + SPA) | ✅ En orden |
| garendil/garendil-infra | `c5f9d4f` (prod deployment) | ✅ En orden |
| garendil/garendil-workers | `2f3ce94` (OSCE worker sync) | ✅ En orden |
| garendil/garendil (brain) | `b373096` (CURRENT/ sync) | ✅ En orden |

---

## Alertas activas

1. **Pool conexiones:** Transaction Pooler (6543) con `pool_size=5`. Si se migra a Session Pooler (5432), cambiar a `NullPool` ([DEC-017](DECISIONS.md#dec-017)).
2. **Layer3 desactivado:** RandomForest necesita ≥50 muestras etiquetadas de Poder Judicial (Fase 2).
3. **[DEC-015](DECISIONS.md#dec-015) pendiente:** Qdrant vs Pinecone para RAG — no bloquea MVP.
4. **garendil-web usa axios** — rutas protegidas deben enviar `Authorization: Bearer <token>`.
5. **Repo obsoleto:** `/home/rodri/garendil-workspace/garendil/` (monorepo v0.7) sigue presente — no dañino pero redundante.
