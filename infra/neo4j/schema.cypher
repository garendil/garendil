// ============================================================
// GARENDIL — Esquema Neo4j
// Ejecutar en Neo4j Browser o cypher-shell
// ============================================================

// ---------- CONSTRAINTS (unicidad) ----------
CREATE CONSTRAINT funcionario_dni IF NOT EXISTS
  FOR (f:Funcionario) REQUIRE f.dni IS UNIQUE;

CREATE CONSTRAINT empresa_ruc IF NOT EXISTS
  FOR (e:Empresa) REQUIRE e.ruc IS UNIQUE;

CREATE CONSTRAINT contrato_id IF NOT EXISTS
  FOR (c:Contrato) REQUIRE c.id IS UNIQUE;

CREATE CONSTRAINT institucion_id IF NOT EXISTS
  FOR (i:Institucion) REQUIRE i.id IS UNIQUE;

// ---------- INDEXES (búsqueda) ----------
CREATE INDEX funcionario_nombre IF NOT EXISTS
  FOR (f:Funcionario) ON (f.nombre);

CREATE INDEX empresa_nombre IF NOT EXISTS
  FOR (e:Empresa) ON (e.nombre);

// ---------- NODOS ----------
// (:Funcionario {dni, nombre, cargo, institucion_id, score_ier})
// (:Empresa     {ruc, nombre, fecha_constitucion, activa})
// (:Contrato    {id, monto, fecha, modalidad, fuente})
// (:Institucion {id, nombre, sector})
// (:Persona     {dni, nombre})  -- personas naturales no funcionarios

// ---------- RELACIONES ----------
// (:Funcionario)-[:TRABAJA_EN {cargo, desde, hasta}]->(:Institucion)
// (:Funcionario)-[:ADJUDICO   {fecha, monto}]->(:Contrato)
// (:Empresa    )-[:GANO       {fecha}]->(:Contrato)
// (:Contrato   )-[:FINANCIADO_POR]->(:Institucion)
// (:Funcionario)-[:VINCULADO_A {tipo, fuente}]->(:Empresa)
// (:Funcionario)-[:VINCULADO_A {tipo, fuente}]->(:Persona)
