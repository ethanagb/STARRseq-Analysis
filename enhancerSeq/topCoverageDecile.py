import pandas as pd
import numpy as np

R1 = pd.read_csv("H1WG.SCP1.H1.R1_5kbWindowsVsControl_Calculations.txt", sep='\t')
R1['FoldChange']= R1["log(enhancerSeq/control)"]
R1.dropna(0,inplace=True)
R1_10th = np.percentile(R1["FoldChange"],90)
R1_top10 = R1[R1.FoldChange >= R1_10th]
R1.to_csv('H1WG.SCP1.H1.R1_5kbWindowsVsControl_Calculations_top10.txt', sep='\t', header=False, index=False)

R2 = pd.read_csv("H1WG.SCP1.H1.R2_5kbWindowsVsControl_Calculations.txt", sep='\t')
R2['FoldChange']= R2["log(enhancerSeq/control)"]
R2.dropna(0,inplace=True)
R2_10th = np.percentile(R2["FoldChange"],90)
R2_top10 = R2[R2.FoldChange >= R1_10th]
R2.to_csv('H1WG.SCP1.H1.R2_5kbWindowsVsControl_Calculations_top10.txt', sep='\t', header=False, index=False)