"""Worker OSCE — consume la API REST OCDS de OSCE.
Esta es la fuente prioritaria (API real, sin scraping).

Doc API: https://contratacionesabiertas.osce.gob.pe/
"""
import os
import httpx
from dotenv import load_dotenv

load_dotenv()

OSCE_BASE_URL = "https://contratacionesabiertas.osce.gob.pe/api/1.0"


def fetch_contratos(page: int = 1, page_size: int = 100) -> dict:
    """Obtiene página de contratos desde la API OCDS de OSCE."""
    url = f"{OSCE_BASE_URL}/records/"
    params = {"page": page, "pageSize": page_size}

    with httpx.Client(timeout=30) as client:
        response = client.get(url, params=params)
        response.raise_for_status()
        return response.json()


def run():
    """Entry point del worker. Ejecutado por Celery o cron en Hetzner."""
    page = 1
    while True:
        data = fetch_contratos(page=page)
        records = data.get("records", [])
        if not records:
            break
        # TODO: parsear OCDS → insertar en Supabase + Neo4j
        print(f"Página {page}: {len(records)} contratos")
        page += 1


if __name__ == "__main__":
    run()
