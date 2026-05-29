# Actualización Notion — Página 05·Técnico

**Fecha:** 2026-05-17
**Versión:** v0.2

## Completado

| Item | Estado |
|------|--------|
| OSCE API integration | ✅ Cliente + rate limiting + retry |
| Modelos SQLAlchemy | ✅ 5 tablas (Funcionario, Empresa, Contrato, Proceso, Conexion) |
| ETL pipeline | ✅ OSCEIngester con Layer 1 scoring |
| Endpoints API | ✅ /search, /perfil/[dni], /stats, /admin/sync-osce |
| Frontend integración | ✅ Búsqueda + perfil con datos reales |
| Tests | ✅ 6 tests unitarios |
| Layer 1 scoring | ✅ empresa nueva, monto anomalo, exoneración |
| Worker scheduler | ✅ Sync diaria 02:00 AM |

## Próximas tareas

1. Scraping MEF (patrimonio declarado)
2. Layer 2 scoring (Isolation Forest)
3. Grafo interactivo (vis.js)
4. Deploy Vercel + Hetzner

**Actualizar campo "Última revisión":** 2026-05-17
