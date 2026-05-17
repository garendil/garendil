# 14 · Frontend — Especificación UI/UX

> Fuente de verdad para la construcción del frontend de Garendil.
> Última actualización: 2026-05-17.
> Espejo de la página 14 en Notion (Base de Operaciones Garendil).

---

## Identidad visual

### Tono

Oscuro técnico — sensación de "dashboard de inteligencia". Herramienta de análisis seria y moderna, no portal gubernamental ni medio periodístico.

Referencias visuales: **Maltego**, **OCCRP Aleph**.

### Paleta de colores

| Token semántico | Valor aprox. | Uso |
|---|---|---|
| `--color-bg` | `#0a0d12` | Fondo base — casi negro con tinte azul frío |
| `--color-surface` | `#111827` | Superficies — gris oscuro azulado |
| `--color-primary` | teal frío / azul eléctrico | CTAs, scores, highlights |
| `--color-risk-high` | rojo desaturado | Scores de riesgo alto |
| `--color-risk-low` | verde frío | Scores de riesgo bajo |
| `--color-text` | `#e5e7eb` | Texto primario — blanco roto |
| `--color-text-muted` | gris medio | Texto secundario |

- **Modo oscuro como default.** Toggle a modo claro disponible.
- Todos los scores numéricos en `font-mono` con color semántico (rojo / amarillo / verde según rango).

### Tipografía

| Rol | Familia | Notas |
|---|---|---|
| Display / headings | Geist o Inter | Técnica, sin serif, peso variable |
| Body | Inter o DM Sans | Legible a tamaños pequeños |
| Datos / números / DNI | `font-mono` | Refuerza sensación de sistema de análisis |

- Mínimo absoluto: **12px**. Body: **16px**.

### Componentes de identidad

- **Logo SVG personalizado** — símbolo de balanza estilizada o grafo abstracto. Funciona en 24px y 200px.
- **Favicon** — versión simplificada 32×32 del logo.

---

## Stack tecnológico del frontend

```
Framework:   Next.js (App Router) — no Pages Router
Estilos:     Tailwind CSS
Grafo:       vis.js Network (preferido) o D3.js force-directed
Renderizado: SSR en /perfil/[dni] para SEO — perfiles indexables por Google
Estado:      React context o estado en memoria — NO localStorage
Pagos:       Culqi (donativos en homepage)
Exportación: Blob download en cliente — no requiere endpoint
```

> El frontend existente usa Vite + React. Debe **migrarse a Next.js**.

---

## Rutas del sitio

| Ruta | Vista | Descripción |
|---|---|---|
| `/` | Homepage | Buscador por DNI + estadísticas del sistema |
| `/perfil/[dni]` | Perfil de funcionario | Análisis completo con grafo, score, secciones |
| `/grafo` | Explorador de grafo global | Vista tipo Obsidian — todos los nodos navegables |
| `/metodologia` | Metodología | Explicación del scoring, fuentes, modelo, enlace al repo |

---

## Homepage (`/`)

### Hero

- Fondo oscuro, logo Garendil centrado.
- Tagline: **"Transparencia basada en datos. Riesgo cuantificado."**
- **Buscador por DNI** como única acción principal — input grande, centrado, botón "Analizar".
- Placeholder: `Ingresa el DNI del funcionario...`
- Validación inline: solo 8 dígitos numéricos (DNI peruano).

### Estadísticas del sistema (debajo del hero)

Contadores animados al cargar — datos desde `GET /api/stats`:

- Funcionarios analizados
- Conexiones mapeadas en el grafo
- Contratos públicos indexados
- Última actualización (timestamp ISO)

### Secciones adicionales

1. **¿Qué es Garendil?** — párrafo breve + 3 puntos de metodología.
2. **Cómo funciona** — 3 pasos: Ingresa DNI → Analizamos fuentes → Obtienes el perfil.
3. **Últimos perfiles generados** — cards de los últimos 5 funcionarios consultados (nombre, cargo, score).
4. **Transparencia** — enlace al repo GitHub + enlace a `/metodologia`.
5. **Donativos** — integración Culqi, mensaje de sostenibilidad del proyecto.

---

## Perfil de funcionario (`/perfil/[dni]`)

### Sección 1 — Header del perfil

- Nombre completo.
- Foto (placeholder SVG si no está disponible en fuentes públicas).
- Cargo actual + institución.
- **Score IER** — número grande en `font-mono`, color semántico, etiqueta ("Riesgo Alto / Medio / Bajo").
- Score desglosado: **Corrupción · Competencia · Adecuación al cargo**.
- Fuentes consultadas + timestamp de última actualización.

### Sección 2 — Grafo de conexiones

- Visualización interactiva (vis.js o D3.js).
- **Nodos:** funcionario central + conexiones (personas, empresas, instituciones).
- **Aristas:** tipo de relación (contrato, proceso judicial, vínculo declarado, aparición conjunta en noticias).
- Cada arista tiene **% de probabilidad de afinidad** basado en interacción histórica.
- Click en nodo → va al perfil de ese nodo.
- Hover → muestra detalle de relación.
- Botón "Expandir grafo" → pantalla completa.
- Botón "Ver en grafo global" → abre `/grafo` centrado en este nodo.

### Sección 3 — Historial de contratos públicos

- Tabla: fecha, entidad, monto, tipo de proceso (licitación / exoneración), estado.
- Fuente: OSCE/SEACE API.
- **Flags de alerta:**
  - Empresa creada <30 días antes del contrato.
  - Exoneración sin justificación documentada.
  - Concentración recurrente con mismo proveedor.

### Sección 4 — Patrimonio declarado

- Tabla comparativa por año: bienes declarados, variación.
- Fuente: Portal Transparencia Estándar.
- **Flag:** variación patrimonial anómala respecto al salario declarado.

### Sección 5 — Historial delictivo / procesos judiciales

- Lista de procesos: expediente, juzgado, delito imputado, estado, fecha.
- Fuente: Poder Judicial (scraping).
- Distinguir: investigado / procesado / sentenciado / absuelto.

### Sección 6 — Historial académico

- Títulos declarados, institución, año.
- **Flag:** título no verificable o institución no reconocida por SUNEDU.
- Fuente: SERVIR + SUNEDU.

### Sección 7 — Perfil psicológico inferido

- Basado en conductas públicas documentadas (**no** diagnóstico clínico).
- Indicadores: patrones de decisión bajo presión, consistencia discurso/acción, red de lealtades.
- Cada indicador citado con referencia académica (Dark Triad en contexto político, análisis de conducta pública).
- **Disclaimer prominente** — mostrar en bloque visual diferenciado:

  > *"Este análisis no constituye un diagnóstico clínico. Se basa exclusivamente en conductas públicas documentadas y en modelos estadísticos. No representa una opinión médica ni legal."*

- Estilo visual: fondo ligeramente distinto para demarcar que es inferencia, no dato verificado.

### Sección 8 — Exportar perfil

- Botón primario: **"Exportar como .md"** — genera y descarga el archivo (blob download en cliente).
- Botón secundario: **"Copiar enlace al perfil"**.

---

## Vista Grafo Global (`/grafo`)

- Explorador de red persistente tipo Obsidian.
- Todos los funcionarios y entidades indexadas como nodos navegables.
- Interacciones: zoom, pan, click en nodo → panel lateral con resumen + link al perfil.
- **Filtros:** por institución, por rango de score IER, por tipo de conexión.
- **Búsqueda de nodo** por nombre o DNI dentro del grafo.
- Modo pantalla completa disponible.
- **Tecnología:** vis.js Network (preferido) o D3.js force-directed.
- **Performance:** renderizar solo nodos visibles en viewport (virtualización).

---

## Página de metodología (`/metodologia`)

- Explicación del modelo IER: qué mide, cómo se calcula, qué fuentes usa.
- Descripción de las 3 capas del modelo: reglas → anomaly detection → ML supervisado.
- Listado de fuentes con links y frecuencia de actualización.
- Limitaciones conocidas del sistema (qué no puede detectar).
- Enlace al repositorio GitHub: `github.com/rodhandev/garendil`.
- Sección para reportar errores o imprecisiones.

---

## Especificación del archivo `.md` exportable

Estructura del documento generado al exportar un perfil:

```markdown
---
dni: "12345678"
nombre: "Juan Pérez García"
cargo_actual: "Alcalde de Lima"
score_ier: 74
nivel_riesgo: "Alto"
fecha_generacion: "2026-05-17T00:00:00-05:00"
fuentes_consultadas:
  - OSCE/SEACE
  - Portal Transparencia Estándar
  - Poder Judicial
  - SERVIR
version_modelo: "1.0.0"
---

# Perfil: Juan Pérez García

## Score IER: 74/100 — Riesgo Alto

### Desglose
- Corrupción: XX/100
- Competencia: XX/100
- Adecuación al cargo: XX/100

## Historial de contratos públicos
[tabla o lista de contratos con flags]

## Patrimonio declarado
[tabla comparativa por año]

## Historial delictivo
[lista de procesos]

## Historial académico
[títulos y flags]

## Perfil psicológico inferido
[indicadores con citas académicas]

**Disclaimer:** Este análisis no constituye un diagnóstico clínico.

## Conexiones — Grafo

### Nodos relacionados
- **Empresa XYZ** (RUC: 12345678901) — afinidad: 87% — tipo: contratista recurrente
- **Carlos Quispe** (DNI: 87654321) — afinidad: 63% — tipo: co-investigado proceso 2021
- **Municipalidad de Lima** — afinidad: 100% — tipo: empleador actual

### Aristas de riesgo
- Juan Pérez → Empresa XYZ: 3 contratos por exoneración (2019-2023)
- Juan Pérez → Carlos Quispe: aparición conjunta en 2 procesos judiciales
```

---

## Criterios de accesibilidad y calidad

- WCAG AA: contraste 4.5:1 texto body, 3:1 texto grande.
- Touch targets: 44×44px mínimo.
- SSR en `/perfil/[dni]` para indexabilidad SEO.
- `prefers-reduced-motion` respetado en todas las animaciones.
- `alt` en todas las imágenes; icon-only buttons con `aria-label`.
- Sin `localStorage` — estado en React context o memoria.
