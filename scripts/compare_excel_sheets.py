#%%
import pandas as pd
import numpy as np

#%%
for s in range(4):
    sNew = pd.read_excel('../data/data_20201110_new.xlsx', sheet_name=s)
    sOld = pd.read_excel('../data/vintage_data/data_20201110.xlsx', sheet_name=s)
    comparison = sNew == sOld
    rows, cols = np.where(comparison==False)
    for item in zip(rows, cols):
        if np.isnan(sNew.iloc[item[0], item[1]]) or np.isnan(sOld.iloc[item[0], item[1]]):
            if not np.isnan(sNew.iloc[item[0], item[1]])*np.isnan(sOld.iloc[item[0], item[1]]):
                print(f'sheet {s}: row {item[0]}, col {item[1]}, old = {sOld.iloc[item[0], item[1]]}, new = {sNew.iloc[item[0], item[1]]}')
        else:
            diff = sNew.iloc[item[0], item[1]]/sOld.iloc[item[0], item[1]]*100 - 100
            if diff>1e-6:
                print(f'sheet {s}: row {item[0]}, col {item[1]}, diff % = {diff}')