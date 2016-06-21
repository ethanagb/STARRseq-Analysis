#!/bin/bash
#BSUB -q shared
#BSUB -W 23:55
#BSUB -J calcConserv
#BSUB -R "span[hosts=1]"
#BSUB -e /project/fas/gerstein/eab232/starrseq/analysis/logs/%J.err
#BSUB -o /project/fas/gerstein/eab232/starrseq/analysis/logs/%J.out

module load Langs/Python/2.7.10
module load Libs/PANDAS
module load Libs/NUMPY
python calculateFeatureConservation.py