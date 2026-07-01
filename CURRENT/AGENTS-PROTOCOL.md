---
type: runbook
title: "Protocolo Agentes — Garendil"
description: "Flujo Perplexity ↔ Claude Code. Orden de lectura, autonomía y cierre."
tags: [protocol, agents, workflow]
timestamp: 2026-06-30
refs:
  - DECISIONS.md
  - STATUS.md
  - ARCHITECTURE.md
---

# AGENTS-PROTOCOL — Garendil

> Perplexity debate y genera prompts. Claude Code ejecuta; nunca decide.

## Contexto del proyecto
[Pendiente — leer VISION.md para completar contexto del proyecto]

## Orden de lectura obligatorio al iniciar sesión
1. STATUS.md — alertas activas
2. DECISIONS.md — últimas 5 DECs
3. ARCHITECTURE.md — stack Python FastAPI + Next.js + Neo4j + PostgreSQL
4. Solo si el tema lo requiere: ROADMAP.md, VISION.md

## Autonomía de Claude Code

### Puede hacer sin consultar:
- Leer cualquier archivo del brain
- Actualizar STATUS.md al cerrar sesión
- Agregar DECs a DECISIONS.md
- Corregir frontmatter OKF

### Debe consultar antes de hacer:
- Modificar ARCHITECTURE.md (decisiones de diseño del sistema)
- Cambiar dependencias críticas del stack
- Eliminar o renombrar archivos del brain
- [Pendiente — completar reglas específicas según dominio del proyecto]

## Anti-patrones prohibidos
- Resolver síntomas sin documentar causa raíz en DECISIONS.md
- Asumir que el repo está actualizado sin verificar STATUS.md
- [Pendiente — agregar anti-patrones específicos del proyecto]

## Checklist de cierre de sesión
- [ ] STATUS.md actualizado (estado, commits, alertas, próximos pasos)
- [ ] Nuevas decisiones en DECISIONS.md (DEC-XXX)
- [ ] git push (brain + repos de código con cambios)
- [ ] Sugerencias proactivas: ¿DEC pendiente? ¿archivo >15KB? ¿STATUS real?
