# SESSIONS.md — Historial de sesiones

> Mantenido por Perplexity + usuario al cierre de cada sesión.
> Entrada más reciente arriba.
> Este archivo es referencia histórica — no fuente primaria.

---

## Sesión 007 — 2026-06-04

**Agente principal:** Claude Code + Perplexity + usuario
**Tema:** Auditoría completa del proyecto post-pausa (commit `abacd45`)

**Resuelto:**

| Repo | Estado | Detalle |
|------|--------|---------|
| garendil-api | ✅ | 20+ endpoints operativos, sin 501s, arquitectura Supabase en orden |
| garendil-web | ✅ | 6 páginas funcionales incluyendo perfil SSR con IER + vis.js; login/register son placeholders intencionales (Fase 1) |
| garendil-infra | ✅ | setup-hetzner.sh, deploy.sh, nginx SSL, docker-compose listos para producción |
| garendil-workers | ⚠️ | OSCE fetch funciona; storage layer (→ Supabase + Neo4j) pendiente en línea 34 |
| garendil-brain | ✅ | CURRENT/ completo y sincronizado; bug menor: README.md dice `npm install` en vez de `pnpm` |

**Sin bugs críticos en código.** Todo el bloqueo es de infraestructura/secrets.

**4 bloqueos para deploy MVP (en orden):**
1. Crear proyecto Supabase → obtener secrets reales
2. Ejecutar `supabase_001_initial_schema.sql` en Supabase SQL Editor
3. Configurar `.env` en Hetzner VPS
4. Correr `setup-hetzner.sh` + `deploy.sh`

**Pendiente para próxima sesión:**
- Crear proyecto Supabase (manual) → obtener SUPABASE_URL, SUPABASE_SERVICE_KEY, SUPABASE_DB_URL, SUPABASE_ANON_KEY
- Ejecutar `supabase_001_initial_schema.sql` en Supabase SQL Editor
- Provisionar Hetzner VPS y ejecutar `setup-hetzner.sh`
- Deploy garendil-web en Vercel con variables de entorno
- Smoke test end-to-end (registro → login → request autenticada)
- Fix menor: README.md `npm install` → `pnpm install`
- Implementar storage layer en garendil-workers (línea 34)

---

## Sesión 006 — 2026-05-31

**Agente principal:** Claude Code + Perplexity + usuario
**Tema:** Scripts de infraestructura y configuración de deploy para Fase 1

**Resuelto:**

garendil-infra:
- `docker-compose.prod.yml` — API + Neo4j + Redis en Docker; API bound a 127.0.0.1:8000; sin postgres (Supabase externo)
- `nginx/nginx.prod.conf` — Reverse proxy HTTPS + HSTS + certbot path; placeholder DOMAIN
- `scripts/setup-hetzner.sh` — Provisioning inicial VPS: instala Docker, nginx, certbot, ufw; clona repos; obtiene SSL
- `scripts/deploy.sh` — Redeploy: git pull → docker build → up → health check
- `env.prod.example` — Template de variables con notas de DEC-017 (Transaction Pooler)

garendil-web:
- `vercel.json` creado — framework nextjs, pnpm build
- `.env.example` bug fix: `API_URL` → `NEXT_PUBLIC_API_URL` (el código lo requería con prefijo)

**Variables pendientes (el usuario las provee):**

Hetzner VPS — `/opt/garendil/.env`:
- SUPABASE_URL
- SUPABASE_SERVICE_KEY
- SUPABASE_DB_URL (Transaction Pooler, puerto 6543 — DEC-017)
- NEO4J_PASSWORD
- CORS_ORIGINS=https://garendil-web.vercel.app

Vercel dashboard — Settings → Environment Variables:
- NEXT_PUBLIC_SUPABASE_URL
- NEXT_PUBLIC_SUPABASE_ANON_KEY
- NEXT_PUBLIC_API_URL=https://api.TU_DOMINIO

**Flujo de deploy cuando se tenga el VPS:**
1. `ssh root@<VPS_IP>`
2. `curl -fsSL .../setup-hetzner.sh | bash -s api.TU_DOMINIO tu@email.com`
3. Completar `/opt/garendil/.env` con secrets reales
4. `/opt/garendil/garendil-infra/scripts/deploy.sh`

**Pendiente para próxima sesión:**
- Crear proyecto Supabase (manual) → obtener las 3 variables
- Ejecutar `supabase_001_initial_schema.sql` en Supabase SQL Editor
- Provisionar Hetzner VPS y ejecutar `setup-hetzner.sh`
- Deploy garendil-web en Vercel con variables de entorno
- Smoke test end-to-end (registro → login → request autenticada)
- Implementar login/register funcionales en garendil-web (actualmente placeholders)

---

## Sesión 005 — 2026-05-31

**Agente principal:** Claude Code + usuario
**Tema:** Reorganización documental — arquitectura CURRENT/ + ARCHIVE/

**Resuelto:**
- Creada estructura CURRENT/ con 6 archivos canónicos (~22KB total)
- Creada estructura ARCHIVE/ con historial
- CURRENT/ARCHITECTURE.md: nuevo archivo con stack, IER, módulos, fuentes
- CURRENT/SERVERS.md: nuevo archivo con topología de infra (Hetzner, Supabase, Vercel)
- CURRENT/DECISIONS.md sincronizado con DEC-001 a DEC-020
- Archivos root actualizados como redirects a CURRENT/
- CLAUDE.md (brain + workspace) actualizados con reglas de lectura y 5 reglas documentales
- README.md actualizado con tabla de arquitectura documental

**Pendiente para próxima sesión:**
- Deploy garendil-web en Vercel
- Setup Hetzner VPS para garendil-api
- Crear proyecto Supabase y ejecutar migration 001

---

## Sesión 004 — 2026-05-29

**Agente principal:** Claude Code + Perplexity + usuario
**Tema:** Integración Supabase en garendil-api — DB + Auth middleware

**Resuelto:**
- Creada estructura CURRENT/ con 6 archivos canónicos (~22KB total)
- Creada estructura ARCHIVE/ con historial
- CURRENT/ARCHITECTURE.md: nuevo archivo con stack, IER, módulos, fuentes
- CURRENT/SERVERS.md: nuevo archivo con topología de infra (Hetzner, Supabase, Vercel)
- CURRENT/DECISIONS.md, STATUS.md, ROADMAP.md, AGENTS-PROTOCOL.md: versiones canónicas
- Archivos root actualizados como redirects a CURRENT/
- CLAUDE.md (brain + workspace) actualizados con nuevas reglas de lectura
- README.md actualizado con tabla de arquitectura documental

**Pendiente para próxima sesión:**
- Deploy garendil-web en Vercel
- Setup Hetzner VPS para garendil-api
- Crear proyecto Supabase y ejecutar migration 001

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
- Implementada arquitectura Supabase en garendil-api (commit db4d473)

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
