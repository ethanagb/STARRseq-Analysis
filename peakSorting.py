import pandas as pd
import numpy as np

peakDF = pd.read_csv('~/Documents/GersteinLab/S2_STARRseq_rep1_vsControl_peaks.bed',
                       sep='\t',header=None, names = ['chrom','start','end','name','score'])
#Get chromosome names
chrNames = peakDF.chrom.unique()
infile = open('flybase_genes.txt','r')
n = 5000 #set size of mandatory distance from TSS
with open('TSS_windows.bed',"w+") as outfile:
    for line in infile.readlines():
        if line.startswith('#'):
            continue
        else:
            chrom = line.split('\t')[2]
            TSS = int(line.split('\t')[4])
            negBuffer = TSS-(n/2)
            posBuffer = TSS+(n/2)
            if negBuffer < 0:
                negBuffer = 0;
            outfile.write(str(chrom) + '\t' + str(negBuffer) + '\t' + str(posBuffer) + '\n')