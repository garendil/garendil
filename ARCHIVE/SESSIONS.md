# SESSIONS.md — Historial de sesiones

> Mantenido por Perplexity + usuario al cierre de cada sesión.
> Entrada más reciente arriba.
> Este archivo es referencia histórica — no fuente primaria.

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
- README.md actualizado con arquitectura documental

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
