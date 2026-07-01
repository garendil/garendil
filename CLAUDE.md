# garendil-workspace — CLAUDE.md

Workspace raíz del proyecto Garendil. Contiene todos los repos del ecosistema.

## Estructura

```
garendil-workspace/
├── garendil-brain/    → Docs, decisiones, roadmap (garendil/garendil en GitHub)
├── garendil-api/      → FastAPI backend v0.7 (60+ endpoints, IER Layer1/2/3)
├── garendil-web/      → Next.js 14 frontend v0.7 (homepage, perfil, metodología)
├── garendil-infra/    → docker-compose, k8s, nginx, scripts
└── garendil-workers/  → Scraping workers (OSCE, MEF, Contraloría, Poder Judicial)
```

## Reglas

- Package manager: **pnpm** — nunca npm ni yarn
- Repo canónico brain: github.com/garendil/garendil
- Nunca push a rodhandev/garendil
- Stack: FastAPI + Supabase + Neo4j (Hetzner) + Next.js (Vercel)

## Leer primero en cada sesión

1. `garendil-brain/CURRENT/STATUS.md` — estado en tiempo real
2. `garendil-brain/CURRENT/SERVERS.md` — topología de infra
3. `garendil-brain/CURRENT/DECISIONS.md` — decisiones técnicas vigentes
4. `garendil-brain/CLAUDE.md` — contexto completo del proyecto

Solo consultar `garendil-brain/ARCHIVE/` si la información necesaria no existe en `CURRENT/`.

## Arquitectura documental

- `garendil-brain/CURRENT/` — fuente de verdad operativa (priorizar siempre)
- `garendil-brain/ARCHIVE/` — referencia histórica (solo si se necesita contexto histórico)
- Ningún archivo en CURRENT/ supera 15 KB — si llega a ese límite, proponer archivado
---

## Convenciones OKF — obligatorio en todo archivo MD del brain

### Frontmatter obligatorio
Todo archivo creado o modificado en CURRENT/ debe tener:
```yaml
---
type: concept | runbook | reference | log
title: "Título del documento"
description: "Descripción breve (1-2 líneas)"
tags: [tag1, tag2]   # máximo 5
timestamp: YYYY-MM-DD
# Campos opcionales:
volatile: true        # solo STATUS.md
resource: ../ruta/    # apunta a código/CAD/assets fuera del brain (DEC-002)
refs:                 # apunta a otros docs del brain (DEC-004)
  - OTRO-DOC.md
  - DECISIONS.md
---
```

### Cuándo usar resource: vs refs:
- `resource:` → el doc describe un artefacto externo al brain (código, CAD, config)
  Ejemplo: ARCHITECTURE.md que documenta src/modulo/ → resource: ../../src/modulo/
- `refs:` → el doc depende o referencia otros docs del brain
  Ejemplo: REQUIREMENTS.md que referencia GROWTH.md → refs: [GROWTH.md, ROADMAP.md]

### Cross-references entre documentos
- Siempre usar links Markdown con anclas: [DEC-014](DECISIONS.md#dec-014)
- Nunca duplicar contenido de otro doc — solo referenciar
- Decisiones superadas: marcar [SUPERSEDED por DEC-XXX] al inicio de la sección
- Antes de crear contenido nuevo, verificar que no existe ya en otro archivo del brain

### Numeración DEC
- Formato: DEC-001, DEC-002... (secuencial por proyecto)
- Scope en commit: feat(DEC-XXX): o docs(DEC-XXX):
- Consultar DECISIONS.md para saber el próximo número disponible

---

### Límites y mantenimiento de archivos CURRENT/
- Tamaño máximo por archivo: ~15 KB — si supera, mover historial a ARCHIVE/
- División CURRENT/ARCHIVE: CURRENT/ solo tiene docs activos y vigentes
- ARCHIVE/ recibe: sesiones antiguas, DECs superadas, auditorías pasadas

### Sugerencias proactivas al cerrar sesión
Al final de cada sesión, evaluar y reportar:
- ¿Hay decisión tomada hoy que deba registrarse como DEC-XXX?
- ¿Algún archivo CURRENT/ está por superar ~15 KB?
- ¿STATUS.md refleja el estado real al cierre?

## Rutina de cierre de sesión — OBLIGATORIO

1. Actualizar STATUS.md (estado actual, commits recientes, alertas, próximos pasos)
2. git add . && git commit -m "docs: end-of-session sync $(date +%Y-%m-%d)"
3. git push (brain + repos de código que tuvieron cambios)

⚠️ Sin push al final de sesión, Perplexity lee datos desactualizados en GitHub
   la próxima vez que use MCP para tomar contexto del proyecto.
