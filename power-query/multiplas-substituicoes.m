let 
ReplaceAll = (
    InputTable as table,
    ColumnName as text, 
    ReplacementTable as table, 
    optional StartRow as number
    ) 
=>
let
ActualRow = 
    if(StartRow = null) 
    then 0 
    else StartRow
,
result = 
    Table.ReplaceValue(
        InputTable,
        ReplacementTable{ActualRow}[Old], 
        ReplacementTable{ActualRow}[New],
        Replacer.ReplaceText, 
        {ColumnName}
    )
,
NextRow = ActualRow + 1
,
OutputTable = 
    if NextRow > (Table.RowCount(ReplacementTable) - 1)
    then result
    else @ReplaceAll(result, ColumnName, ReplacementTable, NextRow)
in
    OutputTable
in
    ReplaceAll