# OSCE API — Especificación de Integración

**Base URL:** https://api.osce.go.pe
**Estándar:** OCDS (Open Contracting Data Standard)
**Autenticación:** API Key (variable de entorno OSCE_API_KEY)

## Endpoints principales

### 1. GET /contratos
Obtiene lista paginada de contratos públicos

**Parámetros:**
- `page` (int, default=1)
- `per_page` (int, default=50, max=1000)
- `estado` (string): 'activo', 'completado', 'cancelado'
- `fecha_desde` (ISO 8601): ej '2024-01-01'
- `fecha_hasta` (ISO 8601)
- `monto_min` (float)
- `monto_max` (float)

**Respuesta:**
```json
{
  "data": [
    {
      "id": "PE-2024-001234",
      "titulo": "Servicios de consultoria...",
      "descripcion": "...",
      "entidad_contratante": {
        "nombre": "Ministerio de Educación",
        "ruc": "20123456789"
      },
      "proveedor": {
        "nombre": "Empresa XYZ SAC",
        "ruc": "20987654321",
        "responsable_dni": "12345678"
      },
      "monto": 150000.00,
      "moneda": "PEN",
      "tipo_proceso": "licitacion_publica",
      "estado": "completado",
      "fecha_publicacion": "2024-01-15T10:30:00Z",
      "fecha_inicio": "2024-02-01",
      "fecha_fin": "2024-08-01",
      "documentos": [
        {
          "tipo": "bases",
          "url": "..."
        }
      ]
    }
  ],
  "pagination": {
    "page": 1,
    "per_page": 50,
    "total": 45230,
    "total_pages": 905
  }
}
```

### 2. GET /contratos/{id}
Detalle completo de un contrato

### 3. GET /proveedores
Búsqueda de proveedores por RUC o nombre

### 4. GET /entidades
Búsqueda de entidades contratantes

## Rate Limiting

- 100 requests/minuto por API Key
- 1000 requests/hora
- Si excede: retry con backoff exponencial

## Error Handling

- 401: API Key inválida
- 429: Rate limit excedido → esperar 60s antes de reintentar
- 500: Error de servidor OSCE → log y reintentar con exponential backoff

## Strategy de ingesta

1. **Primera carga:** últimos 3 años de contratos
2. **Updates incremental:** diaria, solo cambios desde última sincronización
3. **Archivos:** guardar respuesta JSON raw en PostgreSQL (para auditoria)
4. **Índices:** sobre DNI de responsables, RUC de empresas, fechas

## Endpoints secundarios (futuro)

- `/procesos-disciplinarios` (Contraloría)
- `/sentencias` (Poder Judicial)
- `/patrimonio` (Portal Transparencia)
