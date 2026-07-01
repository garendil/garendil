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

## Rutina de cierre de sesión — OBLIGATORIO

1. Actualizar STATUS.md (estado actual, commits recientes, alertas, próximos pasos)
2. git add . && git commit -m "docs: end-of-session sync $(date +%Y-%m-%d)"
3. git push (brain + repos de código que tuvieron cambios)

⚠️ Sin push al final de sesión, Perplexity lee datos desactualizados en GitHub
   la próxima vez que use MCP para tomar contexto del proyecto.
