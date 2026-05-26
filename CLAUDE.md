# Garendil — CLAUDE.md

> Documento de contexto para LLM. Proporciona toda la información necesaria para que Claude opere como asistente técnico del proyecto Garendil sin necesidad de explicaciones adicionales en cada sesión.

---

## Identidad del proyecto

**Garendil** es un sistema público de scoring de riesgo de corrupción para funcionarios peruanos. Es un proyecto cívico-tecnológico de impacto social construido sobre datos abiertos y transparencia radical.

- **Sector:** CivicTech — transparencia pública, anticorrupción
- **Alcance:** Funcionarios públicos peruanos (municipal, regional, nacional)
- **Estado actual:** Concepto definido — modelo IER en diseño, frontend en especificación
- **Repositorio:** github.com/garendil/garendil (público)
- **Dominio futuro:** garendil.pe (pendiente)

### Etimología del nombre

**Garendil** = **Gar** (Sindarin: sostener, guardar) + **en** (Quenya: fluir) + **dil** (Quenya: devoto, el que sirve con amor). Significado compuesto: *"El guardián devoto"* o *"el que sostiene con devoción lo que fluye"*. El nombre refleja la misión del proyecto: custodiar la verdad pública de forma permanente y sin ceder.

---

## Documentación del proyecto

| Archivo | Contenido |
|---|---|
| `CLAUDE.md` | Este archivo — contexto global para LLM |
| `docs/14-frontend-ux.md` | Especificación completa del frontend UI/UX |

---

## El núcleo del sistema — Índice de Exposición al Riesgo (IER)

El **IER** es un score numérico de **0 a 100** por funcionario que cruza múltiples fuentes de datos públicos:

| # | Dimensión | Fuente de datos |
|---|---|---|
| 1 | Declaraciones juradas de bienes | SUNAT / SERVIR |
| 2 | Procesos disciplinarios | SERVIR / Contraloría |
| 3 | Sentencias y procesos penales | Poder Judicial |
| 4 | Contratos con el Estado | SEACE |
| 5 | Incremento patrimonial inconsistente | Cruce declaraciones vs. ingresos |
| 6 | Historial de cargos | Rotación inusual, cargos simultáneos |

Un score más alto indica mayor exposición al riesgo de corrupción. El score es **público, trazable y auditable** — cada punto del IER debe tener una fuente verificable.

### Modelo de scoring

Arquitectura de 3 capas (en orden de implementación):

1. **Reglas explícitas** — umbrales deterministas por dimensión (exoneración, condena, etc.)
2. **Anomaly detection** — Isolation Forest para detectar patrones fuera de distribución
3. **ML supervisado** — clasificador entrenado con casos etiquetados (fase futura)

Referencia de arquitectura transferible: **Serenata de Amor** (`okfn-brasil`).

---

## Stack tecnológico

```
Backend:     Python · FastAPI · PostgreSQL
Scraping:    BeautifulSoup / Scrapy (datos abiertos peruanos)
Frontend:    Next.js (App Router) + Tailwind CSS
Grafo:       vis.js Network (preferido) o D3.js force-directed
LLM:         Claude (procesamiento de documentos, destilación, análisis)
Formatos:    .md como formato primario para LLM (38% menos tokens que JSON)
             CSV incrustado en .md para datos tabulares masivos
             YAML para relaciones jerárquicas (funcionario → institución → contratos)
Pagos:       Culqi (donativos)
Hosting:     Hetzner VPS (backend + Neo4j + workers)
             Vercel (frontend Next.js)
             Supabase (auth + tablas relacionales)
```


### Por qué .md como formato primario

Los archivos `.md` son el formato óptimo como fuente para LLMs:
- Consumen hasta **38% menos tokens** que JSON con el mismo contenido
- Son legibles por humanos para auditoría
- Permiten incrustar CSV y YAML para datos estructurados
- Evitar JSON como fuente directa al LLM salvo casos específicos de APIs

---

## Fuentes de datos públicos

| Fuente | API disponible | Método | Prioridad |
|---|---|---|---|
| OSCE/SEACE — contratos | ✅ API REST (OCDS) | API — estándar OCDS | 1 |
| MEF Portal Transparencia | ❌ | Scraping | 2 |
| INFOBRAS — obras públicas | ❌ | Scraping | 2 |
| Contraloría General | ❌ PDFs + web | Scraping + PDF parsing | 2 |
| Poder Judicial | ❌ | Scraping | 2 |
| SERVIR — historial funcionarios | TBD | TBD | 2 |
| RENIEC | ❌ Solo convenio Estado | No viable fase 1 | — |
| SUNAT declaraciones privadas | ❌ No pública | No viable fase 1 | — |
| SPIJ — jurisprudencia | TBD | TBD | 3 |
| El Peruano — normas legales | TBD | TBD | 3 |

---

## Módulos del sistema

### Módulo 01 · IER Core

El motor central de scoring. Agrega y pondera las 6 dimensiones del IER por funcionario. Cada actualización del score está documentada con fuente, fecha y delta generado.

### Módulo 09 · Noticias — Scoring de Veracidad y Riesgo

Pipeline de ingesta y evaluación de noticias que alimenta el IER:

1. Scraping / ingesta diaria de noticias (medios peruanos, portales oficiales, redes)
2. Clasificación automática por funcionario mencionado (NLP / NER)
3. Evaluación de veracidad de la noticia (score 0.0–1.0): tipo de medio, respaldo de otras fuentes, declaraciones oficiales
4. Impacto ponderado al IER según nivel de veracidad
5. Registro documentado en `.md` por evento

**Estructura del archivo `.md` por evento de noticia:**
```
- Nombre del funcionario
- Cargo
- Fecha de la noticia
- Titular
- Medio
- URL fuente
- Nivel de veracidad asignado (0.0–1.0)
- Justificación del nivel de veracidad
- Resumen del acto descrito
- Impacto calculado al IER (delta)
- Fecha de registro en el sistema
```

### Módulo 10 · Jurídico — Decisión Asistida con Lógica Difusa

Sistema de apoyo a decisiones jurídicas basado en leyes vigentes y jurisprudencia:

1. Destilación de leyes vigentes a `.md` estructurados
2. Base de casos anteriores indexados como `.md` con metadatos
3. Motor de lógica difusa que calcula probabilidad de resultados posibles
4. Salida con referencias exactas: artículos de ley + casos previos consultados

**Por qué lógica difusa:** El derecho no opera en binario. La lógica difusa asigna grados de verdad (0.0–1.0) a proposiciones jurídicas, siendo más honesta que un modelo determinista para modelar la ambigüedad legal inherente.

**Relación con Garendil:** Puede operar como módulo integrado (evalúa peso jurídico de procesos del IER) o como producto independiente (LegalIA Perú).

**Próximos pasos del módulo jurídico:**
- [ ] Definir esquema `.md` estándar para leyes vigentes peruanas
- [ ] Definir esquema `.md` estándar para sentencias y casos judiciales
- [ ] Identificar fuentes oficiales (SPIJ, El Peruano, Poder Judicial)
- [ ] Investigar motores de lógica difusa en Python: `scikit-fuzzy`, `simpful`
- [ ] Prototipo: destilar 5 leyes y 5 sentencias a `.md`

### Módulo 11 · Competencia Dual — Inteligencia & Moral

Score bidimensional por funcionario que mide dos ejes complementarios:

| Dimensión | Fuente | Notas |
|---|---|---|
| **Moral** | IER existente | Historial de procesos, declaraciones, contratos, noticias verificadas |
| **Inteligencia** | Pruebas de competencia periódicas | Voluntarias — aceptación o negativa es dato público |

**Principio clave:** Un funcionario muy inteligente sin moral es peligroso; uno muy moral sin capacidad intelectual es ineficaz. Ninguna dimensión compensa la ausencia de la otra.

**Integración con Galendor:** El módulo puede apoyarse en la plataforma Galendor para diseñar y administrar las pruebas de competencia intelectual.

**Output:** Score dual (Inteligencia / Moral) visible en el perfil público del funcionario, con historial de evolución longitudinal.

### Módulo 13 · LexGraph

Derecho modelado como grafo de precedentes judiciales. Capa de conocimiento jurídico con Neo4j o Kuzu como núcleo. Se integra con el Módulo 10 para enriquecer el contexto legal de cada proceso.

---

## Marco legal habilitante

| Ley | Descripción |
|---|---|
| **Ley 27806** | Ley de Transparencia y Acceso a la Información Pública |
| **Ley 27815** | Código de Ética de la Función Pública |
| **Portal de Transparencia Estándar** | Datos públicos disponibles por mandato legal |
| **SEACE** | Sistema Electrónico de Contrataciones del Estado |

Todo el sistema opera dentro del marco de datos públicos — no hay extracción de datos privados ni vulneración de protección de datos personales.

---

## Modelo de sostenibilidad

| Opción | Pros | Contras |
|---|---|---|
| ONG / asociación sin fines de lucro | Credibilidad, acceso a donaciones | Burocracia, dependencia de fondos externos |
| SaaS para empresas (due diligence) | Revenue propio y sostenible | Posible conflicto de interés percibido |
| Alianza con universidad | Legitimidad académica, rigor | Lento, burocrático |
| Periodismo de datos + patrocinios | Alcance masivo | Difícil de monetizar directamente |

Integración Culqi habilitada en el frontend para donativos directos.

---

## Próximos pasos globales del proyecto

> Ver ROADMAP.md para el estado actualizado de tareas por fase.

**Fase 1 — MVP frontend + buscador (en curso)**
- [ ] Inicializar Next.js App Router en apps/web/
- [ ] Diseño system: tokens, paleta, tipografía
- [ ] Homepage con buscador por DNI
- [ ] Página de perfil `/perfil/[dni]` con SSR
- [ ] Visualización de grafo básica (vis.js)
- [ ] Auth con Supabase (registro + login)
- [ ] Sección de donativos con Culqi

---

## Relación con el ecosistema de proyectos

Garendil opera dentro de un ecosistema de proyectos del mismo autor:

| Proyecto | Descripción | Relación con Garendil |
|---|---|---|
| **Galendor** | EdTech preuniversitaria (FSRS-7, MCQs con IA) | Plataforma de pruebas para Módulo 11 |
| **Zhinova** | Automatización web con IA (en producción) | Stack tecnológico compartido |
| **Rivengard** | Delivery interurbano | Ecosistema del mismo autor |
| **Durinforge** | Marketplace de construcción | Ecosistema del mismo autor |
| **Makinor** | Robot Jetson Nano con IA local | Ecosistema del mismo autor |

---

## Principios de diseño del sistema

1. **Trazabilidad total** — cada punto del IER tiene fuente, fecha y justificación
2. **Auditabilidad humana** — los `.md` son legibles por personas, no solo por máquinas
3. **Datos abiertos únicamente** — sin extracción de datos privados
4. **Lógica difusa sobre certezas falsas** — el sistema es honesto sobre la incertidumbre
5. **Transparencia radical** — el propio código y metodología son públicos
6. **Impacto social sobre monetización** — el proyecto prioriza utilidad pública

---

## Instrucciones para Claude

Cuando trabajes en este proyecto:

- El nombre del proyecto es **Garendil** (no Integritas — ese fue el nombre anterior)
- Los archivos fuente para el LLM deben ser `.md`, no JSON
- Toda decisión del sistema debe ser **auditable y trazable**
- El IER es un score de **riesgo**, no de **culpabilidad** — esta distinción es crítica
- La lógica difusa es el motor apropiado para ambigüedad legal y moral
- El proyecto es **peruano** — las fuentes de datos, leyes y contexto son del sistema público peruano
- Cuando generes esquemas `.md` para eventos de noticias o módulos jurídicos, seguir las estructuras definidas en este documento
- La especificación completa del frontend está en `docs/14-frontend-ux.md` — leer ese archivo antes de tocar cualquier código del frontend
- El perfil psicológico inferido **siempre** debe incluir el disclaimer prominente definido en `docs/14-frontend-ux.md`
- El score IER se muestra siempre en `font-mono` con color semántico
- Antes de tocar cualquier archivo, leer STATUS.md y DECISIONS.md
- Las decisiones de arquitectura están en DECISIONS.md (DEC-001 a
  DEC-014) — no debatirlas, solo implementarlas
- El repositorio canónico es github.com/garendil/garendil —
  nunca hacer push a rodhandev/garendil
