# MEF Portal Transparencia — Guía de Scraping

**URL Base:** https://www.portal.transparencia.gob.pe/

## Estructura de búsqueda

### Endpoint: Portal de Transparencia Estándar
- URL: https://www.portal.transparencia.gob.pe/buscador/funcionario
- Búsqueda por: DNI, nombres, institución
- Datos disponibles:
  - Nombre completo
  - Cargo
  - Institución
  - Patrimonio declarado (años)
  - Link a detalle (PDF o HTML)

### Estructura HTML de detalle
```html
<div class="funcionario-detalle">
  <h1>Juan Pérez García</h1>
  <table class="patrimonio">
    <tr>
      <td>Año</td>
      <td>Bienes inmuebles</td>
      <td>Bienes muebles</td>
      <td>Ingresos</td>
    </tr>
    <!-- filas por año -->
  </table>
</div>
```

## Estrategia de scraping

1. **Búsqueda inicial:** GET /buscador/funcionario?dni=XXXXXXXX
2. **Parse de listado:** extraer link al detalle
3. **Fetch detalle:** GET /funcionario/{id}
4. **Parse de tabla:** extraer patrimonio por año
5. **Almacenar:** guardar en BD con flags de anomalía

## Rate limiting

- No tiene API formal → usar httpx con delays
- Delay mínimo: 2 segundos entre requests
- User-Agent real requerido

## Datos a extraer

| Campo | Tipo | Notas |
|-------|------|-------|
| dni | string | Ya tenemos |
| bienes_inmuebles_año | float | Por año |
| bienes_muebles_año | float | Por año |
| ingresos_año | float | Salario declarado |
| variacion_patrimonio | float | (año_actual - año_anterior) / año_anterior |

## Flags de Layer 1

- `patrimonio_anomalo`: variación > 50% sin explicación
- `incremento_injustificado`: patrimonio sube pero ingresos bajan
- `bienes_no_declarados`: cambios en activos sin actualización
