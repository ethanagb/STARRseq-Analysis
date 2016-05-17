#!/bin/bash
#BSUB -q shared
#BSUB -W 23:55
#BSUB -J MACS
#BSUB -R "span[hosts=1]"
#BSUB -e /project/fas/gerstein/eab232/starrseq/analysis/logs/%J.err
#BSUB -o /project/fas/gerstein/eab232/starrseq/analysis/logs/%J.out

GENOME_DIR="/project/fas/gerstein/eab232/starrseq/data/genomes/Drosphilia/dm3"
GENOME_FASTA="dm3_forMapping" 
STARRSEQ_DIR="/project/fas/gerstein/eab232/starrseq/data/raw"
ANALYSIS_DIR="/project/fas/gerstein/eab232/starrseq/analysis"
BEDTOOLS_PATH="/home/fas/gerstein/eab232/software/bedtools2/bin"
MACS_PATH = "/home/fas/gerstein/eab232/software/MACS-1.3.7.1/bin"

python $MACS_PATH/macs -t $ANALYSIS_DIR/S2_STARRseq_rep1_Dmel_map.bed -c $ANALYSIS_DIR/inputData/S2_STARRseq_input_Dmel_map.sorted.bed  --name S2_STARRseq_rep1_vsControl  --gsize 120000000 --pvalue .00001 --bw 500 --mfold 3 