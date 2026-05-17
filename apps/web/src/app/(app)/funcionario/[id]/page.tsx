// Perfil público de funcionario — indexado por SSR para SEO
// Params: id = DNI o slug único
export default function FuncionarioPage({
  params,
}: {
  params: { id: string }
}) {
  return (
    <main>
      <h1>Perfil: {params.id}</h1>
    </main>
  )
}
