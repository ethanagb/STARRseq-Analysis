import pandas as pd

df = pd.read_csv("H1WG.SCP1.H1.R1_5kbWindowCov.bed", sep = '\t', header=None, names=['chrom','start','end','cumulative_coverage'])
df['mean_coverage'] = df['cumulative_coverage']/float(5000)
df.to_csv("H1WG.SCP1.H1.R1_5kpWindowCov_meancov.bed", sep='\t', index=False, header=False)
R1 = df
df=None

df = pd.read_csv("../H1WG.SCP1.H1.R2/H1WG.SCP1.H1.R2_5kbWindowCov.bed", sep = '\t', header=None, names=['chrom','start','end','cumulative_coverage'])
df['mean_coverage'] = df['cumulative_coverage']/float(5000)
df.to_csv("../H1WG.SCP1.H1.R2/H1WG.SCP1.H1.R2_5kpWindowCov_meancov.bed", sep='\t', index=False, header=False)
R2 = df
df = None



