# Estado de acceso a fuentes de datos

Verificar antes de implementar cada conector. Última revisión: pendiente.

| Fuente | URL | Acceso | Notas |
|--------|-----|--------|-------|
| MEF Transparencia Económica | transparencia.mef.gob.pe | Scraping | Sin API pública documentada |
| OSCE / SEACE | seace.osce.gob.pe | API REST (verificar) | Endpoint base: `https://prod2.seace.gob.pe/seacebus-uiwd-pub/` |
| SUNAT RUC | e-consultaruc.sunat.gob.pe | Scraping + Playwright | Captcha presente |
| JNE Declaraciones | declara.jne.gob.pe | Scraping | — |
| Contraloría | contraloria.gob.pe | Scraping | — |
| INFObras | infobras.vivienda.gob.pe | Por verificar | Posible API REST |
| RENIEC | reniec.gob.pe | No disponible públicamente | Solo verificación con clave |

## Pendiente verificar

- [ ] SEACE: documentar parámetros reales del endpoint por DNI/RUC
- [ ] INFObras: revisar si expone API REST pública
- [ ] MEF: revisar si hay dataset descargable actualizable vía batch
