# INFOBRAS — Guía de Scraping

**URL Base:** https://www.infobras.com.pe/

## Endpoints disponibles

### 1. Búsqueda de obras
- URL: https://www.infobras.com.pe/obras?estado=ESTADO
- Parámetros:
  - estado: en_licitacion, en_ejecucion, paralizada, culminada
  - responsable: nombre o DNI del funcionario
  - año: 2020-2026

### 2. Detalle de obra
- URL: https://www.infobras.com.pe/obra/{id}
- Datos:
  - Nombre de la obra
  - Ubicación
  - Presupuesto aprobado
  - Presupuesto ejecutado
  - Responsable (DNI + nombre)
  - Contratista
  - Fechas (inicio, fin programado, fin real)
  - Estado

## Estructura HTML

```html
<div class="obra-card">
  <h3>Nombre Obra</h3>
  <p class="responsable">Responsable: Juan Pérez (DNI: 12345678)</p>
  <p class="presupuesto">Presupuesto: S/. 1,200,000</p>
  <p class="estado">Estado: En ejecución</p>
</div>
```

## Rate limiting

- Max 30 requests/minuto
- Delay: 2-3 segundos entre requests
- User-Agent: Mozilla/5.0 (necesario)

## Flags de Layer 1

- `obra_paralizada_frecuencia`: más de 3 obras paralizadas
- `sobrecosto_obra`: presupuesto ejecutado > presupuesto aprobado en >20%
- `atrasos_recurrentes`: obras siempre llegan retrasadas
