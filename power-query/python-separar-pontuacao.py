import pandas as pd

pat = r'(?<=[A-Za-z])[\.\/](?=[A-Za-z])'

dataset["New"] = dataset["<COLUNA>"].str.replace(pat, ' ')
