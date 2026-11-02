// Municípios do Brasil direto da API de Localidades do IBGE (sem autenticação).
// Doc: https://servicodados.ibge.gov.br/api/docs/localidades
// view=nivelado devolve uma linha por município, já com UF e região.
// Área territorial NÃO vem na API (está em Municípios-UF.xlsx).
let
    Fonte = Json.Document(
        Web.Contents(
            "https://servicodados.ibge.gov.br/api/v1/localidades/municipios",
            [Query = [view = "nivelado"]]
        )
    ),
    Tabela = Table.FromRecords(Fonte),
    Colunas = Table.SelectColumns(Tabela, {"municipio-id", "municipio-nome", "UF-id", "UF-sigla", "UF-nome", "regiao-sigla", "regiao-nome"}),
    Renomeado = Table.RenameColumns(Colunas, {
        {"municipio-id", "CD_MUN"}, {"municipio-nome", "NM_MUN"},
        {"UF-id", "CD_UF"}, {"UF-sigla", "NM_UF_SIGLA"}, {"UF-nome", "NM_UF"},
        {"regiao-sigla", "SG_REGIAO"}, {"regiao-nome", "NM_REGIAO"}
    }),
    Tipos = Table.TransformColumnTypes(Renomeado, {
        {"CD_MUN", Int64.Type}, {"NM_MUN", type text},
        {"CD_UF", Int64.Type}, {"NM_UF_SIGLA", type text}, {"NM_UF", type text},
        {"SG_REGIAO", type text}, {"NM_REGIAO", type text}
    })
in
    Tipos
