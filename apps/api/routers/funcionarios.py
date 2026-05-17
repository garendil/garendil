from fastapi import APIRouter, HTTPException

router = APIRouter(prefix="/api/v1/funcionarios", tags=["funcionarios"])


@router.get("/{dni}")
async def get_funcionario(dni: str):
    """
    Retorna el perfil completo de un funcionario por DNI.
    Incluye score IER, contratos, y metadata del grafo.
    """
    # TODO: implementar consulta a Supabase + Neo4j
    raise HTTPException(status_code=501, detail="Not implemented yet")


@router.get("/buscar")
async def buscar_funcionarios(q: str, page: int = 1, limit: int = 20):
    """
    Búsqueda full-text por nombre o DNI.
    """
    # TODO: implementar
    raise HTTPException(status_code=501, detail="Not implemented yet")
