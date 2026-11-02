each Text.FromBinary(Text.ToBinary(_, 1251), TextEncoding.Utf8)
each Text.FromBinary(Text.ToBinary(_, TextEncoding.Windows), TextEncoding.Utf8)

each Text.FromBinary(Text.ToBinary(Text.ToBinary(_, TextEncoding.Windows), 1251), TextEncoding.Utf8)
