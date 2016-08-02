#!/bin/bash
#BSUB -q shared
#BSUB -W 23:55
#BSUB -J sortPeaks
#BSUB -R "span[hosts=1]"
#BSUB -e /project/fas/gerstein/eab232/starrseq/analysis/logs/%J.err
#BSUB -o /project/fas/gerstein/eab232/starrseq/analysis/logs/%J.out

bedtools intersect -wa -a H1WG.SCP1.H1.R1_peaks.bed -b TSS_windows.bed | uniq > H1WG.SCP1.H1.R1_peaks.bed_proximal.bed
diff -U $(wc -l < H1WG.SCP1.H1.R1_peaks.bed) H1WG.SCP1.H1.R1_peaks.bed H1WG.SCP1.H1.R1_peaks.bed_proximal.bed | grep '^-' | sed 's/^-//g' > S2_STARRseq_rep1_vsControl_peaks_distal_2kbp.bed