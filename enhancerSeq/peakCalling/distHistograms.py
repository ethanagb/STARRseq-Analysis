import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt

namelist = ['H1WG.SCP1.H1.R1_allFoldEnrich.dist','H1WG.SCP1.H1.R1_top10FoldEnrich.dist','H1WG.SCP1.H1.R2_allFoldEnrich.dist', 'H1WG.SCP1.H1.R2_top10FoldEnrich.dist']
basePath="/Users/ethanbaker/Documents/GersteinLab/STARRseqAnalysis/enhancerSeq/peakCalling/"

for file in namelist:
	data = pd.read_csv(str(basePath)+str(file), sep = '\t', header=None, names=['FoldEnrichment'])
	sns.set(style='whitegrid', context='paper')
	sns.distplot(data["FoldEnrichment"], color='g')
	plt.savefig(str(basePath)+str(file) + '.png', dpi=500, format='tiff')
	plt.clf()