#!/bin/bash

#####################
##RNAseq Expression Analysis  
##Ethan Baker 
##Gerstein Lab, Yale University
##Modified: 06 Jun 2016
#####################

GENOME_DIR="/project/fas/gerstein/eab232/starrseq/data/genomes/Drosphilia/dm3"
GENOME_FASTA="dm3_forMapping" 
STARRSEQ_DIR="/project/fas/gerstein/eab232/starrseq/data/raw"
ANALYSIS_DIR="/project/fas/gerstein/eab232/starrseq/analysis/tophat_alignment"
BEDTOOLS_PATH="/home/fas/gerstein/eab232/software/bedtools2/bin"
MACS_PATH="/home/fas/gerstein/eab232/software/MACS-1.3.7.1/bin"
CONTROL_BED="/project/fas/gerstein/eab232/starrseq/analysis/inputData/S2_STARRseq_input_Dmel_map.sorted.bed"

#BSUB -q shared
#BSUB -W 23:55
#BSUB -J RNAexpr
#BSUB -R "span[hosts=1]"
#BSUB -e /project/fas/gerstein/eab232/starrseq/analysis/logs/%J.err
#BSUB -o /project/fas/gerstein/eab232/starrseq/analysis/logs/%J.out



#Tophat steps

#Merge alignment files
module load Tools/SAMtools
samtools merge accepted_hitsAll.bam accepted_hits0.bam accepted_hits1.bam accepted_hits2.bam accepted_hits3.bam accepted_hits4.bam accepted_hits5.bam accepted_hits6.bam accepted_hits7.bam 

#Make BED files
cd $ANALYSIS_DIR
samtools view -Sb accepted_hitsAll.sam > accepted_hitsAll.bam 
$BEDTOOLS_PATH/bedtools bamtobed -i accepted_hitsAll.bam > accepted_hitsAll.bed 
gzip accepted_hitsAll.sam

#Build coverage profile
sort -k 1,1 accepted_hitsAll.bed > accepted_hitsAll.sorted.bed 
$BEDTOOLS_PATH/bedtools genomecov -bg -trackline -i accepted_hitsAll.sorted.bed -g $GENOME_DIR/$GENOME_FASTA.fa.fai > accepted_hits_Cov.bedgraph