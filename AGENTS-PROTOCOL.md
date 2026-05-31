# AGENTS-PROTOCOL.md — Protocolo de colaboración entre agentes

> **REDIRECT** — Fuente canónica: [`CURRENT/AGENTS-PROTOCOL.md`](CURRENT/AGENTS-PROTOCOL.md)
> Este archivo se mantiene por compatibilidad. Editar en CURRENT/AGENTS-PROTOCOL.md.

> Mantenido por Perplexity + usuario cuando el flujo de trabajo cambia.
> Claude Code solo lee este archivo.

## Agentes activos

| Agente | Rol | Acceso repo |
|---|---|---|
| **Perplexity** | Estrategia, decisiones, documentación | Lectura + escritura |
| **Claude Code** | Implementación técnica | Lectura + escritura |
| **Usuario** | Product owner, validación | — |

## División de responsabilidades

### Perplexity escribe
- DECISIONS.md — decisiones técnicas y estratégicas
- SESSIONS.md — resumen de sesión al cerrar (entrada más reciente arriba)
- TROUBLESHOOTING.md — bugs resueltos confirmados
- ROADMAP.md — estado actualizado de tareas
- AGENTS-PROTOCOL.md — cuando el flujo de trabajo cambia

### Claude Code escribe
- STATUS.md — único archivo. Se sobreescribe completo cada sesión.
  Nunca tiene historial acumulado.

### Claude Code solo lee
- DECISIONS.md, ROADMAP.md, TROUBLESHOOTING.md, AGENTS-PROTOCOL.md
- CLAUDE.md (contexto global del proyecto)
- docs/14-frontend-ux.md (especificación UI/UX del frontend)

### Perplexity solo lee
- STATUS.md — leer al inicio para captar estado en tiempo real

## Rutina de inicio de sesión (Claude Code)

Al comenzar cualquier sesión técnica:
1. Leer STATUS.md — estado actual
2. Leer DECISIONS.md — decisiones vigentes
3. Solo si el tema lo requiere: leer el archivo específico

## Flujo obligatorio antes de escribir en el repo

No solo agregar — siempre: Leer → Auditar → Corregir → Documentar

1. Leer el archivo relevante antes de modificarlo
2. Auditar: ¿hay info desactualizada, duplicada o contradictoria?
3. Corregir lo que esté mal
4. Solo entonces hacer el commit con el contenido nuevo

## Regla principal

Las decisiones estratégicas y de arquitectura se toman entre
Perplexity y el usuario. Claude Code implementa — no decide.

## Formato de commits

docs: [resumen breve]
feat: [resumen breve]
fix: [resumen breve]
refactor: [resumen breve]
