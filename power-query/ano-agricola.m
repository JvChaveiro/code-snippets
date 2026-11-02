= Table.AddColumn(
            filter_dimension, "crop_year_description", each 
                let
                    anoAgricola = Number.FromText([crop_season_year]),
                    safra = [crop_season_description],
                    result =
                        if anoAgricola = 1890 then "Sem Safra" 
                        else if Text.Contains(safra, "Verão") then Number.ToText(anoAgricola) &"/"& Text.End(Number.ToText(anoAgricola + 1), 2)
                        else if Text.Contains(safra, "Safrinha") then Number.ToText(anoAgricola - 1) &"/"& Text.End(Number.ToText(anoAgricola), 2)
                        else Number.ToText(anoAgricola) &"/"& Text.End(Number.ToText(anoAgricola), 2)
                in
                    result, 
        type text
        )
