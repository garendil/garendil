---
type: reference
title: "Servers"
description: "Estado actual de los servidores y servicios. Solo info vigente."
tags: [infrastructure]
timestamp: 2026-05-31
---

# SERVERS.md — Topología de infraestructura

> Estado actual de los servidores y servicios. Solo info vigente.
> Mantenido por Perplexity + usuario.

---

## Servicios activos

| Servicio | Proveedor | Estado | Notas |
|---|---|---|---|
| **Supabase** | Supabase Cloud | ⚠️ Pendiente crear proyecto | Auth + PostgreSQL + RLS |
| **Hetzner VPS** | Hetzner | ⚠️ Pendiente provisionar | FastAPI + Neo4j + Workers |
| **Vercel** | Vercel | ⚠️ Pendiente deploy | garendil-web (Next.js) |

---

## Hetzner VPS

**Propósito:** garendil-api + Neo4j + scraping workers

**Stack a instalar:**
- FastAPI (Python 3.12) con PM2 o systemd
- Neo4j Community Edition
- Workers scraping (OSCE, MEF, Contraloría, Poder Judicial)

**Variables de entorno requeridas:**
```
SUPABASE_URL=
SUPABASE_SERVICE_KEY=
SUPABASE_DB_URL=postgresql://[user]:[pass]@[host]:6543/postgres
NEO4J_URI=bolt://localhost:7687
NEO4J_USER=neo4j
NEO4J_PASSWORD=
REDIS_URL=redis://localhost:6379
CORS_ORIGINS=https://garendil.pe,https://garendil-web.vercel.app
```

**Puertos:**
- 8000: FastAPI
- 7474: Neo4j Browser
- 7687: Neo4j Bolt
- 6379: Redis

---

## Supabase

**Propósito:** PostgreSQL gestionado + auth + RLS

**Pendiente:**
- Crear proyecto en app.supabase.io
- Ejecutar `garendil-infra/supabase/migrations/001_initial_schema.sql`
- Obtener `SUPABASE_DB_URL` (Transaction Pooler puerto 6543)
- Obtener `SUPABASE_URL` y `SUPABASE_ANON_KEY` y `SUPABASE_SERVICE_KEY`

**Pool de conexiones:**
- Usar Transaction Pooler (puerto 6543) con `pool_size=5, max_overflow=0`
- Si se migra a Session Pooler (puerto 5432) → cambiar a `NullPool`

**Tablas:** funcionarios, empresas, contratos, procesos, conexiones, user_profiles

---

## Vercel

**Propósito:** garendil-web (Next.js 14 App Router)

**Repo:** github.com/garendil/garendil-web

**Variables de entorno requeridas:**
```
NEXT_PUBLIC_SUPABASE_URL=
NEXT_PUBLIC_SUPABASE_ANON_KEY=
NEXT_PUBLIC_API_URL=https://api.garendil.pe
```

**Pendiente:**
- Conectar repo garendil/garendil-web a Vercel
- Configurar variables de entorno
- Configurar dominio garendil.pe (pendiente compra)

---

## Dominio

- **Dominio:** garendil.pe — pendiente de compra/registro
- **DNS previsto:** garendil.pe → Vercel (frontend), api.garendil.pe → Hetzner VPS
