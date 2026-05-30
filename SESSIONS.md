# SESSIONS.md — Historial de sesiones

> Mantenido por Perplexity + usuario al cierre de cada sesión.
> Entrada más reciente arriba.

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
