---
type: reference
title: "GROWTH — Estrategia de Crecimiento"
description: "Estrategia de adquisición, canales y hitos comerciales. Mantenido por Perplexity + Rodhan. Claude Code NO modifica este archivo salvo instrucción explícita."
tags: [growth, comercial, adquisicion, estrategia]
timestamp: 2026-06-30
---

# GROWTH — Estrategia de Crecimiento

> Mantenido por Perplexity + Rodhan.
> Claude Code NO modifica este archivo salvo instrucción explícita.
> Última actualización: 2026-06-30
> 📝 Provisional — afinar con Rodhan en sesión dedicada

---

## Estado comercial actual

- Fase: Desarrollo MVP — 0 usuarios activos
- Producto: scoring IER (Índice de Exposición al Riesgo) para funcionarios públicos peruanos
- Monetización: pendiente definir (datos públicos, posible modelo premium/API)
- Stack: Python FastAPI + Next.js, fuentes OSCE/SEACE/Contraloría/Poder Judicial

---

## Usuario objetivo

**Target primario:** Periodistas de investigación y medios peruanos
- **Necesidad:** verificar contratos y vínculos de funcionarios antes de publicar
- **Pain point:** datos dispersos en múltiples portales del Estado
- **Frecuencia uso:** semanal (investigaciones profundas)
- **Precio objetivo:** gratis inicial (validar adopción), premium S/ 99-149/mes con API

**Target secundario:** ONGs transparencia (ProÉtica, IDL, convoca.pe)
- **Necesidad:** monitoreo sistemático de funcionarios de alto riesgo
- **Pain point:** scraping manual de cada fuente
- **Precio objetivo:** plan organizacional S/ 500-1000/mes

**Target terciario:** Ciudadanos verificando candidatos antes de votar

---

## Canales de adquisición — por prioridad

### 1. Twitter/X — periodistas y activistas cívicos

- Publicar casos concretos: "Funcionario X tiene IER 85/100 por [razones específicas]"
- Hilos mostrando vínculos ocultos detectados por sistema
- Hashtags: #TransparenciaPerú #Anticorrupción #DatosAbiertos
- Estado: requiere primeros datos reales cargados

### 2. Alianzas con medios (convoca.pe, IDL-Reporteros, Ojo Público)

- Ofrecer API gratuita a medios para verificar fuentes
- Co-branding: "verificado con Garendil" en investigaciones
- Estado: post-MVP funcional

### 3. SEO — búsquedas de verificación de funcionarios

- Keywords: "verificar funcionario público Perú", "contratos OSCE [nombre]"
- Landing pages por funcionario (nombre + IER score + contratos)
- Estado: requiere crawler operativo + contenido indexable

### 4. Eventos de periodismo de datos / hackathons cívicos

- Demo en vivo: "cómo encontrar red de contratos en 5 minutos"
- Workshops: "usar Garendil para investigación de contratos"
- Estado: post-validación técnica

### 5. Reddit/HackerNews — lanzamiento técnico

- Post: "Built a public officials risk scoring system for Peru using Neo4j + scraping"
- Atrae: developers, data journalists internacional
- Estado: al tener MVP público

---

## Casos de uso con mayor potencial

| Caso de uso | Valor usuario | Viralidad |
|-------------|---------------|-----------|
| Buscar funcionario → ver IER + contratos + red vínculos | Muy alto (ahorra días scraping manual) | Media |
| Alertas cuando funcionario de interés recibe nuevo contrato | Alto (monitoreo pasivo) | Baja |
| Exportar red de vínculos (CSV/JSON) para análisis | Alto (periodistas datos) | Media |
| API pública para medios/ONGs | Muy alto (integración sistemas) | Alta |

---

## Diferenciador vs competidores

**vs Portales oficiales (OSCE, Contraloría):**
- Agregado: una búsqueda vs 5 portales separados
- IER score: métrica única de riesgo (portales solo listan contratos)
- Grafo vínculos: visualiza red (portales no cruzan datos)

**vs Medios manuales:**
- Automatizado: scraping continuo vs investigación manual
- Histórico: mantiene datos históricos (portales oficiales pueden borrar)
- API: acceso programático vs copiar-pegar manual

**vs Plataformas LatAm similares (Quién es Quién México, etc):**
- Perú-specific: fuentes locales (OSCE, Contraloría)
- Neo4j grafo: relaciones complejas (no solo lista)
- Scoring IER: métrica cuantitativa (no solo cualitativa)

---

## Hitos de crecimiento

- [ ] Scraper OSCE/SEACE operativo (primeros 1000 contratos)
- [ ] Primer funcionario con IER calculado + red vínculos
- [ ] Landing pública con búsqueda funcionarios
- [ ] Primer periodista usa Garendil en investigación publicada
- [ ] API pública documentada (rate limit 100 req/día free)
- [ ] Alianza con 1 medio (convoca.pe, IDL-Reporteros, Ojo Público)
- [ ] 100 búsquedas/día → activar modelo premium

---

## Referencias cruzadas

- Ver [VISION.md](VISION.md) para principios producto ("every data point has source_url")
- Ver [STATUS.md](STATUS.md) para estado scraping actual
- Ver [DECISIONS.md](DECISIONS.md) para decisiones técnicas

---

**Próximo paso crítico:** Scraper operativo + primer funcionario con IER → validar que scoring tiene sentido
