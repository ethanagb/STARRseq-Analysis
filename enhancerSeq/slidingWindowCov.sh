#!/bin/bash
#BSUB -q shared
#BSUB -W 23:55
#BSUB -J windowCov1
#BSUB -R "span[hosts=1]"
#BSUB -e /project/fas/gerstein/eab232/starrseq/analysis/logs/%J.err
#BSUB -o /project/fas/gerstein/eab232/starrseq/analysis/logs/%J.out

bedtools coverage -A hg19_5kbWindows.bed -B H1.SCP1.WGscreenLib.R1.bed > H1.SCP1.WGscreenLib.R1_vs5kbWindowsCoverage.bed