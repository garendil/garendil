# Garendil — Runbook de Incidentes

## Síntoma: Scoring devuelve 0 para todos

**Causa probable:** Layer2 no entrenado.

```bash
curl -X POST http://localhost:8000/api/admin/train-layer2
```

---

## Síntoma: Redis down

**Impacto:** Caché no funciona; scoring sigue funcionando (fallback silencioso).

```bash
docker compose restart redis
```

---

## Síntoma: Neo4j no responde

**Impacto:** Grafo no sincroniza; API sigue funcionando.

```bash
docker compose restart neo4j
curl -X POST http://localhost:8000/api/admin/sync-neo4j
```

---

## Síntoma: DB queries lentas

```sql
ANALYZE;
SELECT * FROM pg_stat_user_indexes;
```

---

## Síntoma: Layer3 entrenamiento falla

**Causa probable:** Insuficientes datos etiquetados (< 50 samples).

```bash
curl http://localhost:8000/api/admin/layer3-status
# Esperar a que Poder Judicial confirme más casos
```

---

## Síntoma: Memory leak en API

```bash
docker compose restart api
```

---

## Health check completo

```bash
curl http://localhost:8000/api/health/full
```

---

## Escalada

| Tier | Tiempo | Condición |
|------|--------|-----------|
| 1 | < 1 min | Health check OK |
| 2 | 1–5 min | Una dependencia down, fallback activo |
| 3 | > 5 min | API completamente caída |
