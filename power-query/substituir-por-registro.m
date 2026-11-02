= Table.TransformColumnTypes(
        Table.TransformColumns(
            #"Tipo Alterado", 
            {{"trial_status", each Record.FieldOrDefault(status_list,_,_)}}
        ), 
        {{"trial_status", type text}}
    )