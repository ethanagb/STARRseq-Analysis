#!/bin/bash
#BSUB -q shared
#BSUB -W 23:55
#BSUB -J meme
#BSUB -R "span[hosts=1]"
#BSUB -e /project/fas/gerstein/eab232/starrseq/analysis/logs/%J.err
#BSUB -o /project/fas/gerstein/eab232/starrseq/analysis/logs/%J.out

GENOME_DIR="/project/fas/gerstein/eab232/starrseq/data/genomes/Drosphilia/dm3"
GENOME_FASTA="dm3_forMapping" 
ANALYSIS_DIR="/project/fas/gerstein/eab232/starrseq/analysis"
SOFTWARE_DIR="/home/fas/gerstein/eab232/software/bin"

#A tentative motifDiscovery procedure

#Extract sequences for MACS peaks.
#bedtools getfasta -fi $GENOME_DIR/$GENOME_FASTA.fa -bed $ANALYSIS_DIR/S2_STARRseq_rep1_vsControl_peaks_fixedPos.bed -fo $ANALYSIS_DIR/S2_STARRseq_rep1_vsControl_peaks.fa

#Use the MEME algorithm for motif discovery.
$SOFTWARE_DIR/meme -dna -maxsize 7296745 $ANALYSIS_DIR/S2_STARRseq_rep1_vsControl_peaks.fa 