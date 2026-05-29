# STATUS — 2026-05-29

> Escrito por Claude Code. Se sobreescribe completo cada sesión.
> Perplexity lo lee al inicio pero nunca lo modifica.

---

## Estructura actual del repo

Este repo (`garendil/garendil`) es el **brain/docs** del proyecto.
El código de desarrollo activo está en el monorepo local (no públicado aún en GitHub).

### Lo que existe aquí

| Ruta | Estado | Notas |
|------|--------|-------|
| `CLAUDE.md` | ✅ Completo | Contexto total para LLM. Vigente. |
| `DECISIONS.md` | ✅ Completo | DEC-001 a DEC-015 vigentes |
| `ROADMAP.md` | ✅ Vigente | Fases 0–3 definidas |
| `SESSIONS.md` | ✅ 1 sesión | Sesión 001 (2026-05-25) |
| `TROUBLESHOOTING.md` | ✅ Existe | — |
| `AGENTS-PROTOCOL.md` | ✅ Existe | — |
| `apps/web/` | ⚠️ Scaffold | Next.js 14 + Supabase + Tailwind. page.tsx = placeholder ("Garendil" texto). Sin auth, sin buscador real. |
| `apps/api/` | ⚠️ Scaffold | FastAPI + /health. Ambos endpoints en routers/funcionarios.py retornan 501. Sin scoring. |
| `workers/scraper/osce_worker.py` | 🔶 Parcial | fetch_contratos() funciona. Sin storage a Supabase aún. |
| `infra/neo4j/schema.cypher` | ✅ Completo | Constraints + indexes para Funcionario, Empresa, Contrato, Institucion |
| `infra/supabase/migrations/001_initial_schema.sql` | ✅ Real | profiles table + RLS policies |
| `docs/14-frontend-ux.md` | ✅ Completo | Especificación UI/UX de referencia |

---

## Código de desarrollo activo (fuera de este repo)

El monorepo local tiene **v0.7** con:

- FastAPI: 60+ endpoints, IER Layer1/Layer2/Layer3, Redis cache, Prometheus
- Next.js: homepage completa (buscador DNI, stats, perfiles recientes, metodología)
- Scoring: ScoringLayer ABC, IERCalculatorV3, RandomForest (layer3 weight=0.0 hasta datos etiquetados)
- Tests: 27/27 passing

Este código NO está en garendil/garendil aún.
Próximo paso: organizar en garendil-workspace y subir repos separados.

---

## Pendiente inmediato

- [ ] Crear `/home/rodri/garendil-workspace/` con repos separados (siguiendo patrón zhinova-workspace)
- [ ] Subir garendil-api (FastAPI v0.7) a GitHub bajo org garendil
- [ ] Subir garendil-web (Next.js v0.7) a GitHub bajo org garendil
- [ ] Conectar garendil-api a Supabase real (reemplazar PostgreSQL local)
- [ ] Implementar auth Supabase en garendil-web (DEC-009)
- [ ] Conectar homepage buscador DNI al backend real

---

## Inconsistencias detectadas

- `README.md` menciona nombres viejos: **Integritas**, **Mírantir**, **scikit-fuzzy**, **NetworkX** — todos reemplazados. Perplexity debe actualizar README.
- `ROADMAP.md` marca Fase 1 como no iniciada, pero el scaffold de Next.js ya existe.
- `apps/web/package.json` no incluye `lucide-react` ni `vis-network` (ambos en uso en v0.7 local).

---

## Alertas para Perplexity

1. **README.md desactualizado** — mencionar al usuario que hay que actualizarlo con stack real.
2. **Dos repos de código:** este repo (brain) y el monorepo local (v0.7 dev). En la próxima sesión se unificarán bajo garendil-workspace.
3. **DEC-015 pendiente:** elegir entre Qdrant (self-hosted Hetzner) y Pinecone (SaaS) para RAG/embeddings. No bloquea MVP pero hay que decidir antes de Fase 3.
4. **garendil-api no conecta a Supabase** — ambos endpoints retornan 501. Sin backend real hasta subir el v0.7 local.
