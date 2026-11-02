/*
    Baseado no dCalendario de Alison Pezzott
    https://github.com/alisonpezzott/powerbi
*/

let
    /* 
        Data Inicial. Especifique o início da sua tabela. Extremamente recomendado o uso de parâmetros.
       Apesar de não aconselhável pode-se usar List.Min(Tabela[Coluna]) para obter a menor data de uma coluna ou ainda
       List.Min(List.Combine({Tabela1[Coluna], Tabela2[Coluna2], TabelaN[ColunaN]}) quando precisar obter de várias colunas, 
       contudo é reforçado que pode causar perdas de performance durante a carga.
    */
    dataInicial = #date(2023, 1, 1), 

    /* 
        Data Final. O padrão é o final do ano da data atual.
       Pode se usar os mesmos recursos que a dataInicial
    */
    dataFinal = Date.EndOfYear(Date.From(DateTime.LocalNow())), 

    //Dia em que inicia a semana 
    inicioSemana = Day.Sunday, 

    //Mês do início de cada ano fiscal 
    mesInicioAnoFiscal = 1,

    //Geração da tabela
    tabela = 
        let
            idioma = "pt-BR", 
            dataAtual = Date.From(DateTime.LocalNow()), 

            //Quantidade de dias
            duracao = Duration.Days(dataFinal-dataInicial) + 1,

            //Lista com todas as datas 
            listaDatas = List.Dates(dataInicial, duracao, #duration(1, 0, 0, 0))
        in 

            //Invoca a função do construtor de tabela
            #table(

                //Define os nomes e tipos das colunas
                type table[
                    _idCalendario = text,
                    Data = date,
                    DataAtual = text,
                    DataAtualVerificador = Int64.Type,
                    Ano = Int64.Type,
                    AnoAtual = text,
                    Trimestre = Int64.Type,
                    TrimestreNome = text,
                    TrimestreAnoCod = text,
                    TrimestreAno = text,
                    Mês = Int64.Type,
                    MêsAtual = text,
                    MêsAtualVerificador = Int64.Type,
                    MêsAtualAbv = text,
                    MêsNome = text,
                    MêsNomeAbv = text,
                    MêsAnoCod = text,
                    MêsAno = text,
                    SemanaDoAno = Int64.Type,
                    SemanaDoAnoNome = text,
                    SemanaDoMês = Int64.Type,
                    SemanaDoMêsNome = text,
                    SemanaPeríodo = text,
                    Dia = Int64.Type,
                    DiaDaSemana = Int64.Type,
                    DiaDaSemanaNome = text,
                    FinalDeSemana = logical
                ],

                //Transforma a lista de datas 
                List.Transform(

                    //Lista que será transformada 
                    listaDatas,

                    //Lista das trasnformações
                    each {
                            //----- _idCalendario =
                            Date.ToText(_, "YYYYMMDD"),
                            //----- Data =
                            _,
                            //----- DataAtual =
                            let 
                                offset = Number.From(_ - dataAtual)
                            in 
                                if offset = 0 then "Data Atual" 
                                // else if offset = -1 then "Data Anterior" 
                                // else if offset = 1 then "Próxima Data" 
                                else Date.ToText(_, [Format="dd/MM/yyyy"]), 
                            //----- DataAtualVerificador =
                            let 
                                offset = Number.From(_ - dataAtual)
                            in 
                                if _ <= dataAtual then 1
                                else 0, 
                            //----- Ano =
                            Date.Year(_),
                            //----- AnoAtual =
                            let 
                                offset = Date.Year(_) - Date.Year(dataAtual) 
                            in
                                if offset = 0 then "Ano Atual" 
                                // else if offset = -1 then "Ano Anterior" 
                                // else if offset = 1 then "Próximo Ano" 
                                else Date.ToText(_,[Format="yyyy"]), 
                            //----- Trimestre =
                            Date.QuarterOfYear(_),
                            //----- TrimestreNome =
                            Text.From(Date.QuarterOfYear(_)) & "T",
                            //----- TrimestreAnoCod =
                            Date.ToText(_, "yyyy") & Text.From(Date.QuarterOfYear(_)),
                            //----- TrimestreAno =
                            Text.From(Date.QuarterOfYear(_)) & "T-" & Date.ToText(_, "yyyy"),
                            //----- Mês =
                            Date.Month(_),
                            //----- MêsAtual =
                            let
                                contexto = Date.Year(_) * 12 - 1 + Date.Month(_),
                                atual = Date.Year(dataAtual) * 12 - 1 + Date.Month(dataAtual),
                                offset = contexto - atual
                            in
                                if offset = 0 then "Mês Atual" 
                                // else if offset = -1 then "Mês Anterior" 
                                // else if offset = 1 then "Próximo Mês" 
                                else Date.MonthName(_, idioma),
                            //----- MêsAtualVerificador =
                            let
                                contexto = Date.Year(_) * 12 - 1 + Date.Month(_),
                                atual = Date.Year(dataAtual) * 12 - 1 + Date.Month(dataAtual),
                                offset = contexto - atual
                            in
                                if contexto <= atual then 1
                                else 0,
                            //----- MêsAtualAbv =
                            let
                                contexto = Date.Year(_) * 12 - 1 + Date.Month(_),
                                atual = Date.Year(dataAtual) * 12 - 1 + Date.Month(dataAtual),
                                offset = contexto - atual
                            in
                                if offset = 0 then "Mês Atual" 
                                // else if offset = -1 then "Mês Anterior" 
                                // else if offset = 1 then "Próximo Mês" 
                                else Text.Start(Date.MonthName(_, idioma), 3),
                            //----- MêsNome =
                            Date.MonthName(_),
                            //----- MêsNomeAbv =
                            Date.ToText(_,[Format="MMM"]),
                            //----- MêsAnoCod =
                            Date.ToText(_, "yyyyMM"),
                            //----- MêsAno =
                            Date.ToText(_, "MMM-yy"),
                            //----- SemanaDoAno =
                            Date.WeekOfYear(_),
                            //----- SemanaDoAnoNome =
                            Text.From(Date.WeekOfYear(_)) & "º sem",
                            //----- SemanaDoMês =
                            Date.WeekOfMonth(_),
                            //----- SemanaDoMêsNome =
                            Text.From(Date.WeekOfMonth(_)) & "º sem",
                            //----- SemanaPeriodo =
                            let
                                dia = Date.Day(_),
                                mes = Date.ToText(_, [Format="MM"]),
                                finalMes = Date.ToText(Date.EndOfMonth(_), [Format="dd"])
                            in
                                if dia < 15 then "01" &"/"& mes &" - "& "14" &"/"& mes
                                else "15" &"/"& mes &" - "& finalMes &"/"& mes,
                            //----- Dia =
                            Date.Day(_),
                            //----- DiaDaSemana =
                            Date.DayOfWeek(_, Day.Sunday),
                            //----- DiaDaSemanaNome =
                            Date.DayOfWeekName(_),
                            //----- FinalDeSemana =
                            if Date.DayOfWeek(_, Day.Sunday) = 0 or Date.DayOfWeek(_, Day.Sunday) = 6 then true else false
                        }
                    )
            )
in
    tabela