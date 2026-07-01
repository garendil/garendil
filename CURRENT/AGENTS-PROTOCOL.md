---
type: runbook
title: "Agents Protocol"
description: "Mantenido por Perplexity + usuario cuando el flujo cambia. Claude Code solo lee."
tags: [protocol]
timestamp: 2026-06-20
---

# AGENTS-PROTOCOL.md — Protocolo de colaboración entre agentes

> Mantenido por Perplexity + usuario cuando el flujo cambia. Claude Code solo lee.
> Fuente canónica: este archivo.

---

## Agentes activos

| Agente | Rol | Acceso repo |
|---|---|---|
| **Perplexity** | Estrategia, decisiones, documentación | Lectura + escritura |
| **Claude Code** | Implementación técnica | Lectura + escritura |
| **Usuario** | Product owner, validación | — |

---

## División de responsabilidades

### Perplexity escribe
- [DECISIONS.md](DECISIONS.md) — decisiones técnicas y estratégicas
- [ROADMAP.md](ROADMAP.md) — estado actualizado de tareas
- `CURRENT/AGENTS-PROTOCOL.md` — cuando el flujo cambia
- [SESSIONS.md](../ARCHIVE/SESSIONS.md) — resumen de sesión al cerrar (entrada más reciente arriba)
- [TROUBLESHOOTING.md](../ARCHIVE/TROUBLESHOOTING.md) — bugs resueltos confirmados

### Claude Code escribe
- `CURRENT/STATUS.md` — único archivo. Se sobreescribe completo cada sesión. Sin historial acumulado.

### Claude Code solo lee
- [STATUS.md](STATUS.md), [DECISIONS.md](DECISIONS.md), [ROADMAP.md](ROADMAP.md)
- [ARCHITECTURE.md](ARCHITECTURE.md), [SERVERS.md](SERVERS.md)
- `CURRENT/AGENTS-PROTOCOL.md`
- [CLAUDE.md](../CLAUDE.md) (contexto global del proyecto)
- [docs/14-frontend-ux.md](../docs/14-frontend-ux.md) (especificación UI/UX del frontend)
- [ARCHIVE/](../ARCHIVE/) — solo si el tema lo requiere

### Perplexity solo lee
- [STATUS.md](STATUS.md) — leer al inicio para captar estado en tiempo real

---

## Rutina de inicio de sesión (Claude Code)

Al comenzar cualquier sesión técnica:
1. Leer [STATUS.md](STATUS.md) — estado actual
2. Leer [SERVERS.md](SERVERS.md) — topología de infra
3. Leer [DECISIONS.md](DECISIONS.md) — decisiones vigentes
4. Solo si el tema lo requiere: leer [ARCHITECTURE.md](ARCHITECTURE.md) o [docs/14-frontend-ux.md](../docs/14-frontend-ux.md)
5. Solo si se necesita contexto histórico: leer archivos en [ARCHIVE/](../ARCHIVE/)

---

## Flujo obligatorio antes de escribir en el repo

Leer → Auditar → Corregir → Documentar

1. Leer el archivo relevante antes de modificarlo
2. Auditar: ¿hay info desactualizada, duplicada o contradictoria?
3. Corregir lo que esté mal
4. Solo entonces hacer el commit con el contenido nuevo

---

## Reglas de la arquitectura documental

### CURRENT/ — fuente de verdad
- Solo estado actual y operativo
- Sin historial, sin decisiones superseded, sin logs
- Ningún archivo supera **15 KB** — si llega a ese límite, proponer división o archivado
- Toda IA debe priorizar CURRENT/ sobre ARCHIVE/

### ARCHIVE/ — referencia histórica
- Puede crecer indefinidamente
- Nunca es fuente primaria
- Solo consultar cuando se necesita contexto histórico explícito

---

## Regla principal

Las decisiones estratégicas y de arquitectura se toman entre Perplexity y el usuario. Claude Code implementa — no decide.

---

## Formato de commits

```
docs: [resumen breve]
feat: [resumen breve]
fix: [resumen breve]
refactor: [resumen breve]
```
