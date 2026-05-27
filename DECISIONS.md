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

## DEC-006 · Auth y tablas relacionales: Supabase
**Fecha:** 2026-05-17
**Estado:** ✅ Vigente
**Decisión:** Supabase gestiona auth, sesiones de usuario y datos
tabulares relacionales. Sin cuentas de administrador especiales —
gestión directa vía Supabase dashboard y SSH a Hetzner.

---

## DEC-007 · Grafo de conexiones: Neo4j en Hetzner VPS
**Fecha:** 2026-05-17
**Estado:** ✅ Vigente
**Decisión:** Neo4j como motor del grafo de relaciones entre
funcionarios, empresas y contratos. Corre en el mismo VPS de Hetzner.

---

## DEC-008 · Visualización de grafo: global, modo Obsidian
**Fecha:** 2026-05-17
**Estado:** ✅ Vigente
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
**Estado:** ✅ Vigente
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
**Estado:** 🔵 Pendiente de elección
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
