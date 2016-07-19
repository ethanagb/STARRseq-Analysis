from __future__ import division
import pandas as pd

FEATUREFILE = 'S2_STARRseq_rep1_vsControl_peaks.bed'
CONSERVATIONFILEDIR = './conservation/'

peakDF = pd.read_csv(str(FEATUREFILE), sep = '\t', header=None, names=['chrom','start','end','name','enrichmentVal'])
#Reject negative peak starts, if they exist (sometimes this can happen w/ MACS)
peakDF.drop(peakDF[peakDF.start <= 0].index, inplace=True)
peakDF.reset_index(inplace=True)
peakDF.drop('index', axis=1, inplace=True)
peakDF['conservation'] = 1.0

chromNames = peakDF.chrom.unique()

for chromosome in chromNames: 
	chromSubset = peakDF[peakDF.chrom == str(chromosome)]
	chromDF = pd.read_csv(str(CONSERVATIONFILEDIR) + str(chromosome)+'.bed', sep='\t', header=None, names=['chrom','start','end','conserveScore'])
	
	for i in xrange(0,len(chromSubset.index)):
		x = chromDF[chromDF.start >= chromSubset['start'][chromSubset.index[i]]]
		featureSubset = x[x.start < chromSubset['end'][chromSubset.index[i]]]
		x=None
		featureConservation = float(sum(featureSubset.conserveScore)/(chromSubset['end'][chromSubset.index[i]]-chromSubset['start'][chromSubset.index[i]]))
		peakDF.set_value(chromSubset.index[i],'conservation',featureConservation)
		featureSubset=None
peakDF.to_csv("featureConservation.td", sep = '\t')