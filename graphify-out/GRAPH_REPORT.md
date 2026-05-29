# Graph Report - .  (2026-05-17)

## Corpus Check
- 123 files · ~66,150 words
- Verdict: corpus is large enough that graph structure adds value.

## Summary
- 560 nodes · 613 edges · 91 communities detected
- Extraction: 88% EXTRACTED · 12% INFERRED · 0% AMBIGUOUS · INFERRED: 76 edges (avg confidence: 0.61)
- Token cost: 0 input · 0 output

## Community Hubs (Navigation)
- [[_COMMUNITY_IER Core & Scoring Concepts|IER Core & Scoring Concepts]]
- [[_COMMUNITY_API Routes & Alert System|API Routes & Alert System]]
- [[_COMMUNITY_Data Sources & Dependencies|Data Sources & Dependencies]]
- [[_COMMUNITY_Zhinova Reference Architecture|Zhinova Reference Architecture]]
- [[_COMMUNITY_ML Scoring Engine (L1 + L2)|ML Scoring Engine (L1 + L2)]]
- [[_COMMUNITY_Pydantic Schemas & Backend API|Pydantic Schemas & Backend API]]
- [[_COMMUNITY_IAF Competencies Calculator|IAF Competencies Calculator]]
- [[_COMMUNITY_Neo4j Graph Persistence|Neo4j Graph Persistence]]
- [[_COMMUNITY_Peru Open Data ETL Docs|Peru Open Data ETL Docs]]
- [[_COMMUNITY_SQLAlchemy Database Models|SQLAlchemy Database Models]]
- [[_COMMUNITY_Fuzzy Scoring & API Docs|Fuzzy Scoring & API Docs]]
- [[_COMMUNITY_Web Scrapers (MEF + INFOBRAS)|Web Scrapers (MEF + INFOBRAS)]]
- [[_COMMUNITY_APEP Methodology & Prompts|APEP Methodology & Prompts]]
- [[_COMMUNITY_Zhinova Infrastructure (K8s)|Zhinova Infrastructure (K8s)]]
- [[_COMMUNITY_API Test Suite|API Test Suite]]
- [[_COMMUNITY_SUNAT ETL Connector|SUNAT ETL Connector]]
- [[_COMMUNITY_OSCE ETL Connector|OSCE ETL Connector]]
- [[_COMMUNITY_MEF ETL Connector|MEF ETL Connector]]
- [[_COMMUNITY_OSCE Async Client|OSCE Async Client]]
- [[_COMMUNITY_Dashboard Test Suite|Dashboard Test Suite]]
- [[_COMMUNITY_Module Group 20|Module Group 20]]
- [[_COMMUNITY_Module Group 21|Module Group 21]]
- [[_COMMUNITY_Module Group 22|Module Group 22]]
- [[_COMMUNITY_Module Group 23|Module Group 23]]
- [[_COMMUNITY_Module Group 24|Module Group 24]]
- [[_COMMUNITY_Module Group 25|Module Group 25]]
- [[_COMMUNITY_Module Group 26|Module Group 26]]
- [[_COMMUNITY_Module Group 27|Module Group 27]]
- [[_COMMUNITY_Module Group 28|Module Group 28]]
- [[_COMMUNITY_Module Group 29|Module Group 29]]
- [[_COMMUNITY_Module Group 30|Module Group 30]]
- [[_COMMUNITY_Module Group 31|Module Group 31]]
- [[_COMMUNITY_Module Group 32|Module Group 32]]
- [[_COMMUNITY_Module Group 33|Module Group 33]]
- [[_COMMUNITY_Module Group 34|Module Group 34]]
- [[_COMMUNITY_Module Group 35|Module Group 35]]
- [[_COMMUNITY_Module Group 36|Module Group 36]]
- [[_COMMUNITY_Module Group 37|Module Group 37]]
- [[_COMMUNITY_Module Group 38|Module Group 38]]
- [[_COMMUNITY_Module Group 39|Module Group 39]]
- [[_COMMUNITY_Module Group 40|Module Group 40]]
- [[_COMMUNITY_Module Group 41|Module Group 41]]
- [[_COMMUNITY_Module Group 42|Module Group 42]]
- [[_COMMUNITY_Module Group 43|Module Group 43]]
- [[_COMMUNITY_Module Group 44|Module Group 44]]
- [[_COMMUNITY_Module Group 45|Module Group 45]]
- [[_COMMUNITY_Module Group 46|Module Group 46]]
- [[_COMMUNITY_Module Group 47|Module Group 47]]
- [[_COMMUNITY_Module Group 48|Module Group 48]]
- [[_COMMUNITY_Module Group 49|Module Group 49]]
- [[_COMMUNITY_Module Group 50|Module Group 50]]
- [[_COMMUNITY_Module Group 51|Module Group 51]]
- [[_COMMUNITY_Module Group 52|Module Group 52]]
- [[_COMMUNITY_Module Group 53|Module Group 53]]
- [[_COMMUNITY_Module Group 54|Module Group 54]]
- [[_COMMUNITY_Module Group 55|Module Group 55]]
- [[_COMMUNITY_Module Group 56|Module Group 56]]
- [[_COMMUNITY_Module Group 57|Module Group 57]]
- [[_COMMUNITY_Module Group 58|Module Group 58]]
- [[_COMMUNITY_Module Group 59|Module Group 59]]
- [[_COMMUNITY_Module Group 60|Module Group 60]]
- [[_COMMUNITY_Module Group 61|Module Group 61]]
- [[_COMMUNITY_Module Group 62|Module Group 62]]
- [[_COMMUNITY_Module Group 63|Module Group 63]]
- [[_COMMUNITY_Module Group 64|Module Group 64]]
- [[_COMMUNITY_Module Group 65|Module Group 65]]
- [[_COMMUNITY_Module Group 66|Module Group 66]]
- [[_COMMUNITY_Module Group 67|Module Group 67]]
- [[_COMMUNITY_Module Group 68|Module Group 68]]
- [[_COMMUNITY_Module Group 69|Module Group 69]]
- [[_COMMUNITY_Module Group 70|Module Group 70]]
- [[_COMMUNITY_Module Group 71|Module Group 71]]
- [[_COMMUNITY_Module Group 72|Module Group 72]]
- [[_COMMUNITY_Module Group 73|Module Group 73]]
- [[_COMMUNITY_Module Group 74|Module Group 74]]
- [[_COMMUNITY_Module Group 75|Module Group 75]]
- [[_COMMUNITY_Module Group 76|Module Group 76]]
- [[_COMMUNITY_Module Group 77|Module Group 77]]
- [[_COMMUNITY_Module Group 78|Module Group 78]]
- [[_COMMUNITY_Module Group 79|Module Group 79]]
- [[_COMMUNITY_Module Group 80|Module Group 80]]
- [[_COMMUNITY_Module Group 81|Module Group 81]]
- [[_COMMUNITY_Module Group 82|Module Group 82]]
- [[_COMMUNITY_Module Group 83|Module Group 83]]
- [[_COMMUNITY_Module Group 84|Module Group 84]]
- [[_COMMUNITY_Module Group 85|Module Group 85]]
- [[_COMMUNITY_Module Group 86|Module Group 86]]
- [[_COMMUNITY_Module Group 87|Module Group 87]]
- [[_COMMUNITY_Module Group 88|Module Group 88]]
- [[_COMMUNITY_Module Group 89|Module Group 89]]
- [[_COMMUNITY_Module Group 90|Module Group 90]]

## God Nodes (most connected - your core abstractions)
1. `Funcionario` - 25 edges
2. `OSCEIngester` - 15 edges
3. `IsolationForest` - 14 edges
4. `Neo4jClient` - 12 edges
5. `Zhinova Architecture Decisions` - 10 edges
6. `mensaje.router.js — Core Message Router` - 10 edges
7. `APEP — Agentic Prompt-to-Execution Pattern` - 9 edges
8. `IER — Índice de Exposición al Riesgo` - 9 edges
9. `Technology: PostgreSQL 16` - 9 edges
10. `System Architecture Diagram` - 8 edges

## Surprising Connections (you probably didn't know these)
- `Isolation Forest para anomaly detection sin dependencias externas.     Outliers` --uses--> `Funcionario`  [INFERRED]
  services/api/app/services/scoring/layer2.py → backend/app/db/models.py
- `Retorna anomaly scores 0.0–1.0. Score > 0.5 indica anomalía.` --uses--> `Funcionario`  [INFERRED]
  services/api/app/services/scoring/layer2.py → backend/app/db/models.py
- `Layer 2: Anomaly detection basado en histórico de contratos.` --uses--> `Funcionario`  [INFERRED]
  services/api/app/services/scoring/layer2.py → backend/app/db/models.py
- `Features extraídas del histórico:         [cantidad, monto_promedio, monto_max,` --uses--> `Funcionario`  [INFERRED]
  services/api/app/services/scoring/layer2.py → backend/app/db/models.py
- `Calcula Layer 2 score (0.0–1.0). Score > 0.5 = comportamiento anómalo.` --uses--> `Funcionario`  [INFERRED]
  services/api/app/services/scoring/layer2.py → backend/app/db/models.py

## Hyperedges (group relationships)
- **ETL Parallel Pipeline (6 data sources)** — dev_etl_mef, dev_etl_osce, dev_etl_jne, dev_etl_sunat, dev_etl_contraloria, dev_etl_infobras [EXTRACTED 1.00]
- **IER Scoring Layers (L1 + L2 + L3)** — concept_layer1_rules, concept_layer2_anomaly, concept_layer3_supervised, concept_ier [EXTRACTED 1.00]
- **SQLAlchemy Models (Funcionario + Empresa + Contrato)** — prompt_v2_model_funcionario, prompt_v2_model_empresa, prompt_v2_model_contrato [EXTRACTED 1.00]
- **APEP Pattern Actors (Claude.ai + Claude Code + User)** — apep_orchestrator_role, apep_agent_role, apep_methodology [EXTRACTED 1.00]
- **IAF Dimensions (Inteligencia + Empatía + Credibilidad + IER)** — competencies_inteligencia, competencies_empatia, competencies_credibilidad, competencies_iaf_formula [EXTRACTED 1.00]
- **Garendil Roadmap Phases A-F** — roadmap_phase_a, roadmap_phase_b, roadmap_phase_c, roadmap_phase_d, roadmap_phase_e, roadmap_phase_f [EXTRACTED 1.00]
- **Open State Data Sources (6 sources)** — datasource_mef, datasource_osce_seace, datasource_jne, datasource_sunat, datasource_contraloria, datasource_infobras [EXTRACTED 1.00]
- **v4 Prompt Components (Neo4j + Dashboard + Alerts + Deploy)** — prompt_v4_neo4j_client, prompt_v4_alert_manager, prompt_v4_dashboard_endpoints, prompt_v4_admin_layout, prompt_v4_neo4j_sync, prompt_v4_deployment_guide [EXTRACTED 1.00]
- **Zhinova Message Processing Pipeline** — concept_telegram_adapter, concept_mensaje_router, concept_context_loader, concept_llm_service, concept_calificaciones_service, concept_sistema_scheduler [EXTRACTED 1.00]
- **Garendil Public Data Sources** — concept_data_sources_mef, concept_data_source_osce, concept_data_source_sunat, concept_data_source_jne, concept_data_source_contraloria, concept_data_source_infobras [EXTRACTED 1.00]
- **Garendil Layer 1 Scoring Signals** — concept_layer1_flags_infobras, concept_layer1_flags_mef, concept_layer1_scoring_osce, concept_ier_score [EXTRACTED 0.95]
- **Garendil Legal Compliance Framework** — concept_ley_transparencia, concept_ley_proteccion_datos, concept_ier_score, docs_legal [EXTRACTED 1.00]
- **Zhinova Kubernetes Migration Plan** — concept_trim1a_bitwarden, concept_trim1b_k8s, concept_trim2a_orchestrator, concept_trim2b_autoscaler, concept_bitwarden_sm, concept_k8s_manifests, concept_master_orchestrator [EXTRACTED 1.00]
- **Garendil Python Backend Stack** — pkg_fastapi, pkg_sqlalchemy, pkg_httpx, pkg_sklearn, pkg_networkx, pkg_anthropic, pkg_alembic, pkg_playwright [EXTRACTED 0.95]

## Communities

### Community 0 - "IER Core & Scoring Concepts"
Cohesion: 0.05
Nodes (56): Competency Dimension: Credibilidad (30%), DB Table: funcionario_scores (IAF + dimensions), Competency Dimension: Empatía (25%), IAF — Índice de Aptitud Final, IAF Formula: I×0.30 + E×0.25 + C×0.30 + (100-IER)/100×0.15, Competency Dimension: Inteligencia (30%), Competencies Module — Integritas v2.0 Spec, DNI — Primary Identifier for Peruvian Officials (+48 more)

### Community 1 - "API Routes & Alert System"
Cohesion: 0.07
Nodes (29): Alert, AlertLevel, AlertManager, Gestor centralizado de alertas basadas en scores y patrones de contratos., Verifica anomalías y genera alertas según scores y contratos.          Args:, DeclarativeBase, Enum, Base (+21 more)

### Community 2 - "Data Sources & Dependencies"
Cohesion: 0.06
Nodes (41): Backend Python Requirements, Contraloría General (Data Source), INFObras VIVIENDA (Data Source), JNE Declaraciones (Data Source), OSCE/SEACE (Data Source), SUNAT RUC (Data Source), MEF Transparencia (Data Source), IER — Índice de Exposición al Riesgo (0.0–1.0) (+33 more)

### Community 3 - "Zhinova Reference Architecture"
Cohesion: 0.07
Nodes (39): admin.commands.js, calificaciones.service.js — Star Ratings, Canal-Agnostic Multi-Tenant Architecture, Claude Haiku (Development/Testing), context.loader.js — Notion Context, Culqi Payment Gateway, DeepSeek LLM (Production), Peru +51 Phone Filter (+31 more)

### Community 4 - "ML Scoring Engine (L1 + L2)"
Cohesion: 0.09
Nodes (16): apply_layer1_flags(), Aplica reglas explícitas Layer 1 sobre un contrato + empresa.      Reglas:     1, IsolationForest, Layer2Scorer, Isolation Forest para anomaly detection sin dependencias externas.     Outliers, Calcula Layer 2 score (0.0–1.0). Score > 0.5 = comportamiento anómalo., Entrena el modelo con todos los funcionarios en BD., Retorna anomaly scores 0.0–1.0. Score > 0.5 indica anomalía. (+8 more)

### Community 5 - "Pydantic Schemas & Backend API"
Cohesion: 0.09
Nodes (18): BaseModel, Config, ContratoSchema, Config, EmpresaSchema, calcular_ier(), Motor de lógica difusa para el cálculo del IER. Usa scikit-fuzzy. Implementación, # TODO: implementar lógica difusa con scikit-fuzzy (+10 more)

### Community 6 - "IAF Competencies Calculator"
Cohesion: 0.11
Nodes (19): calcular(), CredibilidadCalculator, DimensionScores, EmpatiaCalculator, FuncionarioAptitud, FuncionarioEvaluador, IAFCalculator, InteligenciaCalculator (+11 more)

### Community 7 - "Neo4j Graph Persistence"
Cohesion: 0.08
Nodes (8): Neo4jClient, Cliente async para Neo4j graph database., Retorna {nodos, aristas} del entorno de un funcionario hasta `profundidad` salto, Top funcionarios por volumen de empresas contratadas (detección de redes)., Sincroniza datos de PostgreSQL a Neo4j.     Ejecutar después de ingestar datos d, sync_to_neo4j(), Neo4j client hace skip si el servidor no está disponible., test_neo4j_client_skips_when_unavailable()

### Community 8 - "Peru Open Data ETL Docs"
Cohesion: 0.14
Nodes (22): IER Variables Table (7 variables), Data Source: Contraloría General (Audits), Data Source: INFObras (Public Works), Data Source: JNE (Asset Declarations), Data Source: MEF Portal Transparencia, Data Source: SEACE/OSCE (Public Contracts), Data Source: SUNAT (RUC/Companies), Decision 8: Only Open State Data Sources (+14 more)

### Community 9 - "SQLAlchemy Database Models"
Cohesion: 0.16
Nodes (8): Base, TimestampMixin, Conexion, Contrato, Empresa, Funcionario, Proceso, TimestampMixin

### Community 10 - "Fuzzy Scoring & API Docs"
Cohesion: 0.11
Nodes (20): GET /api/v1/funcionarios/{dni} Endpoint, GET /health Endpoint, GET /api/v1/scoring/{dni} Endpoint, API Reference — Integritas/Mírantir, Schema: FuncionarioOut, Schema: ScoringOut, Schema: VariableContribucion, Decision 3: scikit-fuzzy for Scoring Engine (+12 more)

### Community 11 - "Web Scrapers (MEF + INFOBRAS)"
Cohesion: 0.13
Nodes (6): INFOBRAScraper, MEFScraper, Scraper para INFOBRAS, Scraper para MEF Portal Transparencia, Scrape obras públicas de un responsable desde INFOBRAS.          Returns list of, Scrape patrimonio de un funcionario desde MEF Transparencia.          Returns di

### Community 12 - "APEP Methodology & Prompts"
Cohesion: 0.2
Nodes (10): Claude Code Agent Role, APEP — Agentic Prompt-to-Execution Pattern, Claude.ai Orchestrator Role, PROMPT_*.md Executable Format, Rationale: Specification IS the Code, PROMPT Garendil v1 — Full Initialization, Monorepo Setup (pnpm + Turborepo), PROMPT Garendil v3 — Scraping + Layer 2 + Graph (+2 more)

### Community 13 - "Zhinova Infrastructure (K8s)"
Cohesion: 0.27
Nodes (10): Bitwarden Secrets Manager, deployer.js — Bot Deployment Script, Kubernetes Manifests (9 YAMLs), Master Orchestrator (etcd health), TRIM 1a: Bitwarden + Deployer Refactor, TRIM 1b: Kubernetes Cluster, TRIM 2a: Master Orchestrator, TRIM 2b: Worker Autoscaler + Hetzner Automation (+2 more)

### Community 14 - "API Test Suite"
Cohesion: 0.22
Nodes (0): 

### Community 15 - "SUNAT ETL Connector"
Cohesion: 0.25
Nodes (7): get_empresas_por_dni(), get_info_ruc(), Conector SUNAT — RUC y vinculaciones empresariales.  Fuente: https://e-consultar, Retorna empresas donde el DNI figura como representante legal o socio., # TODO: implementar scraping con Playwright, Retorna información básica de un RUC., # TODO: implementar scraping con Playwright

### Community 16 - "OSCE ETL Connector"
Cohesion: 0.25
Nodes (7): get_contratos_por_dni(), get_licitaciones_por_entidad(), Conector OSCE / SEACE — licitaciones y contrataciones públicas.  API real dispon, Retorna contratos públicos asociados al DNI dado., # TODO: implementar llamada real a la API de SEACE, Retorna licitaciones de una entidad pública dado su RUC., # TODO: implementar llamada real a la API de SEACE

### Community 17 - "MEF ETL Connector"
Cohesion: 0.25
Nodes (7): get_planilla_por_dni(), get_proveedores_por_dni(), Conector Portal de Transparencia Económica — MEF.  Fuente: https://transparencia, Retorna registros de contratos como proveedor del Estado., # TODO: implementar scraping, Retorna registros en planillas del Estado., # TODO: implementar scraping

### Community 18 - "OSCE Async Client"
Cohesion: 0.33
Nodes (1): OSCEClient

### Community 19 - "Dashboard Test Suite"
Cohesion: 0.4
Nodes (0): 

### Community 20 - "Module Group 20"
Cohesion: 0.7
Nodes (4): AsyncSessionLocal(), get_db(), get_engine(), get_session_factory()

### Community 21 - "Module Group 21"
Cohesion: 0.4
Nodes (4): get_obras_por_entidad(), Conector INFObras — avance y costo de obras públicas.  Fuente: https://infobras., Retorna obras públicas de una entidad con su avance y costo., # TODO: implementar

### Community 22 - "Module Group 22"
Cohesion: 0.4
Nodes (4): get_sanciones_por_dni(), Conector Contraloría General de la República.  Fuente: https://www.contraloria.g, Retorna sanciones e informes de auditoría relacionados al DNI., # TODO: implementar scraping

### Community 23 - "Module Group 23"
Cohesion: 0.4
Nodes (4): get_declaraciones_por_dni(), Conector JNE — declaraciones de bienes y rentas.  Fuente: https://declara.jne.go, Retorna declaraciones juradas de bienes y rentas., # TODO: implementar scraping

### Community 24 - "Module Group 24"
Cohesion: 0.5
Nodes (0): 

### Community 25 - "Module Group 25"
Cohesion: 0.67
Nodes (0): 

### Community 26 - "Module Group 26"
Cohesion: 0.67
Nodes (0): 

### Community 27 - "Module Group 27"
Cohesion: 0.67
Nodes (0): 

### Community 28 - "Module Group 28"
Cohesion: 0.67
Nodes (0): 

### Community 29 - "Module Group 29"
Cohesion: 0.67
Nodes (2): BaseSettings, Settings

### Community 30 - "Module Group 30"
Cohesion: 0.67
Nodes (2): Definición de variables de entrada del IER y sus pesos., Variable

### Community 31 - "Module Group 31"
Cohesion: 0.67
Nodes (2): Reglas difusas para el motor IER. Implementación pendiente — requiere scikit-fuz, # TODO: definir universos de variables y reglas fuzzy

### Community 32 - "Module Group 32"
Cohesion: 0.67
Nodes (3): Decision 10: NetworkX + Pyvis for Graphs, Phase D: Real Data + Coverage (Month 2), Technology: NetworkX (Graph Analysis)

### Community 33 - "Module Group 33"
Cohesion: 0.67
Nodes (3): GrafoFuncionario React Component (vis.js), Perfil Page with Graph + Scores + MD Export, Technology: vis.js (Interactive Graph Frontend)

### Community 34 - "Module Group 34"
Cohesion: 0.67
Nodes (3): Decision 9: Claude API for AI Narrative (Phase F), Phase F: Advanced Features (Q3-Q4 2026), Technology: Claude API (AI Narrative)

### Community 35 - "Module Group 35"
Cohesion: 0.67
Nodes (3): Notion Project Structure Pattern, Notion-to-Code Workflow, Zhinova Project Playbook

### Community 36 - "Module Group 36"
Cohesion: 1.0
Nodes (0): 

### Community 37 - "Module Group 37"
Cohesion: 1.0
Nodes (0): 

### Community 38 - "Module Group 38"
Cohesion: 1.0
Nodes (0): 

### Community 39 - "Module Group 39"
Cohesion: 1.0
Nodes (0): 

### Community 40 - "Module Group 40"
Cohesion: 1.0
Nodes (0): 

### Community 41 - "Module Group 41"
Cohesion: 1.0
Nodes (0): 

### Community 42 - "Module Group 42"
Cohesion: 1.0
Nodes (0): 

### Community 43 - "Module Group 43"
Cohesion: 1.0
Nodes (0): 

### Community 44 - "Module Group 44"
Cohesion: 1.0
Nodes (0): 

### Community 45 - "Module Group 45"
Cohesion: 1.0
Nodes (0): 

### Community 46 - "Module Group 46"
Cohesion: 1.0
Nodes (0): 

### Community 47 - "Module Group 47"
Cohesion: 1.0
Nodes (0): 

### Community 48 - "Module Group 48"
Cohesion: 1.0
Nodes (0): 

### Community 49 - "Module Group 49"
Cohesion: 1.0
Nodes (0): 

### Community 50 - "Module Group 50"
Cohesion: 1.0
Nodes (0): 

### Community 51 - "Module Group 51"
Cohesion: 1.0
Nodes (1): Calcula score de inteligencia combinando múltiples indicadores.

### Community 52 - "Module Group 52"
Cohesion: 1.0
Nodes (1): Calcula score de empatía.                  Args:             sentimiento_promedi

### Community 53 - "Module Group 53"
Cohesion: 1.0
Nodes (1): Calcula score de credibilidad.                  Args:             coherencia_dis

### Community 54 - "Module Group 54"
Cohesion: 1.0
Nodes (1): Calcula IAF y categoría de aptitud.                  Args:             scores: D

### Community 55 - "Module Group 55"
Cohesion: 1.0
Nodes (0): 

### Community 56 - "Module Group 56"
Cohesion: 1.0
Nodes (0): 

### Community 57 - "Module Group 57"
Cohesion: 1.0
Nodes (0): 

### Community 58 - "Module Group 58"
Cohesion: 1.0
Nodes (0): 

### Community 59 - "Module Group 59"
Cohesion: 1.0
Nodes (0): 

### Community 60 - "Module Group 60"
Cohesion: 1.0
Nodes (0): 

### Community 61 - "Module Group 61"
Cohesion: 1.0
Nodes (0): 

### Community 62 - "Module Group 62"
Cohesion: 1.0
Nodes (0): 

### Community 63 - "Module Group 63"
Cohesion: 1.0
Nodes (0): 

### Community 64 - "Module Group 64"
Cohesion: 1.0
Nodes (0): 

### Community 65 - "Module Group 65"
Cohesion: 1.0
Nodes (0): 

### Community 66 - "Module Group 66"
Cohesion: 1.0
Nodes (0): 

### Community 67 - "Module Group 67"
Cohesion: 1.0
Nodes (0): 

### Community 68 - "Module Group 68"
Cohesion: 1.0
Nodes (0): 

### Community 69 - "Module Group 69"
Cohesion: 1.0
Nodes (0): 

### Community 70 - "Module Group 70"
Cohesion: 1.0
Nodes (0): 

### Community 71 - "Module Group 71"
Cohesion: 1.0
Nodes (0): 

### Community 72 - "Module Group 72"
Cohesion: 1.0
Nodes (0): 

### Community 73 - "Module Group 73"
Cohesion: 1.0
Nodes (0): 

### Community 74 - "Module Group 74"
Cohesion: 1.0
Nodes (0): 

### Community 75 - "Module Group 75"
Cohesion: 1.0
Nodes (0): 

### Community 76 - "Module Group 76"
Cohesion: 1.0
Nodes (0): 

### Community 77 - "Module Group 77"
Cohesion: 1.0
Nodes (0): 

### Community 78 - "Module Group 78"
Cohesion: 1.0
Nodes (0): 

### Community 79 - "Module Group 79"
Cohesion: 1.0
Nodes (0): 

### Community 80 - "Module Group 80"
Cohesion: 1.0
Nodes (0): 

### Community 81 - "Module Group 81"
Cohesion: 1.0
Nodes (0): 

### Community 82 - "Module Group 82"
Cohesion: 1.0
Nodes (1): Frontend Page: Perfil.tsx

### Community 83 - "Module Group 83"
Cohesion: 1.0
Nodes (1): Decision 4: DNI as Primary Identifier

### Community 84 - "Module Group 84"
Cohesion: 1.0
Nodes (1): Decision 11: ETL On-Demand + Weekly Batch

### Community 85 - "Module Group 85"
Cohesion: 1.0
Nodes (1): Decision 12: Natural Person (DNI) as Analysis Unit

### Community 86 - "Module Group 86"
Cohesion: 1.0
Nodes (1): PROGRESS.md — Garendil v0.3 State

### Community 87 - "Module Group 87"
Cohesion: 1.0
Nodes (1): README — Garendil v0.4 Production Ready

### Community 88 - "Module Group 88"
Cohesion: 1.0
Nodes (1): Phase E: Deploy + Beta Launch (Month 3)

### Community 89 - "Module Group 89"
Cohesion: 1.0
Nodes (1): Layer 3: Supervised ML (Future)

### Community 90 - "Module Group 90"
Cohesion: 1.0
Nodes (1): Technology: Playwright Chromium (Scraping)

## Knowledge Gaps
- **138 isolated node(s):** `Integritas Competencies Module v1.0 - Inteligencia (0.0–1.0) - Empatía (0.0–1.0)`, `Almacena los 4 scores dimensionales.`, `Valida rangos de entrada.`, `Resultado completo de evaluación de un funcionario.`, `Convierte a diccionario para JSON.` (+133 more)
  These have ≤1 connection - possible missing edges or undocumented components.
- **Thin community `Module Group 36`** (2 nodes): `page.tsx`, `handleSearch()`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Module Group 37`** (2 nodes): `layout.tsx`, `RootLayout()`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Module Group 38`** (2 nodes): `useFuncionario.ts`, `useFuncionario()`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Module Group 39`** (2 nodes): `page.tsx`, `fetchAll()`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Module Group 40`** (2 nodes): `GrafoFuncionario.tsx`, `GrafoFuncionario()`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Module Group 41`** (2 nodes): `Layout.tsx`, `Layout()`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Module Group 42`** (2 nodes): `BuscadorDNI()`, `BuscadorDNI.tsx`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Module Group 43`** (2 nodes): `Perfil.tsx`, `Perfil()`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Module Group 44`** (2 nodes): `Donativos()`, `Donativos.tsx`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Module Group 45`** (2 nodes): `Home.tsx`, `Home()`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Module Group 46`** (2 nodes): `run_migrations()`, `migrate.py`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Module Group 47`** (2 nodes): `health_check()`, `main.py`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Module Group 48`** (2 nodes): `test_main.py`, `test_health()`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Module Group 49`** (2 nodes): `main.py`, `health()`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Module Group 50`** (2 nodes): `session.py`, `get_db()`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Module Group 51`** (1 nodes): `Calcula score de inteligencia combinando múltiples indicadores.`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Module Group 52`** (1 nodes): `Calcula score de empatía.                  Args:             sentimiento_promedi`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Module Group 53`** (1 nodes): `Calcula score de credibilidad.                  Args:             coherencia_dis`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Module Group 54`** (1 nodes): `Calcula IAF y categoría de aptitud.                  Args:             scores: D`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Module Group 55`** (1 nodes): `postcss.config.js`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Module Group 56`** (1 nodes): `next.config.js`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Module Group 57`** (1 nodes): `tailwind.config.js`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Module Group 58`** (1 nodes): `postcss.config.js`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Module Group 59`** (1 nodes): `tailwind.config.js`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Module Group 60`** (1 nodes): `vite.config.ts`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Module Group 61`** (1 nodes): `App.tsx`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Module Group 62`** (1 nodes): `main.tsx`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Module Group 63`** (1 nodes): `__init__.py`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Module Group 64`** (1 nodes): `__init__.py`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Module Group 65`** (1 nodes): `__init__.py`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Module Group 66`** (1 nodes): `__init__.py`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Module Group 67`** (1 nodes): `__init__.py`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Module Group 68`** (1 nodes): `__init__.py`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Module Group 69`** (1 nodes): `__init__.py`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Module Group 70`** (1 nodes): `__init__.py`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Module Group 71`** (1 nodes): `__init__.py`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Module Group 72`** (1 nodes): `__init__.py`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Module Group 73`** (1 nodes): `__init__.py`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Module Group 74`** (1 nodes): `__init__.py`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Module Group 75`** (1 nodes): `__init__.py`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Module Group 76`** (1 nodes): `__init__.py`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Module Group 77`** (1 nodes): `__init__.py`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Module Group 78`** (1 nodes): `__init__.py`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Module Group 79`** (1 nodes): `__init__.py`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Module Group 80`** (1 nodes): `__init__.py`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Module Group 81`** (1 nodes): `__init__.py`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Module Group 82`** (1 nodes): `Frontend Page: Perfil.tsx`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Module Group 83`** (1 nodes): `Decision 4: DNI as Primary Identifier`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Module Group 84`** (1 nodes): `Decision 11: ETL On-Demand + Weekly Batch`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Module Group 85`** (1 nodes): `Decision 12: Natural Person (DNI) as Analysis Unit`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Module Group 86`** (1 nodes): `PROGRESS.md — Garendil v0.3 State`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Module Group 87`** (1 nodes): `README — Garendil v0.4 Production Ready`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Module Group 88`** (1 nodes): `Phase E: Deploy + Beta Launch (Month 3)`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Module Group 89`** (1 nodes): `Layer 3: Supervised ML (Future)`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Module Group 90`** (1 nodes): `Technology: Playwright Chromium (Scraping)`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.

## Suggested Questions
_Questions this graph is uniquely positioned to answer:_

- **Why does `Funcionario` connect `API Routes & Alert System` to `ML Scoring Engine (L1 + L2)`, `Neo4j Graph Persistence`?**
  _High betweenness centrality (0.028) - this node is a cross-community bridge._
- **Why does `IER — Índice de Exposición al Riesgo` connect `IER Core & Scoring Concepts` to `Peru Open Data ETL Docs`, `Fuzzy Scoring & API Docs`?**
  _High betweenness centrality (0.022) - this node is a cross-community bridge._
- **Why does `IER Variables Table (7 variables)` connect `Peru Open Data ETL Docs` to `IER Core & Scoring Concepts`?**
  _High betweenness centrality (0.013) - this node is a cross-community bridge._
- **Are the 23 inferred relationships involving `Funcionario` (e.g. with `Scores detallados: Layer 1 (reglas) + Layer 2 (anomalías) + IER combinado.` and `Entrena el modelo Layer 2 con todos los funcionarios en BD.`) actually correct?**
  _`Funcionario` has 23 INFERRED edges - model-reasoned connections that need verification._
- **Are the 10 inferred relationships involving `OSCEIngester` (e.g. with `Scores detallados: Layer 1 (reglas) + Layer 2 (anomalías) + IER combinado.` and `Entrena el modelo Layer 2 con todos los funcionarios en BD.`) actually correct?**
  _`OSCEIngester` has 10 INFERRED edges - model-reasoned connections that need verification._
- **Are the 4 inferred relationships involving `IsolationForest` (e.g. with `Outlier debe tener score mayor que puntos normales.` and `Datos normales (gaussianos) deben producir scores bajos en promedio.`) actually correct?**
  _`IsolationForest` has 4 INFERRED edges - model-reasoned connections that need verification._
- **Are the 2 inferred relationships involving `Neo4jClient` (e.g. with `Neo4j client hace skip si el servidor no está disponible.` and `Sincroniza datos de PostgreSQL a Neo4j.     Ejecutar después de ingestar datos d`) actually correct?**
  _`Neo4jClient` has 2 INFERRED edges - model-reasoned connections that need verification._