#!/bin/bash
#BSUB -q week
#BSUB -W 123:55
#BSUB -J MACS-R2
#BSUB -R "span[hosts=1]"
#BSUB -e /project/fas/gerstein/eab232/enhancerSeq/analysis/logs/%J.err
#BSUB -o /project/fas/gerstein/eab232/enhancerSeq/analysis/logs/%J.out

ANALYSIS_DIR="/project/fas/gerstein/eab232/enhancerSeq/analysis"
MACS_PATH="/home/fas/gerstein/eab232/software/MACS-1.3.7.1/bin"
CONTROL_BED="/project/fas/gerstein/eab232/enhancerSeq/analysis/H1.SCP1.WGscreenLib.R1.sorted.bam"

python $MACS_PATH/macs -t $ANALYSIS_DIR/H1WG.SCP1.H1.R2/H1WG.SCP1.H1.R2.sorted.bam -c $CONTROL_BED --name H1WG.SCP1.H1.R2_vsControlPeaks  --gsize 2700000000 --pvalue .00001 --bw 500 --mfold 3 --format BAM