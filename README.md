# code-snippets

Trechos de código que eu reaproveito no dia a dia de BI e análise de dados: tabelas calendário, funções de tratamento de texto, padrões de DAX, scripts de carga do Qlik e formatos prontos.

A ideia é ter um ponto de partida testado em vez de reescrever a mesma coisa a cada projeto. Copie, ajuste ao seu modelo e use.

## Organização

| Pasta | Conteúdo |
|---|---|
| `dax/` | Medidas e tabelas calculadas em DAX (Power BI) |
| `power-query/` | Consultas e funções em M (Power Query) |
| `qlik/` | Scripts de carga do Qlik Sense |
| `excel/` | Formatos personalizados de célula |
| `git/` | Comandos de Git que uso normalmente |
| `referencia/` | Listas e tabelas de apoio (stop words, paletas, municípios) |

## Convenções

- Um snippet por arquivo, com a extensão da linguagem: `.dax`, `.m`, `.qvs`.
- Nomes em minúsculas, separados por hífen.
- Valores sensíveis ou específicos de um ambiente aparecem como placeholder: `<EMAIL>`, `<PASSWORD>`, `<WORKFLOW_ID>`.
- Quando um snippet parte do trabalho de outra pessoa, o crédito fica no cabeçalho do próprio arquivo.
