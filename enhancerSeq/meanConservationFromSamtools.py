import pandas as pd
import numpy as np

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

R2Screen = pd.read_csv("H1.SCP1.WGscreenLib.R2_5kpWindowCov.bed", sep='\t', header=None, names=['chrom', 'start', 'end', 'cumulative_coverage']) 
R2Screen['mean_coverage'] = R2Screen['cumulative_coverage']/float(5000)
R1Screen = pd.read_csv("H1.SCP1.WGscreenLib.R1_5kpWindowCov.bed", sep='\t', header=None, names=['chrom','start','end','cumulative_coverage']) 
R1Screen['mean_coverage'] = R1Screen['cumulative_coverage']/float(5000)

R1['control_mean_coverage'] = R1Screen['mean_coverage']
R1['log(enhancerSeq/control)'] = np.log10(R1['mean_coverage']/R1['control_mean_coverage'])
R1.to_csv("H1WG.SCP1.H1.R1_5kbWindowsVsControl_Calculations.txt", sep='\t', index=False)

R2['control_mean_coverage'] = R2Screen['mean_coverage']
R2['log(enhancerSeq/control)'] = np.log10(R2['mean_coverage']/R2['control_mean_coverage'])
R2.to_csv("H1WG.SCP1.H1.R2_5kbWindowsVsControl_Calculations.txt", sep='\t', index=False)