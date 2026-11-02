    formatedDoc = 
        Table.TransformColumns(filter_dimension,{
            {"farm_document", each 
            let 
                cleanText = Text.Select(_, {"0".."9"}),
                textSize = Text.Length(cleanText),
                docsFormat = 
                    if textSize = 11 then Text.Middle(cleanText, 0, 3) & "." & Text.Middle(cleanText, 3, 3) & "." & Text.Middle(cleanText, 6, 3) & "-" & Text.Middle(cleanText, 9, 2) 
                    else if textSize = 14 then Text.Middle(cleanText, 0, 2) & "." & Text.Middle(cleanText, 2, 3) & "." & Text.Middle(cleanText, 5, 3) & "/" & Text.Middle(cleanText, 8, 4) & "-" & Text.Middle(cleanText, 12, 2) 
                    else _
            in 
                docsFormat,
            type text
            }
        })