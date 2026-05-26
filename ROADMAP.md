# ROADMAP.md — Estado de tareas

> Mantenido por Perplexity + usuario.

## Fase 0 — Brain y estructura ✅
- [x] Definir stack completo
- [x] Definir modelo de scoring IER
- [x] Definir arquitectura de infraestructura
- [x] Crear CLAUDE.md
- [x] Crear STATUS.md, DECISIONS.md, SESSIONS.md, ROADMAP.md,
      TROUBLESHOOTING.md, AGENTS-PROTOCOL.md
- [x] Crear docs/14-frontend-ux.md (especificación UI/UX)

## Fase 1 — MVP frontend + buscador
- [ ] Inicializar Next.js App Router en apps/web/
- [ ] Diseño system: tokens, paleta, tipografía
- [ ] Homepage con buscador por DNI
- [ ] Página de perfil /perfil/[dni] con SSR
- [ ] Visualización de grafo básica (vis.js)
- [ ] Auth con Supabase (registro + login)
- [ ] Sección de donativos con Culqi

## Fase 2 — Backend + scoring
- [ ] Setup FastAPI en Hetzner VPS
- [ ] Setup PostgreSQL
- [ ] Setup Neo4j
- [ ] Worker ETL: OSCE API (OCDS)
- [ ] Workers scraping: MEF, Contraloría, Poder Judicial
- [ ] Implementar Capa 1 IER (reglas explícitas)
- [ ] Implementar Capa 2 IER (Isolation Forest)

## Fase 3 — Features avanzados
- [ ] Exportación de perfiles como .md
- [ ] Módulo 09 · Noticias (scoring de veracidad)
- [ ] Módulo 10 · Jurídico (lógica difusa)
- [ ] Módulo 11 · Competencia Dual
- [ ] Módulo 13 · LexGraph (Neo4j)
- [ ] Capa 3 IER (ML supervisado) cuando haya datos etiquetados
