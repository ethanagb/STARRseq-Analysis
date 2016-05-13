#!/bin/bash

#####################
##STARRseq Analysis  
##Ethan Baker 
##Gerstein Lab, Yale University
##Modified: 13 may 2016
#####################

LOG_DIR="/project/fas/gerstein/eab232/starrseq/analysis/logs"
GENOME_DIR="/project/fas/gerstein/eab232/starrseq/data/genomes/Drosphilia/dm3"
GENOME_FASTA="dm3_forMapping" 
STARRSEQ_DIR="/project/fas/gerstein/eab232/starrseq/data/raw"
ANALYSIS_DIR="/project/fas/gerstein/eab232/starrseq/analysis"
BEDTOOLS_PATH="/home/fas/gerstein/eab232/software/bedtools2/bin"

#BSUB -q shared
#BSUB -W 23:55
#BSUB -J Dm_bwt2
#BSUB -R "span[hosts=1]"
#BSUB -e $LOG_DIR/%J.err
#BSUB -o $LOG_DIR/%J.out

module load Apps/Bowtie2

#Download Arnold 2013 STARRseq data
cd $STARRSEQ_DIR
wget http://starklab.org/data/arnold_science_2013/S2_STARRseq_rep1_1.fastq.gz
wget http://starklab.org/data/arnold_science_2013/S2_STARRseq_rep1_2.fastq.gz
#wget http://starklab.org/data/arnold_science_2013/S2_STARRseq_rep2_1.fastq.gz
#wget http://starklab.org/data/arnold_science_2013/S2_STARRseq_rep2_2.fastq.gz

tar -xvzf S2_STARRseq_*.fastq.gz

#Build bowtie2 index of dm3 
bowtie2-build -f $GENOME_DIR/$GENOME_FASTA.fa $GENOME_DIR

#Perform alignment (default mode is unique mapping, -M deprecated)
bowtie2 -x $GENOME_DIR/$GENOME_FASTA -1 $STARRSEQ_DIR/S2_STARRseq_rep1_1.fastq -2 $STARRSEQ_DIR/S2_STARRseq_rep1_2.fastq -S $ANALYSIS_DIR/S2_STARRseq_rep1_Dmel_map.sam -p 8 

#Convert SAM -> BAM -> BED
cd $ANALYSIS_DIR
module load Tools/SAMtools
samtools view -Sb S2_STARRseq_rep1_Dmel_map.sam > S2_STARRseq_rep1_Dmel_map.bam 
$BEDTOOLS_PATH/bedtools bamtobed -i S2_STARRseq_rep1_Dmel_map.bam > S2_STARRseq_rep1_Dmel_map.bed 
gzip S2_STARRseq_rep1_Dmel_map.sam

#Generate coverage bedgraph
cd $GENOME_DIR
samtools faidx $GENOME_FASTA.fa
cd $ANALYSIS_DIR
sort -k 1,1 S2_STARRseq_rep1_Dmel_map.bed > S2_STARRseq_rep1_Dmel_map.sorted.bed 
$BEDTOOLS_PATH/bedtools genomecov -bg -trackline -i S2_STARRseq_rep1_Dmel_map.sorted.bed -g $GENOME_DIR/$GENOME_FASTA.fa.fai > S2_STARRseq_rep1_Dmel_map_Cov.bedgraph

#MACS PeakCalling

