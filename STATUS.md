# STATUS — 2026-05-29

> Escrito por Claude Code. Se sobreescribe completo cada sesión.
> Perplexity lo lee al inicio pero nunca lo modifica.

---

## Ecosistema Garendil — repos activos en GitHub

| Repo | URL | Estado | Contenido |
|------|-----|--------|-----------|
| `garendil/garendil` | github.com/garendil/garendil | ✅ Brain/docs | CLAUDE.md, DECISIONS, ROADMAP, SESSIONS, docs/ |
| `garendil/garendil-api` | github.com/garendil/garendil-api | ✅ Pusheado hoy | FastAPI v0.7 — 60+ endpoints, IER Layer1/2/3 |
| `garendil/garendil-web` | github.com/garendil/garendil-web | ✅ Pusheado hoy | Next.js 14 — homepage completa, perfil SSR |
| `garendil/garendil-infra` | github.com/garendil/garendil-infra | ✅ Pusheado hoy | docker-compose, k8s, nginx |

---

## Workspace local

```
/home/rodri/garendil-workspace/
  CLAUDE.md              ← índice del workspace
  garendil-brain/        ← clone garendil/garendil (este repo)
  garendil-api/          ← FastAPI v0.7 (98 archivos tracked)
  garendil-web/          ← Next.js v0.7 (25 archivos tracked)
  garendil-infra/        ← docker-compose + k8s (14 archivos)
  garendil-workers/      ← placeholder (scraping workers pendientes)
```

---

## Estado del código — garendil-api (v0.7)

- FastAPI: 60+ endpoints activos
- Motor IER: Layer1Scorer + Layer2Scorer (IsolationForest) + Layer3Scorer (RandomForest, weight=0.0)
- IERCalculatorV3: pesos configurables, auditable
- Redis cache: TTL 7 días (redis.asyncio)
- Prometheus + Sentry + audit trail
- Tests: 27/27 passing
- DB: PostgreSQL local (pendiente migrar a Supabase)
- Grafo: Neo4j local (pendiente conectar a Neo4j en Hetzner)

## Estado del código — garendil-web (v0.7)

- Homepage: hero + buscador DNI + stats counter + perfiles recientes + metodología + footer
- /perfil/[dni]: SSR, grafo vis.js, historial contratos, exportar .md
- /grafo: placeholder
- /metodologia: spec completa del modelo IER
- Admin dashboard: /admin + /admin/status
- Build: 0 errores, 8/8 páginas

---

## Pendiente inmediato

- [ ] **Conectar garendil-api a Supabase** (reemplazar PostgreSQL local por Supabase)
- [ ] **Deploy garendil-api** en Hetzner VPS (DEC-005)
- [ ] **Deploy garendil-web** en Vercel (DEC-004)
- [ ] **Implementar auth Supabase** en garendil-web (DEC-009)
- [ ] **Conectar buscador DNI** al backend real (homepage → /api/search)
- [ ] **Layer3 training**: requiere datos etiquetados del Poder Judicial (≥50 samples)

---

## Alertas para Perplexity

1. **README.md de garendil/garendil desactualizado** — menciona Integritas, Mírantir, scikit-fuzzy, NetworkX. Debe actualizarse.
2. **DEC-015 pendiente**: elegir Qdrant vs Pinecone para RAG. No bloquea MVP.
3. **garendil-workers vacío** — solo placeholder. Workers de OSCE/MEF/Contraloría no implementados aún.
4. **garendil-api usa PostgreSQL local** — requiere migración a Supabase antes del deploy.
5. **Ambiente de desarrollo**: docker-compose en garendil-infra levanta PostgreSQL + Neo4j + Redis locales.

---

## Inconsistencias conocidas

- garendil/garendil `apps/web/` y `apps/api/` son scaffold antiguo — el código real está en garendil-web y garendil-api.
- `package.json` en garendil/garendil/apps/web/ falta lucide-react y vis-network.
- ROADMAP.md marca Fase 1 sin iniciar pero garendil-web ya tiene homepage completa.