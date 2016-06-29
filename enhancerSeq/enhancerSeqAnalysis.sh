#!/bin/bash
#BSUB -q week
#BSUB -W 136:57
#BSUB -M 
#BSUB -J bow2_1
#BSUB -R "span[hosts=1]"
#BSUB -e /project/fas/gerstein/eab232/enhancerSeq/analysis/logs/%J.err
#BSUB -o /project/fas/gerstein/eab232/enhancerSeq/analysis/logs/%J.out

ENHANCERSEQ_DIR='/gpfs/scratch/fas/gerstein/common/KW_EnhancerSeq'
GENOME_DIR="/project/fas/gerstein/eab232/enhancerSeq/data/genomes/Homo_sapiens/hg19"
GENOME_FASTA="hg19.fa" 
ANALYSIS_DIR="/project/fas/gerstein/eab232/enhancerSeq/analysis"
BEDTOOLS_PATH="/home/fas/gerstein/eab232/software/bedtools2/bin"
MACS_PATH="/home/fas/gerstein/eab232/software/MACS-1.3.7.1/bin"
CONTROL_BED="/project/fas/gerstein/eab232/starrseq/analysis/inputData/S2_STARRseq_input_Dmel_map.sorted.bed"

#Build bowtie2 index of hg19
module load Apps/Bowtie2
cd $GENOME_DIR
bowtie2-build -f $GENOME_FASTA .

#Perform alignment (default mode is unique mapping, -M deprecated)
bowtie2 -x $GENOME_DIR/$GENOME_FASTA -1 $ENHANCERSEQ_DIR/H1.SCP1.WGscreenLib.R1.1.fastq.gz -2 $ENHANCERSEQ_DIR/H1.SCP1.WGscreenLib.R1.2.fastq.gz -S $ANALYSIS_DIR/H1.SCP1.WGscreenLib.R1.sam -p 8 

cd $ANALYSIS_DIR
module load Tools/SAMtools
samtools view -Sb H1.SCP1.WGscreenLib.R1.sam > H1.SCP1.WGscreenLib.R1.bam 
$BEDTOOLS_PATH/bedtools bamtobed -i H1.SCP1.WGscreenLib.R1.bam > H1.SCP1.WGscreenLib.R1.bed 
gzip H1.SCP1.WGscreenLib.R1.sam