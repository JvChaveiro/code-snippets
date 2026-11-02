#table(
    type table [
        Date = date,
        _idCalendar = text,
        Year = Int64.Type,
        Quarter = Int64.Type,
        QuarterName = text,
        QuarterYear = text,
        Month = Int64.Type,
        MonthName = text,
        MonthYear = text,
        WeekOfYear = Int64.Type,
        WeekOfMonth = Int64.Type,
        Day = Int64.Type,
        DayOfWeek = Int64.Type,
        DayOfWeekName = text,
        isWeekend = logical
    ],
    List.Transform(
        List.Dates(#date(2000, 1, 1), 18627, #duration(1, 0, 0, 0)), // YEARS 2000 to 2050
        each
            {
                _,
                Date.ToText(_, "YYYYMMDD"),
                Date.Year(_),
                Date.QuarterOfYear(_),
                Text.From(Date.QuarterOfYear(_)) & "T",
                Text.From(Date.QuarterOfYear(_)) & "T-" & Date.ToText(_, "yyyy"),
                Date.Month(_),
                Date.MonthName(_),
                Date.ToText(_, "MMM-yy"),
                Date.WeekOfYear(_),
                Date.WeekOfMonth(_),
                Date.Day(_),
                Date.DayOfWeek(_, Day.Sunday),
                Date.DayOfWeekName(_),
                if Date.DayOfWeek(_, Day.Sunday) = 0 or Date.DayOfWeek(_, Day.Sunday) = 6 then true else false
            }
    )
)