import pandas as pd
import numpy as np

def generatePeakBuffers(infile):

    infile = open(str(infile),'r') #This BED has chrom | txStart | txEnd
    n = 5000 #set size of mandatory distance from TSS
    with open('TSS_windows.bed',"w+") as outfile:
        for line in infile.readlines():
            if line.startswith('#'):
                continue
            else:
                chrom = line.split('\t')[0]
                TSS = int(line.split('\t')[1])
                negBuffer = TSS-(n/2)
                posBuffer = TSS+(n/2)
                if negBuffer < 0:
                    negBuffer = 0;
                outfile.write(str(chrom) + '\t' + str(negBuffer) + '\t' + str(posBuffer) + '\n')

if __name__ == "__main__":
    generatePeakBuffers(infile)
