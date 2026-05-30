# garendil — Scoring de Riesgo de Funcionarios Peruanos

> **Índice de Exposición al Riesgo (IER)** — plataforma pública que cruza bases de datos del Estado peruano para generar un score de riesgo por funcionario público.

[![Estado](https://img.shields.io/badge/estado-en%20desarrollo-yellow)](#)
[![Stack](https://img.shields.io/badge/stack-Python%20%2B%20FastAPI%20%2B%20Next.js-blue)](#)
[![Licencia](https://img.shields.io/badge/licencia-MIT-green)](#)

---

## ¿Qué es?

**Garendil** es un sistema cívico de transparencia que:

1. Recibe el DNI de un funcionario público peruano
2. Cruza automáticamente múltiples bases de datos del Estado
3. Calcula un **IER [0.0–1.0]** usando un modelo híbrido de 3 capas (reglas explícitas → anomaly detection → ML supervisado)
4. Muestra el desglose auditado de cada variable que contribuyó al score

> ⚠️ El IER es un **indicador de riesgo**, no una acusación. Todas las fuentes son públicas y verificables.

---

## Repos del ecosistema

| Repo | Propósito |
|---|---|
| [garendil/garendil](https://github.com/garendil/garendil) | Brain — decisiones, arquitectura, docs |
| [garendil/garendil-api](https://github.com/garendil/garendil-api) | Backend FastAPI — scoring IER y endpoints |
| [garendil/garendil-web](https://github.com/garendil/garendil-web) | Frontend Next.js — buscador público |
| [garendil/garendil-infra](https://github.com/garendil/garendil-infra) | Infraestructura — Docker Compose, Hetzner VPS |

---

## Fuentes de datos

| Fuente | Contenido |
|---|---|
| OSCE / SEACE | Licitaciones y contratos públicos (API REST OCDS) |
| MEF — Transparencia Económica | Contratos, transferencias, planillas |
| Contraloría General | Auditorías, observaciones, sanciones |
| INFObras | Ejecución de obras públicas |
| Poder Judicial | Procesos legales públicos |
| JNE | Declaraciones de bienes y rentas |

---

## Stack

- **Backend:** Python 3.12 + FastAPI
- **DB:** PostgreSQL 16 + Supabase (auth + RLS)
- **Grafo:** Neo4j
- **ETL:** requests + BeautifulSoup + Playwright
- **Scoring:** arquitectura híbrida — reglas explícitas + Isolation Forest + (futuro) scikit-learn
- **Frontend:** Next.js 14 App Router + Tailwind CSS
- **Grafo UI:** vis.js Network
- **Pagos/Donativos:** Culqi
- **Infra:** Hetzner VPS + Vercel (frontend)

---

## Setup rápido

```bash
# Clonar los repos necesarios
git clone https://github.com/garendil/garendil-api
git clone https://github.com/garendil/garendil-web
git clone https://github.com/garendil/garendil-infra

# Levantar infraestructura local
cd garendil-infra && docker-compose up -d

# API
cd ../garendil-api && pip install -r requirements.txt
uvicorn app.main:app --reload

# Web
cd ../garendil-web && npm install && npm run dev
```

---

## Marco legal

Proyecto basado únicamente en datos de acceso público conforme a:
- Ley N°27806 — Transparencia y Acceso a Información Pública
- Ley N°29733 — Protección de Datos Personales

---

## Estado

Ver [ROADMAP.md](./ROADMAP.md) para el estado actualizado de tareas.
Ver [DECISIONS.md](./DECISIONS.md) para las decisiones de arquitectura vigentes.

---

## Inspiración

Arquitectura de anomaly detection basada en [Serenata de Amor](https://github.com/okfn-brasil) (okfn-brasil, Brasil).
